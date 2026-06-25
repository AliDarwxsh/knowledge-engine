---
title: "02 Principles"
summary: "Load-bearing rules for decision-making. Principles are named, dated, and held to a high standard of evidence."
date: 2026-06-26
tags: [principles, decision-making, heuristics, human-layer]
---

# 02 Principles

> Principles are the rules the operator refuses to break under pressure.

---

## Purpose

This folder holds the operator's **load-bearing principles** — the rules of thumb that have survived contact with reality and proven themselves across multiple decisions. A principle is a sentence or short paragraph that names a rule, a context where it applies, and the evidence that justifies it.

The Human Layer (02 Principles) holds individual principle notes. The Machine Layer ([[wiki/concepts/principles/principles-moc|Principles MOC]]) holds the structured, machine-queryable index.

---

## What Lives Here

| Note Type | Purpose | Format |
|-----------|---------|--------|
| Single principle | One named principle with evidence and counter-evidence | `principle-name.md` |
| Principle cluster | A group of related principles | `cluster-name.md` |
| Principle dispute | An ongoing disagreement between principles | `dispute-name.md` |

Use the [[templates/principle-note|principle-note template]] for every new principle.

---

## What Makes a Good Principle

A principle is **not**:

- A wish ("be more disciplined")
- A platitude ("do your best")
- A single observation ("X worked once")

A principle **is**:

- Named in active voice ("Specific knowledge compounds; general knowledge doesn't.")
- Bounded by context ("Applies when stakes are reversible.")
- Backed by evidence ("Three projects over 18 months followed this pattern.")
- Testable ("The opposite prediction is observable.")

> [!tip] **The 10x test.** A real principle explains 10x more decisions than it cost to discover.

---

## When to Open

- When facing a hard choice and the trade-offs are unclear
- During a quarterly review of [[06 Decision Archive|06 Decision Archive]]
- When two principles conflict — escalate to a [[principle-dispute|principle dispute]]
- Before committing to a long-term position

---

## Editing Discipline

- A principle is **promoted** from a [[10 Ideas & Opportunities|10 Ideas]] observation only after appearing in at least three unrelated decisions.
- Every principle note carries a `confidence` frontmatter field: `low | medium | high | load-bearing`.
- Disputed principles stay in this folder. They get a `[DISPUTED]` tag and link to a dispute note.
- Deprecated principles move to [[11 Timeline|11 Timeline]] with the date and reason.

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[01 Identity]] | Principles are identity encoded as rules |
| [[03 Projects]] | Each project links to the principles it embodies |
| [[06 Decision Archive]] | Every decision cites the principles it applied |
| [[05 Framework Library]] | Frameworks are analytical tools; principles are behavioral rules |
| [[wiki/concepts/principles/principles-moc\|Principles MOC]] | The machine-layer structured index |

---

*The cost of holding a principle is the discipline of holding it.*