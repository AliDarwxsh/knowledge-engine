---
name: vault-capture
description: The core capture loop. Takes raw input (text, pasted chat, file path, URL), classifies it, generates frontmatter, creates the note in the correct folder, suggests wikilinks, and files it. Use whenever the user wants to capture a thought or has content to ingest.
version: 1.0.0
author: knowledge-engine
tags: [capture, classify, ingest, primary-workflow]
---

# vault-capture — Ingest, Classify, Link

> The engine's core loop. Drops in raw thoughts. Files them as structured, linked, tagged notes. Zero decisions at capture time.

---

## When to Invoke

The user says any of:
- "Capture this: <text or path>"
- "Save this thought: <text>"
- "Ingest this article: <path or URL>"
- "/capture <text>"
- "/vault-capture <text or path>"
- Auto-triggered by inbox-processor cron (every 6 hours)

---

## Prerequisites

1. Vault is initialized (`CLAUDE.md` exists at root)
2. `schema/ontology.md` has been read into context
3. `schema/agents.md` permissions reviewed (this skill writes to most folders)
4. `schema/copywriting-standards.md` internalized (for note voice)

---

## Execution — Five Phases

### Phase 1: Parse Input

Determine the input type:

| Input Form | Action |
|------------|--------|
| Raw text (inline in command) | Use directly |
| Path to .md file | Read file contents |
| Path to .pdf / .txt / .json | Read file, extract text |
| URL | Fetch content via MCP web tools |
| Paste from clipboard | Use as-is |

Strip any leading/trailing whitespace. Truncate to 50,000 characters max (chunk longer inputs and process in pieces, creating one parent note with child notes linked).

### Phase 2: Classify

Determine the note TYPE and TARGET FOLDER using this decision matrix:

| Type | Detection Signal | Target Folder | File Naming |
|------|------------------|---------------|-------------|
| **Principle** | "should", "must", "the rule is", absolute language, decisive tone | `02 Principles/` | `principle-<slug>.md` |
| **Identity** | First-person self-reference, "I am", "I believe", "my..." | `01 Identity/` | `identity-<slug>.md` |
| **Project note** | Specific project mentioned in `CLAUDE.md`, action verbs, deadline, output | `03 Projects/<project-name>/` | `<slug>.md` |
| **Knowledge** | Facts, definitions, research, explanations, "X is..." | `04 Knowledge Library/` | `<slug>.md` |
| **Framework** | Mental model, named pattern, "the X model", "first principles", decision matrix | `05 Framework Library/` | `framework-<slug>.md` |
| **Decision** | Past tense, "I decided", "we chose", reasoning chain | `06 Decision Archive/` | `decision-<slug>.md` |
| **System/SOP** | Step-by-step, repeatable, "how to", process description | `07 Systems & SOPs/` | `sop-<slug>.md` |
| **Prompt** | Structured prompt for AI, contains "You are" or similar | `08 Prompt Library/` | `prompt-<slug>.md` |
| **Research** | Deep dive, citations, multi-source synthesis | `09 Research Archive/` | `research-<slug>.md` |
| **Idea** | Future tense, "what if", "could we", speculative, not yet committed | `10 Ideas & Opportunities/` | `idea-<slug>.md` |
| **Relationship** | People, networks, social dynamics, named individuals | `12 Relationship Maps/` | `relation-<slug>.md` |
| **Reference** | External resource, link, tool, book, article — not your own thinking | `04 Knowledge Library/` (with `reference` tag) | `reference-<slug>.md` |

**Classification Confidence**:
- HIGH (clear signal) → proceed
- MODERATE (one signal) → proceed, note uncertainty in frontmatter
- LOW (ambiguous) → classify as the best fit, but create a `## Review` section asking the user to confirm

If completely unclassifiable, file in `00 Inbox/_unclassified/` and flag for human review.

### Phase 3: Generate Frontmatter

Every note MUST have this frontmatter:

```yaml
---
title: "Full Sentence Title — Telegraphs the Core Idea"
summary: "One compelling sentence. Lead with the conclusion, not the topic."
type: <principle|identity|project|knowledge|framework|decision|system|prompt|research|idea|relation|reference>
domain: <primary domain from ontology, e.g., philosophy, business, design>
tags: [<tag1>, <tag2>, <tag3>]  # From schema/ontology.md only
created: <YYYY-MM-DD>
captured_by: vault-capture v1.0.0
source: <original source if imported, else "user-capture">
confidence: <high|moderate|low>
related: []  # Populated in Phase 4
---
```

**Title rule**: Full sentence, not topic. "Mastery emerges from constraint" not "On mastery". "AI amplifies judgment, it doesn't replace it" not "AI thoughts".

**Summary rule**: One sentence. Lead with the conclusion. No "This note explores..." or "In this document we will...".

**Tag rule**: Max 5 tags. All from `schema/ontology.md`. No invented tags. If a concept needs a tag that doesn't exist, use the closest domain and add a flag in `## Review`.

