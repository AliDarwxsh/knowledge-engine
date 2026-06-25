---
title: "Forward References — The Gray Link Philosophy"
summary: "How to use wikilinks that point to notes that do not yet exist, when to create them, and when to resolve them."
date: 2026-06-26
tags: [workflow, wikilinks, forward-references, graph]
---

# Forward References — The Gray Link Philosophy

> A link to a note that does not yet exist is a hypothesis. The hypothesis should resolve.

---

## Purpose

Forward references — `[[wikilinks]]` pointing to notes that have not been written yet — are an essential part of the vault's design. They let the operator and AI agents express **intent** about structure without prematurely filling in content. This workflow defines when to create forward references and when to resolve them.

> [!tip] **Forward references are gray links.** Obsidian displays them differently from canonical links. The vault treats them as promises, not noise.

---

## When to Create a Forward Reference

Create a forward reference when:

1. **You mention a concept that should become a note.** E.g., writing a principle that depends on a framework not yet defined.
2. **You reference a person, project, or event by name without a note.** E.g., "see [[person-name]]" before creating the person note.
3. **You imply a section that does not yet exist.** E.g., a TOC that anticipates future additions.

**Do NOT create forward references** when:

- The referenced note already exists (use the canonical link).
- The reference is speculative and likely to never resolve (use a comment instead).
- The reference would replace an existing note (use the existing note).

---

## Resolution Window

Every forward reference must resolve within **30 days** of creation. Resolution means one of:

| Resolution | Action |
|------------|--------|
| **Create the referenced note** | The forward reference becomes a canonical link |
| **Retarget the link** | Point to an existing note instead |
| **Remove the link** | The forward reference was a wrong turn; delete it |

> [!warning] **Forward references older than 30 days are flagged as hermeneutic debt** during the [[workflows/daily-rhythm|monthly lint]].

---

## Forward Reference Discipline

| Practice | Reason |
|----------|--------|
| Always include display text | Forward references without text are unsearchable |
| Note the intent in the surrounding paragraph | Helps resolution (the writer knew what they meant) |
| Track high-priority forward references | Add to [[13 Meta Analysis\|13 Meta Analysis]] as a `proposal-name.md` |
| Resolve during weekly review, not just monthly | Prevents debt accumulation |

---

## Forward Reference Patterns

### Pattern 1 — Anticipated Principle

While writing a [[03 Projects|project note]], you state "this embodies [[Principle of Compounding Decisions]]." The principle does not exist yet.

**Resolution:** During the next weekly review, either create the principle note (if the claim survives scrutiny) or retarget the link to an existing principle.

### Pattern 2 — Anticipated Person

While writing a [[06 Decision Archive|decision note]], you mention "agreed with [[person-name]]." The person note does not exist.

**Resolution:** Create the [[12 Relationship Maps|person note]] within 7 days, or remove the reference if the person is not tracked in the vault.

### Pattern 3 — Anticipated Project

While writing an idea note, you mention "[[Project X]] depends on this." Project X does not exist yet.

**Resolution:** Either create Project X (if it is real and upcoming) or retarget to the closest existing project.

### Pattern 4 — Anticipated Synthesis

While writing two unrelated notes, you realize a synthesis will be possible. You write "see [[Cross-Domain Pattern Y]]."

**Resolution:** Either create the synthesis note (in [[wiki/synthesis/|wiki/synthesis/]]) or remove the reference if the pattern does not emerge.

---

## Tracking Forward References

The vault maintains a forward-reference backlog:

| Location | Purpose |
|----------|---------|
| Obsidian's native graph view | Visualizes forward references as gray nodes |
| `13 Meta Analysis/proposals/` | High-priority forward references tracked as proposals |
| Monthly lint report | Lists unresolved forward references >30 days |

---

## AI Agent Behavior

Hermes and other agents must:

1. **Treat forward references as legitimate intent.** Do not delete them on the grounds that the target does not exist.
2. **Propose resolution.** When asked to review a note with forward references, offer to create the target note or retarget the link.
3. **Never auto-resolve without operator approval.** Forward-reference resolution is a semantic decision.

> [!warning] **Do not silently resolve.** Resolving a forward reference is an act of structure. It must be visible and approved.

---

## Common Failure Modes

| Failure | Recovery |
|---------|----------|
| Forward references accumulate for months | Monthly lint catches them; resolve or delete in batch |
| Forward references point to notes with similar names | Verify target filename during resolution; avoid collision |
| Forward reference duplicates an existing note | Retarget or merge; do not create a near-duplicate |
| Forward reference was a wrong turn | Delete with a `changelog` comment in the source note |

---

## Inputs and Outputs

| Input | Output |
|-------|--------|
| Existing notes with forward references | Resolved links or removed references |
| Backlog of unresolved forward references | Forward-reference resolution report in [[13 Meta Analysis\|13 Meta Analysis]] |

---

## Related

- [[workflows/inbox-triage\|inbox-triage.md]] — triage promotes inbox items; forward references are noted during triage
- [[workflows/daily-rhythm\|daily-rhythm.md]] — weekly review touches forward references
- [[workflows/maintenance-protocol\|maintenance-protocol.md]] — monthly lint flags unresolved forward references
- [[schema/CLAUDE\|schema/CLAUDE.md]] — Layer 2 link rules
- [[schema/agents\|schema/agents.md]] — Cartographer responsibilities

---

*A forward reference is a hypothesis. Hypotheses deserve resolution.*