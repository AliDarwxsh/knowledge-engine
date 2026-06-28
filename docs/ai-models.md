# AI Models

> How to configure your AI provider. The engine uses your model. You bring the key.

## Quick Setup

```bash
# OpenAI (fastest, cheapest for routine tasks)
export OPENAI_API_KEY="sk-..."

# Anthropic Claude (best synthesis, nuanced reasoning)
export ANTHROPIC_API_KEY="sk-ant-..."

# OpenRouter (universal access — any model, one key)
export OPENROUTER_API_KEY="sk-or-..."

# DeepSeek (Chinese open-weight leader, excellent reasoning)
export DEEPSEEK_API_KEY="sk-..."

# Ollama (local, free, private — requires GPU)
# 1. Install Ollama: https://ollama.com/download
# 2. Pull a model: ollama pull qwen2.5:14b
# 3. Run: ollama serve
# No API key needed.
```

Add the export to your shell rc file (`~/.zshrc` or `~/.bashrc`) to persist across sessions.

```bash
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc
source ~/.zshrc
```

## Model Selection by Use Case

The engine defaults to whatever model your Hermes installation is configured to use. You can override per-skill or globally.

### By Task Complexity

| Use Case | Recommended Model | Cost (per 1M tokens) | Why |
|----------|-------------------|----------------------|-----|
| Classification (vault-capture) | GPT-4o-mini, Claude Haiku, Qwen 2.5-Instruct | $0.15–0.80 | Fast pattern matching |
| Linking (vault-link) | GPT-4o-mini, Claude Haiku, Qwen 2.5-Instruct | $0.15–0.80 | Semantic similarity |
| Synthesis (vault-digest) | **Kimi K2.6**, Claude Sonnet 4, DeepSeek V3 | $2.50–15 | Deep reasoning, cross-domain insight |
| Linting (vault-lint) | GPT-4o-mini, Qwen 2.5-Instruct (read-only) | $0.15–0.80 | Simple checks |
| Import (vault-import) | GPT-4o-mini for extraction, **Kimi K2.6** for synthesis | $0.15–15 | Accuracy + depth |
| Query (vault-query) | GPT-4o-mini, Qwen 2.5-Instruct | $0.15–0.80 | Most queries are simple |

### By Budget

**Low budget ($5/month):**
- Use Qwen 2.5-Instruct or GPT-4o-mini for everything except digest
- Run digest monthly instead of weekly
- Set user limits via `hermes config set model_limits ...`

**Medium budget ($30/month):**
- Mix Qwen 2.5-Instruct / GPT-4o-mini with Kimi K2.6 or DeepSeek V3
- Kimi/DeepSeek for digest and complex synthesis
- Qwen/GPT-4o-mini for everything else

**High budget ($100+/month):**
- Use Kimi K2.7, Claude Opus 4, or DeepSeek V3 for everything
- Best quality, highest cost

**Zero budget:**
- Run Ollama locally with Qwen 2.5, Llama 3.3, or Mistral
- Slower but free
- Privacy advantage: no data leaves your machine

## Recommended Models (June 2026)

### Top-Tier Reasoning (Synthesis, Deep Analysis)

| Model | Provider | Context | Strength | Best For |
|-------|----------|---------|----------|----------|
| **Kimi K2.6 / K2.7** | Moonshot AI (OpenRouter) | 256K | Long-context reasoning, decision analysis | vault-digest, complex synthesis, strategic decisions |
| **DeepSeek V3** | DeepSeek / OpenRouter | 64K | Mathematical reasoning, code, structured output | vault-import extraction, technical vaults |
| **Claude Sonnet 4** | Anthropic | 200K | Nuanced synthesis, voice matching | vault-digest, copywriting-heavy vaults |
| **Qwen 2.5-Max** | Alibaba Cloud / OpenRouter | 128K | Multilingual, strong reasoning | Non-English vaults, mixed-language content |

### Mid-Tier Workhorses (Classification, Linking, Query)

| Model | Provider | Context | Strength | Best For |
|-------|----------|---------|----------|----------|
| **Qwen 2.5-Instruct** | Alibaba / Ollama | 128K | Fast, cheap, competent | vault-capture, vault-link, vault-query |
| **GPT-4o-mini** | OpenAI | 128K | Fastest, cheapest, reliable | All routine tasks |
| **Claude Haiku** | Anthropic | 200K | Speed, cost efficiency | High-volume classification |
| **Minimax 3** | MiniMax / OpenRouter | 1M | Massive context window | Large document ingestion, book-length imports |

### Local / Privacy-First (Ollama)

| Model | Size | RAM Needed | Strength |
|-------|------|------------|----------|
| `qwen2.5:14b` | 14B | 10GB | Best local reasoning for digest tasks |
| `llama3.3:70b` | 70B | 45GB | Highest quality local synthesis |
| `mistral:7b` | 7B | 6GB | Fastest, decent quality |
| `deepseek-r1:14b` | 14B | 10GB | Strong reasoning, structured output |

## Provider-Specific Configuration

### OpenAI

```bash
export OPENAI_API_KEY="sk-..."
# Optional: override model
export OPENAI_MODEL="gpt-4o-mini"  # or gpt-4o, gpt-4-turbo
```

