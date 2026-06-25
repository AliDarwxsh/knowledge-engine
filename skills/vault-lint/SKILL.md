---
name: vault-lint
description: Health check suite. Validates frontmatter, detects orphans, scans for contradictions, checks tag compliance, finds link rot, detects duplicates, triages forward references. Runs nightly via cron or on-demand.
version: 1.0.0
author: knowledge-engine
tags: [lint, audit, health-check, maintenance]
---

# vault-lint — Vault Health Audit

> The auditor's role. Runs every check the schema demands. Surfaces what's broken, stale, or missing. Never edits — only reports.

---

## When to Invoke

- User: "/lint", "/vault-lint", "Health check", "Audit my vault"
- Auto: nightly-lint cron (2:00am)

---

## Execution — Seven Audit Checks

### Check 1: Frontmatter Completeness

For every `.md` file (excluding `schema/`, `sources/`, `wiki/journal/sync-logs/`, `13 Meta Analysis/`, `_processed/`):

Required fields:
- `title` (string, present)
- `summary` (string, ≤200 chars)
- `type` (string, from valid types list)
- `tags` (array, ≥1 tag)
- `created` (date, YYYY-MM-DD)

Report:
```
Frontmatter Audit:
✅ Pass: <N>
⚠️ Missing title: <files>
⚠️ Missing summary: <files>
⚠️ Missing tags: <files>
⚠️ Invalid type: <files>
❌ No frontmatter: <files>
```

### Check 2: Orphan Detection

For every note (excluding `00 Inbox/`, `_processed/`, `_unclassified/`):

1. Extract all `[[wikilinks]]` from the note (outgoing links)
2. Extract all incoming `[[wikilinks]]` by grepping the entire vault for the note's filename
3. If incoming links = 0 → **orphan**
4. If outgoing links = 0 → **dead-end** (note that links to nothing)

Report both lists separately. Orphans are higher priority.

```
Orphan Audit:
Orphans (0 incoming): <count> — <files>
Dead-ends (0 outgoing): <count> — <files>
```

### Check 3: Tag Compliance

For every note with frontmatter `tags:`:

1. Load `schema/ontology.md` and extract canonical tag list
2. For each tag in each note, check it exists in ontology
3. If not → **non-compliant tag**

```
Tag Compliance:
✅ Compliant: <N> notes
❌ Non-compliant tags found: <count>
   - [[note-1]] uses "fake-tag" → suggest: <closest match or "propose-new-tag">
   - [[note-2]] uses "misc" → suggest: <domain>
```

### Check 4: Link Rot

For every `[[wikilink]]` in every note:

1. Check if target file exists (try `[[target]]`, `[[target|The Target]]`, slug variations)
2. If not → **broken link**

```
Link Rot:
Broken links: <count>
   - [[note-a]] links to [[ghost-note]] (does not exist)
   - [[note-b]] links to [[missing-person]] (does not exist)
```

Link rot is distinct from forward references. Forward references are INTENTIONAL (gray links to be triaged). Broken links are bugs.

### Check 5: Contradiction Scan

Same as [[vault-sync]] Phase 4, but more thorough:

1. Extract all `principle` and `decision` notes
2. For each pair, check for direct contradiction (one asserts X, the other asserts not-X)
3. Check if a resolution note exists in `wiki/journal/contradictions/`
4. If conflict + no resolution → **unflagged contradiction**

```
Contradictions:
Resolved: <count>
Unflagged: <count>
   - [[principle-a]] vs [[principle-b]] on <topic>
```

### Check 6: Duplicate Detection

Use semantic similarity (cosine similarity of embeddings, or keyword overlap as fallback):

1. Extract all notes
2. Compute pairwise similarity
3. Threshold: >0.85 → **near-duplicate**
4. Threshold: 0.70-0.85 → **possibly overlapping**

```
Duplicates:
Near-duplicates (>0.85): <count>
   - [[note-a]] ↔ [[note-b]] (similarity: 0.91)
Possibly overlapping (0.70-0.85): <count>
```

### Check 7: Forward Reference Triage

For every gray link (link to non-existent note):

1. Extract all wikilinks where target doesn't exist
2. Group by target name
3. If ≥3 references to same ghost → **propose creating note**
4. If 1-2 references → **suggest removing link or creating note**

```
Forward References:
Total gray links: <count>
Proposed notes (≥3 references): <count>
   - [[ghost-concept]] referenced in: [[note-1]], [[note-2]], [[note-3]]
   - ...
Pending triage (1-2 references): <count>
```

---

## Output — Health Scorecard

Calculate vault health score (0-100):

| Check | Weight | Deduction per issue |
|-------|--------|---------------------|
| Frontmatter completeness | 20% | -1 per missing field per note |
| Orphan detection | 20% | -3 per orphan |
| Tag compliance | 15% | -2 per non-compliant tag |
| Link rot | 15% | -1 per broken link |
| Contradictions | 15% | -5 per unflagged contradiction |
| Duplicates | 10% | -3 per near-duplicate |
| Forward refs (uncategorized) | 5% | -1 per pending triage item |

Health bands:
- 90-100: Excellent — engine is healthy
- 75-89: Good — minor issues, routine maintenance sufficient
- 60-74: Needs attention — schedule a sync review session
- 40-59: Declining — daily maintenance required to recover
- <40: Critical — structural reorganization needed

Write the scorecard to `wiki/journal/sync-logs/YYYY-MM-DD-lint.md`.

Deliver a concise summary:

```
## Vault Health: <score>/100

Top issues:
1. <most frequent issue> (<count>)
2. <second>
3. <third>

Recommended actions:
- <action 1>
- <action 2>
- <action 3>
```

---

## What This Skill Does NOT Do

- **Never edits notes** — reports only
- **Never deletes notes** — even duplicates are flagged, not removed
- **Never modifies schema** — even if it finds violations
- **Never makes autonomous fixes** — user approves each change

---

## Cost Estimation

- Tokens per lint: ~3,000-10,000 depending on vault size
- Nightly run: ~$0.01-0.05/night with hosted models
- Local models: $0

---

## Related Skills

- [[vault-sync]] — fixes issues this skill reports
- [[vault-forward-refs]] — specifically handles Check 7 output
- [[vault-digest]] — summarizes health trends weekly

---

*Engine version: 1.0.0*