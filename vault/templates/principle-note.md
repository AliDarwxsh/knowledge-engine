---
title: "Principle Note Template"
summary: "A reusable scaffold for principle notes in 02 Principles. Every principle must pass the 10x test and cite three decisions."
date: 2026-06-26
tags: [template, principle, decision-making, evergreen]
---

# Principle Note Template

> A principle is a rule the operator refuses to break under pressure.

---

## Filename Convention

`kebab-case-name.md` — placed in `02 Principles/`.

---

## Frontmatter

```yaml
---
title: "<Principle Name>"
summary: "<One-sentence rule in active voice>"
date: YYYY-MM-DD
tags: [principle, decision-making, evergreen]
confidence: low | medium | high | load-bearing
recurrence: <int>   # number of decisions where cited
status: canonical | draft | disputed | deprecated
related_dimensions: [<identity-dimension>, ...]
---
```

---

## Template Body

```markdown
# <Principle Name>

> <One-sentence rule, active voice.>

---

## The Rule

<State the principle clearly. It should be applicable as a direct instruction to oneself.>

## The Context

<When does this principle apply? What domain, what stakes, what reversibility?>

## The Mechanism

<Why does this principle work? What is the underlying mechanism that makes the rule true?>

## The 10x Test

<Explain why this principle explains 10x more decisions than it cost to discover. If it does not, it does not belong here.>

## When to Apply

- <situation 1>
- <situation 2>
- <situation 3>

## When NOT to Apply

- <counter-situation 1>
- <counter-situation 2>

## Evidence — Decisions Where This Applied

1. [[06 Decision Archive/decision-1]] — <brief>
2. [[06 Decision Archive/decision-2]] — <brief>
3. [[06 Decision Archive/decision-3]] — <brief>
4. [[06 Decision Archive/decision-4]] — <brief>
5. [[06 Decision Archive/decision-5]] — <brief>

## Counter-Evidence

- <counter-example, if any>

## Linked Identity Dimensions

- [[01 Identity/dimension-name]]
- [[01 Identity/dimension-name]]

## Related Principles

- [[02 Principles/related-principle-1]]
- [[02 Principles/related-principle-2]]

## Changelog

- <YYYY-MM-DD> — created from [[10 Ideas & Opportunities/idea-name]] after evidence threshold met.
- <YYYY-MM-DD> — confidence upgraded to <level> based on <reason>.
```

---

## Promotion Criteria

A note in [[10 Ideas & Opportunities|10 Ideas]] becomes a principle only when:

1. **The rule is named in active voice.** "Capture beats curation" beats "capturing is important."
2. **The context is bounded.** The principle specifies when it applies and when it does not.
3. **Three or more decisions cite it.** See the Evidence section.
4. **The 10x test passes.** The principle explains 10x more decisions than it cost to discover.
5. **At least one supporting framework exists.** The principle is not pure intuition.

---

## Confidence Levels

| Level | Definition | Treatment |
|-------|------------|-----------|
| `low` | Stated once or twice | Hold lightly; cite cautiously |
| `medium` | Tested in 3+ decisions | Cite when relevant |
| `high` | Tested in 10+ decisions across multiple years | Anchor for major decisions |
| `load-bearing` | Tested in 20+ decisions; reverses when violated | Foundation; cite by default |

---

## Deprecation

A principle is deprecated when:

1. It has not been cited in any decision for 12+ months.
2. A counter-example has emerged that the principle does not accommodate.
3. A [[wiki/synthesis/00-synthesis-engine-hub|synthesis note]] explains the supersession.

Deprecated principles move to [[11 Timeline|11 Timeline]] with the date and reason. The original principle file stays in [[02 Principles|02 Principles]] but carries `status: deprecated` and a redirect note.

---

## Failure Modes

| Failure | Recovery |
|---------|----------|
| Principle stated as platitude | Rewrite in active voice with a bounded context |
| Principle with fewer than 3 decisions | Move back to [[10 Ideas & Opportunities\|10 Ideas]] |
| Principle in tension with another | Open a [[principle dispute note]] in [[02 Principles\|02 Principles]] |
| Principle duplicated | Merge; preserve changelog |

---

## Related

- [[templates/evergreen-note\|evergreen-note.md]]
- [[02 Principles\|02 Principles]] — the parent folder
- [[06 Decision Archive\|06 Decision Archive]] — where decisions cite principles
- [[wiki/concepts/principles/principles-moc\|Principles MOC]] — the machine-layer index
- [[schema/copywriting-standards\|schema/copywriting-standards.md]] — voice standards

---

*A principle earns its place by surviving contact with reality.*