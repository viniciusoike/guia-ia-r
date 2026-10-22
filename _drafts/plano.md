# Plano do livro

Notas internas. Esta pasta não é renderizada.

## Leitor

Usuário de R (economista, analista) que já usa ChatGPT ou Claude no navegador, mas ainda não adotou agentes, MCPs ou skills.

## Decisões

- Só português, só HTML, código estático (`eval: false`).
- Parte I independe de ferramenta; Parte II é opinativa, datada e organizada por faixa de preço (grátis, ~US$ 20, US$ 100–200 por mês).
- Preços em US$ e R$ com IOF; câmbio em `_quarto.yml` (`cambio`), conversão com `{{< brl X >}}`.
- Parte II lista modelos não testados.
- Voz em primeira pessoa.
- Texto CC BY-NC-SA 4.0; configurações MIT.
- Hospedado em academy.ekio.io/livros/ia-para-r/ via proxy do Netlify.

## Lançamento (meta: 18/11/2026)

Capítulos do lançamento: Como ler este guia, História, O mínimo sobre LLMs, Interfaces, Contexto, MCP, Skills, Meu setup, Modelos que recomendo, Fluxos. Os demais saem marcados como em desenvolvimento.

Ordem de escrita: setup, modelos recomendados, história, interfaces/contexto/MCP/skills, fluxos, LLMs, introdução.

## Pendências

- Atualizar o câmbio em `_quarto.yml` (5,50 é provisório).
- Capa: prompt em `_drafts/capa-prompt.md`.

## Fontes e posições para os capítulos 2 e 13

- Textos antigos (set/2025 e jul/2025) em `_drafts/fontes/textos-antigos-2025.md`. Servem de base histórica; não precisam de citação direta.
- Hoje não uso Copilot nem Windsurf. Usei o Supermaven por muito tempo; hoje uso pouco.
- O espírito do conselho de 2025 continua valendo: começar pequeno, não pagar por muitas ferramentas e construir confiança na IA dentro do próprio fluxo de trabalho.
- O que mudou: não recomendo mais começar pelo Claude gratuito. O ponto de partida é uma assinatura, ChatGPT Plus ou Claude Pro, usada com o Codex ou o Claude Code.
- Testei GLM 5.3, Muse Spark, DeepSeek V4, Kimi K3 e outros via OpenCode (set/2026); entram como "testei", não como "não testei".

## Dados de uso

- Scripts em `_drafts/uso/` (testes em `test-funcoes.R`). Rodar `01-importar.R` e depois `02-graficos.R`.
- Só agregados vão para `dados/uso/`; os registros brutos ficam na máquina.
- Logs do Claude Code agora ficam 365 dias (`cleanupPeriodDays`); antes de 22/09/2026 só há dados do T3 e do Codex.

## Assinaturas (out/2026)

- Pago ChatGPT Plus e Claude Pro. O OpenCode Go está pausado, com volta prevista.

## Tarefas do lançamento

- No tutorial `ekio-academy/tutorials/tutorial-r/fundamentals/2025-09-intro-r-1`, trocar a seção de IA por um parágrafo com link para o livro.
- Trocar o tile "Em preparação" de `livros.qmd` por um link para o livro e a capa definitiva.
- Atualizar o câmbio em `_quarto.yml`.
- Incidente do `realestatebr` (provavelmente Claude 3.5 Sonnet): o Vinicius vai levantar os detalhes para o capítulo de riscos.
