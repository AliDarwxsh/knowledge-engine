---
title: "Decision Archive MOC — Map of Content for Decisions"
summary: "Machine-queryable map of every decision in the vault. Indexed by date, domain, reversibility, and principles applied."
date: 2026-06-26
tags: [moc, decisions, journal, machine-layer]
ai_context: "Hermes uses this MOC to retrieve precedents when reasoning about a new decision. Always check this MOC before recommending action on a decision with a precedent."
---

# Decision Archive MOC

> Every decision is a precedent. The MOC is the index of precedents.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/journal/decisions/` |
| Mirror | [[06 Decision Archive\|06 Decision Archive]] (Human Layer) |
| Owner | Operator-writable; AI-readable |

---

## Reversibility Vocabulary

| Reversibility | Definition | Weight in Decision-Making |
|---------------|------------|---------------------------|
| `reversible` | Easy to undo within weeks | Default weight: low |
| `costly-reversible` | Undoable but expensive (weeks–months) | Default weight: medium |
| `irreversible` | Effectively permanent | Default weight: high |

> [!note] **Reversibility drives weight.** A reversible decision can be made on less evidence than an irreversible one.

---

## Decision Edge Schema

```yaml
decision_node:
  id: decision-<YYYY-MM-DD>-<slug>
  decided: YYYY-MM-DD
  domain: <top-level>
  status: pending | decided | executed | retracted
  reversibility: reversible | costly-reversible | irreversible
  confidence_at_decision: low | medium | high
  outcome_recorded: YYYY-MM-DD | null
  outcome_match: matched | better-than | worse-than | unknown
  cross_links:
    principles: ["[[02 Principles/principle-name]]"]
    projects: ["[[03 Projects/project-name]]"]
    frameworks: ["[[05 Framework Library/framework-name]]"]
    people: ["[[12 Relationship Maps/person-name]]"]
```

---

## Decisions Index

| Decision | Date | Reversibility | Outcome |
|----------|------|---------------|---------|
| _populate after first decision_ | — | — | — |

---

## Outcome Capture Rule

Every decision MUST eventually have an `outcome_recorded` field:

| Outcome | Definition |
|---------|------------|
| `matched` | Predicted outcome materialized as expected |
| `better-than` | Outcome exceeded prediction |
| `worse-than` | Outcome underperformed prediction |
| `unknown` | Outcome not yet observable; mark and revisit |

> [!warning] **An archive without outcomes is a log, not a learning system.** Force outcome capture during quarterly review.

---

## Decisions ↔ Principles

Every load-bearing principle in [[wiki/concepts/principles/principles-moc|principles-moc]] must cite at least three decisions.

## Decisions ↔ Frameworks

A decision that cites no framework is unforced. A decision that cites 3+ frameworks is overanalyzed. The sweet spot is 1–2 frameworks per decision.

## Decisions ↔ Identity

Major decisions may surface identity dimensions; tag with `identity_dimension: <dimension>`.

---

## Precedent Retrieval

Before making a decision with a precedent:

1. Search the MOC for similar `domain` and `reversibility`.
2. Read the precedent's reasoning (not just the outcome).
3. Apply [[workflows/forward-references|forward-references]] if the precedent is incomplete.
4. Record the new decision with full context.

---

## Promotion Criteria

A note in [[10 Ideas & Opportunities|10 Ideas]] or an inbox decision moment becomes a **decision note** when:

1. The decision has been made (not just considered).
2. The reasoning is captured at the moment of choice.
3. The principles are explicitly cited.
4. The alternatives are listed (at least two).

A decision is **retracted** when:

1. The decision is reversed before the outcome is observable.
2. The retraction itself becomes a new decision note with full context.

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "Have I decided this before?" | Filter by `domain` and `reversibility` |
| "What were my predictions vs outcomes?" | Filter by `outcome_match` |
| "Which decisions were based on principle X?" | Reverse lookup via principle cross-link |
| "What is the strongest precedent?" | Sort by `confidence_at_decision` and `outcome_match` |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Outcome capture pass | Monthly | Operator |
| Confidence calibration | Quarterly | Operator |
| Retraction scan | Quarterly | [[schema/agents\|Auditor]] |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[06 Decision Archive\|06 Decision Archive]] (Human Layer)
- [[wiki/concepts/principles/principles-moc\|Principles MOC]]
- [[wiki/synthesis/00-synthesis-engine-hub\|Synthesis Hub]]

---

*Record the precedent, not just the outcome.*