---
title: "copywriting-standards — Style Guide"
summary: "Eight copywriting standards for the vault. Active voice, concrete nouns, zero filler. Enforced by the Editor agent."
date: 2026-06-26
tags: [schema, copywriting, style, voice, standards]
ai_context: "Hermes applies these standards to every edit and generation. Voice violations are flagged in the monthly audit and corrected by the Editor agent with operator approval."
---

# copywriting-standards — Style Guide

> Eight rules. Active voice. Concrete nouns. Zero filler.

---

## Purpose

The Copywriting Standards define the **voice** of the vault. Every note that survives in the canonical layer passes the Copywriting Audit. The audit is run by the [[schema/agents|Editor]] agent and surfaces in [[13 Meta Analysis|13 Meta Analysis]].

> [!tip] **The voice test.** If a paragraph could appear in any generic productivity blog, it does not pass.

---

## The Eight Standards

### 1. Active Voice

**Rule:** Every sentence leads with the subject and verb.

| Bad | Good |
|-----|------|
| The decision was made by the operator to ship. | The operator decided to ship. |
| A pattern was observed across the data. | The data revealed a pattern. |

**Exception:** Technical descriptions of systems may use passive voice when the actor is irrelevant. Document the exception.

---

### 2. Concrete Nouns

**Rule:** Every abstract noun is grounded in a specific entity, file, or action.

| Bad | Good |
|-----|------|
| productivity | shipping X by Friday |
| innovation | three new product ideas |
| value | revenue increase of $X |

> [!warning] **Banned abstractions:** leverage, facilitate, optimize, holistic, robust, scalable, world-class, cutting-edge. Replace with the specific thing they refer to.

---

### 3. Precise Verbs

**Rule:** Every verb states an observable action. Avoid corporate verbs that obscure action.

| Bad | Good |
|-----|------|
| utilize | use |
| facilitate | help, enable |
| leverage | use, exploit, apply |
| operationalize | run, ship |
| action | do |
| move forward | proceed, advance, ship |

---

### 4. Zero Filler

**Rule:** No filler words, ever.

**Banned filler list:**
- very, really, quite, rather, somewhat
- just, basically, essentially, literally
- in order to (use "to")
- actually, obviously, clearly (when used as hedges)
- of course, naturally (when used as hedges)
- it is worth noting that
- it should be noted that

> [!tip] **The deletion test.** If removing a word does not change meaning, the word is filler. Delete it.

---

### 5. One Idea Per Paragraph

**Rule:** Each paragraph contains one idea. Split when a second idea appears.

| Bad | Good |
|-----|------|
| The inbox was cleared. The principles were updated. | The inbox was cleared. The principles were updated to reflect the new framework. |

A paragraph may have multiple sentences supporting the same idea. A paragraph must not have multiple ideas.

---

### 6. Lead with the Conclusion

**Rule:** The first sentence of every section states the takeaway. Details follow.

| Bad | Good |
|-----|------|
| We considered three options. Option A was... | We chose Option A. The reasoning is below. |

This rule applies to:
- Note intros
- Section headers
- Email and chat responses generated from vault content

---

### 7. Telegraphic Headings

**Rule:** Every heading predicts content. No generic headings.

| Bad | Good |
|-----|------|
| Notes | Three Reasons Capture Beats Curation |
| Thoughts | The Reversibility Heuristic in Practice |
| Overview | Inbox Volume Doubled After the Workflow Change |
| Discussion | Why We Killed the Friday Review |

The heading should be readable as a one-line summary of the section.

---

### 8. Callouts for Non-Negotiables

**Rule:** Use Obsidian callouts to surface load-bearing insights that must not be missed.

| Callout | When to Use |
|---------|-------------|
| `> [!note]` | A non-obvious fact the reader needs |
| `> [!tip]` | A pattern or shortcut worth applying |
| `> [!warning]` | A failure mode or risk the reader must avoid |
| `> [!important]` | A rule that overrides defaults |
| `> [!example]` | An illustrative case |

**Banned:** Generic "Notes:" callouts, decorative blockquotes without semantic value.

---

## Audit Process

The [[schema/agents|Editor]] runs the Copywriting Audit on every write:

1. **Active voice check** — flag passive constructions.
2. **Concrete noun check** — flag banned abstractions.
3. **Filler check** — flag every word on the banned list.
4. **Heading check** — flag generic headings.
5. **Callout check** — confirm load-bearing claims use callouts.

Audit results are logged in [[13 Meta Analysis|13 Meta Analysis]].

---

## Voice Exceptions

A note may request an exception when:

1. The note is a transcript or source quote (preserve original voice).
2. The note is a research log capturing data verbatim.
3. The exception is logged in frontmatter as `voice_exception: <reason>`.

Exceptions are auditable. The Editor flags any note requesting an exception without a stated reason.

---

## Examples

### Before
> In order to facilitate the optimization of our capture workflow, we have basically just made the decision to leverage the inbox in a more robust way, which will obviously lead to a holistic improvement in productivity.

### After
> We simplified the inbox workflow. Capture takes less than 10 seconds; triage takes 5 minutes.

The after-version is 24 words versus 41, and carries more information.

---

## Related

- [[schema/CLAUDE|schema/CLAUDE.md]] — Layer 3 rules
- [[schema/agents|schema/agents.md]] — Editor agent permissions
- [[schema/ontology|schema/ontology.md]] — tag vocabulary
- [[schema/terminology|schema/terminology.md]] — canonical terms

---

*Active voice. Concrete nouns. Zero filler. The vault speaks in clear sentences.*