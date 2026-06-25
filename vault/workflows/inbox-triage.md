---
title: "Inbox Triage — The Four-Path Decision Tree"
summary: "Every inbox item resolves into one of four paths: DO, KEEP, FILE, or DELETE. The triage workflow defines each path's destination, time budget, and recovery rules."
date: 2026-06-26
tags: [workflow, triage, inbox, decision-tree, capture]
---

# Inbox Triage — The Four-Path Decision Tree

> Every item gets one of four answers. The answer is not optional.

---

## Purpose

This workflow is invoked during the [[workflows/daily-rhythm|evening pass]] to process [[00 Inbox|00 Inbox]] items. Every item resolves to exactly one of four paths. The tree is small on purpose: complexity at triage produces paralysis, not better outcomes.

---

## The Four Paths

| Path | Trigger | Destination | Time Budget |
|------|---------|-------------|-------------|
| **DO** | Will act within 7 days | Promote to [[03 Projects\|03 Projects]] with `next_action` set | 60 seconds |
| **KEEP** | Has reference value, no action needed | [[04 Knowledge Library\|04 Knowledge Library]], [[05 Framework Library\|05 Framework Library]], [[10 Ideas & Opportunities\|10 Ideas]], [[12 Relationship Maps\|12 Relationship Maps]] | 45 seconds |
| **FILE** | Personal, emotional, or private | [[01 Identity\|01 Identity]], [[11 Timeline\|11 Timeline]] | 30 seconds |
| **DELETE** | No durable value | `archive/trash/` or delete | 10 seconds |

---

## Decision Logic

```
                    ┌─ Will I act in <7 days? ─── YES ──▶ DO
                    │
                    NO
                    │
Incoming item ─────┼─ Does this have reference value? ─ YES ──▶ KEEP
                    │
                    NO
                    │
                    ├─ Is this personal or private? ──── YES ──▶ FILE
                    │
                    NO
                    │
                    └─────────────────────────────────────────▶ DELETE
```

> [!note] **Order matters.** DO first, KEEP second, FILE third, DELETE last. The default if you cannot decide is KEEP — it preserves the option to revisit.

---

## Path Details

### DO — Promote to Project

| Condition | Action |
|-----------|--------|
| Has a concrete next action | Move to [[03 Projects\|03 Projects]] with the action in `next_action` |
| Already in a project | Add as a task under the project note |
| Will be done today | Move to today's [[templates/daily-note\|daily note]] |

**Time budget:** 60 seconds. If longer, the item is more complex than a single DO and should be KEEP-deferred for decomposition.

### KEEP — Preserve for Reference

| Destination | When to Use |
|-------------|-------------|
| [[04 Knowledge Library\|04 Knowledge Library]] | A fact, reference, or domain note |
| [[05 Framework Library\|05 Framework Library]] | A mental model or analytical framework |
| [[10 Ideas & Opportunities\|10 Ideas]] | A possibility worth revisiting, no immediate action |
| [[12 Relationship Maps\|12 Relationship Maps]] | A note about a person or network |

**Time budget:** 45 seconds. If longer, the item is multiple things — split into multiple items.

### FILE — Preserve as Personal

| Destination | When to Use |
|-------------|-------------|
| [[01 Identity\|01 Identity]] | A self-observation, value, or role shift |
| [[11 Timeline\|11 Timeline]] | A dated event worth chronologizing |

**Time budget:** 30 seconds. Personal items are usually short.

### DELETE — Discard

| Condition | Action |
|-----------|--------|
| No reference value | Move to `archive/trash/` (preserves for 30 days) |
| Spam, duplicates, low-signal | Delete immediately |
| Sensitive / unwanted | Delete and skip trash |

**Time budget:** 10 seconds. The fastest path; do not deliberate.

---

## When Items Resist Classification

Some items do not fit any path cleanly. Common cases:

| Case | Resolution |
|------|------------|
| "Maybe later, but unsure" | KEEP → [[10 Ideas & Opportunities\|10 Ideas]] with `last_reviewed` date |
| "Important but no time" | KEEP → [[04 Knowledge Library\|04 Knowledge Library]] as reference |
| "Multiple items in one" | Split into multiple inbox items; triage each |
| "Already done" | Mark as `done` in the relevant [[03 Projects\|03 Projects]] task list |
| "Embarrassing or emotional" | FILE → [[01 Identity\|01 Identity]] (never DELETE private) |

> [!warning] **Never DELETE personal items.** If the operator is unsure, KEEP is the safe default. DELETE is reserved for obvious noise.

---

## Failure Modes

| Failure | Recovery |
|---------|----------|
| Triage exceeds 5 minutes | Park remaining items; resume tomorrow |
| Item moved to wrong path | Move it during next triage; do not edit in place |
| Inbox has 30+ items | Triage top 10; rest get a weekly batch session |
| Same item recurs weekly | Either trigger a [[03 Projects\|project]] or delete with a stronger reason |

---

## Inputs and Outputs

| Input | Output |
|-------|--------|
| Items in [[00 Inbox\|00 Inbox]] | Items distributed to their canonical folders |
| Daily note entry | "Evening pass: cleared N items in T minutes" |

---

## Related

- [[workflows/daily-rhythm\|daily-rhythm.md]] — the evening pass that runs this triage
- [[workflows/maintenance-protocol\|maintenance-protocol.md]] — broader cadence
- [[workflows/forward-references\|forward-references.md]] — handling gray links during triage
- [[00 Inbox\|00 Inbox]] — the capture surface
- [[wiki/journal/inbox/inbox-moc\|Inbox MOC]] — the machine-layer view

---

*Four paths. One decision. The tree does not negotiate.*