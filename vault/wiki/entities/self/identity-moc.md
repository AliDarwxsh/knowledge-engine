---
title: "Identity MOC — Map of Content for Self"
summary: "Machine-queryable map of the operator's identity cluster. Aggregates identity notes, values, narrative arcs, and principles."
date: 2026-06-26
tags: [moc, identity, self, machine-layer]
ai_context: "Hermes uses this MOC to answer questions about who the operator is. Cross-link with principles, decisions, and timeline entries when reasoning about identity."
---

# Identity MOC

> A machine-readable map of who the operator is — and who they are becoming.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/entities/self/` |
| Mirror | [[01 Identity\|01 Identity]] (Human Layer) |
| Owner | Operator-writable; AI-readable |
| Source-of-truth | [[01 Identity\|01 Identity]] |

---

## Identity Dimensions

The identity cluster organizes around six dimensions:

| Dimension | Question | Linked Cluster |
|-----------|----------|----------------|
| **Values** | What does the operator refuse to compromise on? | [[wiki/concepts/principles/principles-moc\|principles-moc]] |
| **Roles** | What roles does the operator currently inhabit? | [[wiki/entities/projects/project-moc\|project-moc]] |
| **Narrative** | What story does the operator tell about themselves? | [[wiki/journal/timeline/timeline-moc\|timeline-moc]] |
| **Capabilities** | What can the operator demonstrably do? | [[wiki/entities/projects/project-moc\|project-moc]] |
| **Tensions** | Where is the operator in internal conflict? | [[wiki/synthesis/00-synthesis-engine-hub\|synthesis-hub]] |
| **Trajectory** | Where is the operator heading? | [[wiki/concepts/principles/principles-moc\|principles-moc]] |

---

## Identity Edge Schema

```yaml
identity_node:
  id: identity-<slug>
  type: claim | role | value | narrative
  status: canonical | draft | disputed
  first_recorded: YYYY-MM-DD
  last_updated: YYYY-MM-DD
  sources:
    - "[[01 Identity/identity-statement]]"
  cross_links:
    principles: ["[[02 Principles/principle-name]]"]
    decisions: ["[[06 Decision Archive/decision-name]]"]
    projects: ["[[03 Projects/project-name]]"]
  confidence: low | medium | high | load-bearing
```

---

## Identity ↔ Principles

Identity claims without principles are wishes. The strongest identity nodes have at least one load-bearing principle attached.

| Identity Claim | Linked Principle |
|----------------|------------------|
| _populate after onboarding_ | _populate after first principle extraction_ |

---

## Identity ↔ Decisions

The strongest signal of identity is decision history. The cluster cross-references every load-bearing principle with at least three decisions in [[wiki/journal/decisions/decision-archive-moc|decision-archive-moc]].

---

## Identity ↔ Timeline

Identity is not static. Every revision of an identity claim gets a [[wiki/journal/timeline/timeline-moc|timeline]] entry.

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "Who is the operator?" | Values table above → [[01 Identity\|01 Identity]] |
| "What does the operator value most?" | [[wiki/concepts/principles/principles-moc\|principles-moc]] sorted by recurrence |
| "How has identity changed?" | [[wiki/journal/timeline/timeline-moc\|timeline-moc]] filtered by `tag: identity` |
| "Where is identity in tension?" | [[wiki/synthesis/00-synthesis-engine-hub\|synthesis-hub]] filtered by `tag: contradiction` |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Identity claim reconciliation | Quarterly | Operator |
| Cross-link with principles | Monthly | [[schema/agents\|Cartographer]] |
| Tension scan | Quarterly | [[schema/agents\|Synthesist]] |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[01 Identity\|01 Identity]] (Human Layer)
- [[wiki/concepts/principles/principles-moc\|Principles MOC]]
- [[wiki/synthesis/00-synthesis-engine-hub\|Synthesis Hub]]

---

*Identity is a graph, not a sentence.*