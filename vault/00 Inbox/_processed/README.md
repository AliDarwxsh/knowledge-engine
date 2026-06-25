---
title: "_processed — Archive of Inbox Items Already Handled"
summary: "Inbox items after vault-capture has processed them. Date-stamped subfolders for traceability."
date: 2026-06-26
tags: [meta, hub, inbox, archive]
ai_context: "Hermes moves processed items here for traceability. Read-only for review; not actively edited."
---

# _processed — Handled Inbox Items

> Archive of inbox items after [[vault-capture]] has processed them. Date-stamped for traceability.

## What Lives Here

Original inbox captures after the engine has classified, tagged, and filed them. The original raw text is preserved here for reference; the classified note lives in its canonical folder.

```
00 Inbox/_processed/
├── 2026-06-26/
│   ├── raw-001.md               # original capture
│   ├── raw-002.md
│   └── ...
└── 2026-06-27/
    └── ...
```

## Lifecycle

1. **Captured** — User drops raw thought in `00 Inbox/`
2. **Processed** — `vault-capture` (or inbox-processor cron) classifies, creates the canonical note
3. **Archived** — Original raw text moved to `_processed/<date>/`
4. **Reference** — If user wants to see the original wording, they find it here

## Retention

Keep indefinitely. The cost is minimal (plain text) and the value is high (preserves original wording, timestamps, source).

## Related

- [[00 Inbox/README|00 Inbox]] — parent folder
- [[vault-capture]] — the skill that moves items here
- [[workflows/inbox-triage|inbox-triage]] — decision tree applied during processing