---
title: "Relationship MOC — Map of Content for People"
summary: "Machine-queryable map of every person, organization, and network in the operator's life."
date: 2026-06-26
tags: [moc, relationships, people, networks, machine-layer]
ai_context: "Hermes uses this MOC to reason about collaborators, advisors, peers, and acquaintances. Treat person notes as private — read-only, never export externally."
---

# Relationship MOC

> People are not nodes. They are the reasons the graph exists.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/entities/people/` |
| Mirror | [[12 Relationship Maps\|12 Relationship Maps]] (Human Layer) |
| Owner | Operator-writable; AI-readable |
| Privacy | Treat all person data as confidential |

> [!warning] **Person notes are private.** AI may read but must not export or share externally. See [[schema/agents|agents.md]].

---

## Relationship Taxonomy

| Type | Definition | Cadence |
|------|------------|---------|
| `mentor` | Provides guidance the operator does not have | Monthly+ |
| `peer` | Mutual exchange of value | Weekly–monthly |
| `collaborator` | Active shared project | Weekly |
| `client` | Service-for-value exchange | Per-engagement |
| `personal` | Family, friends, intimate | Variable |
| `acquaintance` | Known but low-frequency | Quarterly+ |
| `dormant` | Inactive; preserved for history | None |

---

## Person Edge Schema

```yaml
person_node:
  id: person-<slug>
  type: mentor | peer | collaborator | client | personal | acquaintance | dormant
  first_contact: YYYY-MM-DD
  last_interaction: YYYY-MM-DD
  cadence: weekly | monthly | quarterly | variable | none
  trust: low | medium | high
  cross_links:
    projects: ["[[03 Projects/project-name]]"]
    decisions: ["[[06 Decision Archive/decision-name]]"]
    identity: ["[[01 Identity/dimension-name]]"]
  notes: "[[12 Relationship Maps/person-name]]"
```

---

## Cadence Audit

| Status | Definition | Action |
|--------|------------|--------|
| `fresh` | Last interaction within cadence window | None |
| `cooling` | Past cadence but <2x window | Reach out |
| `stale` | Past 2x window | Mark dormant or re-engage |
| `dormant` | No interaction in 6+ months | Preserve as dormant |

---

## Relationship ↔ Projects

The strongest signal of a working relationship is shared projects. Cross-link to [[wiki/entities/projects/project-moc|project-moc]].

## Relationship ↔ Decisions

Major decisions about people — hiring, partnering, parting — get archived in [[wiki/journal/decisions/decision-archive-moc|decision-archive-moc]].

## Relationship ↔ Identity

Some relationships activate specific identity dimensions. Tag with `identity_dimension: <dimension>`.

---

## Network Maps

Beyond individual people, the operator maintains network maps — diagrams of how clusters of people relate:

| Network | Description | Last Updated |
|---------|-------------|--------------|
| _populate after onboarding_ | _ | _ |

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "Who is X?" | Person node → [[12 Relationship Maps\|12 Relationship Maps]] |
| "Who is dormant?" | Filter by `type = dormant` |
| "Who shares project Y?" | Reverse lookup via project cross-link |
| "Who is cooling?" | Filter by `status = cooling` |

---

## Privacy Discipline

- Person notes live in [[12 Relationship Maps\|12 Relationship Maps]] and are mirrored into the wiki without private content.
- AI agents **never** export person data outside the vault.
- When generating summaries for external sharing, redact person names unless explicitly approved.

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[12 Relationship Maps\|12 Relationship Maps]] (Human Layer)
- [[wiki/entities/projects/project-moc\|Project MOC]]
- [[wiki/journal/decisions/decision-archive-moc\|Decision Archive MOC]]

---

*A relationship is a graph, not a contact card.*