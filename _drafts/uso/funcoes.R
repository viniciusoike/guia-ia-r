# Funções auxiliares da análise de uso de IA -------------------------------

limpar_modelo <- function(modelo) {
  return(stringr::str_remove(modelo, "^.*/"))
}

classificar_fornecedor <- function(modelo) {
  fornecedor <- dplyr::case_when(
    stringr::str_starts(modelo, "claude") ~ "Anthropic",
    stringr::str_starts(modelo, "gpt|codex") ~ "OpenAI",
    .default = "Outros"
  )
  return(fornecedor)
}

classificar_interface_claude <- function(entrypoint) {
  interface <- dplyr::recode_values(
    entrypoint,
    "sdk-ts" ~ "T3 Code",
    "cli" ~ "Terminal",
    "claude-vscode" ~ "Extensão do IDE",
    default = "Outros"
  )
  return(interface)
}

classificar_interface_codex <- function(originator, source) {
  interface <- dplyr::case_when(
    originator %in% c("T3 Code", "t3code_desktop") ~ "T3 Code",
    originator %in% c("Codex Desktop", "codex_work_desktop") ~ "App do Codex",
    originator == "codex-tui" | source == "cli" ~ "Terminal",
    .default = "Outros"
  )
  return(interface)
}

# `uso` tem uma linha por modelo com tokens em cada categoria; `precos` tem o
# preço por token de cada modelo. Modelos sem preço ficam com custo NA.
calcular_custo_api <- function(uso, precos) {
  custo <- uso |>
    dplyr::left_join(precos, by = "modelo") |>
    dplyr::mutate(
      custo_usd = input *
        preco_input +
        cache_write * preco_cache_write +
        cache_write_1h * preco_cache_write_1h +
        cache_read * preco_cache_read +
        output * preco_output
    ) |>
    dplyr::select(-dplyr::starts_with("preco_"))
  return(custo)
}
