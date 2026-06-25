---
title: "00 Inbox"
summary: "The capture station. Everything arrives here first, untriaged. Capture beats curation."
date: 2026-06-26
tags: [inbox, capture, triage, workflow, human-layer]
---

# 00 Inbox

> Capture first. Triage later. Nothing is lost.

---

## Subdirectories

The Inbox contains three staging folders used by Hermes:

| Subfolder | Purpose | Used by |
|-----------|---------|---------|
| `[[_imported]]` | Staging for [[vault-import]] chat exports | vault-import |
| `[[_unclassified]]` | Staging for ambiguous captures | vault-capture |
| `[[_processed]]` | Archive of items after processing | vault-capture |

---

## Purpose

The Inbox is the **only** folder where the operator captures without friction. Every note, link, quote, screenshot, voice memo, and idea lands here before any processing happens. Capture always wins over curation.

| Property | Rule |
|----------|------|
| Allowed formats | `.md`, image, PDF, audio, web clip |
| Naming | Inbox items keep their capture filename — do not rename on intake |
| Time to capture | <10 seconds per item |
| Triage window | Same day, evening, or weekly — see [[workflows/daily-rhythm\|daily-rhythm]] |

---

## The Capture-First Philosophy

Two failure modes dominate knowledge work:

1. **Capture friction** — pausing to file, tag, and structure before writing.
2. **Loss friction** — discarding an item because its destination is unclear.

The Inbox eliminates both. Drop the item in. Decide later. The decision tree in [[workflows/inbox-triage\|inbox-triage.md]] handles the rest.

> [!note] **Rule of capture:** If you hesitate more than 10 seconds, the note is lost. Default to capture, decide on the evening pass.

---

## The Four-Path Decision Tree

Every item arriving in the Inbox resolves into one of four paths:

| Path | When | Action |
|------|------|--------|
| **DO** | Will be acted on in <7 days | Promote to [[03 Projects\|03 Projects]] as a task |
| **KEEP** | Reference value, no action needed | Move to [[04 Knowledge Library\|04 Knowledge Library]] or [[10 Ideas & Opportunities\|10 Ideas & Opportunities]] |
| **FILE** | Personal, emotional, or private | Move to [[01 Identity\|01 Identity]] or [[11 Timeline\|11 Timeline]] |
| **DELETE** | No durable value | Move to `archive/` or delete |

Full tree with examples: [[workflows/inbox-triage\|workflows/inbox-triage.md]].

---

## Daily Rhythm

The Inbox is paired with the [[workflows/daily-rhythm\|evening inbox pass]]:

1. Open [[00 Inbox]].
2. For each item, apply the four-path decision tree.
3. Move, archive, or delete.
4. Close the inbox.

Time budget: **5 minutes per day**.

---

## When to Open

- When something arrives unprocessed
- During the evening inbox pass
- Before opening any other folder (the inbox is the lowest-resistance starting point)

---

## When NOT to Open

- During deep work — the inbox is a maintenance surface, not a creation surface
- When the goal is synthesis — go to [[wiki/synthesis/00-synthesis-engine-hub\|Synthesis Hub]] instead

---

## Related

- [[workflows/inbox-triage\|inbox-triage.md]] — the full decision tree
- [[workflows/daily-rhythm\|daily-rhythm.md]] — the 5-minute evening pass
- [[templates/daily-note\|daily-note template]] — for daily notes that reference inbox items
- [[wiki/journal/inbox/inbox-moc\|Inbox MOC]] — the machine-layer view of processed inbox items

---

*Capture beats curation. The inbox is a river, not a warehouse.*