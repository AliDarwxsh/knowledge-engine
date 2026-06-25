---
title: "11 Timeline"
summary: "Chronological record of events, milestones, and dated entries. The vault's append-only history."
date: 2026-06-26
tags: [timeline, chronology, history, milestones, human-layer]
---

# 11 Timeline

> The vault does not forget. It dates.

---

## Purpose

This folder holds the operator's **chronological record** — dated events, milestones, revisions, and snapshots. The timeline is append-only. Nothing in this folder is edited; entries are added with their date.

| Property | Rule |
|----------|------|
| Filename | `YYYY-MM-DD-event-name.md` |
| Edit policy | Append-only; never edit past entries |
| Granularity | Daily for personal events; weekly for projects |

---

## What Lives Here

| Note Type | Purpose | Filename |
|-----------|---------|----------|
| Daily entry | A day of activity or reflection | `YYYY-MM-DD.md` |
| Milestone | A significant event | `YYYY-MM-DD-milestone-name.md` |
| Revision | A note that changed in another folder | `YYYY-MM-DD-revision-note-name.md` |

---

## When to Open

- When tracing the history of a current decision or project
- During a quarterly or annual review
- When looking for what happened around a specific date
- When preparing a retrospective

---

## How to Use

1. **Date the filename.** `YYYY-MM-DD` first, then a short descriptor.
2. **Append, never edit.** Past entries are sacred.
3. **Cross-link.** Each timeline entry should link to the relevant [[02 Principles|principles]], [[03 Projects|projects]], or [[06 Decision Archive|decisions]].
4. **Reference, don't repeat.** The timeline points to other notes; it does not duplicate their content.

---

## Anatomy of a Timeline Entry

```yaml
---
title: "2026-06-26 — Started Daily Rhythm SOP"
date: 2026-06-26
tags: [timeline, sop, daily-rhythm]
linked_notes:
  - "[[07 Systems & SOPs/daily-rhythm]]"
  - "[[02 Principles/Capture Beats Curation]]"
---

# 2026-06-26

Started the [[07 Systems & SOPs/daily-rhythm|Daily Rhythm SOP]]. First evening pass on [[00 Inbox|inbox]] cleared in 4 minutes. The [[02 Principles/Capture Beats Curation|capture-beats-curation]] principle applied.

## Decisions
- Adopted the five-minute evening pass as default.

## Links
- [[07 Systems & SOPs/daily-rhythm|Daily Rhythm SOP]]
- [[00 Inbox|Inbox]]
```

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[01 Identity]] | Identity revisions get timeline entries |
| [[02 Principles]] | Principle promotions / retractions get dated entries |
| [[03 Projects]] | Project milestones get timeline entries |
| [[06 Decision Archive]] | Decision dates anchor timeline entries |
| [[wiki/journal/timeline/timeline-moc\|Timeline MOC]] | The machine-layer structured index |

---

*The timeline is the vault's spine. Every other folder hangs from it.*