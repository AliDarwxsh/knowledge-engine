---
title: "Project MOC — Map of Content for Projects"
summary: "Machine-queryable map of every project in the vault. Aggregates project notes, status, pipelines, and outputs."
date: 2026-06-26
tags: [moc, projects, machine-layer]
ai_context: "Hermes uses this MOC to reason about active projects. Use it when answering 'what is the operator working on?', 'what should I prioritize?', or 'what depends on X?'."
---

# Project MOC

> Every project the operator is shipping, planning, or maintaining — in one queryable map.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/entities/projects/` |
| Mirror | [[03 Projects\|03 Projects]] (Human Layer) |
| Owner | Operator-writable; AI-readable |
| Source-of-truth | [[03 Projects\|03 Projects]] |

---

## Project Status Vocabulary

| Status | Definition |
|--------|------------|
| `planning` | Defined, not yet started |
| `active` | Receiving weekly attention |
| `paused` | Deliberately stopped; resumable |
| `shipping` | Outputs going out this week |
| `archived` | Closed; preserved for reference |

---

## Project Edge Schema

```yaml
project_node:
  id: project-<slug>
  status: planning | active | paused | shipping | archived
  started: YYYY-MM-DD
  last_action: YYYY-MM-DD
  next_action: "<verb> <object>"
  pipeline:
    inputs: [...]
    process: [...]
    outputs: [...]
    feedback: [...]
  cross_links:
    principles: ["[[02 Principles/principle-name]]"]
    decisions: ["[[06 Decision Archive/decision-name]]"]
    people: ["[[12 Relationship Maps/person-name]]"]
    frameworks: ["[[05 Framework Library/framework-name]]"]
  health: green | yellow | red
```

---

## Active Projects Index

| Project | Status | Next Action | Health |
|---------|--------|-------------|--------|
| _populate after onboarding_ | _ | _ | _ |

---

## Project ↔ Principles

Every project cites the principles it embodies. The strongest projects cite 2–3 load-bearing principles.

## Project ↔ Decisions

Major project pivots and commitments get archived in [[wiki/journal/decisions/decision-archive-moc|decision-archive-moc]].

## Project ↔ People

Projects rarely ship alone. Cross-link to [[wiki/entities/people/relationship-moc|relationship-moc]] for every collaborator.

## Project ↔ Frameworks

A project that applies 2+ [[wiki/concepts/frameworks/frameworks-moc|frameworks]] is better-understood than one that applies none.

---

## Pipeline Audit

Every project should have all four pipeline stages populated. Audited monthly:

| Stage | Required? |
|-------|-----------|
| Inputs | Yes |
| Process | Yes |
| Outputs | Yes |
| Feedback | Yes — without feedback, the project is a task list |

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "What is active?" | Active Projects Index above |
| "What is stalled?" | Health = red or no `last_action` in 30+ days |
| "What depends on X?" | Cross-link graph (people, decisions, principles) |
| "What can ship this week?" | Filter by `status = shipping` |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Status reconciliation | Weekly | Operator |
| Health check | Monthly | [[schema/agents\|Cartographer]] |
| Pipeline audit | Monthly | [[schema/agents\|Auditor]] |
| Archive dormant | Quarterly | Operator |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[03 Projects\|03 Projects]] (Human Layer)
- [[wiki/entities/self/identity-moc\|Identity MOC]]
- [[wiki/journal/decisions/decision-archive-moc\|Decision Archive MOC]]
- [[templates/project-note\|Project Note Template]]

---

*Projects are loops. The MOC is the dashboard.*