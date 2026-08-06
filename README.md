# Knowledge Engine

The vault that *reads itself*.

You have hundreds of conversations you forgot you had. The decisions you already made, the principles you already wrote, the questions you already answered are inside them. Every new session, you rebuild context from memory. The engine ends that.

Knowledge Engine is an open source system that turns scattered input (notes, articles, AI chat exports) into a self-organizing vault. It captures, classifies, links, and grows while you sleep. You stop re-explaining yourself because the system already *remembers*.

## The law

Three principles hold the whole design together.

1. **Files are truth.** No database, no proprietary format, no lock-in. Every note is a markdown file you can open in any editor, forever.
2. **Bring your own key.** The engine reasons with your AI provider, your API key, your machine. No credits held, no cloud dependency, no other hands on your data.
3. **The vault is the API.** Every skill, every schedule, every output is a markdown file. Fork a skill, edit a file, change the engine. No build step.

## What you get

| Component | What it does |
| --- | --- |
| **Dual-layer vault** | Human folders for how you work, a machine layer for how the engine thinks |
| **10 Hermes skills** | vault-init, vault-capture, vault-sync, vault-lint, vault-digest, vault-import, vault-query, vault-link, vault-morning-brief, vault-forward-refs |
| **5 scheduled jobs** | Morning brief, inbox processing, connection finding, nightly lint, weekly digest |
| **One-command setup** | Installs the vault, the skills, and the schedules |
| **Verification script** | Confirms the engine is wired before you trust it |

## Quick start

**macOS and Linux**

```bash
# 1. Install Hermes (free, open source)
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

# 2. Install Obsidian (free for personal use)
# https://obsidian.md

# 3. Clone the engine
git clone https://github.com/AliDarwxsh/knowledge-engine.git
cd knowledge-engine

# 4. Run setup (scaffolds the vault, installs skills, schedules cron)
bash scripts/setup.sh       # or: python3 scripts/setup.py

# 5. Open the vault in Obsidian, then run the init interview
hermes skill run vault-init
```

**Windows**

```powershell
# 1. Install Hermes
irm https://hermes-agent.nousresearch.com/install.ps1 | iex

# 2. Install Obsidian
# https://obsidian.md

# 3. Clone the engine
git clone https://github.com/AliDarwxsh/knowledge-engine.git
cd knowledge-engine

# 4. Run setup (needs Python 3.8+)
scripts\setup.cmd

# 5. Register the scheduled jobs (optional)
powershell -ExecutionPolicy Bypass -File cron\windows\register-cron.ps1

# 6. Open the vault and run the init interview
hermes skill run vault-init
```

Windows walkthrough: [docs/installation-windows.md](docs/installation-windows.md). macOS and Linux walkthrough: [docs/getting-started.md](docs/getting-started.md).

Drop your first thought in `00 Inbox/`. The engine files it while you sleep.

## The daily loop

```
7:00 AM    Morning brief. What changed overnight, what is open.
All day    Drop thoughts in the inbox as they arrive.
Every 6h   The engine processes the inbox. Classifies, tags, links.
Evening    Five-minute review. Approve, adjust, delete.
2:00 AM    Nightly health check.
3:00 AM    Connection finder proposes new links.
Sunday     Weekly synthesis. Cross-domain insights.
```

## Architecture

```
+--------------------------------------------------+
| OBSIDIAN     Storage and human surface            |
| Plain markdown. Dual-layer vault.                 |
| You: capture, review, decide.                     |
+------------------------+-------------------------+
                         | MCP filesystem
+------------------------v-------------------------+
| HERMES       Automation engine                    |
| Skills, schedules, memory, sub-agents, MCP tools  |
+------------------------+-------------------------+
                         | Your own API key
+------------------------v-------------------------+
| AI MODELS    Reasoning                             |
| OpenAI, Anthropic, DeepSeek, Qwen, Ollama         |
+--------------------------------------------------+
```

## Capabilities

### Chat import

Thousands of AI conversations you forgot. `vault-import` extracts decisions, principles, questions, and knowledge from any chat export (ChatGPT, Claude, DeepSeek, Kimi, any model that exports), with source citations.

```bash
/vault-import ~/Downloads/chat-export.zip
```

The first real run: 187 notes built from 342 conversations, linked to 53 existing notes. 55% of a forgotten history, returned in one command.

### Auto-classification

Drop a raw thought in the inbox. The engine reads it, decides what it is (principle, idea, project, research, reference), writes the frontmatter, suggests the folder, and links 3 to 5 related notes. Zero decisions at capture time.

### Adaptive structure

The vault learns how you think. After 50 notes it sees the pattern: 23 notes about pricing, want a folder? After 200 it names the emerging themes. Structure follows usage, never a template.

### Forward references

When the engine meets a concept that should exist, it leaves a gray link. Weekly triage creates the missing note if the concept earned it, or removes the link if it was noise. No invented stubs.

### Permission levels

Conservative (classify and link, never file without approval), moderate (file, flag uncertainty), aggressive (full autonomy). Change anytime in one file.

### Self-repair

Tell the engine what broke. It reads its own source, diagnoses the fault, and fixes itself. No manual repairs, no reinstallation.

## What this engine is not

- **Not a SaaS.** Installed locally, run locally, owned by you.
- **Not a replacement for Obsidian.** Obsidian is the surface. The engine is the automation.
- **Not AI-generated noise.** Every note passes the vault's quality standards before it lands.
- **Not a clone of any AI's memory.** This is your knowledge, structured your way, queryable by any AI you choose.

## Documentation

| Doc | What is inside |
| --- | --- |
| [docs/getting-started.md](docs/getting-started.md) | Installation, configuration, first capture |
| [docs/installation-windows.md](docs/installation-windows.md) | Full Windows walkthrough |
| [docs/architecture.md](docs/architecture.md) | How the engine works |
| [docs/daily-workflow.md](docs/daily-workflow.md) | What happens each day |
| [docs/customization.md](docs/customization.md) | Adapting the engine |
| [docs/faq.md](docs/faq.md) | Questions and troubleshooting |
| [docs/FUNCTIONAL_GAPS.md](docs/FUNCTIONAL_GAPS.md) | Known limits, planned improvements |

## Project

[Contributing](CONTRIBUTING.md), [Security](SECURITY.md), [Changelog](CHANGELOG.md), [License](LICENSE)
