---
title: "Graph Index — Master Map of the Knowledge Graph"
summary: "The single master map of every cluster, hub, and major node in the wiki. The first thing to load on session start."
date: 2026-06-26
tags: [graph-index, master-map, hub, moc, machine-layer]
ai_context: "Hermes must load this file on session start. It is the canonical entry point for navigating the wiki graph. If a cluster or hub does not appear here, it is incomplete."
---

# Graph Index — Master Map

> One index. Every node. Start here.

---

## Purpose

The Graph Index is the **single canonical map** of every cluster, hub, and major node in the wiki. It exists so that any AI agent (or operator) can orient in seconds. If a hub is not linked here, the hub is incomplete.

> [!note] **Loading protocol:** On session start, Hermes reads `wiki/__graph_index__.md` first, then the cluster MOC relevant to the user's question.

---

## Cluster Map

```
wiki/
├── entities/                    [Things that exist]
│   ├── self/                    → identity-moc.md
│   ├── projects/                → project-moc.md
│   └── people/                  → relationship-moc.md
│
├── concepts/                    [Ideas that organize thinking]
│   ├── principles/              → principles-moc.md
│   ├── frameworks/              → frameworks-moc.md
│   └── knowledge/               → knowledge-moc.md
│
├── synthesis/                   → 00-synthesis-engine-hub.md
│
└── journal/                     [Dated records]
    ├── decisions/               → decision-archive-moc.md
    ├── timeline/                → timeline-moc.md
    └── inbox/                   → inbox-moc.md
```

---

## Cluster Hubs

| Cluster | Hub | Purpose |
|---------|-----|---------|
| `entities/self/` | [[wiki/entities/self/identity-moc\|identity-moc.md]] | Who the operator is |
| `entities/projects/` | [[wiki/entities/projects/project-moc\|project-moc.md]] | Active and archived projects |
| `entities/people/` | [[wiki/entities/people/relationship-moc\|relationship-moc.md]] | People and networks |
| `concepts/principles/` | [[wiki/concepts/principles/principles-moc\|principles-moc.md]] | Load-bearing principles |
| `concepts/frameworks/` | [[wiki/concepts/frameworks/frameworks-moc\|frameworks-moc.md]] | Mental models and frameworks |
| `concepts/knowledge/` | [[wiki/concepts/knowledge/knowledge-moc\|knowledge-moc.md]] | Domain knowledge index |
| `synthesis/` | [[wiki/synthesis/00-synthesis-engine-hub\|00-synthesis-engine-hub.md]] | Cross-domain insights |
| `journal/decisions/` | [[wiki/journal/decisions/decision-archive-moc\|decision-archive-moc.md]] | Decision archive |
| `journal/timeline/` | [[wiki/journal/timeline/timeline-moc\|timeline-moc.md]] | Chronological record |
| `journal/inbox/` | [[wiki/journal/inbox/inbox-moc\|inbox-moc.md]] | Processed inbox items |

---

## Cross-Cluster Edges

The strongest cross-cluster relationships:

| From | To | Relationship |
|------|-----|--------------|
| `entities/self/` | `concepts/principles/` | Identity ↔ principles |
| `entities/projects/` | `concepts/frameworks/` | Projects ↔ applied frameworks |
| `entities/projects/` | `concepts/principles/` | Projects ↔ embodied principles |
| `journal/decisions/` | `concepts/principles/` | Decisions ↔ principles applied |
| `journal/decisions/` | `entities/projects/` | Decisions ↔ project context |
| `synthesis/` | `concepts/*` | Synthesis ↔ all concept clusters |
| `synthesis/` | `journal/*` | Synthesis ↔ all journal clusters |

> [!tip] **When in doubt, follow the cross-cluster edges.** Most high-signal nodes have at least three edges leaving their cluster.

---

## Orphan and Contradiction Flags

| Flag | Meaning | Action |
|------|---------|--------|
| `[ORPHAN]` | Node has no incoming links | Add inbound [[wikilinks]] from MOCs |
| `[CONFLICT]` | Two nodes make opposing claims | Open synthesis note |
| `[STALE]` | Node untouched for >12 months | Review or deprecate |

These flags are surfaced by the [[schema/agents|Auditor]] during the monthly lint.

---

## Maintenance

- **Weekly:** Orphan check, link suggestions.
- **Monthly:** Contradiction scan, cluster reconciliation.
- **Quarterly:** Hub health review, archive deprecated nodes.

See [[workflows/maintenance-protocol|maintenance-protocol.md]].

---

## Related

- [[wiki/README|wiki/README.md]] — wiki overview
- [[schema/CLAUDE|schema/CLAUDE.md]] — governance
- [[schema/agents|schema/agents.md]] — agent roles
- [[README|README.md]] — vault overview

---

*If a node is not on this map, it does not exist.*