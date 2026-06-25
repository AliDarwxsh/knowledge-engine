---
title: "Frameworks MOC — Map of Content for Mental Models"
summary: "Machine-queryable map of every mental model and framework in the vault. Indexed by situation, domain, and applicability."
date: 2026-06-26
tags: [moc, frameworks, mental-models, machine-layer]
ai_context: "Hermes uses this MOC to retrieve frameworks by situation. Use when the operator faces an analytical decision, when teaching AI to apply a model, or when auditing framework overuse."
---

# Frameworks MOC

> A framework is a lens. The right lens changes the answer.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/concepts/frameworks/` |
| Mirror | [[05 Framework Library\|05 Framework Library]] (Human Layer) |
| Owner | Operator-writable; AI-readable |

---

## Framework Applicability Vocabulary

| Applicability | Definition |
|---------------|------------|
| `narrow` | Applies in one specific domain |
| `broad` | Applies across multiple domains |
| `universal` | Applies across all decisions of a certain type |

---

## Framework Edge Schema

```yaml
framework_node:
  id: framework-<slug>
  source: "<author or origin>"
  applicability: narrow | broad | universal
  stated: YYYY-MM-DD
  applied_count: <int>     # number of decisions where used
  domain_tags: [...]       # topical domains where useful
  anti_patterns:           # when NOT to apply
    - "<situation where the framework misleads>"
  cross_links:
    principles: ["[[02 Principles/principle-name]]"]
    decisions: ["[[06 Decision Archive/decision-name]]"]
```

---

## Frameworks Index

| Framework | Source | Applicability | Applied Count |
|-----------|--------|---------------|---------------|
| _populate after first framework extraction_ | — | — | — |

---

## Situation-Based Retrieval

The most useful way to retrieve a framework is by **situation**, not by framework name. Common situations:

| Situation | Candidate Frameworks |
|-----------|----------------------|
| A decision with uncertain outcome | Pre-mortem, expected value, reversibility test |
| A repeated failure | Five Whys, systems map, feedback loop analysis |
| A complex multi-stakeholder decision | Schelling point, principal-agent, game tree |
| A long-term commitment | Reversibility test, second-order effects, identity fit |
| A creative problem | Inversion, analogy from distant domain, constraint relaxation |
| A negotiation | BATNA, zone of possible agreement, anchored expectations |

---

## Overuse Discipline

| Symptom | Cause | Recovery |
|---------|-------|----------|
| Same framework cited in 5+ decisions in a row | Default thinking | Force a different framework for the next 3 decisions |
| Framework produces elaborate analysis, no decision | Analysis paralysis | Apply reversibility test; ship the reversible option |
| Multiple frameworks on same decision produce contradictory answers | Domain mismatch | Pick one; defer the others to a future synthesis note |

> [!tip] **Apply at most two frameworks per decision.** More usually means confused thinking.

---

## Cross-Cluster Edges

| Edge | Strong Signal |
|------|---------------|
| Framework ↔ Decision | A framework is validated when applied decisions improve |
| Framework ↔ Principle | Repeated application yields a principle |
| Framework ↔ Project | Projects often stack 2–3 frameworks |
| Framework ↔ Knowledge | Frameworks abstract from domain knowledge notes |

---

## Promotion Criteria

A candidate framework is **promoted to the MOC** when:

1. It is named and attributable to an origin (author or tradition).
2. It has been applied in at least three unrelated decisions.
3. Its domain and anti-patterns are documented.
4. At least one [[04 Knowledge Library|knowledge note]] supports its mechanism.

A framework is **deprecated** when:

1. It has not produced useful decisions in 18+ months.
2. A newer framework supersedes it.
3. Its anti-patterns have grown to dominate.

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "What helps me think about X?" | Situation-Based Retrieval table |
| "What did I use last time?" | Reverse lookup via decision cross-link |
| "What frameworks are overused?" | Overuse Discipline audit |
| "Where is framework X from?" | `source` field of framework node |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Applicability refresh | Quarterly | Operator |
| Overuse scan | Monthly | [[schema/agents\|Auditor]] |
| Anti-pattern capture | Per use | [[schema/agents\|Editor]] |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[05 Framework Library\|05 Framework Library]] (Human Layer)
- [[wiki/concepts/principles/principles-moc\|Principles MOC]]
- [[templates/evergreen-note\|Evergreen Note Template]]

---

*A framework is a tool. Use it. Sharpen it. Retire it.*