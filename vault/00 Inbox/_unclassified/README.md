---
title: "_unclassified — Inbox Items Awaiting Human Triage"
summary: "Staging for ambiguous captures that vault-capture could not classify with sufficient confidence."
date: 2026-06-26
tags: [meta, hub, inbox, triage]
ai_context: "Hermes writes ambiguous captures here. User reviews and either re-classifies manually or instructs Hermes on where to file them."
---

# _unclassified — Ambiguous Captures

> Staging area for items that [[vault-capture]] could not classify with confidence. Human review required.

## What Lives Here

Notes where the classification signal was unclear. Each gets a `## Review` section asking the user to confirm the destination.

```
00 Inbox/_unclassified/
├── capture-2026-06-26-001.md
├── capture-2026-06-26-002.md
└── ...
```

## Lifecycle

1. **Created** — `vault-capture` writes here when classification confidence is LOW or completely ambiguous
2. **Reviewed** — User opens each file, reads the `## Review` prompt, decides the destination
3. **Moved** — User either manually moves the file or instructs Hermes to file it (e.g., "file that into 02 Principles")
4. **Deleted** — If the note was noise, delete it (don't archive noise)

## Why a Separate Folder

- Prevents misclassification from polluting canonical structure
- Surfaces uncertainty without forcing the engine to guess
- Makes review scannable (all ambiguous items in one place)
- Avoids the "where did this go?" problem

## Related

- [[00 Inbox/README|00 Inbox]] — parent folder
- [[vault-capture]] — the skill that writes here when uncertain
- [[workflows/inbox-triage|inbox-triage]] — manual decision tree for these items