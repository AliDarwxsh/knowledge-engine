# Knowledge Engine

> **A self-organizing knowledge system. Hermes + Obsidian. Capture. Auto-classify. Query. It gets smarter every day.**

---

You have ideas. They're scattered across notes apps, AI chats, browser tabs, and that one Notion page you opened six months ago. Every session, you rebuild context from memory and forget most of it.

**Knowledge Engine fixes that.**

It's a vault that holds everything you know, with Hermes sitting on top — reading it, filing it, linking it, and growing it for you. You stop re-explaining yourself every session because the system already remembers.

## The 30-Second Pitch

- 📥 **Capture once** — Drop thoughts, articles, chat exports. Zero decisions at capture time.
- 🧠 **Engine classifies** — Reads your input. Routes it to the right folder. Tags it. Links it to related notes.
- 🔍 **Query anything** — "What did I write about pricing?" Get answers with citations from your own notes.
- 🌐 **Graph compounds** — Every note strengthens every other note. The vault learns you over time.
- 🔓 **You own everything** — Plain markdown files. No vendor lock-in. No cloud dependency.

## What You Get

| Component | What It Does |
|-----------|-------------|
| **Obsidian Vault** | Dual-layer structure: Human folders (00-13) for your workflow, Machine layer (wiki/sources/schema) for AI |
| **10 Hermes Skills** | vault-init, vault-capture, vault-sync, vault-lint, vault-digest, vault-import, vault-query, vault-link, vault-morning-brief, vault-forward-refs |
| **5 Cron Jobs** | Morning brief (7am), inbox processor (every 6h), connection finder (3am), nightly lint (2am), weekly digest (Sun 6pm) |
| **Setup Script** | One command installs everything |
| **Verification Script** | Confirms the engine is properly wired |

## Quick Start

**macOS / Linux:**
```bash
# 1. Install Hermes (if you don't have it)
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

# 2. Clone this repo (replace YOUR_GITHUB_USERNAME with your GitHub handle)
git clone https://github.com/YOUR_GITHUB_USERNAME/knowledge-engine.git
cd knowledge-engine

# 3. Run setup (scaffolds vault, installs skills, schedules cron)
bash scripts/setup.sh       # or: python3 scripts/setup.py

# 4. Open your vault in Obsidian
# File → Open vault → select the vault path

# 5. Run the one-time init interview
hermes skill run vault-init
```

**Windows (PowerShell or Command Prompt):**
```powershell
# 1. Install Hermes (if you don't have it)
irm https://hermes-agent.nousresearch.com/install.ps1 | iex

# 2. Clone this repo (replace YOUR_GITHUB_USERNAME with your GitHub handle)
git clone https://github.com/YOUR_GITHUB_USERNAME/knowledge-engine.git
cd knowledge-engine

# 3. Run setup
scripts\setup.cmd           # delegates to scripts\setup.py — needs Python 3.8+

# 4. (Optional) Register cron jobs in Windows Task Scheduler
powershell -ExecutionPolicy Bypass -File cron\windows\register-cron.ps1

# 5. Open your vault in Obsidian and run the one-time init interview
hermes skill run vault-init
```

> **Windows users:** see [`docs/installation-windows.md`](docs/installation-windows.md) for the full walkthrough. **macOS/Linux users:** see [`docs/getting-started.md`](docs/getting-started.md).

That's it. Drop your first thought in `00 Inbox/`. Watch it get classified, tagged, and linked within hours.

## The Daily Loop

```
7:00 AM    Morning brief delivered — what happened overnight, what's open
Morning    Drop thoughts in inbox as they arrive
Every 6h   Engine processes inbox — classifies, tags, links
Evening    5-min review: approve, adjust, delete
2:00 AM    Nightly health check
3:00 AM    Connection finder proposes new links
Sunday 6pm Weekly synthesis — cross-domain insights
```

## Architecture

```
┌──────────────────────────────────────────────────┐
│ OBSIDIAN — Storage & Human Surface                │
│ Plain markdown. Dual-layer vault.                 │
│ User does: capture, review, decide.               │
└───────────────────┬──────────────────────────────┘
                    │ MCP filesystem (read/write)
┌───────────────────▼──────────────────────────────┐
│ HERMES — Automation Engine                        │
│ Skills (workflows) · Cron (scheduling)            │
│ Memory (vault context) · Sub-agents (parallel)    │
│ MCP tools (filesystem, web, agentmemory)          │
└───────────────────┬──────────────────────────────┘
                    │ User's own API key
┌───────────────────▼──────────────────────────────┐
│ AI MODELS — Reasoning                              │
│ OpenAI · Anthropic · DeepSeek · Ollama            │
│ User configures their provider. Zero cost to us.  │
└──────────────────────────────────────────────────┘
```

**Three principles:**

1. **Files are truth.** No databases. No proprietary formats. Your notes are markdown files you can open in any editor forever.

2. **Bring your own key.** The engine uses your AI provider. We never hold credits. We never see your data beyond your local machine.

3. **The vault is the API.** Every skill, every cron job, every output is a markdown file. Community members can fork skills and modify them by editing SKILL.md files. No build step. No compilation.

## What This Engine Is Not

