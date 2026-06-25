# Changelog

All notable changes to knowledge-engine will be documented in this file.

## [1.0.0] — 2026-06-26

### Added
- **Dual-layer Obsidian vault template**: Human Layer (00-13) + Machine Layer (wiki/sources/schema) with 50+ pre-built files
- **10 Hermes skills**: vault-init, vault-capture, vault-sync, vault-lint, vault-digest, vault-import, vault-query, vault-link, vault-morning-brief, vault-forward-refs
- **5 cron jobs**: morning-brief (7am), inbox-processor (every 6h), connection-finder (3am), nightly-lint (2am), weekly-digest (Sun 6pm)
- **setup.sh**: One-command installation script with color output and error handling
- **verify.sh**: Installation verification script with 8 check categories
- **Documentation**: architecture.md, daily-workflow.md, ai-models.md, customization.md
- **Governance schema**: CLAUDE.md (3-layer rules), agents.md (permission boundaries), ontology.md (tag taxonomy), terminology.md, copywriting-standards.md (8 voice rules)
- **Workflow docs**: inbox-triage.md, daily-rhythm.md, forward-references.md, maintenance-protocol.md
- **Templates**: daily-note, evergreen-note, principle-note, project-note, literature-note, meeting-note
- **AI chat import pipeline**: vault-import skill supporting ChatGPT, Claude, Gemini, and generic formats
- **Forward reference system**: Gray-link philosophy and weekly triage workflow
- **Permission model**: Conservative/Moderate/Aggressive autonomy levels
- **Cost transparency**: Per-operation token estimates in every skill
- MIT License
- Community contributing guide

### Design Decisions
- Hermes as automation engine (not custom CLI) — leveraging existing scheduling, memory, model routing
- Dual-layer architecture (human + machine) inspired by Karpathy's LLM Wiki pattern
- User-owned AI keys — engine never holds credits
- Local-first, offline-capable with Ollama support
- Skills as markdown files — forkable, editable without build steps
- Permission boundaries enforced per-skill (never touch schema/ or sources/)

### Known Limitations
- Vault-import currently supports text-based chat exports only (JSON/markdown/txt)
- Semantic search uses keyword matching; vector embeddings are a future enhancement
- Cron jobs require Hermes running; no standalone scheduler
- Multi-vault support requires profile switching; not concurrent

---

*Versioning follows SemVer. See CONTRIBUTING.md for release process.*