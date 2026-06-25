---
name: vault-forward-refs
description: Triage forward references (gray links to non-existent notes). Groups references by target, proposes new notes for high-frequency ghosts, suggests removing low-value links. Weekly companion to vault-lint.
version: 1.0.0
author: knowledge-engine
tags: [forward-reference, gray-link, triage, maintenance]
---

# vault-forward-refs — Gray Link Triage

> When the engine encounters a concept that should exist but doesn't, it creates a forward reference (gray link). This skill triages those accumulated references weekly.

---

## Background — Why Forward References Exist

When [[vault-capture]] or [[vault-link]] encounters a concept referenced in context but without a canonical note:

1. **Bad option A**: Skip the link → loss of information
2. **Bad option B**: Invent a fake note → pollutes vault with stubs
3. **Good option**: Create `[[forward-reference-concept]]` → Obsidian renders gray link, triaged later

This skill processes the accumulated gray links and decides:
- **Create** the canonical note (if concept is referenced 3+ times)
- **Promote** an existing related note (if the link target was vague)
- **Remove** the link (if the concept doesn't justify a standalone note)

---

## When to Invoke

- User: "/forward-refs", "/vault-forward-refs", "Triage gray links"
- Auto: weekly as part of vault-lint cycle (every Sunday after digest)

---

## Execution — Five Phases

### Phase 1: Inventory All Gray Links

Scan entire vault for wikilinks where the target file doesn't exist:

```bash
# Pseudocode
for each .md file:
  for each [[wikilink]] in file:
    if target_file_does_not_exist(target):
      add to gray_links_inventory
```

Build a frequency map: `forward-ref-concept → [files that reference it]`

### Phase 2: Categorize Each Gray Link

For each unique gray link target, decide category:

| Category | Detection | Action |
|----------|-----------|--------|
| **HIGH PRIORITY** | Referenced 5+ times across vault | Propose creating note |
| **MEDIUM PRIORITY** | Referenced 2-4 times | Propose creating note with caveat |
| **LOW PRIORITY** | Referenced once | Suggest removing link or creating note |
| **STALE** | Referenced in notes >6 months old, not touched recently | Suggest removing |
| **CONFLICTING** | Multiple sources use same name for different concepts | Flag for disambiguation |

### Phase 3: Generate Proposals

For each HIGH and MEDIUM priority gray link, generate a proposal:

```markdown
### [[forward-ref-concept]]

**Referenced in**: <N> notes
**First seen**: <date>
**Last seen**: <date>
**Context excerpts**:
- From [[note-1]]: "...<surrounding text>..."
- From [[note-2]]: "...<surrounding text>..."
- From [[note-3]]: "...<surrounding text>..."

**Proposed canonical note**:

---
title: "<Generated title>"
summary: "<One-sentence summary based on usage contexts>"
type: <inferred>
tags: [<inferred>]
---

# <Title>

<Body generated from the contexts where the term was used>

## Related
- [[note-1]]
- [[note-2]]
- [[note-3]]

---

**Decision**: Create / Modify existing / Remove links
```

### Phase 4: Execute Approvals

Based on user's permission level:

- **Conservative**: Present proposals, do nothing automatically
- **Moderate**: Auto-create notes for HIGH priority, present MEDIUM
- **Aggressive**: Auto-create HIGH and MEDIUM, remove LOW

If permission level allows auto-creation, also:
- Update `related:` field in referencing notes (add the new canonical link)
- Add to appropriate MOC
- Update `schema/ontology.md` if new tag introduced

### Phase 5: Report

```
## Forward Reference Triage: <YYYY-MM-DD>

**Total gray links found**: <N>
**Unique targets**: <M>

### Action Taken

- **Notes created**: <count> — [[new-note-1]], [[new-note-2]], ...
- **Links removed**: <count>
- **Links promoted** (to existing note): <count>
- **Pending decisions**: <count>

### Created Notes Summary

| New Note | Sources | Type |
|----------|---------|------|
| [[new-1]] | 5 notes | principle |
| [[new-2]] | 3 notes | framework |
| ... | ... | ... |

### Pending Your Decision

- [[some-ghost]] — 2 references, ambiguous context. Create or remove?
- [[another-ghost]] — conflicting meanings across sources. Disambiguate?
```

Write report to `wiki/journal/sync-logs/YYYY-MM-DD-forward-refs.md`.

---

## Permission Boundaries

This skill:
- ✅ Reads entire vault
- ✅ Creates new notes (if permission level allows)
- ✅ Modifies `related:` field in existing notes (if permission level allows)
- ✅ Removes wikilinks from notes (if permission level allows)
- ✅ Updates MOCs and ontology (if permission level allows)
- ❌ Never modifies `schema/CLAUDE.md` or `schema/copywriting-standards.md`
- ❌ Never edits `sources/`

---

## Cost Estimation

- Tokens per triage: ~3,000-10,000
- Weekly run: ~$0.02-0.05/week
- Local models: $0

---

## Related Skills

- [[vault-lint]] — Check 7 produces the input for this skill
- [[vault-capture]] — creates forward references during classification
- [[vault-link]] — creates forward references when finding connections

---

*Engine version: 1.0.0*