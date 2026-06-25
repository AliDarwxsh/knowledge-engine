---
title: "Timeline MOC — Map of Content for Chronology"
summary: "Machine-queryable map of every dated entry in the vault. Indexed by date, event type, and entities involved."
date: 2026-06-26
tags: [moc, timeline, chronology, journal, machine-layer]
ai_context: "Hermes uses this MOC to retrieve historical context. Use when reasoning about 'when did X happen?', 'what was the state on date Y?', or building retrospectives."
---

# Timeline MOC

> The vault does not forget. It dates.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/journal/timeline/` |
| Mirror | [[11 Timeline\|11 Timeline]] (Human Layer) |
| Owner | Operator-writable; AI-readable |
| Edit policy | Append-only |

---

## Event Type Vocabulary

| Event Type | Definition | Example |
|------------|------------|---------|
| `daily` | A day of activity or reflection | Daily notes |
| `milestone` | A significant event with lasting impact | Project launch, role change |
| `revision` | A note edited in another folder | Identity claim updated |
| `decision` | A decision made | Archived decision date |
| `project-event` | A project state change | Started, paused, shipped |
| `relationship-event` | A relationship state change | First contact, parting |
| `system-event` | A vault-level change | Workflow added, schema revised |

---

## Timeline Edge Schema

```yaml
timeline_node:
  id: timeline-<YYYY-MM-DD>-<slug>
  date: YYYY-MM-DD
  event_type: daily | milestone | revision | decision | project-event | relationship-event | system-event
  entities_involved:
    people: ["[[12 Relationship Maps/person-name]]"]
    projects: ["[[03 Projects/project-name]]"]
    principles: ["[[02 Principles/principle-name]]"]
  cross_links:
    - "[[06 Decision Archive/decision-name]]"
    - "[[03 Projects/project-name]]"
```

---

## Timeline Index

| Date | Event | Type | Linked Entities |
|------|-------|------|-----------------|
| _populate after first timeline entry_ | — | — | — |

---

## Append-Only Discipline

| Rule | Reason |
|------|--------|
| Never edit past entries | The timeline is a historical record |
| Date every filename with `YYYY-MM-DD-` | Sortability |
| Cite at least one entity in cross_links | The timeline connects to the rest of the vault |
| When a note elsewhere is revised, add a timeline entry | Revision events surface in the chronology |

---

## Granularity Guide

| Cadence | Granularity |
|---------|-------------|
| Personal life | Daily |
| Projects | Weekly state changes + milestones |
| Decisions | Decision date (one entry per decision) |
| Identity | Only on revisions |
| Schema / system | Only on changes |

> [!tip] **A timeline entry is not a journal entry.** A journal entry is reflective; a timeline entry is a fact-with-date.

---

## Cross-Cluster Edges

| Edge | Strong Signal |
|------|---------------|
| Timeline ↔ Decisions | Every decision has a timeline entry on its date |
| Timeline ↔ Projects | Every project state change has a timeline entry |
| Timeline ↔ Identity | Every identity revision has a timeline entry |
| Timeline ↔ Relationships | First contacts, partings, and major interactions |

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "What happened on date X?" | Filter by `date` |
| "When did project Y start?" | Reverse lookup via project cross-link |
| "What changed in the system?" | Filter by `event_type = system-event` |
| "What did the operator do in month Y?" | Filter by date range |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Daily entry | Daily | Operator |
| Milestone capture | Per event | Operator |
| Schema event log | Per change | [[schema/agents\|Schema Keeper]] |
| Quarterly prune | Quarterly | Operator (move dormant entries to `archive/`) |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[11 Timeline\|11 Timeline]] (Human Layer)
- [[wiki/journal/decisions/decision-archive-moc\|Decision Archive MOC]]
- [[13 Meta Analysis\|13 Meta Analysis]] — quarterly review uses the timeline

---

*The spine of the vault runs through this MOC.*