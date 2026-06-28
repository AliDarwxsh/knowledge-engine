---
name: vault-query
description: Natural language query against the vault. Reads full content of top matches, answers with citations, flags contradictions, returns actionable intelligence. Use whenever the user asks a question the vault might know the answer to.
version: 1.0.0
author: knowledge-engine
tags: [query, search, retrieval, qa]
---

# vault-query — Natural Language Vault Search

> Ask your vault anything. Get an answer with citations from your own notes — not the internet.

---

## When to Invoke

- User: "/query <question>", "What did I write about <topic>?", "Find me notes on <X>"
- Auto-triggered when user asks a knowledge question mid-session (if Hermes context has vault loaded)

---

## Prerequisites

1. Vault is initialized (`CLAUDE.md` exists at root)
2. Vault contains at least some notes to search against
3. `schema/ontology.md` has been read (for tag-aware search)
4. This skill does NOT write — it only reports

---

## Execution — Five Phases

### Phase 1: Understand The Query

Parse the natural language query:

1. **Intent classification**:
   - LOOKUP — "What is X?" → find canonical note
   - EXPLORATION — "What do I think about X?" → find multiple related notes
   - SYNTHESIS — "Why did I decide X?" → find decision chain
   - DISCOVERY — "Have I written about X?" → existence check
   - TEMPORAL — "What did I write last month about X?" → time-bounded search
   - CONTRADICTION — "Do I have conflicting views on X?" → compare opposing notes

2. **Extract key concepts** (1-5 terms)
3. **Identify time bounds** (if any)
4. **Identify domain hints** (if any)

### Phase 2: Search The Vault

Run a multi-strategy search:

1. **Filename match**: `search_files` for filenames containing concepts
2. **Title match**: grep for `title:` lines containing concepts
3. **Tag match**: find notes with relevant tags
4. **Body match**: grep for concept occurrences in body text
5. **Wikilink target**: if query references a known concept, find what links to it

Aggregate results, deduplicate, rank by:
- Exact title match: 1.0
- Title contains concept: 0.8
- Frontmatter tag match: 0.7
- Body contains concept (multiple times): 0.6
- Body contains concept (once): 0.4
- Wikilink target: 0.5

Top 5-10 candidates proceed.

### Phase 3: Read Full Content

For top candidates, READ the full note (not just frontmatter). This is what differentiates the engine from keyword search — it actually understands your notes.

Skip reading if:
- Note is `draft` (incomplete)
- Note is in `00 Inbox/` unprocessed
- Note is older than 6 months AND query doesn't reference past (efficiency)

### Phase 4: Synthesize The Answer

For LOOKUP intent: return the canonical note directly with a quote.

For EXPLORATION intent: synthesize 2-5 sentences connecting relevant notes.

For SYNTHESIS intent: reconstruct the decision chain chronologically.

For DISCOVERY intent: simple yes/no with relevant notes listed.

For TEMPORAL intent: organize findings by date within the time window.

For CONTRADICTION intent: present opposing views side by side, suggest resolution if possible.

Output format:

```
## Answer

<Direct answer to the question, 1-3 sentences>

## Sources

- [[note-1]] — <relevant excerpt, ≤50 words>
- [[note-2]] — <relevant excerpt, ≤50 words>
- [[note-3]] — <relevant excerpt, ≤50 words>

## Related

- [[related-1]] — <why this might also interest you>

## Confidence

<High / Moderate / Low>

<If contradictions exist:>
## Tension Detected

[[note-a]] and [[note-b]] disagree on <X>. See [[contradiction-note]] for analysis.
```

### Phase 5: Suggest Next Action

End every query with a relevant next-step suggestion:

- If user asked LOOKUP and note exists: "Want to explore [[related-note]] next?"
- If user asked EXPLORATION: "Want me to write a synthesis note connecting these?"
- If user asked SYNTHESIS: "Want to revisit this decision with new context?"
- If user asked DISCOVERY (found nothing): "Nothing yet. Want to capture your thinking on this topic?"
- If contradictions found: "Want to write a resolution note?"

---

## Permission Boundaries

This skill:
- ✅ Reads from entire vault
- ❌ NEVER writes to vault (read-only)
- Outputs go to chat, not to files

---

## Adversarial Cases

|| Case | Response |
||------|----------|
|| Query is too vague ("What do I know?") | Ask: "Pick a topic: people, projects, principles, or recent notes?" |
|| Query matches 50+ notes | Show top 5 by relevance, ask if user wants to broaden |
|| Query matches 0 notes | "Nothing in your vault yet. Want to capture a note on this?" |
|| Query references note that doesn't exist | Check for similar names. "Did you mean [[similar-note]]?" |
|| Query is a yes/no question with no relevant vault content | "Your vault doesn't address this yet. Should I research and add a note?" |

---

## What This Skill Does NOT Do

- ❌ Never writes to vault (read-only)
- ❌ Never transmits vault content beyond the configured AI model
- ❌ Never modifies note content
- ❌ Never creates or deletes files

---

## Cost Estimation

- Tokens per query: ~2,000-8,000 (depends on number of notes read)
- Per-query cost: ~$0.005-0.02 with hosted models

---

## Related Skills

- [[vault-link]] — finds connections between notes this skill returns
- [[vault-capture]] — invoked if user wants to add content based on query results
- [[vault-digest]] — produces periodic synthesis; queries return specific answers

---

*Engine version: 1.0.0*