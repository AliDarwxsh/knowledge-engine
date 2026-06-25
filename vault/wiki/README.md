---
title: "wiki — The Knowledge Graph"
summary: "Machine-maintained knowledge graph. Entities, concepts, synthesis, and journal entries — all linked, all cited."
date: 2026-06-26
tags: [wiki, knowledge-graph, machine-layer, moc]
ai_context: "Hermes treats wiki/ as its primary read source. Use this index when bootstrapping a session about the operator's accumulated knowledge."
---

# wiki — The Knowledge Graph

> The graph is the long-term memory of the system. The Human Layer is the dashboard.

---

## Purpose

The `wiki/` directory is the **machine-maintained knowledge graph** of the vault. Every page in it is a node in a connected, citable, queryable graph that AI agents (and the operator) can traverse. The wiki is the second tier of the Karpathy-inspired three-tier stack:

1. **`sources/`** — immutable raw material
2. **`wiki/`** — structured, linked knowledge ← you are here
3. **`schema/`** — governance and standards

> [!tip] **Reading order:** schema/CLAUDE.md first (rules), then wiki/ (graph), then sources/ (raw material) when needed.

---

## Directory Map

```
wiki/
├── README.md                    # this file
├── __graph_index__.md           # the master map of all clusters and hubs
├── entities/                    # things that exist
│   ├── self/identity-moc.md
│   ├── projects/project-moc.md
│   └── people/relationship-moc.md
├── concepts/                    # ideas that organize thinking
│   ├── principles/principles-moc.md
│   ├── frameworks/frameworks-moc.md
│   └── knowledge/knowledge-moc.md
├── synthesis/                   # cross-domain insights
│   └── 00-synthesis-engine-hub.md
└── journal/                     # dated and processed records
    ├── decisions/decision-archive-moc.md
    ├── timeline/timeline-moc.md
    └── inbox/inbox-moc.md
```

---

## Cluster Roles

| Cluster | What It Holds | When to Read |
|---------|---------------|--------------|
| `entities/` | Things that exist (people, projects, self) | "Tell me about X" |
| `concepts/` | Ideas that organize thinking (principles, frameworks) | "How does the operator think?" |
| `synthesis/` | Cross-domain insights and emergent patterns | "What patterns connect things?" |
| `journal/` | Dated records: decisions, timeline, inbox | "When did X happen?" |

---

## Node Standards

Every wiki node MUST have:

1. **YAML frontmatter** — `title`, `summary`, `date`, `tags`, plus an `ai_context` line where applicable.
2. **Three or more outgoing [[wikilinks]]**.
3. **One or more incoming links** (no orphans — see [[schema/agents|agents.md]] for the orphan-check rule).
4. **Citation back to source** in `sources/` when the note was distilled from raw material.
5. **Status field** in frontmatter where applicable: `canonical | draft | disputed | deprecated`.

> [!warning] **A wiki node without outgoing links is not yet a wiki node.** It is a draft in `00 Inbox`.

---

## How to Use the Wiki

### As an Operator
- Treat the wiki as the **long-form memory** of the system. When you cannot remember a principle, a project, or a decision, search the wiki before [[06 Decision Archive|06 Decision Archive]].
- Use the [[__graph_index__|Graph Index]] as the master map.
- Use the per-cluster MOC files as you would a table of contents.

### As an AI Agent
- On session start, load the [[__graph_index__|Graph Index]] first.
- Treat every MOC as an entry point for a cluster.
- Before writing, confirm the destination cluster and check [[schema/agents|agents.md]] for write permissions.
- Always cite the source [[wikilinks|source]] of every claim.

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Orphan check | Weekly | [[schema/agents\|Cartographer]] |
| Link-suggestion pass | Monthly | [[schema/agents\|Cartographer]] |
| Contradiction scan | Monthly | [[schema/agents\|Auditor]] |
| Cluster reconciliation | Quarterly | [[schema/agents\|Synthesist]] |

See [[workflows/maintenance-protocol|maintenance-protocol.md]] for the full cadence.

---

## Related

- [[README|README.md]] — vault overview
- [[schema/CLAUDE|schema/CLAUDE.md]] — governance
- [[schema/agents|schema/agents.md]] — agent roles and write permissions
- [[sources/README|sources/README.md]] — immutable raw material
- [[workflows/maintenance-protocol|workflows/maintenance-protocol.md]] — maintenance schedule

---

*The graph is the memory. The graph is the leverage.*