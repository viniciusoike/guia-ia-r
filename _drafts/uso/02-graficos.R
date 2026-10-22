# Gráficos de uso de IA para o capítulo "Meu setup atual" -----------------

library(dplyr)
library(readr)
library(ggplot2)

source(here::here("_drafts", "uso", "funcoes.R"))

dir_dados <- here::here("dados", "uso")
dir_imagens <- here::here("imagens")

cores_fornecedor <- c(
  "Anthropic" = "#1E3A5F",
  "OpenAI" = "#78936B",
  "Outros" = "#97BACB"
)

cores_agente <- c("Claude Code" = "#1E3A5F", "Codex" = "#78936B")

tema <- ekioplot::theme_ekio(
  base_size = 12,
  font_title = "Host Grotesk",
  font_text = "Host Grotesk",
  background = "white"
)

# Modelos por mês no T3 Code -----------------------------------------------

threads_t3 <- read_csv(
  file.path(dir_dados, "threads_t3.csv"),
  show_col_types = FALSE
)

meses_pt <- c(
  "jan",
  "fev",
  "mar",
  "abr",
  "mai",
  "jun",
  "jul",
  "ago",
  "set",
  "out",
  "nov",
  "dez"
)

rotular_mes <- function(datas) {
  return(meses_pt[lubridate::month(datas)])
}

# Outubro ainda está em curso; a barra fica mais clara para não parecer queda.
mes_parcial <- as.Date("2026-10-01")

# Os rótulos ficam só em setembro, o único mês com os três segmentos visíveis.
threads_mes <- threads_t3 |>
  summarise(n_threads = sum(n_threads), .by = c(mes, fornecedor)) |>
  mutate(
    fornecedor = factor(fornecedor, levels = names(cores_fornecedor)),
    parcial = mes == mes_parcial,
    rotulo = if_else(mes == as.Date("2026-09-01"), as.character(fornecedor), NA)
  )

grafico_modelos <- ggplot(threads_mes, aes(mes, n_threads, fill = fornecedor)) +
  geom_col(aes(alpha = parcial), width = 20) +
  geom_text(
    aes(label = rotulo, colour = fornecedor == "Outros"),
    position = position_stack(vjust = 0.5),
    family = "Host Grotesk",
    size = 3.6,
    na.rm = TRUE
  ) +
  scale_x_date(labels = rotular_mes, date_breaks = "1 month") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  scale_fill_manual(values = cores_fornecedor) +
  scale_alpha_manual(values = c("FALSE" = 1, "TRUE" = 0.6)) +
  scale_colour_manual(values = c("FALSE" = "white", "TRUE" = "#1E3A5F")) +
  labs(
    title = "O Claude é a base; GPT e modelos abertos entraram depois",
    subtitle = "Threads abertas no T3 Code por fornecedor do modelo, 2026",
    x = NULL,
    y = NULL,
    caption = "Outros: GLM, DeepSeek, Kimi, Muse Spark e outros modelos via OpenCode. Outubro até o dia 21.\nFonte: registros locais do T3 Code."
  ) +
  tema +
  theme(legend.position = "none")

ggsave(
  file.path(dir_imagens, "uso-modelos-t3.png"),
  grafico_modelos,
  width = 8,
  height = 5,
  dpi = 200
)

# Custo equivalente em API em outubro --------------------------------------

precos <- read_csv(
  file.path(dir_dados, "precos_api.csv"),
  show_col_types = FALSE
)
uso_claude <- read_csv(
  file.path(dir_dados, "uso_claude_dia.csv"),
  show_col_types = FALSE
)
uso_codex <- read_csv(
  file.path(dir_dados, "uso_codex_dia.csv"),
  show_col_types = FALSE
)

uso_outubro <- bind_rows(
  "Claude Code" = uso_claude,
  "Codex" = uso_codex,
  .id = "agente"
) |>
  mutate(across(c(cache_write, cache_write_1h), \(x) coalesce(x, 0))) |>
  filter(dia >= as.Date("2026-10-01"), dia <= as.Date("2026-10-21"))

custo_dia <- uso_outubro |>
  calcular_custo_api(precos) |>
  summarise(custo_usd = sum(custo_usd, na.rm = TRUE), .by = c(dia, agente))

custo_total <- sum(custo_dia$custo_usd)
cli::cli_inform("Custo equivalente em outubro: US$ {round(custo_total)}.")

grafico_custo <- ggplot(custo_dia, aes(dia, custo_usd, fill = agente)) +
  geom_col(width = 0.8) +
  scale_x_date(date_labels = "%d/%m", date_breaks = "1 week") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  scale_fill_manual(values = cores_agente) +
  labs(
    title = "Em três semanas de outubro, meu uso custaria perto de US$ 900 em API",
    subtitle = "Custo diário equivalente pelos preços de API de cada modelo, em US$",
    x = NULL,
    y = NULL,
    fill = NULL,
    caption = "Codex a partir de 6/10, quando começam os registros detalhados. Outubro até o dia 21.\nFonte: registros locais do Claude Code e do Codex; preços da tabela usada pelo T3 Code."
  ) +
  tema +
  theme(legend.position = "top", legend.justification = "left")

ggsave(
  file.path(dir_imagens, "uso-custo-outubro.png"),
  grafico_custo,
  width = 8,
  height = 5,
  dpi = 200
)
