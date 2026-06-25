---
title: "_imported — Inbox Staging for Chat Exports"
summary: "Staging area for vault-import. Chat export notes land here pending vault-sync promotion to canonical folders."
date: 2026-06-26
tags: [meta, hub, inbox, staging]
ai_context: "Hermes reads from this folder during vault-sync to promote imported notes. Do NOT edit files here directly; vault-sync moves them to canonical locations."
---

# _imported — Chat Import Staging

> Staging area for chat export ingestion. Files here are processed by [[workflows/vault-sync]] and promoted to canonical folders.

## What Lives Here

Notes created by [[vault-import]] skill land here temporarily. Each import creates a date-stamped subfolder:

```
00 Inbox/_imported/
├── 2026-06-26/                    # date of import
│   ├── note-from-chatgpt-1.md
│   ├── note-from-chatgpt-2.md
│   └── ...
└── 2026-07-03/
    └── ...
```

## Lifecycle

1. **Created** — `vault-import` drops new notes here with `source:` frontmatter pointing to the original chat export
2. **Reviewed** — User can manually inspect before promotion
3. **Promoted** — `vault-sync` moves notes to canonical folders (02 Principles/, 04 Knowledge Library/, etc.) and adds them to MOCs
4. **Archived** — Once promoted, the staging file is removed

## Why a Staging Folder

- Lets the user review AI-imported notes before they pollute the canonical structure
- Preserves source attribution (the original chat conversation is cited in frontmatter)
- Allows bulk operations during sync (rather than scattering imports across folders)

## Related

- [[00 Inbox/README|00 Inbox]] — parent folder
- [[vault-import]] — the skill that creates files here
- [[vault-sync]] — the skill that promotes files from here
- [[workflows/inbox-triage|inbox-triage]] — decision tree used during promotion