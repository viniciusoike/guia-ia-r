<!-- Fonte: ekio-academy/tutorials/tutorial-r/fundamentals/2025-09-intro-r-1/index.qmd, linhas 77-141 (setembro de 2025). -->

## Inteligência Artificial, Chatbots e Autocomplete

Os recursos de inteligência artificial avançaram significativamente nos últimos anos e muitos usuários passaram a programar junto com eles. É difícil definir o uso ideal de IA, visto que estas ferramentes estão em rápido crescimento.

É importante deixar claro que, até o presente momento, as ferramentas de IA não conseguem produzir código de alta qualidade sem supervisão adequada. Simplesmente passar instruções genéricas para um chatbot é uma receita para um código disfuncional e ineficiente.

### LLMs e Chatbots

As IAs de maior sucesso atualmente são LLMs (large language models). Em geral, estes modelos estão disponíveis na forma de chatbots, onde o usuário pode fazer perguntas e receber respostas. O ChatGPT, por exemplo, oferece exatamente este tipo de serviço.

Apesar de muito úteis, chatbots são bastante limitados. A qualidade das suas respostas depende de contexto e prover este contexto costuma ser bastante inconveniente. O usuário precisa copiar e colar seu código ou fazer o upload de arquivos antes de fazer a sua pergunta. Ainda assim, há a chance do modelo simplesmente responder com algo inútil.

Chatbots podem, no melhor do casos, entregar um código que precisa ser copiado e colado e depois executado manualmente pelo usuário. Se o código tiver algum erro, é necessário explicar o erro ao modelo e seguir neste processo iterativamente até conseguir um código funcional.

Em muitos casos, um programador experiente consegue fazer este trabalho com mais qualidade e em menos tempo.

### Coding Agents e Ferramentas Integradas

Coding agents são LLMs especializadas em programação. Enquanto a maior parte dos chatbots disponíveis são generalistas, feitas para lidar com qualquer tipo de problema, este *agents* são focados em código.

Alguns destes agents também foram integrados em editores de texto ou até no terminal, permitindo que o agent "veja" o código, tenha acesso a pastas, dados e outros documentos. Isto resolve o problema do contexto e permite ...

Apesar disto, os coding agents ainda cometem erros e precisam ser guiados para gerar melhores resultados.

### Claude AI

Atualmente, a melhor ferramenta de IA para programação em R é a [Claude AI](https://claude.ai), da Anthropic. Além do Chatbot, a Anthropic oferece uma API para programação em R e o [ClaudeCode](https://www.anthropic.com/claude-code), uma ferramenta integrada ao terminal que consegue programar diretamente no seu computador.

A Claude AI também é integrada ao Positron via a extensão do editor e também através do Positron Assistant, um coding agent.

O pacote Pro da Claude custa, em setembro de 2025, R$ 110/mês e o pacote Max, R$ 550/mês. A este custo, o Claude Max custa mais do que uma assinatura anual do Office 365 e mesmo o Claude Pro custa mais do que praticamente qualquer assinatura de software/streaming no mercado.

Neste sentido, não se recomenda que usuários novos paguem por estes serviços. A melhor opção é **utilizar a versão gratuita do Claude** enquanto ela estiver disponível.

### Copilot e Windsurf

Outra ferramenta popular de IA é o chamado "autocomplete". Estas ficam rodando no background e fazem sugestões inteligentes no seu código à medida que você vai avançando.

Essencialmente, estas ferramentas são como "corretor automático" turbinado, recomendando às vezes diversas linhas de código de uma só vez. As sugestões de código costumam ser boas, mas, como sempre, não é incomum que o "autocomplete" sugira um código non-sense.

O pacote Pro do GitHub Copilot custa U$ 10/mês (cerca de R$ 55-60) e o pacote Pro+ custa U$ 39/mês (cerca de R$ 220-240). Assim como o Claude AI, os preços do Copilot não foram ajustados para o Brasil. O valor gasto em dois meses do pacote Pro+ é mais do que suficiente para pagar uma assinatura anual do Microsoft 365 (incluindo 2TB OneDrive, pacote office, Copilot, etc.) ou Google Workspace (incluindo Gemini) por um ano.

Neste sentido, não se recomenda que usuários novos paguem por estes serviços. A melhor opção é **utilizar a versão gratuita do GitHub Copilot ou Windsurf** enquanto elas estiverem disponíveis.

### Como usar a IA?

Não se recomenda que novos usuários dependam muito de recursos de IA. Estas ferramentas podem criar vícios ruins e até dificultar seu aprendizado a longo prazo.

Ninguém sabe, com certeza, qual o impacto cognitivo que a IA vai ter sobre nosso cérebro. Contudo, acredito que muitos já tiveram a experiência de depender do autocorretor do celular. Nosso cérebro é preguiçoso e se "ele sabe" que basta escrever "exce" para chegar em "exceção" é natural que "ele esqueça" com o tempo se o certo é "exceção", "excessão" ou "excescão".

## Setups completos

Como resumo do conteúdo acima e para ajudar a orientar usuários recomenda-se os três setups abaixo.

### RStudio + Copilot + Claude AI

Atualmente, o RStudio conta com suporte somente para o GitHub Copilot, então a decisão de "autocomplete" é simples. Junto com uma conta no Claude AI, este setup gratuito garante o melhor chatbot do mercado para R.

### Positron + Copilot + Claude AI + extensão Claude

O Positron tem maior flexibilidade no uso de ferramentas de IA. Este setup inclui as mesmas ferramentas do primeiro com a adição da extensão integrada do Claude. Essencialmente, esta ferramenta permite chamar o chatbot da Claude de dentro do Positron.

### Positron + Windsurf + Claude AI + extensão Claude

O último setup é igual ao anterior mas usa o Windsurf, na sua versão gratuita ao invés do GitHub Copilot.

<!-- Fonte: restateinsight/posts/general-posts/2025-07-setup-r/index.qmd (julho de 2025). -->


## Usando Positron

Recentemente, a empresa Posit, desenvolvedora do RStudio, lançou uma nova versão do IDE, chamada [Positron](https://positron.posit.co). Esta nova versão é construída com base no VSCode, da Microsoft, e tem objetivo de ser uma IDE otimizada para cientistas de dados. O Positron suporta tanto R quanto Python e acompanha algumas excelentes extensões pré-instaladas.

Atualmente, uso o Positron com maior frequência no meu dia-a-dia. O Positron é um pouco mais leve e rápido do que o RStudio, além de ter melhor integração com ferramentas de AI.

![](/static/images/setup_r/print_positron.png){fig-align="center"}

Entre as vantagens do Positron:

-   Melhor exibição de gráficos (usa agg como padrão).

-   Melhor integração com ferramentas de AI (Claude Code, Windsurf, Supermaven, etc.)

-   Explorer de arquivos muito mais funcional.

-   Mais extensões e mais opções no geral.

Entre as desvantagens do Positron:
