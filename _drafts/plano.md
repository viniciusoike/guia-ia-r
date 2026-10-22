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
- Texto antigo sobre Claude Code, Codeium/Windsurf, Supermaven, Copilot, Positron e Posit Assistant: não encontrado; reconstruir na entrevista do capítulo de história.
- Capa: prompt em `_drafts/capa-prompt.md`.