### Phase 4: Find and Suggest Wikilinks

Search the vault for notes semantically related to the new content. Steps:

1. **Keyword match**: Extract 3-5 key concepts from the new note
2. **Vault scan**: Use `search_files` or grep to find notes containing these concepts
3. **Tag overlap**: Find notes with overlapping tags
4. **Synthesize**: Generate a candidate list of 3-7 most relevant existing notes

For each match, decide:
- **Strong match** (related concept, builds on or relates to) → add `[[wikilink]]` in body and to `related:` in frontmatter
- **Weak match** (shares vocabulary, different meaning) → add to `## Loose Connections` at bottom of note
- **Forward reference** (concept should exist but doesn't) → add `[[forward-reference-concept]]` (creates gray link per schema/CLAUDE.md)

In the note body, place the strongest links inline using natural prose, not as a bare list. Example:

> Mastery emerges when constraint becomes the creative engine. This builds on [[constraint-as-creativity-catalyst]] and contradicts the assumption in [[mastery-through-volume]].

### Phase 5: Write the Note

Create the file at the target path with this structure:

```markdown
---
<frontmatter from Phase 3>
---

# <Title from frontmatter>

> <One-sentence pull quote that captures the core>

---

## The Idea

<The body — written in the user's voice per schema/copywriting-standards.md. Active voice. Concrete nouns. Zero filler. One idea per paragraph.>

## Evidence & Sources

<If this note originated from a specific source — book, conversation, article — cite it here. If it's pure thinking, write "Origin: own reflection, <date>".>

## Related

- [[strong-link-1]]
- [[strong-link-2]]
- [[strong-link-3]]

## Loose Connections

- [[weak-link-1]]

## Review

<Only if confidence is MODERATE or LOW. Pose a single, clear question for the user.>
```

If confidence is HIGH, omit the `## Review` section entirely.

### Phase 6: Confirm to User

Output a concise confirmation:

```
✅ Captured [[note-name]]

Type: <type>
Folder: <target folder>
Tags: <tag1>, <tag2>, <tag3>
Links: 3 strong, 1 forward reference

Created at: <absolute path>
```

---

## Permission Boundaries

This skill WRITES to:
- `01 Identity/`, `02 Principles/`, `03 Projects/`, `04 Knowledge Library/`, `05 Framework Library/`, `06 Decision Archive/`, `07 Systems & SOPs/`, `08 Prompt Library/`, `09 Research Archive/`, `10 Ideas & Opportunities/`, `12 Relationship Maps/`
- `00 Inbox/_unclassified/` (only if ambiguous)

This skill READS from:
- All of the above
- `schema/CLAUDE.md`, `schema/ontology.md`, `schema/agents.md`, `schema/copywriting-standards.md`
- `CLAUDE.md` (user profile)
- All `wiki/` (machine layer)

This skill DOES NOT TOUCH:
- `schema/` files (governance is human-owned)
- `sources/` files (immutable raw material)
- `13 Meta Analysis/` (system self-reflection, requires explicit user direction)

---

## Adversarial Cases

| Case | Response |
|------|----------|
| User pastes 50,000 characters | Chunk into parent note + 5-10 child notes with `part-of: [[parent]]` |
| Note contradicts existing note | Create both. Flag contradiction in `wiki/journal/contradictions/` |
| Same idea already exists | Detect via semantic similarity > 0.7. Ask user: update existing or create new? |
| Input is empty | Halt with: "Nothing to capture. Paste a thought, path, or URL." |
| Input is gibberish | Halt with: "Input doesn't look like text. Provide a thought, file path, or URL." |
| Folder doesn't exist | Create it. Log creation. Continue. |

---

## Voice Standards

Every generated note must pass the 8 copywriting standards from `schema/copywriting-standards.md`:
1. Clarity First — one idea per sentence
2. Specificity — named entities, numbers, dates
3. Direct Address — "you" when instructing, no "one should"
4. Shadow Inclusion — every strength note includes its failure mode
5. Analogy Anchor — open with concrete image before abstract elaboration
6. No Fluff — eliminate "very", "really", "just", "actually", "in order to"
7. Active Voice — subject performs the verb
8. Jargon Taxonomy — new terms defined on first use

---

## Cost Estimation

- LLM tokens per capture: ~1,500-3,000 (classification + summarization + linking)
- At GPT-4o-mini pricing ($0.15/1M input): ~$0.0002-0.0005 per note
- At Claude Haiku: similar
- At local Ollama: $0
- 100 captures/day = $0.02-0.05/day with hosted models

---

## Related Skills

- [[vault-sync]] — batch processes multiple unprocessed inbox items
- [[vault-lint]] — validates this skill's output against schema rules
- [[vault-link]] — runs nightly, finds additional links beyond this skill's scope
- [[vault-forward-refs]] — triages the gray links this skill creates

---

*Engine version: 1.0.0 — part of knowledge-engine public release*