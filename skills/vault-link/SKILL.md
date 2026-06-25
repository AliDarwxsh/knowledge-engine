---
name: vault-link
description: Connection finder. Reads recently created/modified notes, searches the entire vault for non-obvious connections, proposes wikilinks the user didn't make consciously. Runs nightly via cron or on-demand.
version: 1.0.0
author: knowledge-engine
tags: [link, connections, graph, maintenance]
---

# vault-link — Non-Obvious Connection Finder

> The cartographer's role. Finds connections between notes the user didn't make consciously. Strengthens the knowledge graph by surfacing what should link.

---

## When to Invoke

- User: "/link", "/vault-link", "Find connections", "What should link to what?"
- Auto: connection-finder cron (3:00am)

---

## Execution — Five Phases

### Phase 1: Identify Target Notes

Two modes:

**Recent mode (default for cron)**:
- All notes with `created:` or `modified:` date within last 7 days
- Skips: `00 Inbox/`, `_processed/`, `_imported/`, `13 Meta Analysis/`

**Specific mode (when user invokes)**:
- User specifies: "Find connections for [[note-name]]"
- Or: all notes in a specific folder

### Phase 2: Search For Candidates

For each target note, search the rest of the vault:

1. **Semantic similarity**: Compare embedding vectors (or use keyword overlap as fallback)
2. **Concept overlap**: Extract named entities and concepts; find notes with ≥2 overlapping concepts
3. **Tag affinity**: Find notes with 2+ overlapping tags
4. **Domain bridge**: Find notes from different domains but related concepts
5. **Wikilink proximity**: Notes that link to the same third note are candidates

For each target, generate candidate list of 5-15 existing notes.

### Phase 3: Score And Filter

Score each candidate:

| Signal | Weight |
|--------|--------|
| Shares named entity | +0.3 |
| Shares concept (not just word) | +0.4 |
| Different domain (cross-domain = high value) | +0.2 |
| Recently modified (temporal relevance) | +0.1 |
| One already links to the other (unrequited) | +0.5 |

Threshold:
- >0.7 → strong suggestion, propose inline link
- 0.5-0.7 → moderate suggestion, propose with rationale
- 0.3-0.5 → weak suggestion, only surface in batch report
- <0.3 → ignore

### Phase 4: Propose Links

For each approved suggestion, decide the form:

**Option A: Inline link** (high confidence)
- Add `[[note-x]]` inline in the body where the connection is most natural
- Update `related:` in frontmatter

**Option B: Connection note** (cross-domain insight)
- If the connection is genuinely novel (not just "they share topic X"), create a new note:
  ```
  ---
  title: "Connection: <target-note> ↔ <linked-note>"
  summary: "Cross-domain link between <X> and <Y>: <insight>"
  type: synthesis
  tags: [synthesis, connection]
  related: [<target-note>, <linked-note>]
  ---
  
  # Connection: <target-note> ↔ <linked-note>
  
  **From**: [[target-note]] (domain: <X>)
  **To**: [[linked-note]] (domain: <Y>)
  
  ## The Bridge
  <Why these connect. What's the shared insight?>
  
  ## Implication
  <What this connection reveals about the user's thinking>
  ```

**Option C: Forward reference** (concept doesn't exist)
- If the link would be valuable but the target note doesn't exist yet, add `[[forward-ref-concept]]` (gray link)
- Log for [[vault-forward-refs]] triage

### Phase 5: Report

Output a connection report:

```
## Connection Report
**Date**: <YYYY-MM-DD>
**Target notes scanned**: <count>
**Connections found**: <count>
  - Strong (proposed inline): <count>
  - Moderate (with rationale): <count>
  - Weak (batch only): <count>
  - Cross-domain insights: <count>
  - Forward references created: <count>

### Notable Connections

#### [[note-a]] ↔ [[note-b]]
**Domains**: <X> ↔ <Y>
**Why this matters**: <one-sentence rationale>

#### [[note-c]] ↔ [[note-d]]
...

### Cross-Domain Discoveries

<For each new connection note created, show the insight>

### Forward References Created

- [[forward-ref-1]] — appears in [[note-x]], [[note-y]], [[note-z]]
```

Write report to `wiki/journal/sync-logs/YYYY-MM-DD-link.md`.

---

## Permission Boundaries

This skill:
- ✅ Reads entire vault
- ✅ Updates `related:` field in frontmatter (with user's permission level)
- ✅ Adds inline wikilinks (with user's permission level)
- ✅ Creates connection notes in `wiki/synthesis/`
- ✅ Creates forward references (gray links)
- ❌ Does NOT modify body content beyond adding links
- ❌ Does NOT delete existing links
- ❌ Does NOT write to `schema/` or `sources/`

Permission level governs action:
- **Conservative**: Only propose. Don't edit.
- **Moderate**: Apply inline link suggestions. Propose connection notes.
- **Aggressive**: Apply all suggestions. Create connection notes. Create forward refs.

---

## Cost Estimation

- Tokens per run: ~5,000-15,000
- Nightly run: ~$0.02-0.05/night
- Local models: $0

---

## Related Skills

- [[vault-capture]] — invoked when link reveals a gap that needs a new note
- [[vault-forward-refs]] — triages the gray links this skill creates
- [[vault-digest]] — incorporates this skill's discoveries into weekly synthesis
- [[vault-lint]] — validates this skill's link additions

---

*Engine version: 1.0.0*