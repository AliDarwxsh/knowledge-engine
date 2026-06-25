---
title: "06 Decision Archive"
summary: "Past decisions and their reasoning. The archive is consulted before similar decisions arise."
date: 2026-06-26
tags: [decisions, archive, reasoning, retrospective, human-layer]
---

# 06 Decision Archive

> Every decision is a precedent. Record the precedent, not just the outcome.

---

## Purpose

This folder holds the operator's **decision history** — what was decided, why, what was considered, and what the outcome was. A decision note is not the same as a memory of an outcome; it is the full reasoning trail captured at the moment of choice.

| Layer | Records |
|-------|---------|
| **Human Layer** ([[06 Decision Archive\|06 Decision Archive]]) | Narrative decision notes |
| **Machine Layer** ([[wiki/journal/decisions/decision-archive-moc\|Decision Archive MOC]]) | Structured, queryable index |

---

## What Lives Here

| Note Type | Purpose | Filename |
|-----------|---------|----------|
| Single decision | One specific choice with full context | `decision-name.md` |
| Decision series | Multiple decisions in a domain over time | `series-domain-decisions.md` |
| Decision retraction | A reversal or pivot of a prior decision | `retraction-decision-name.md` |

---

## Anatomy of a Decision Note

Every decision note answers six questions:

1. **What was the decision?** — one sentence
2. **When was it made?** — date, context
3. **What were the alternatives?** — at least two
4. **Which [[02 Principles\|principles]] applied?** — explicit list
5. **What was the reasoning?** — paragraph form, not bullet soup
6. **What did we expect to happen?** — stated prediction

A seventh question, **what actually happened?**, is appended later when the outcome is known.

> [!warning] **No outcome yet is fine.** Capture the decision at the moment it is made; add the outcome later in a dated footer.

---

## When to Open

- Before making any decision with a precedent — search this folder first
- During a weekly review to update outstanding decisions with outcomes
- When a decision is being reconsidered or retracted
- During a quarterly synthesis to identify decision patterns

---

## How to Use

1. **Capture at the moment of decision.** Reasoning deteriorates within hours.
2. **Name the decision descriptively.** "Switched to weekly billing on 2026-04-12" beats "Billing decision."
3. **Cite the principles.** A decision without principles is a whim.
4. **Append outcomes, never overwrite.** Each dated footer is a snapshot.
5. **Tag with confidence.** Frontmatter `confidence: low | medium | high` after the outcome is known.

---

## Decision Quality Markers

| Marker | Meaning |
|--------|---------|
| `precedent-setting` | First decision of its kind; will be referenced often |
| `reversible` | Easy to undo; weight accordingly |
| `irreversible` | Hard to undo; demands higher reasoning quality |
| `retracted` | Decision was reversed; preserved for learning |

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[02 Principles]] | Every decision cites the principles it applied |
| [[03 Projects]] | Decisions inside a project link to the project note |
| [[05 Framework Library]] | Applied frameworks are named in the reasoning |
| [[11 Timeline]] | Decision dates anchor timeline entries |
| [[wiki/journal/decisions/decision-archive-moc\|Decision Archive MOC]] | The machine-layer structured index |

---

*The archive is not about being right. It is about being able to retrace why.*