# Importa o histórico de uso de IA e salva tabelas agregadas --------------
#
# Lê os registros locais do T3 Code, do Codex e do Claude Code e grava em
# dados/uso/ apenas agregados (por dia ou mês, interface e modelo). Prompts,
# títulos e caminhos de projetos nunca saem desta máquina.

library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(readr)

source(here::here("_drafts", "uso", "funcoes.R"))

dir_saida <- here::here("dados", "uso")

caminho_t3 <- path.expand("~/.t3/userdata/statev2.sqlite")
caminho_codex <- path.expand("~/.codex/state_5.sqlite")
dir_codex <- path.expand("~/.codex/sessions")
dir_claude <- path.expand("~/.claude/projects")
caminho_precos <- path.expand("~/.t3/userdata/usage-model-rates.json")

ler_sqlite <- function(caminho, consulta) {
  con <- DBI::dbConnect(RSQLite::SQLite(), caminho, flags = RSQLite::SQLITE_RO)
  on.exit(DBI::dbDisconnect(con))
  return(tibble::as_tibble(DBI::dbGetQuery(con, consulta)))
}

# T3 Code: modelo escolhido em cada thread --------------------------------

cli::cli_progress_step("Lendo threads do T3 Code")

threads_t3_raw <- ler_sqlite(
  caminho_t3,
  "select created_at,
          default_provider as interface_t3,
          json_extract(payload_json, '$.modelSelection.model') as modelo
   from orchestration_v2_projection_threads
   where deleted_at is null"
)

threads_t3 <- threads_t3_raw |>
  filter(!is.na(modelo)) |>
  mutate(
    mes = as.Date(paste0(str_sub(created_at, 1, 7), "-01")),
    modelo = limpar_modelo(modelo),
    fornecedor = classificar_fornecedor(modelo)
  ) |>
  count(mes, fornecedor, modelo, name = "n_threads")

# Codex: tokens por thread -------------------------------------------------

cli::cli_progress_step("Lendo threads do Codex")

threads_codex_raw <- ler_sqlite(
  caminho_codex,
  "select created_at, originator, source, model as modelo, tokens_used
   from threads"
)

threads_codex <- threads_codex_raw |>
  mutate(
    mes = as.Date(lubridate::floor_date(
      as.POSIXct(created_at, origin = "1970-01-01", tz = "UTC"),
      "month"
    )),
    subagente = str_starts(source, fixed("{")),
    interface = classificar_interface_codex(originator, source),
    modelo = coalesce(modelo, "desconhecido")
  ) |>
  summarise(
    n_threads = n(),
    tokens = sum(tokens_used),
    .by = c(mes, interface, subagente, modelo)
  )

# Codex: tokens por tipo, a partir dos rollouts que ainda existem ----------

cli::cli_progress_step("Lendo rollouts do Codex")

ler_rollout <- function(caminho) {
  linhas <- read_lines(caminho)
  linhas_tokens <- str_subset(linhas, '"token_count","info":\\{')
  linhas_contexto <- str_subset(linhas, '"type":"turn_context"')
  if (length(linhas_tokens) == 0 || length(linhas_contexto) == 0) {
    return(NULL)
  }

  total <- jsonlite::fromJSON(dplyr::last(
    linhas_tokens
  ))$payload$info$total_token_usage
  contexto <- jsonlite::fromJSON(dplyr::last(linhas_contexto))$payload

  rollout <- tibble::tibble(
    dia = as.Date(str_extract(basename(caminho), "\\d{4}-\\d{2}-\\d{2}")),
    modelo = contexto$model,
    input_total = total$input_tokens,
    cache_read = total$cached_input_tokens,
    output = total$output_tokens
  )
  return(rollout)
}

arquivos_codex <- list.files(
  dir_codex,
  "\\.jsonl$",
  recursive = TRUE,
  full.names = TRUE
)

rollouts_codex <- arquivos_codex |>
  map(ler_rollout) |>
  list_rbind()

