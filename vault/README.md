---
title: "README — Knowledge Archive"
summary: "The definitive guide to a dual-layer knowledge system: a Human Layer of workflow portals above, a Machine Layer of AI-maintained intelligence below."
date: 2026-06-26
tags: [meta, readme, architecture, onboarding, dual-layer]
---

# Knowledge Archive — README

> A dual-layer knowledge system. The Human Layer captures, navigates, decides. The Machine Layer connects, synthesizes, audits.

---

## What This Is

The Knowledge Archive is a **living intelligence system**, not a storage container. It documents a single operator's intellectual evolution, identity, principles, projects, and accumulated knowledge across time. It runs on a **dual-layer architecture** inspired by Andrej Karpathy's LLM-Wiki pattern: a human-facing surface on top, a machine-maintained graph underneath.

| Layer | Location | Purpose | Primary User |
|-------|----------|---------|--------------|
| **Human Layer** | `00 Inbox/` through `13 Meta Analysis/` | Workflow portals, navigation anchors, daily use | The operator |
| **Machine Layer** | `wiki/`, `sources/`, `schema/` | Knowledge graph, immutable sources, governance | AI agents |

---

## The Human Layer (00–13)

Numbered folders form an intuitive workflow. They are narrative, scannable, and human-readable.

| Folder | Purpose | When to Open |
|--------|---------|--------------|
| [[00 Inbox]] | Capture station for unprocessed material | When something arrives |
| [[01 Identity]] | Who the operator is, who they are becoming | When facing identity questions |
| [[02 Principles]] | Load-bearing rules for decisions | When facing hard choices |
| [[03 Projects]] | Active work and its architecture | When executing or planning |
| [[04 Knowledge Library]] | Domain knowledge, research, facts | When learning or investigating |
| [[05 Framework Library]] | Mental models and thinking tools | When analyzing or strategizing |
| [[06 Decision Archive]] | Past decisions and their reasoning | When similar decisions arise |
| [[07 Systems & SOPs]] | Repeatable processes and rituals | When doing recurring work |
| [[08 Prompt Library]] | AI prompts and interaction patterns | When working with AI |
| [[09 Research Archive]] | Deep research and source material | When building on prior research |
| [[10 Ideas & Opportunities]] | Possibilities not yet pursued | When seeking new directions |
| [[11 Timeline]] | Chronological record of events | When tracing history or causes |
| [[12 Relationship Maps]] | People, networks, and dynamics | When navigating relationships |
| [[13 Meta Analysis]] | The vault analyzing itself | When improving the system |

See [[Knowledge Archive Home]] for the navigation hub.

---

## The Machine Layer

The Machine Layer is a Karpathy-inspired three-tier stack maintained by AI agents.

### `sources/` — Immutable Raw Material

Everything that enters the archive starts here. Once migrated, sources are **never edited**. They are the bedrock of truth — original transcripts, exports, scans, and external artifacts.

### `wiki/` — The Knowledge Graph

The wiki is a graph of entities, concepts, synthesis, and journal entries. Every page carries YAML frontmatter, at least three outgoing [[wikilinks]], and a citation back to its source.

Entry points:
- [[wiki/__graph_index__|Graph Index]] — the master map of all clusters and hubs
- [[wiki/entities/self/identity-moc|Identity MOC]]
- [[wiki/entities/projects/project-moc|Project MOC]]
- [[wiki/entities/people/relationship-moc|Relationship MOC]]
- [[wiki/concepts/principles/principles-moc|Principles MOC]]
- [[wiki/concepts/frameworks/frameworks-moc|Frameworks MOC]]
- [[wiki/concepts/knowledge/knowledge-moc|Knowledge MOC]]
- [[wiki/synthesis/00-synthesis-engine-hub|Synthesis Hub]]
- [[wiki/journal/decisions/decision-archive-moc|Decision Archive MOC]]
- [[wiki/journal/timeline/timeline-moc|Timeline MOC]]
- [[wiki/journal/inbox/inbox-moc|Inbox MOC]]

### `schema/` — Governance and Standards

The schema directory defines how the archive operates. It is the constitution of the system. See [[schema/CLAUDE|schema/CLAUDE.md]] for the three-layer rule architecture, [[schema/agents|agents.md]] for agent roles, [[schema/ontology|ontology.md]] for the tag taxonomy, [[schema/terminology|terminology.md]] for the glossary, and [[schema/copywriting-standards|copywriting-standards.md]] for the style guide.

### `workflows/` — Callable Operations

Four workflows automate archive maintenance. See [[workflows/inbox-triage|inbox-triage.md]], [[workflows/daily-rhythm|daily-rhythm.md]], [[workflows/forward-references|forward-references.md]], and [[workflows/maintenance-protocol|maintenance-protocol.md]].

### `templates/` — Note Scaffolds

Reusable scaffolds for every note type: [[templates/daily-note|daily-note.md]], [[templates/evergreen-note|evergreen-note.md]], [[templates/principle-note|principle-note.md]], [[templates/project-note|project-note.md]], [[templates/literature-note|literature-note.md]], [[templates/meeting-note|meeting-note.md]].

---

## Conventions

### Filenames
- `kebab-case.md` for every file
- No spaces, no special characters except hyphens
- Descriptive, specific, publication-ready titles

### YAML Frontmatter
Every file begins with:
```yaml
---
title: "The Exact Title of This Page"
summary: "One sentence summarizing the core insight."
date: 2026-06-26
tags: [concept, framework, decision]
---
```

### Wikilinks
- Format: `[[path/to/file|Display Text]]`
- Display text must be descriptive and scannable
- Every page targets ≥3 outgoing links and ≥1 incoming link

### Copywriting Standards
All text passes the Copywriting Audit. See [[schema/copywriting-standards|Copywriting Standards]]. Core rules:
- Active voice, concrete nouns, precise verbs
- Zero filler words
- One idea per paragraph, lead with the conclusion
- Headings telegraph content — no generic "Notes" or "Thoughts"
- Callouts (`> [!note]`, `> [!tip]`, `> [!warning]`) for non-negotiable insights

---

## Maintenance Rhythm

| Cadence | Action |
|---------|--------|
| Daily | Five-minute evening inbox pass per [[workflows/daily-rhythm|daily-rhythm.md]] |
| Weekly | Review [[00 Inbox]], process into appropriate sections |
| Monthly | Review [[13 Meta Analysis]] for quality drift, run a health check |
| Quarterly | Deep read of [[wiki/synthesis/00-synthesis-engine-hub|Synthesis Hub]], reconcile the wiki |
| Annually | Full audit, eliminate duplicates, update evolution map |

See [[workflows/maintenance-protocol|maintenance-protocol.md]] for the full schedule with time budgets.

---

## Architecture History

| Version | Date | Changes |
|---------|------|---------|
| v1.0 | 2026-06-26 | Dual-layer template published. Human Layer (00–13) scaffolded. Machine Layer (wiki/, sources/, schema/) initialized. Governance files written. Workflows and templates provided. |

---

*Architecture: Dual-Layer System v1.0 — Public Template*  
*Last updated: 2026-06-26*