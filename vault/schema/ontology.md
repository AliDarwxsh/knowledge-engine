---
title: "ontology — Tag Taxonomy"
summary: "Canonical tag taxonomy for the vault. Every tag used in frontmatter or wikilinks must come from this list or be proposed here."
date: 2026-06-26
tags: [schema, ontology, taxonomy, tags, governance]
ai_context: "Hermes uses this file as the canonical source of tags. Before applying a tag, check that it exists here. Off-ontology tags are rejected and surfaced as semantic violations."
---

# ontology — Tag Taxonomy

> One tag, one meaning. Apply by intent, not by habit.

---

## Purpose

The ontology defines the **canonical set of tags** that may appear in any frontmatter or wikilink within the vault. Tags not on this list are flagged as semantic violations during the [[schema/agents|Auditor]] monthly scan.

---

## Top-Level Domains

| Domain | Description |
|--------|-------------|
| `meta` | Files about the vault itself (READMEs, schema, governance) |
| `identity` | Self-model and personal narrative |
| `principle` | Load-bearing behavioral rules |
| `project` | Active and archived projects |
| `knowledge` | Domain knowledge notes |
| `framework` | Mental models and thinking tools |
| `decision` | Past decisions and reasoning |
| `system` | SOPs, rituals, processes |
| `prompt` | AI prompts and interaction patterns |
| `research` | Time-bounded investigations |
| `idea` | Pre-project possibilities |
| `timeline` | Chronological entries |
| `relationship` | People and networks |
| `analysis` | Meta-analysis and system reflection |
| `hub` | Navigation hubs and MOCs |
| `moc` | Machine-layer Map of Content files |
| `synthesis` | Cross-domain insights |
| `journal` | Dated records |
| `machine-layer` | Files belonging to wiki, sources, schema |
| `human-layer` | Files belonging to the numbered Human Layer |

---

## Content Tags

| Tag | Description |
|-----|-------------|
| `concept` | A definable idea |
| `method` | A procedure |
| `decision` | A specific choice with context |
| `claim` | A testable assertion |
| `question` | An open question |
| `evidence` | A citation-backed fact |
| `example` | An illustrative case |
| `counter-example` | Evidence against a claim |
| `quote` | A citation from a source |
| `list` | An enumerated collection |
| `checklist` | A verification list |
| `template` | A reusable scaffold |
| `sop` | A standard operating procedure |
| `ritual` | A recurring practice |
| `meeting` | Meeting notes |
| `daily` | Daily note |
| `reading` | A reading or literature note |
| `reference` | A lookup note |
| `glossary` | A canonical definition |

---

## Status Tags

| Tag | Description |
|-----|-------------|
| `canonical` | Promoted to long-term storage |
| `draft` | Not yet promoted |
| `deprecated` | Superseded; preserved for history |
| `disputed` | Has unresolved contradictions |
| `speculative` | Low-confidence; flagged for review |
| `archived` | Moved out of active folders |
| `load-bearing` | High-confidence, foundational |

---

## Quality Tags

| Tag | Description |
|-----|-------------|
| `orphan` | No incoming links — flag for cartographer |
| `conflict` | Disagrees with another note |
| `drift` | Quality has degraded |
| `unsourced` | Lacks citation |
| `duplicate` | Redundant with another note |
| `stale` | Unchanged >12 months |

---

## Workflow Tags

| Tag | Description |
|-----|-------------|
| `inbox` | Awaiting triage |
| `in-progress` | Active work |
| `blocked` | Waiting on a dependency |
| `review` | Pending review or approval |
| `shipped` | Output delivered |
| `retracted` | Reversed or cancelled |

---

## Synthesis Tags

| Tag | Description |
|-----|-------------|
| `cross-domain` | Pattern across multiple fields |
| `emergent` | New pattern not yet named |
| `contradiction` | Logged inconsistency |
| `forward-hypothesis` | Predictive claim |

---

## Tag Application Rules

| Rule | Reason |
|------|--------|
| Tags are lowercase | Sort stability |
| Hyphens separate words | URL-safe and readable |
| Apply 3–7 tags per note | Discriminative power |
| Top-level domain always present | Routing |
| Status tag only when relevant | Reduce noise |

---

## Off-Ontology Procedure

When a new tag is needed:

1. Capture the proposed tag in [[00 Inbox|00 Inbox]] with context.
2. Promote to a proposal note in [[13 Meta Analysis|13 Meta Analysis]].
3. Schema Keeper reviews for placement (top-level, content, status, quality, workflow, synthesis).
4. Operator approves if the tag reshapes the taxonomy.
5. Add to this file.
6. Update affected nodes.

> [!warning] **Do not introduce synonyms.** Multiple tags for the same concept fragment the graph. Use the canonical tag.

---

## Examples of Bad Tagging

| Bad | Better | Reason |
|-----|--------|--------|
| `Idea` | `idea` | Capitalization inconsistent |
| `Ideas` | `idea` | Plural variant; use canonical singular |
| `my-thought` | `idea` or `concept` | Personalizing tag |
| `very-important` | `load-bearing` | Vague quantifier |
| `ai-related` | `prompt` or `machine-layer` | Domain overlap; choose the more specific |

---

## Related

- [[schema/CLAUDE|schema/CLAUDE.md]] — three-layer rule architecture
- [[schema/agents|schema/agents.md]] — agent permissions
- [[schema/terminology|schema/terminology.md]] — canonical glossary
- [[schema/copywriting-standards|schema/copywriting-standards.md]] — voice standards

---

*The ontology is the vocabulary. The vocabulary shapes what can be said.*