# Testes das funções auxiliares da análise de uso.
# Rodar com: testthat::test_file(here::here("_drafts", "uso", "test-funcoes.R"))

source(here::here("_drafts", "uso", "funcoes.R"))

test_that("limpar_modelo() remove o prefixo do provedor", {
  expect_equal(limpar_modelo("opencode-go/glm-5.3-flash"), "glm-5.3-flash")
  expect_equal(limpar_modelo("moonshotai/kimi-k2.5"), "kimi-k2.5")
  expect_equal(limpar_modelo("claude-opus-5-5"), "claude-opus-5-5")
})

test_that("classificar_fornecedor() separa Anthropic, OpenAI e outros", {
  modelos <- c("claude-opus-5-5", "gpt-6-luna", "codex-auto-review", "glm-5.3")
  expect_equal(
    classificar_fornecedor(modelos),
    c("Anthropic", "OpenAI", "OpenAI", "Outros")
  )
})

test_that("classificar_interface_claude() traduz o entrypoint", {
  expect_equal(
    classificar_interface_claude(c(
      "sdk-ts",
      "cli",
      "claude-vscode",
      "sdk-cli"
    )),
    c("T3 Code", "Terminal", "Extensão do IDE", "Outros")
  )
})

test_that("classificar_interface_codex() usa originator e source", {
  expect_equal(
    classificar_interface_codex(
      c(
        "T3 Code",
        "t3code_desktop",
        "Codex Desktop",
        "codex_work_desktop",
        "codex-tui",
        NA
      ),
      c("vscode", "vscode", "vscode", "vscode", "cli", "cli")
    ),
    c(
      "T3 Code",
      "T3 Code",
      "App do Codex",
      "App do Codex",
      "Terminal",
      "Terminal"
    )
  )
})

test_that("calcular_custo_api() aplica o preço de cada tipo de token", {
  precos <- tibble::tibble(
    modelo = "m",
    preco_input = 4e-6,
    preco_cache_write = 5e-6,
    preco_cache_write_1h = 8e-6,
    preco_cache_read = 2e-7,
    preco_output = 2e-5
  )
  uso <- tibble::tibble(
    modelo = c("m", "desconhecido"),
    input = 1e6,
    cache_write = 1e6,
    cache_write_1h = 1e6,
    cache_read = 1e6,
    output = 1e6
  )
  custo <- calcular_custo_api(uso, precos)
  expect_equal(custo$custo_usd[1], 4 + 5 + 8 + 0.2 + 20)
  expect_true(is.na(custo$custo_usd[2]))
})