### Anthropic

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
export ANTHROPIC_MODEL="claude-3-5-haiku-latest"  # or claude-3-5-sonnet-latest
```

### OpenRouter (Recommended for Model Hopping)

```bash
export OPENROUTER_API_KEY="sk-or-..."
# Any model: openai/gpt-4o-mini, anthropic/claude-3.5-sonnet, moonshotai/kimi-k2-6, etc.
export OPENROUTER_MODEL="moonshotai/kimi-k2-6"
```

OpenRouter is useful if you want to A/B test models without managing multiple API keys. One key, every model.

### DeepSeek

```bash
export DEEPSEEK_API_KEY="sk-..."
export DEEPSEEK_MODEL="deepseek-chat"  # or deepseek-reasoner for reasoning tasks
```

DeepSeek offers excellent reasoning at lower cost than Western providers. Strong for structured extraction and technical content.

### Ollama (Local)

```bash
# 1. Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 2. Pull a model
ollama pull qwen2.5:14b

# 3. Start the server
ollama serve

# 4. Configure Hermes to use it
hermes config set ollama_url http://localhost:11434
hermes config set default_model qwen2.5:14b
```

**Recommended Ollama models for the engine:**
- `qwen2.5:14b` — best local reasoning, 10GB RAM
- `llama3.3:70b` — highest quality, needs 40GB+ RAM or GPU
- `mistral:7b` — fastest, 6GB RAM
- `deepseek-r1:14b` — strong structured output

## Model Routing Strategy

The engine's skills have different complexity requirements. You can configure different models per skill in `~/.hermes/config.yaml`:

```yaml
models:
  default: openai/gpt-4o-mini
  overrides:
    vault-digest: moonshotai/kimi-k2-6  # deep reasoning
    vault-import: openai/gpt-4o         # accurate extraction
    vault-lint: openai/gpt-4o-mini     # simple checks
```

This keeps costs low while using better models where they matter.

## Token Usage & Costs

### Per-Operation Estimates

| Operation | Input Tokens | Output Tokens | Cost (GPT-4o-mini) |
|-----------|--------------|---------------|---------------------|
| vault-capture (single note) | ~500 | ~300 | $0.0001 |
| vault-sync (100 notes) | ~3,000 | ~2,000 | $0.001 |
| vault-lint (500 notes) | ~5,000 | ~1,000 | $0.001 |
| vault-digest (weekly) | ~8,000 | ~2,000 | $0.002 |
| vault-import (100 convos) | ~30,000 | ~10,000 | $0.008 |
| vault-morning-brief | ~2,000 | ~500 | $0.0005 |

### Daily Active User

5 captures + 1 query + cron runs = ~$0.005/day = **$0.15/month**

### Heavy User

20 captures + 1 digest + 1 lint = ~$0.05/day = **$1.50/month**

**One-Time Import**

3,000 AI conversations = ~$3–10 one-time

## Switching Models Mid-Stream

You can change models without losing data:

```bash
# Switch to Kimi for deep synthesis
hermes config set default_model moonshotai/kimi-k2-6
export OPENROUTER_API_KEY="sk-or-..."

# Switch to DeepSeek for structured extraction
hermes config set default_model deepseek/deepseek-chat
export DEEPSEEK_API_KEY="sk-..."

# Switch to local Ollama
hermes config set default_model ollama/qwen2.5:14b
hermes config set ollama_url http://localhost:11434
```

The vault format doesn't change. Only the AI's outputs will have different styles.

## Cost Optimization Tips

1. **Use cheaper models for routine work**: Qwen 2.5-Instruct or GPT-4o-mini for classification, only upgrade for synthesis
2. **Batch operations**: `vault-sync` is more efficient than 100 individual `vault-capture` calls
3. **Local models for privacy-sensitive material**: Run Ollama for work you don't want sent to cloud providers
4. **Cache prompts**: Hermes has built-in prompt caching for OpenAI — reuse context where possible
5. **Set per-skill limits**: Configure max tokens per skill to prevent runaway costs
6. **Monitor usage**: `hermes usage` shows your monthly spend

## Privacy Considerations

**Hosted models (OpenAI, Anthropic, DeepSeek, OpenRouter):**
- Your vault content is sent to the provider for processing
- Read their data policies before use
- OpenAI: data not used for training by default (API)
- Anthropic: data not used for training (API)
- DeepSeek: data retained for service improvement; use OpenRouter proxy for privacy
- OpenRouter: depends on underlying provider

**Local models (Ollama):**
- Nothing leaves your machine
- Slower inference (depends on hardware)
- Best for highly sensitive material

## Troubleshooting

### "API key not found"
```bash
# Check if set
echo $OPENAI_API_KEY

# Set it (in current session)
export OPENAI_API_KEY="sk-..."

# Persist (in shell rc)
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc
```

### "Rate limit exceeded"
- Upgrade your API tier
- Reduce concurrent cron jobs
- Add delays between operations

### "Model too slow"
- Use a smaller/faster model (GPT-4o-mini vs GPT-4o)
- Switch to local Ollama
- Reduce input size (chunk larger notes)

### "Output is wrong style"
- Edit `schema/copywriting-standards.md` to clarify expectations
- Try a different model (Claude sometimes matches voice better than GPT)
- Add few-shot examples to the skill

---

*For architecture details, see [docs/architecture.md](architecture.md).*
*For daily workflow, see [docs/daily-workflow.md](daily-workflow.md).*
*For customization, see [docs/customization.md](customization.md).*
