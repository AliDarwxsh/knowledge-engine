# AI Models

> How to configure your AI provider. The engine uses your model. You bring the key.

## Quick Setup

```bash
# OpenAI (cheapest, fastest for most tasks)
export OPENAI_API_KEY="sk-..."

# Anthropic Claude (better for synthesis, longer context)
export ANTHROPIC_API_KEY="sk-ant-..."

# OpenRouter (any model, pay-as-you-go)
export OPENROUTER_API_KEY="sk-or-..."

# Ollama (local, free, requires local GPU)
# 1. Install Ollama: https://ollama.com/download
# 2. Pull a model: ollama pull llama3.1:8b
# 3. Run: ollama serve
# No API key needed.
```

Add the export to your shell rc file (`~/.zshrc` or `~/.bashrc`) to persist across sessions.

```bash
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc
source ~/.zshrc
```

## Model Selection

The engine defaults to whatever model your Hermes installation is configured to use. You can override per-skill or globally.

### By Use Case

| Use Case | Recommended Model | Cost (per 1M tokens) |
|----------|-------------------|----------------------|
| Classification (vault-capture) | GPT-4o-mini, Claude Haiku | $0.15-0.80 |
| Linking (vault-link) | GPT-4o-mini, Claude Haiku | $0.15-0.80 |
| Synthesis (vault-digest) | GPT-4o, Claude Sonnet | $2.50-15 |
| Linting (vault-lint) | GPT-4o-mini (read-only, no deep reasoning) | $0.15-0.80 |
| Import (vault-import) | GPT-4o-mini for extraction, GPT-4o for synthesis | $0.15-15 |
| Query (vault-query) | GPT-4o-mini (most queries) | $0.15-0.80 |

### By Budget

**Low budget ($5/month)**:
- Use GPT-4o-mini for everything except digest
- Run digest monthly instead of weekly
- Set user limits via `hermes config set model_limits ...`

**Medium budget ($30/month)**:
- Mix GPT-4o-mini and Claude Sonnet
- Sonnet for digest and complex synthesis
- GPT-4o-mini for everything else

**High budget ($100+/month)**:
- Use GPT-4o or Claude Opus for everything
- Best quality, highest cost

**Zero budget**:
- Run Ollama locally
- Use smaller models (llama3.1:8b, mistral:7b)
- Slower but free
- Privacy advantage: no data leaves your machine

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

### OpenRouter

```bash
export OPENROUTER_API_KEY="sk-or-..."
# Specify any model: openai/gpt-4o-mini, anthropic/claude-3.5-sonnet, etc.
export OPENROUTER_MODEL="anthropic/claude-3.5-sonnet"
```

OpenRouter is useful if you want to A/B test models without managing multiple API keys.

### Ollama (Local)

```bash
# 1. Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 2. Pull a model
ollama pull llama3.1:8b

# 3. Start the server
ollama serve

# 4. Configure Hermes to use it
hermes config set ollama_url http://localhost:11434
hermes config set default_model llama3.1:8b
```

**Recommended Ollama models for the engine:**
- `llama3.1:8b` — fast, decent quality, 8GB RAM
- `llama3.1:70b` — high quality, needs 40GB+ RAM or GPU
- `mistral:7b` — alternative, slightly different style
- `qwen2.5:14b` — strong reasoning for digest tasks

## Model Routing Strategy

The engine's skills have different complexity requirements. You can configure different models per skill in `~/.hermes/config.yaml`:

```yaml
models:
  default: openai/gpt-4o-mini
  overrides:
    vault-digest: anthropic/claude-3.5-sonnet  # better synthesis
    vault-import: openai/gpt-4o  # more accurate extraction
    vault-lint: openai/gpt-4o-mini  # simple checks
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

3,000 AI conversations = ~$3-10 one-time

## Switching Models Mid-Stream

You can change models without losing data:

```bash
# Switch to Claude
hermes config set default_model anthropic/claude-3.5-haiku-latest
export ANTHROPIC_API_KEY="sk-ant-..."

# Switch to local Ollama
hermes config set default_model ollama/llama3.1:8b
hermes config set ollama_url http://localhost:11434
```

The vault format doesn't change. Only the AI's outputs will have different styles.

## Cost Optimization Tips

1. **Use cheaper models for routine work**: GPT-4o-mini for classification, only upgrade for synthesis
2. **Batch operations**: `vault-sync` is more efficient than 100 individual `vault-capture` calls
3. **Local models for privacy-sensitive material**: Run Ollama for work you don't want sent to OpenAI/Anthropic
4. **Cache prompts**: Hermes has built-in prompt caching for OpenAI — reuse context where possible
5. **Set per-skill limits**: Configure max tokens per skill to prevent runaway costs
6. **Monitor usage**: `hermes usage` shows your monthly spend

## Privacy Considerations

**Hosted models (OpenAI, Anthropic, OpenRouter):**
- Your vault content is sent to the provider for processing
- Read their data policies before use
- OpenAI: data not used for training by default (API)
- Anthropic: data not used for training (API)
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