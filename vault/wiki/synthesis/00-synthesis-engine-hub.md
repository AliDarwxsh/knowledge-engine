---
title: "Synthesis Engine Hub — Cross-Domain Insights"
summary: "The synthesis engine. Where notes from different domains collide to produce emergent patterns, contradictions, and forward hypotheses."
date: 2026-06-26
tags: [synthesis, hub, cross-domain, emergence, machine-layer]
ai_context: "Hermes uses the synthesis hub to find patterns the operator has not yet named. Use when reasoning about long-term trajectory, contradictions, or novel connections."
---

# Synthesis Engine Hub

> Where different domains meet, new patterns emerge.

---

## Purpose

The synthesis engine is the **highest-leverage cluster** in the vault. It is where notes from [[02 Principles|principles]], [[05 Framework Library|frameworks]], [[04 Knowledge Library|knowledge]], and [[06 Decision Archive|decisions]] collide to produce insights none of them contain individually.

| Layer | Holds |
|-------|-------|
| Inputs | Notes from every other cluster |
| Process | Pattern detection, contradiction scan, analogical transfer |
| Output | Synthesis notes with cross-cluster claims |

> [!tip] **Synthesis is not summary.** A synthesis note produces a claim that no single source note contains.

---

## Synthesis Note Types

| Type | Definition | Example Filename |
|------|------------|------------------|
| `cross-domain-pattern` | A pattern observed across 2+ unrelated domains | `pattern-specific-knowledge.md` |
| `contradiction` | Two nodes that cannot both be true | `contradiction-speed-vs-depth.md` |
| `emergent-question` | A question that emerges only after synthesis | `question-what-counts-as-evidence.md` |
| `forward-hypothesis` | A claim about the future that synthesis supports | `hypothesis-compounding-returns-of-judgment.md` |

Use the [[templates/evergreen-note|evergreen-note template]] for each synthesis note.

---

## Synthesis Edge Schema

```yaml
synthesis_node:
  id: synthesis-<slug>
  type: cross-domain-pattern | contradiction | emergent-question | forward-hypothesis
  stated: YYYY-MM-DD
  confidence: speculative | provisional | grounded
  input_notes:           # minimum 3 from ≥2 clusters
    - "[[wiki/concepts/...]]"
    - "[[02 Principles/...]]"
    - "[[06 Decision Archive/...]]"
  cross_links:
    identity: ["[[01 Identity/...]]"]
    projects: ["[[03 Projects/...]]"]
```

---

## Quality Bar

A synthesis note is **publishable** when:

1. It cites at least three input notes from at least two clusters.
2. It states a claim that no single input note contains.
3. It identifies its own confidence level (`speculative | provisional | grounded`).
4. It survives the [[schema/copywriting-standards|copywriting audit]].

A synthesis note is **speculative** if:

- It draws from fewer than three inputs.
- It cites no decision history.
- It is forward-looking without precedent.

Speculative notes are kept but tagged `[SPECULATIVE]` and excluded from principle promotion.

---

## How Synthesis Happens

| Trigger | Process |
|---------|---------|
| New principle emerges | Compare with existing principles; flag contradictions |
| New decision is archived | Compare with prior decisions in the same domain |
| New knowledge note added | Compare with prior notes in the same field |
| Quarterly review | Force analogical transfer between distant domains |
| AI session | Hermes may propose a synthesis; operator approves |

---

## The Synthesis Loop

```
[domain notes]   [principles]   [decisions]
        ↓              ↓              ↓
        └──────────────┴──────────────┘
                       ↓
                  [synthesis note]
                       ↓
        ┌──────────────┴──────────────┐
        ↓              ↓              ↓
[identity update] [project pivot] [principle revise]
```

---

## Output Targets

When a synthesis note reaches `grounded` confidence, it can promote:

| Output | Destination |
|--------|-------------|
| New principle | [[02 Principles\|02 Principles]] |
| Project pivot | [[03 Projects\|03 Projects]] |
| Identity revision | [[01 Identity\|01 Identity]] |
| Decision retraction | [[06 Decision Archive\|06 Decision Archive]] |

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "What patterns cross my domains?" | Filter by `type: cross-domain-pattern` |
| "What contradicts itself?" | Filter by `type: contradiction` |
| "What questions am I not yet asking?" | Filter by `type: emergent-question` |
| "What does my vault predict?" | Filter by `type: forward-hypothesis` |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Synthesis proposal | Weekly | [[schema/agents\|Synthesist]] |
| Contradiction scan | Monthly | [[schema/agents\|Auditor]] |
| Cross-domain forced pass | Quarterly | [[schema/agents\|Synthesist]] |
| Confidence upgrade | Per output | Operator |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[wiki/concepts/principles/principles-moc\|Principles MOC]]
- [[wiki/concepts/frameworks/frameworks-moc\|Frameworks MOC]]
- [[wiki/journal/decisions/decision-archive-moc\|Decision Archive MOC]]
- [[13 Meta Analysis\|13 Meta Analysis]] — synthesis-quality audits

---

*Synthesis is what makes a vault a mind.*