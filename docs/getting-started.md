# Getting Started

> Install the Knowledge Engine in under 10 minutes. Start capturing. Let the engine organize.

## Prerequisites

- **Hermes Agent** installed — [Download Hermes](https://hermes-agent.nousresearch.com) (free, open-source)
- **Obsidian** installed — [Download Obsidian](https://obsidian.md) (free for personal use)
- An AI provider API key (OpenAI, Anthropic, OpenRouter, or local Ollama)

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/Alidarwxsh/knowledge-engine.git
cd knowledge-engine
```

### 2. Run setup

```bash
bash scripts/setup.sh
```

The script will:
- Locate or create your Obsidian vault
- Scaffold the dual-layer vault structure (Human + Machine layers)
- Copy templates, workflows, and governance files
- Install 10 Hermes skills for automation
- Schedule 5 cron jobs for background processing

### 3. Configure your AI provider

```bash
# OpenAI
export OPENAI_API_KEY="sk-..."

# Anthropic
export ANTHROPIC_API_KEY="sk-ant-..."

# OpenRouter (any model)
export OPENROUTER_API_KEY="sk-or-..."

# Or use local Ollama (free, private)
ollama pull llama3.1:8b
ollama serve
```

See [AI Models](ai-models.md) for detailed configuration.

### 4. Open your vault in Obsidian

```
File → Open vault → Select your vault directory
```

### 5. Run the onboarding interview

Open Hermes and type:

```
/vault-init
```

This asks 8 questions and generates your user profile. Takes ~5 minutes.

### 6. Start capturing

Type a thought into Hermes:

```
/vault-capture "Mastery emerges when constraint becomes the creative engine"
```

Or drop anything into `00 Inbox/` in Obsidian. The engine processes it within 6 hours (or immediately with `/vault-sync`).

## Your First Day

| Time | What Happens |
|------|-------------|
| Morning | Type `/vault-capture "thought"` in Hermes or drop a note in `00 Inbox/` |
| During day | Capture more thoughts as they arrive. Zero decisions at capture time. |
| Evening | 5-minute review: check what the engine classified. Confirm or correct. |
| Night | Engine runs health checks, finds connections, processes your inbox |

## What You'll See

- **7:00 AM next day**: Morning brief delivered — yesterday's activity, today's focus
- **Every 6 hours**: Inbox processed — notes classified, tagged, linked
- **Sunday 6 PM**: Weekly digest — cross-domain insights from your week's thinking

## Folder Map

```
vault/
├── 00 Inbox/              ← Capture everything here
├── 01 Identity/           ← Who you are
├── 02 Principles/         ← Your decision rules
├── 03 Projects/           ← Active work
├── 04 Knowledge Library/  ← Facts and research
├── 05 Framework Library/  ← Mental models
├── 06 Decision Archive/   ← Past decisions
├── 07 Systems & SOPs/     ← Repeatable processes
├── 08 Prompt Library/     ← AI prompts
├── 09 Research Archive/   ← Deep dives
├── 10 Ideas & Opportunities/ ← Future possibilities
├── 11 Timeline/           ← Chronological record
├── 12 Relationship Maps/  ← People and networks
├── 13 Meta Analysis/      ← System health
├── wiki/                  ← AI-maintained knowledge graph
├── sources/               ← Immutable raw imports
└── schema/                ← Governance and standards
```

## Next Steps

- Read [Daily Workflow](daily-workflow.md) for the full daily rhythm
- Read [Customization](customization.md) to adapt the engine to your needs
- Read [Architecture](architecture.md) to understand how it works under the hood
- Read [AI Models](ai-models.md) to optimize your provider configuration

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "hermes: command not found" | Install Hermes: `curl -fsSL https://hermes-agent.nousresearch.com/install.sh \| bash` |
| Inbox not processing | Run `/vault-sync` manually. Check cron jobs: `hermes cron list` |
| Notes classified wrong | Move the note to correct folder. Engine learns from corrections. |
| API key errors | Verify: `echo $OPENAI_API_KEY`. Set in `~/.zshrc` to persist. |
| Nothing happens at 7am | Cron requires Hermes running. Start Hermes Desktop or CLI. |
| Vault structure broken or files missing | Tell Hermes: "Fix my vault structure — some folders are missing" or "Rebuild the vault template." Hermes knows the architecture and can repair it. |
| Skills not working as expected | Tell Hermes: "The vault-capture skill keeps misclassifying my notes — fix it." Hermes can read the skill, diagnose the issue, and patch it. |
| Anything else wrong | Just describe the problem to Hermes in plain language. The engine can read its own source code, understand the architecture, and repair itself. |

## Support

- 📖 [Full Documentation](../README.md)
- 🐛 [GitHub Issues](https://github.com/Alidarwxsh/knowledge-engine/issues)
- 💬 [GitHub Discussions](https://github.com/Alidarwxsh/knowledge-engine/discussions)
