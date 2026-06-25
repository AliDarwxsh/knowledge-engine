---
title: "Principles MOC — Map of Content for Principles"
summary: "Machine-queryable map of every load-bearing principle in the vault. Indexed by confidence, recurrence, and cross-link density."
date: 2026-06-26
tags: [moc, principles, machine-layer]
ai_context: "Hermes uses this MOC to retrieve principles by topic, confidence, or recurrence. Use when reasoning about a decision, evaluating a new principle candidate, or auditing principle drift."
---

# Principles MOC

> A principle is a rule that has survived contact with reality.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/concepts/principles/` |
| Mirror | [[02 Principles\|02 Principles]] (Human Layer) |
| Owner | Operator-writable; AI-readable |
| Promotion rule | A principle is promoted to the MOC after appearing in ≥3 unrelated decisions |

---

## Confidence Vocabulary

| Confidence | Definition | Treatment |
|------------|------------|-----------|
| `low` | Stated once or twice; not yet tested | Hold lightly |
| `medium` | Tested in 3+ decisions | Cite when relevant |
| `high` | Tested in 10+ decisions across multiple years | Anchor for major decisions |
| `load-bearing` | Tested in 20+ decisions; reverses when violated | Foundation; cite by default |

---

## Principle Edge Schema

```yaml
principle_node:
  id: principle-<slug>
  confidence: low | medium | high | load-bearing
  stated: YYYY-MM-DD
  last_revised: YYYY-MM-DD
  recurrence: <int>     # number of decisions where cited
  domains: [...]        # topical domains where applied
  counter_examples: <int>
  cross_links:
    identity: ["[[01 Identity/dimension]]"]
    projects: ["[[03 Projects/project-name]]"]
    decisions: ["[[06 Decision Archive/decision-name]]"]
    frameworks: ["[[05 Framework Library/framework-name]]"]
```

---

## Principles Index

| Principle | Confidence | Recurrence | Domains |
|-----------|------------|------------|---------|
| _populate after first principle extraction_ | — | — | — |

---

## Cross-Cluster Edges

| Edge | Strong Signal |
|------|---------------|
| Principle ↔ Decision | Every load-bearing principle has ≥3 decisions citing it |
| Principle ↔ Identity | Identity dimensions ground the principle |
| Principle ↔ Project | Active projects cite the principles they embody |
| Principle ↔ Framework | A principle often emerges from applying a framework repeatedly |

---

## Promotion Criteria

A note in [[10 Ideas & Opportunities|10 Ideas]] is **promoted to a principle** when:

1. It has been applied in three or more unrelated decisions.
2. Its opposite prediction is observable (testable).
3. The operator can name it in one sentence.
4. At least one [[05 Framework Library|05 Framework]] supports it.

A principle is **deprecated** when:

1. It has not been cited in any decision for 12+ months.
2. A counter-example has emerged that the principle does not accommodate.
3. A [[wiki/synthesis/00-synthesis-engine-hub|synthesis note]] explains the supersession.

Deprecated principles move to [[11 Timeline|11 Timeline]] with the date and reason.

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "What principles apply to X?" | Filter `domains` table by topic |
| "What is the strongest principle?" | Sort by `confidence` and `recurrence` |
| "Which principles are in tension?" | [[wiki/synthesis/00-synthesis-engine-hub\|Synthesis Hub]] filtered by `tag: contradiction` |
| "When was principle X last applied?" | Reverse lookup via decision cross-link |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Recurrence update | Monthly | [[schema/agents\|Cartographer]] |
| Confidence review | Quarterly | Operator |
| Deprecation scan | Annually | [[schema/agents\|Auditor]] |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[02 Principles\|02 Principles]] (Human Layer)
- [[templates/principle-note\|Principle Note Template]]
- [[wiki/synthesis/00-synthesis-engine-hub\|Synthesis Hub]]

---

*A principle that has not been tested is a hypothesis. Promote only after contact with reality.*