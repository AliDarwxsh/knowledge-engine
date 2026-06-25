---
title: "Inbox MOC — Map of Content for Processed Inbox"
summary: "Machine-queryable map of processed inbox items. Indexed by date, triage path, and destination folder."
date: 2026-06-26
tags: [moc, inbox, journal, machine-layer]
ai_context: "Hermes uses this MOC to reason about capture volume, triage patterns, and backlog health. Use when analyzing where ideas come from and how the operator decides."
---

# Inbox MOC

> Capture first. Triage second. The MOC tracks the second.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/journal/inbox/` |
| Mirror | [[00 Inbox\|00 Inbox]] (Human Layer) |
| Owner | Operator-writable; AI-readable |
| Edit policy | Append-only (each item logged on triage) |

---

## Triage Path Vocabulary

| Path | Definition | Destination |
|------|------------|-------------|
| `DO` | Will be acted on within 7 days | [[03 Projects\|03 Projects]] |
| `KEEP` | Reference value, no action | [[04 Knowledge Library\|04 Knowledge Library]], [[05 Framework Library\|05 Framework Library]], [[10 Ideas & Opportunities\|10 Ideas]], [[12 Relationship Maps\|12 Relationship Maps]] |
| `FILE` | Personal, emotional, or private | [[01 Identity\|01 Identity]], [[11 Timeline\|11 Timeline]] |
| `DELETE` | No durable value | `archive/trash/` or deleted |

---

## Inbox Item Edge Schema

```yaml
inbox_item:
  id: inbox-<YYYY-MM-DD>-<slug>
  captured: YYYY-MM-DD
  triaged: YYYY-MM-DD
  triage_path: DO | KEEP | FILE | DELETE
  destination: "<folder and file>"
  source_format: text | image | audio | web-clip | file | voice
  capture_device: phone | laptop | tablet | voice
  triage_latency_hours: <float>
  cross_links:
    - "[[03 Projects/project-name]]"
    - "[[02 Principles/principle-name]]"
```

---

## Inbox Index

| Date Captured | Item | Path | Destination |
|---------------|------|------|-------------|
| _populate after first inbox triage_ | — | — | — |

---

## Triage Metrics

The MOC enables monthly analytics:

| Metric | Formula | Target |
|--------|---------|--------|
| Capture volume | items per week | Operator-defined |
| Triage latency | time from capture to triage | <24 hours |
| DO ratio | `DO` / total items | 5–15% |
| DELETE ratio | `DELETE` / total items | <30% |
| Backlog | items not triaged in 7 days | 0 |

> [!warning] **Backlog drift is the leading indicator of system failure.** If backlog > 0 for two consecutive weeks, run [[workflows/inbox-triage|deep triage]].

---

## Capture Format Vocabulary

| Format | Description | Example |
|--------|-------------|---------|
| `text` | Plain markdown note | Quick thought |
| `image` | Screenshot or photo | Whiteboard, document |
| `audio` | Audio file | Recording |
| `web-clip` | Clipped article or page | Highlight, article |
| `file` | PDF, doc, or other | External material |
| `voice` | Voice memo | Captured on phone |

---

## Capture Device Vocabulary

| Device | Most Common Format |
|--------|--------------------|
| `phone` | voice, image, text |
| `laptop` | text, web-clip, file |
| `tablet` | image, text |
| `voice` | audio |

> [!tip] **Capture device distribution reveals workflow shape.** A 70% phone-capture pattern suggests mobile-first thinking; adjust SOPs accordingly.

---

## Cross-Cluster Edges

| Edge | Strong Signal |
|------|---------------|
| Inbox ↔ Projects | Every `DO` item lands in [[03 Projects\|03 Projects]] |
| Inbox ↔ Knowledge | Every `KEEP` knowledge item lands in [[04 Knowledge Library\|04 Knowledge Library]] |
| Inbox ↔ Ideas | Every `KEEP` speculative item lands in [[10 Ideas & Opportunities\|10 Ideas]] |
| Inbox ↔ Timeline | `FILE` items often land in [[11 Timeline\|11 Timeline]] |

---

## The Four-Path Decision Tree (Detail)

See [[workflows/inbox-triage|workflows/inbox-triage.md]] for the full tree. Quick reference:

```
                 ┌─ Will act in <7 days? ──── DO
                 │
Incoming item ──┼─ Has reference value? ─── KEEP
                 │
                 ├─ Personal / private? ──── FILE
                 │
                 └─ No durable value? ─────── DELETE
```

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "What did I capture this week?" | Filter by `captured` date range |
| "Where did inbox items go?" | Group by `triage_path` |
| "What's my triage latency?" | Average `triage_latency_hours` |
| "What device captures most?" | Group by `capture_device` |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Inbox item logging | Per triage | Operator / [[schema/agents\|Librarian]] |
| Metric review | Monthly | Operator |
| Backlog check | Weekly | [[schema/agents\|Auditor]] |
| Capture-device distribution | Quarterly | Operator |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[00 Inbox\|00 Inbox]] (Human Layer)
- [[workflows/inbox-triage\|inbox-triage.md]] — the decision tree
- [[workflows/daily-rhythm\|daily-rhythm.md]] — the evening pass

---

*The inbox is the operator's intake valve. The MOC is the dashboard on its health.*