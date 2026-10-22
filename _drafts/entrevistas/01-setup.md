# Entrevista 1: meu setup atual (21/10/2026)

Respostas do Vinicius, sem edição. Fonte dos capítulos 12 (setup), 2 (história) e 13 (modelos).

## Q1. Por que o Claude é a base?

I started with ClaudeCode since I already thought Claude (chat) was better at R coding. There seemed to be a consensus that Claude was better at R than ChatGPT. Going to claudecode felt very natural. I follow Posit engineers and coders on GitHub and saw that they were using it as well which enouraged me. Hadely Wickham seems to prefer Claude. And Posit, the company, seems to favor Claude on most ocassions (Posit Assistant was launched with only support for Anthropic models).

To be very frank, I had a lot of trouble using claudecode and even had claude (I think Opus 3.5)almost delete an entire package (realestatebr). I went from micromanaging Claude (and feeling that it was nearly a waste of time) to using it a lot, and thinking things were great, only to get burned later. I think there was a long period were I saw a tradeoff: Claude was faster than me, but the quality of the code was poor, and it tended to build too much. I found myself having to clenaup after Claude (removing unncessary text, features, functions, documentation, examples, etc.)

I started branching out because Claude started feeling a bit stale. The first month I used ChatGPT felt really nice. The 5.6 suite of models was very strong and Astra 6 was an incredible model. Unfortunately the 6 suite models just seem too expensive to use at a Plus subscription. I mostly just use 6.1 Sol as a reviewer. I've even stopped using Astra for computer use tools now that Sonnet 5.5 came out.

I feel like Opus 5.5 was a big game changer for me. It feels like almost a 'perfect' model. It understand me well, and is a legit great coder. It changed my understanding of AI as "just an assitant" to a coworker. I now want to design a task, delegate it to Claude, and only review the final result: as if Claude were the analyst/coder and I were the project manager.

## Q2. Limites do Claude Pro

Yes. I constantly juggle usage limits. Currently I use 'codexbar' to keep track of my use. I almost always max out my subscriptions. I usually go Claude > GPT > opencodego > opencode zen. In recent times, though, managing the subscriptions has become slightly easier due to very generous resets from OpenAI and Anthropic.

I have very small tips, nothing fancy. I usually just wake up early and send a "hello" to haiku and luna. I've developed a sense for how the usage goes for tasks. And, honestly, usage used to more of an issue, but I feel like Opus 5.5 medium is such an efficient model that I rarely find myself running out of usage.

I also learned to manage context better. I try to never go above 200k-250k. I make sure to keep cache warm and compact when necessary. I also delegate simple tasks to simple models when possible.

## Q3. Quando uso o Codex

I started using codex because I was unsatisfied with Opus 5 and starting hearing good things about GPT 5.6. The model I enjoyed the most was 5.6 Luna (high/xhigh). I didn't use it much for coding but used it for pretty much everything that wasn't coding.

GPT 5.6 Sol was a very strong coding model: very efficient and good quality code.

Astra 6 is a very cool model. And I used it a lot for image generation and computer use. Unfortunately the 6 (Sol 6, Sol 6.1, Luna 6) suite models just seem too expensive to use at a Plus subscription. I mostly just use 6.1 Sol as a reviewer for very important PRs. I've even stopped using Astra for computer use tools now that Sonnet 5.5 came out.

I also have a ChatGPT Edu sub via Insper that only works in the Codex desktop app. I use it mostly for Insper related work but I find that the usage drops very quickly. I've used the entire 5h limit in a single task, more than once.

## Q4. Qual GPT, para quê

6.1 Sol for code review. Luna for a lot of tasks. 6 Sol for coding. I used to used 5.6 Sol (low/med) for a lot of coding. cost against quota. Don't care that much about speed.

## Q5. Extensão do Claude no IDE

Yes. It's Positron and I use it mostly when I want Claude as an assitant and flexibility to change code, quickly review changes, render charts, and do quick tests. Also, for reporting, writing, and content I still prefer Positron + Claude extension or Positron + claudecode in the terminal. That way I can write, code, review, explore, and use claude on demand.

## Q6. Por que o T3 Code

I resisted T3 Code for a long time and thought it was stange to code without a script open. T3 Code does have some resources like a Terminal and Files, but ultimately it's a completely different workflow experience. I think T3 Code puts me in a different mindset: it helps me delegate work across models and to work on different projects at the same time. It's also much more convinient to use different models with it (switching from GLM 5.3 Flash to Opus back to Sol).

T3 Code also makes it easier and more convenient to write long prompts. It's better to write than the TUI options. It's minimal, well organized, and efficient. Also, it's just a good way to work with AI: you don't need to spend time giving permissions or authorizations, you just get the results you want. I almost never use opencode because of the lack of an "auto mode". Using open models inside T3 just feels much better.

## Q7. Modelos abertos

I actually really liked to open models, specially GLM 5.3 Flash, this model made me realized how capable small efficient models could be. I used GLM 5.3 Flash for a lot of tasks: rewriting text, writing PRs, organizing folders, looking for files, cleaning up repos (branches, worktrees, old docs), lots of non-coding related tasks.

Muse Spark was a pleasant surprise. I actually used this model for some coding and found decent results. Though I think it benefited a lot from having access to my skills and being setup in a good repo with a lot of high quality R code.

I used more the Flash version of DeepSeek (V4 and V4.1). I think the model seems good, but just didn't use it much. Kimi seems very capable but it's just too expensive.

I will resubscribe to opencode in the near future.

## Q8. Um dia típico

In broad lines, I use T3 Code for work that is already consolidated and where I want to act more as a Product Manager or Senior Dev. I use Positron + Claude for reports, writing, data visualization, important deliverables. For use cases where it's easier for me to tweak and to take control rather than to delegate
