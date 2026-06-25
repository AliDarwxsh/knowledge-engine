---
title: "Evergreen Note Template"
summary: "A reusable scaffold for durable, atomic notes: principles, frameworks, knowledge, references. Optimized for retrieval and linking."
date: 2026-06-26
tags: [template, evergreen-note, atomic, durable]
---

# Evergreen Note Template

> An evergreen note is one you would want to read in two years.

---

## Purpose

The evergreen note is the **atomic unit** of the vault's machine layer. It holds a single, durable claim — a principle, a framework, a domain fact, a definition — that survives the moment of its creation and can be retrieved across contexts.

| Type of Note | Folder | Atomic Claim |
|--------------|--------|--------------|
| Principle | [[02 Principles\|02 Principles]] | A behavioral rule |
| Framework | [[05 Framework Library\|05 Framework Library]] | A mental model |
| Knowledge | [[04 Knowledge Library\|04 Knowledge Library]] | A domain fact or concept |
| Reference | [[04 Knowledge Library\|04 Knowledge Library]] | A specific lookup target |

---

## Frontmatter

```yaml
---
title: "<Descriptive Title>"
summary: "<One sentence: the atomic claim in plain language>"
date: YYYY-MM-DD
tags: [<top-level>, <content>, <status>]
status: canonical | draft | disputed | deprecated
ai_context: "<one sentence telling AI when to load this note>"
---
```

| Field | Required | Purpose |
|-------|----------|---------|
| `title` | Yes | Filename and human-readable title |
| `summary` | Yes | The single takeaway |
| `date` | Yes | Date of last substantive revision |
| `tags` | Yes | From [[schema/ontology\|schema/ontology.md]] |
| `status` | Yes | Lifecycle stage |
| `ai_context` | Recommended | When AI should load this note |

---

## Template Body

```markdown
# <Title>

> <The atomic claim in one sentence. This is the takeaway.>

---

## The Claim

<The claim stated clearly. Lead with the conclusion.>

## Why It Matters

<The consequence. What becomes possible or impossible if this is true.>

## How It Works

<The mechanism. What makes the claim true.>

## When to Apply

<The situations where the claim is operative.>

## When NOT to Apply

<The situations where the claim misleads. Anti-patterns.>

## Evidence

- <source 1>
- <source 2>
- <source 3>

## Counter-Evidence

- <counter-example 1>
- <counter-example 2>

## Related

- [[linked-note-1]]
- [[linked-note-2]]
- [[linked-note-3]]

## Changelog

- <YYYY-MM-DD> — created.
```

---

## The Atomic Test

A note passes the atomic test if:

1. **One claim** — the note contains one idea that can be stated in one sentence.
2. **Self-contained** — the note can be read without prior context.
3. **Link-ready** — the note is well-positioned in the link graph (≥3 outgoing, ≥1 incoming).
4. **Future-relevant** — the note will be useful in two years.

A note fails the atomic test if:

- It summarizes a source (use a [[templates/literature-note|literature note]] instead).
- It contains multiple unrelated claims (split into multiple notes).
- It is a placeholder for an idea (use [[10 Ideas & Opportunities|10 Ideas]] instead).
- It is a journal entry (use [[templates/daily-note|daily note]] instead).

---

## Anatomy Guidance

| Section | Length Guidance |
|---------|-----------------|
| The Claim | 1–2 sentences |
| Why It Matters | 1 paragraph |
| How It Works | 1–3 paragraphs |
| When to Apply | bullet list, 3–7 items |
| When NOT to Apply | bullet list, 1–5 items |
| Evidence | 1–5 sources |
| Counter-Evidence | 0–3 examples |
| Related | 3+ wikilinks |

---

## Promotion Paths

| From | To |
|------|----|
| Daily note insight | Evergreen note in [[04 Knowledge Library]] or [[02 Principles]] |
| Literature note insight | Evergreen note in [[04 Knowledge Library]] |
| [[10 Ideas & Opportunities]] idea with evidence | Evergreen note in [[02 Principles]] or [[05 Framework Library]] |

---

## Related

- [[templates/literature-note\|literature-note.md]]
- [[templates/principle-note\|principle-note.md]]
- [[templates/project-note\|project-note.md]]
- [[schema/copywriting-standards\|schema/copywriting-standards.md]] — voice standards for evergreen notes

---

*An evergreen note is one you would want to read in two years.*