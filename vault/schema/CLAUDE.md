---
title: "schema — Governance and Standards"
summary: "Three-layer rule architecture: structural, semantic, and copywriting. Defines what the vault is and how it must operate."
date: 2026-06-26
tags: [schema, governance, rules, constitution, claude]
ai_context: "Hermes treats schema/CLAUDE.md as the highest-priority governance file. Read this on session start, before any other wiki/ file. All other rules are subordinate to this file."
---

# schema — Governance and Standards

> The constitution of the vault. The Schema Keeper enforces it.

---

## Three-Layer Rule Architecture

The schema defines three layers of rules, in order of decreasing scope:

| Layer | Domain | Enforced By | Editable By |
|-------|--------|-------------|-------------|
| **Layer 1 — Structural** | Folder layout, naming, frontmatter, link graph | [[schema/agents\|Schema Keeper]] | Operator + Schema Keeper |
| **Layer 2 — Semantic** | Ontology, terminology, agent roles, citation rules | [[schema/agents\|Schema Keeper]] | Schema Keeper + operator review |
| **Layer 3 — Copywriting / Voice** | Style, tone, terminology consistency | [[schema/agents\|Editor]] + [[schema/agents\|Schema Keeper]] | Editor |

Every layer is checked by the corresponding agent and surfaced in audit reports.

---

## Layer 1 — Structural Rules

| Rule | Specification |
|------|---------------|
| Folder layout | Human Layer (00–13) and Machine Layer (wiki, sources, schema) |
| Filenames | `kebab-case.md` for every file |
| Frontmatter | `title`, `summary`, `date`, `tags` mandatory |
| Wikilinks | ≥3 outgoing links per note; ≥1 incoming link (no orphans) |
| YAML validity | All frontmatter must parse as valid YAML |
| Folder naming | Numbered prefix for Human Layer; semantic for Machine Layer |

> [!tip] **The orphan rule is non-negotiable.** A note without an incoming link is invisible to graph traversal.

### Structural Failure Recovery

| Failure | Action |
|---------|--------|
| Missing frontmatter | Add required fields; mark `[REPAIRED]` in footer |
| Non-kebab filename | Rename in place; update all wikilinks |
| Orphan note | Add incoming [[wikilinks]] from a MOC |
| Invalid YAML | Run [[schema/agents\|Auditor]] autofix; manual review required if autofix fails |

---

## Layer 2 — Semantic Rules

| Rule | Specification |
|------|---------------|
| Ontology | All tags must come from [[schema/ontology\|schema/ontology.md]] |
| Terminology | All key terms must use definitions from [[schema/terminology\|schema/terminology.md]] |
| Agent permissions | Writes must respect [[schema/agents\|schema/agents.md]] boundaries |
| Source citation | Every wiki claim must cite a source or carry `[UNSOURCED]` |
| Decision completeness | Decision notes must list alternatives and principles |
| Principle evidence | Principles must cite ≥3 decisions |
| Synthesis inputs | Synthesis notes must cite ≥3 notes from ≥2 clusters |

### Semantic Failure Recovery

| Failure | Action |
|---------|--------|
| Off-ontology tag | Replace with canonical tag; log in schema changelog |
| Ambiguous term | Add to [[schema/terminology\|terminology]] if recurring; otherwise rephrase |
| Unsourced claim | Either add a source link or mark `[UNSOURCED]` |
| Insufficient principle evidence | Hold principle in [[10 Ideas & Opportunities\|10 Ideas]] until evidence accrues |
| Synthesis missing inputs | Reject the synthesis; demand minimum inputs |

---

## Layer 3 — Copywriting / Voice Rules

| Rule | Specification |
|------|---------------|
| Active voice | Sentences lead with the subject and verb |
| Concrete nouns | No abstractions without grounding |
| Precise verbs | No "facilitate," "utilize," "leverage" without cause |
| Zero filler | No "very," "really," "just," "basically," "in order to" |
| One idea per paragraph | Paragraphs split when a second idea appears |
| Lead with the conclusion | First sentence states the takeaway |
| Telegraphic headings | No generic "Notes" or "Thoughts"; the heading predicts content |
| Callouts for non-negotiables | Use `> [!note]`, `> [!tip]`, `> [!warning]` |

Full specification: [[schema/copywriting-standards|schema/copywriting-standards.md]].

### Voice Failure Recovery

| Failure | Action |
|---------|--------|
| Filler detected | Auto-rewrite with [[schema/agents\|Editor]] |
| Heading too generic | Auto-suggest a telegraphic alternative |
| Passive voice | Convert to active; require operator approval for stylistic exceptions |

---

## Rule Precedence

When rules conflict:

1. **Layer 1 > Layer 2 > Layer 3** (structural rules trump semantic rules trump voice rules)
2. **Schema > workflows > templates** (schema is binding; workflows and templates may be overridden with operator approval)
3. **Operator > agent** (the operator may override any rule with explicit, logged approval)

---

## Schema Editing

Schema edits follow a strict process:

1. Proposal in [[13 Meta Analysis|13 Meta Analysis]] as a `proposal-change-name.md` note.
2. Review by [[schema/agents|Schema Keeper]].
3. Operator approval if the change is structural or ontology-shaping.
4. Update schema files.
5. Log in [[schema/log|schema/log.md]] (newest first).

---

## Audit Cadence

| Audit | Layer | Frequency | Owner |
|-------|-------|-----------|-------|
| Structural lint | Layer 1 | Weekly | [[schema/agents\|Auditor]] |
| Semantic scan | Layer 2 | Monthly | [[schema/agents\|Auditor]] |
| Voice compliance | Layer 3 | Per write | [[schema/agents\|Editor]] |

---

## Related

- [[schema/agents|schema/agents.md]] — agent roles and permissions
- [[schema/ontology|schema/ontology.md]] — tag taxonomy
- [[schema/terminology|schema/terminology.md]] — canonical glossary
- [[schema/copywriting-standards|schema/copywriting-standards.md]] — style guide
- [[README|README.md]] — vault overview
- [[workflows/maintenance-protocol|workflows/maintenance-protocol.md]] — audit cadence

---

*The schema is the contract. Every other file is a performance under that contract.*