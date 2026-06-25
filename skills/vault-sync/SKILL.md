---
name: vault-sync
description: Reconciles the vault. Processes unprocessed inbox items, updates MOCs, detects new patterns, flags contradictions, proposes structural changes. Runs weekly (manual) or via weekly-sync cron. The "tidy up" workflow.
version: 1.0.0
author: knowledge-engine
tags: [sync, reconcile, maintenance, weekly]
---

# vault-sync — Reconcile, Update, Surface

> The maintenance workflow. Processes inbox, updates MOCs, surfaces what changed, flags what needs attention. Weekly health check for the knowledge system.

---

## When to Invoke

- User: "/sync", "/vault-sync", "Sync my vault", "Process my inbox"
- Auto: weekly-sync cron (Sunday 6pm)

---

## Prerequisites

1. Vault is initialized (`CLAUDE.md` exists at root)
2. `00 Inbox/` folder exists (with or without content)
3. `schema/ontology.md` and `schema/agents.md` have been read
4. `wiki/` MOC structure exists (created by vault-init)

---

## Execution — Six Phases

### Phase 1: Process Inbox

1. Scan `00 Inbox/` for files NOT prefixed with `_processed_`
2. For each unprocessed item, invoke [[vault-capture]] workflow
3. Move processed items to `00 Inbox/_processed/YYYY-MM-DD/`
4. Report count: "Processed N inbox items."

### Phase 2: Update MOCs

For each MOC in `wiki/`:

| MOC | Update Trigger | Update Action |
|-----|---------------|---------------|
| `wiki/entities/self/identity-moc.md` | New notes tagged `identity` | Add to clusters |
| `wiki/entities/projects/project-moc.md` | New notes tagged `project` | Link to project folder |
| `wiki/concepts/principles/principles-moc.md` | New notes tagged `principle` | Group by domain |
| `wiki/concepts/frameworks/frameworks-moc.md` | New notes tagged `framework` | Cluster by theme |
| `wiki/concepts/knowledge/knowledge-moc.md` | New notes tagged `knowledge` | Organize by domain |
| `wiki/synthesis/00-synthesis-engine-hub.md` | New notes with `synthesis` or `pattern` tag | Add cross-domain links |
| `wiki/journal/timeline/timeline-moc.md` | New notes with `timeline` tag | Add chronologically |
| `wiki/journal/inbox/inbox-moc.md` | This sync session's processed items | Log processing |

Update rule: MOCs receive ≤20% growth per sync. If a MOC needs more than 20% new content, propose splitting it.

### Phase 3: Detect New Patterns

Scan last 7 days of notes (by `created:` date in frontmatter). Look for:

1. **Emerging themes**: 3+ notes on related topics not previously clustered
2. **Concept clusters**: terms appearing in 5+ notes
3. **Repeated questions**: same question asked in different contexts
4. **Unused folders**: folders with 0 notes created in 30 days (candidates for archival)

Output: "Patterns detected this week:
- 4 new notes on pricing → suggest 03 Projects/<name>/pricing-strategy.md
- 'Constraint' appears in 7 notes → existing cluster strong, no action needed
- '03 Projects/exploratory-app/' empty for 45 days → archive?"

### Phase 4: Flag Contradictions

Compare claims across recent notes:

1. Extract all `principle`-tagged notes
2. For each pair, check for opposing assertions
3. If conflict detected without resolution note:
   - Create `wiki/journal/contradictions/YYYY-MM-DD-<topic>.md`
   - Format:
     ```
     ---
     title: "Contradiction: <topic>"
     summary: "Two notes assert opposing claims without resolution."
     date: <date>
     tags: [contradiction, audit]
     ---
     
     # Contradiction: <topic>
     
     **Claim A**: [[note-1]] asserts X.
     **Claim B**: [[note-2]] asserts not-X.
     
     ## Analysis
     <which note is more recent? which has stronger evidence?>
     
     ## Recommended Resolution
     <propose synthesis, ask user, or flag for review>
     ```
4. Append to schema/log.md

### Phase 5: Propose Structural Changes

Based on Phases 3 and 4, evaluate:

| Condition | Proposal |
|-----------|----------|
| 3+ new notes on emerging topic | "Create 04 Knowledge Library/<topic>/?" |
| Project folder empty 45+ days | "Archive 03 Projects/<name>/?" |
| MOC exceeds 100 links | "Split into sub-MOCs by domain?" |
| Same note created in 2+ folders | "Choose canonical location?" |
| Folder with 0 notes 90+ days | "Delete empty folder?" |

Output as recommendations, NEVER auto-execute. User approves via direct conversation.

### Phase 6: Report

Deliver a structured sync report:

```
## Vault Sync Report
**Date**: <YYYY-MM-DD>
**Items processed**: <count>
**MOCs updated**: <count>
**Patterns detected**: <count>
**Contradictions flagged**: <count>
**Structural proposals**: <count>

### What Changed
- <3-5 bullet summary of most significant changes>

### Needs Your Attention
- <contradictions and proposals requiring human decision>

### Auto-Actions Taken
- <MOC updates, inbox processing, etc. — be transparent>
```

Write the full report to `wiki/journal/sync-logs/YYYY-MM-DD-sync.md`.

---

## Adversarial Cases

| Case | Response |
|------|----------|
| Inbox is empty | "Nothing to process." — no error |
| Note already exists in target folder | Skip, log duplicate in sync report |
| MOC exceeds 100 links | Propose splitting into sub-MOCs; do not auto-execute |
| Contradiction detected between notes | Create contradiction note, do not resolve |
| Folder with 0 notes (stale) | Propose archival, do not auto-delete |
| Same note found in 2+ folders | Flag for deduplication, do not auto-merge |

---

## What This Skill Does NOT Do

- Never delete notes (only propose)
- Never modify `schema/` files
- Never edit `sources/` files
- Never change note titles after creation (only content edits if user requests)
- Never execute structural proposals without user approval

---

## Cost Estimation

- Tokens per sync: ~5,000-15,000 depending on vault size
- Run weekly: $0.01-0.03/week with hosted models

---

## Related Skills

- [[vault-capture]] — invoked during Phase 1
- [[vault-lint]] — runs independently, more thorough structural audit
- [[vault-digest]] — runs the week after this skill to summarize the changes

---

*Engine version: 1.0.0*