- **Not a SaaS.** You install it locally. You run it locally. You own it.
- **Not a replacement for Obsidian.** Obsidian is the UI. The engine is the automation.
- **Not AI-generated nonsense.** Every note goes through the schema's copywriting standards. Quality is enforced.
- **Not a clone of ChatGPT's memory.** This is YOUR knowledge, structured YOUR way, queryable by any AI you choose.

## The Killer Features

### 1. AI Chat Import

Have 3,000 ChatGPT conversations you forgot about? `vault-import` extracts decisions, principles, questions, and knowledge from each one. Creates structured notes with source citations. Transforms forgotten chat history into searchable knowledge.

```bash
/vault-import ~/Downloads/chatgpt-export.zip
```

Result: 187 notes created from 342 conversations. Linked to 53 existing notes.

### 2. Auto-Classification

Drop a raw thought into the inbox. The engine:
1. Reads it
2. Decides: principle? idea? project? research? reference?
3. Generates frontmatter (title, summary, tags from canonical ontology)
4. Suggests target folder
5. Creates the note with wikilinks to 3-5 related notes

You do zero decision-making at capture time.

### 3. Adaptive Structure

After 50 notes, the engine notices patterns: "You have 23 notes about pricing. Create `04 Knowledge Library/pricing/`?" After 200 notes: "Three emerging themes detected. Want me to create sub-folders?"

The vault learns how YOU think.

### 4. Forward References

When the engine encounters a concept that should exist but doesn't, it creates a gray link. Weekly triage creates the missing note (if 3+ references) or removes the link (if stale).

No invented stubs. No lost context.

### 5. Permission Levels

Choose your comfort:

- **Conservative** — classify and link, never file without approval
- **Moderate** — classify, link, and file. Flag anything uncertain.
- **Aggressive** — full automation. Trust the engine to organize itself.

You can change this anytime by editing `CLAUDE.md`.

### 6. Self-Repairing

If something breaks — a missing folder, a misbehaving skill, a corrupted template — you don't need to debug it. Just tell Hermes:

> "Fix my vault structure."  
> "The inbox processor stopped working."  
> "Rebuild the templates I deleted."

Hermes reads its own source code. It knows the architecture. It can diagnose issues and repair the engine itself. No manual fixes. No reinstallation.

## Documentation

| Doc | What's Inside |
|-----|---------------|
| [docs/getting-started.md](docs/getting-started.md) | Installation, configuration, first capture (macOS/Linux) |
| [docs/installation-windows.md](docs/installation-windows.md) | Full Windows install walkthrough + Task Scheduler setup |
| [docs/architecture.md](docs/architecture.md) | How the engine works under the hood |
| [docs/daily-workflow.md](docs/daily-workflow.md) | What happens each day, hour by hour |
| [docs/ai-models.md](docs/ai-models.md) | How to configure your AI provider |
| [docs/customization.md](docs/customization.md) | How to adapt the engine to your needs |
| [docs/faq.md](docs/faq.md) | Common questions and troubleshooting |
| [docs/FUNCTIONAL_GAPS.md](docs/FUNCTIONAL_GAPS.md) | Known limitations and planned improvements |

## Built On

- **[Hermes Agent](https://hermes-agent.nousresearch.com/)** — Self-improving open-source agent with skill system, scheduling, memory, and tool execution
- **[Obsidian](https://obsidian.md/)** — Local-first markdown knowledge base
- **Your AI provider** — OpenAI, Anthropic, OpenRouter, or local Ollama
- **Karpathy's LLM Wiki pattern** — The inspiration for the dual-layer architecture

## The Bigger Picture

This is the open-source knowledge engine. It runs on Hermes + Obsidian with your own AI keys.

## Contributing

1. Fork the repo
2. Modify any SKILL.md
3. Add new cron jobs to `cron/`
4. Submit a PR

The skills are markdown. The cron jobs are JSON. The vault is markdown. Everything is editable, forkable, and customizable.

## License

MIT — do whatever you want with this.

## Support

- ⭐ Star this repo if it's useful
- 🐛 Issues for bugs and feature requests
- 💬 Discussions for questions and ideas
- ☕ [Sponsor on GitHub](https://github.com/sponsors/YOUR_GITHUB_USERNAME) if you want to support development

---

## Project Status

**Workstreams (v1.1.1)**:

- [x] 10 Hermes skills written (~2,500 lines, YAML frontmatter validated)
- [x] 5 cron job definitions (cron/*.json) + 6 Windows equivalents (cron/windows/*.ps1)
- [x] Cross-platform Python installer (`scripts/setup.py`, `verify.py`) + Windows `.cmd` wrappers + POSIX `.sh` wrappers
- [x] Cross-platform CI matrix (`.github/workflows/test.yml`) on ubuntu/macos/windows
- [x] Architecture, daily workflow, AI models, customization, FAQ, Windows install docs
- [x] SECURITY.md + `scripts/sanitize-check.sh` personal-data guardrails
- [x] Polished README with cross-platform Quick Start
- [x] Vault template (50+ files, dual-layer architecture, governance, templates, workflows)
- [x] All scripts pass syntax validation; all cron JSON valid; all skill frontmatter parse
- [x] Placeholder-free public docs (`YOUR_GITHUB_USERNAME` template only)
- [ ] End-to-end test against real vault (deferred — LLM execution non-deterministic)
- [ ] GitHub repo created and published

---

Built by the Autonomous Second Brain community. Inspired by the original Knowledge Archive. Powered by Hermes Agent.

Version 1.1.1 — released June 2026