# A OpenAI conta tokens em cache dentro de input_tokens.
uso_codex_dia <- rollouts_codex |>
  mutate(input = input_total - cache_read) |>
  summarise(
    n_sessoes = n(),
    across(c(input, cache_read, output), sum),
    .by = c(dia, modelo)
  )

# Claude Code: tokens por chamada ------------------------------------------

cli::cli_progress_step("Lendo transcrições do Claude Code")

ler_transcricao_claude <- function(caminho) {
  linhas <- read_lines(caminho)
  linhas <- str_subset(linhas, '"type":"assistant"')
  linhas <- str_subset(linhas, '"usage":')
  if (length(linhas) == 0) {
    return(NULL)
  }

  chamadas <- map(linhas, \(linha) {
    d <- jsonlite::parse_json(linha)
    u <- d$message$usage
    tibble::tibble(
      id = paste(d$message$id, d$requestId),
      momento = d$timestamp,
      entrypoint = d$entrypoint %||% NA_character_,
      modelo = d$message$model %||% NA_character_,
      input = u$input_tokens %||% 0,
      cache_write_total = u$cache_creation_input_tokens %||% 0,
      cache_write_1h = u$cache_creation$ephemeral_1h_input_tokens %||% 0,
      cache_read = u$cache_read_input_tokens %||% 0,
      output = u$output_tokens %||% 0
    )
  })
  return(list_rbind(chamadas))
}

arquivos_claude <- list.files(
  dir_claude,
  "\\.jsonl$",
  recursive = TRUE,
  full.names = TRUE
)

chamadas_claude <- arquivos_claude |>
  map(ler_transcricao_claude, .progress = TRUE) |>
  list_rbind()

# Cada resposta aparece em várias linhas do transcript; fica uma por chamada.
uso_claude_dia <- chamadas_claude |>
  distinct(id, .keep_all = TRUE) |>
  filter(modelo != "<synthetic>") |>
  mutate(
    dia = as.Date(str_sub(momento, 1, 10)),
    interface = classificar_interface_claude(entrypoint),
    cache_write = cache_write_total - cache_write_1h
  ) |>
  summarise(
    n_chamadas = n(),
    across(c(input, cache_write, cache_write_1h, cache_read, output), sum),
    .by = c(dia, interface, modelo)
  )

# Preços de API por token --------------------------------------------------

cli::cli_progress_step("Lendo tabela de preços")

modelos_usados <- unique(c(uso_claude_dia$modelo, uso_codex_dia$modelo))

tabela_precos <- jsonlite::read_json(caminho_precos)$document

ler_preco <- function(modelo) {
  p <- tabela_precos[[modelo]]
  if (is.null(p)) {
    return(NULL)
  }
  preco <- tibble::tibble(
    modelo = modelo,
    preco_input = p$input_cost_per_token %||% NA_real_,
    preco_cache_write = p$cache_creation_input_token_cost %||% NA_real_,
    preco_cache_write_1h = p$cache_creation_input_token_cost_above_1hr %||%
      p$cache_creation_input_token_cost %||%
      NA_real_,
    preco_cache_read = p$cache_read_input_token_cost %||% NA_real_,
    preco_output = p$output_cost_per_token %||% NA_real_
  )
  return(preco)
}

precos <- modelos_usados |>
  map(ler_preco) |>
  list_rbind()

sem_preco <- setdiff(modelos_usados, precos$modelo)
if (length(sem_preco) > 0) {
  cli::cli_warn("Modelos sem preço de API: {.val {sem_preco}}.")
}

# Salvar -------------------------------------------------------------------

cli::cli_progress_step("Salvando agregados em {.path {dir_saida}}")

write_csv(threads_t3, file.path(dir_saida, "threads_t3.csv"))
write_csv(threads_codex, file.path(dir_saida, "threads_codex.csv"))
write_csv(uso_codex_dia, file.path(dir_saida, "uso_codex_dia.csv"))
write_csv(uso_claude_dia, file.path(dir_saida, "uso_claude_dia.csv"))
write_csv(precos, file.path(dir_saida, "precos_api.csv"))

cli::cli_progress_done()
