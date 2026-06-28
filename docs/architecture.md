# Architecture

> How the knowledge-engine works under the hood. Read this if you want to understand the system deeply or extend it.

## The Dual-Layer Vault

The vault is the foundation. It separates where humans write freely from where AI structures knowledge.

### Human Layer (Folders 00–13)

Numbered folders that create a forced workflow order. You navigate and write here.

| Folder | Purpose |
|--------|---------|
| `00 Inbox/` | Single capture point. Everything lands here first. |
| `01 Identity/` | Who you are, who you're becoming. |
| `02 Principles/` | Load-bearing rules. Decision heuristics. |
| `03 Projects/` | Active work. Each project has Inputs/Process/Outputs/Feedback. |
| `04 Knowledge Library/` | Domain facts, research, reference material. |
| `05 Framework Library/` | Mental models, thinking tools. |
| `06 Decision Archive/` | Past decisions and their reasoning. |
| `07 Systems & SOPs/` | Repeatable processes. |
| `08 Prompt Library/` | AI prompts and interaction patterns. |
| `09 Research Archive/` | Deep research artifacts. |
| `10 Ideas & Opportunities/` | Possibilities not yet pursued. |
| `11 Timeline/` | Chronological record. |
| `12 Relationship Maps/` | People, networks. |
| `13 Meta Analysis/` | The vault analyzing itself. |

### Machine Layer (`wiki/`, `sources/`, `schema/`)

Where AI agents write. Where governance lives.

**`sources/`** — Immutable raw material. AI chat exports, browser bookmarks, Google Takeout. Never edited. The bedrock of truth.

**`wiki/`** — The knowledge graph. Entities (people, projects, organizations, self), concepts (principles, frameworks, knowledge), synthesis (cross-domain insights), and journal (decisions, timeline, inbox processing).

**`schema/`** — The constitution. `CLAUDE.md` defines the three-layer rule architecture. `ontology.md` defines the tag taxonomy. `agents.md` defines agent roles and permissions. `copywriting-standards.md` defines voice.

## The Skill System

Each Hermes skill is a `SKILL.md` file with YAML frontmatter. Skills are executable workflows — they read context, take actions, produce output.

```
skills/
├── vault-init/         # One-time setup interview
├── vault-capture/      # Ingest + classify + tag + link
├── vault-sync/        # Reconcile inbox, update MOCs
├── vault-lint/         # 7-check health audit
├── vault-digest/       # Weekly synthesis
├── vault-import/       # Chat export ingestion
├── vault-query/        # Natural language search
├── vault-link/         # Non-obvious connections
├── vault-morning-brief/ # Daily 7am context
└── vault-forward-refs/ # Weekly gray-link triage
```

Every skill declares:
- **What it does** (description)
- **When to invoke** (trigger conditions)
- **Permission boundaries** (where it can read/write)
- **What it doesn't do** (for safety)

Skills are plain markdown. You can read, modify, and fork any skill by editing its SKILL.md.

## The Cron System

5 jobs run on autopilot. Each is a JSON definition that calls a skill on a schedule.

| Schedule | Job | Skill |
|----------|-----|-------|
| `0 7 * * *` | Morning brief | vault-morning-brief |
| `0 */6 * * *` | Inbox processor | vault-capture (batch mode) |
| `0 3 * * *` | Connection finder | vault-link |
| `0 2 * * *` | Nightly lint | vault-lint |
| `0 18 * * 0` | Weekly digest | vault-digest |

Cost estimate: ~$0.15/week with hosted models. $0 with local Ollama.

## The AI Provider Layer

The engine uses your configured AI provider. You bring your own key.

**Supported providers:**

| Provider | Setup |
|----------|-------|
| OpenAI | `export OPENAI_API_KEY=sk-...` |
| Anthropic | `export ANTHROPIC_API_KEY=sk-ant-...` |
| OpenRouter | `export OPENROUTER_API_KEY=sk-or-...` (access any model) |
| Ollama (local) | Run `ollama serve`, no API key needed |

**Model selection strategy:**

- **Default**: GPT-4o-mini or Claude Haiku (cheap, fast, good enough)
- **Complex reasoning**: GPT-4o or Claude Sonnet (more expensive, better for synthesis)
- **Privacy-first**: Ollama with local models (free, slower)

The engine uses the configured model for all operations. Switch any time.

## The Permission Model

Every skill declares permission boundaries in its SKILL.md. This prevents the engine from:
- Modifying governance (`schema/`)
- Editing immutable history (`sources/`)
- Deleting notes without user approval

Additionally, the user sets a **Permission Level** in `CLAUDE.md`:

| Level | Behavior |
|-------|----------|
| **Conservative** | Classify and link only. Never file without approval. |
| **Moderate** | Classify, link, and file. Flag uncertain items. |
| **Aggressive** | Full automation. Trust the engine. |

The permission level applies to skills that auto-apply changes. Read-only skills (vault-query, vault-lint) ignore it.

## The Cost Model

**Per-note classification**: ~2,000 tokens, ~$0.0003 with GPT-4o-mini.

**Daily active user** (5 captures, 1 query): ~$0.005/day = $0.15/month.

**Heavy user** (20 captures/day, 1 digest, 1 lint): ~$0.05/day = $1.50/month.

**With local Ollama**: $0/month (slower, requires local GPU).

The engine never holds credits. The user pays their AI provider directly. The engine is free, open-source, and local — there is nothing to charge for. If you want to support development, the project's GitHub repository has a Sponsor link.

## The Data Flow

```
User has thought
    ↓
Types into 00 Inbox/
    ↓
Inbox processor cron (every 6h) OR /vault-capture command
    ↓
Engine classifies → 02 Principles/ or 04 Knowledge Library/ or etc.
    ↓
Engine generates frontmatter, tags, wikilinks
    ↓
Note written to vault
    ↓
Related MOCs updated by vault-sync
    ↓
Forward references created if concepts don't exist
    ↓
Weekly digest summarizes week's patterns
    ↓
Morning brief surfaces relevant context for the day
```

## Extension Points

**Add a new skill**: Create `skills/your-skill/SKILL.md` with proper frontmatter. The skill becomes available via `/your-skill`.

**Add a new cron job**: Create `cron/your-job.json` with schedule, skill reference, and prompt. Install via `hermes cron install cron/your-job.json`.

**Add a new folder**: Create the folder in vault. Update `schema/CLAUDE.md` to document it. Update skills that reference the new location.

**Add a new AI provider**: Configure via `hermes config set`. The engine uses whatever provider is configured.

**Customize the ontology**: Edit `schema/ontology.md`. All skills read from this file.

**Change voice standards**: Edit `schema/copywriting-standards.md`. All generated notes follow these rules.

## Why This Architecture

Three principles drove these decisions:

1. **Local-first.** Your notes never leave your machine unless you explicitly use a hosted AI model. You can run the entire engine offline with Ollama.

2. **Forkable.** Every skill is a markdown file. Every cron job is JSON. Every vault file is markdown. Community members can modify anything by editing text.

3. **Vendor-neutral.** The engine doesn't lock you to Hermes forever. The vault format (markdown + frontmatter + wikilinks) works in any Obsidian-compatible tool.

The architecture is the floor. The skills are the ceiling. Everything between is yours to shape.

---

*For daily usage patterns, see [docs/daily-workflow.md](daily-workflow.md).*
*For AI provider setup, see [docs/ai-models.md](ai-models.md).*
*For customization, see [docs/customization.md](customization.md).*