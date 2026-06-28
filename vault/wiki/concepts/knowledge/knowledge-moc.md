---
title: "Knowledge MOC — Map of Content for Domain Knowledge"
summary: "Machine-queryable map of every domain knowledge note in the vault. Indexed by field, subfield, and citation count."
date: 2026-06-26
tags: [moc, knowledge, domains, machine-layer]
ai_context: "Hermes uses this MOC to retrieve domain knowledge for synthesis, citation, or research. Use when answering factual questions, building research summaries, or identifying knowledge gaps."
---

# Knowledge MOC

> The library is what the operator knows.

---

## Cluster Overview

| Property | Value |
|----------|-------|
| Cluster | `wiki/concepts/knowledge/` |
| Mirror | [[04 Knowledge Library\|04 Knowledge Library]] (Human Layer) |
| Owner | Operator-writable; AI-readable |

---

## Domain Taxonomy

| Top-Level Domain | Subfields | Note Count |
|------------------|-----------|------------|
| _populate after onboarding_ | _ | _ |

The taxonomy is canonical — see [[schema/ontology|schema/ontology.md]] for the full tag tree.

---

## Knowledge Edge Schema

```yaml
knowledge_node:
  id: knowledge-<domain>-<slug>
  domain: <top-level>
  subfield: <subfield>
  type: domain | reference | source-distillation | glossary
  stated: YYYY-MM-DD
  last_revised: YYYY-MM-DD
  citations: <int>     # number of outbound source links
  referenced_by: <int> # number of inbound links
  status: canonical | draft | disputed
  cross_links:
    principles: ["[[02 Principles/principle-name]]"]
    frameworks: ["[[05 Framework Library/framework-name]]"]
    projects: ["[[03 Projects/project-name]]"]
  sources:
    - "[[sources/...]]"
```

---

## Knowledge Index

| Note | Domain | Citations | Referenced By |
|------|--------|-----------|---------------|
| _populate after first knowledge note_ | — | — | — |

---

## Source Linkage Rule

Every knowledge node MUST cite at least one source:

| Source Type | Path |
|-------------|------|
| Distilled from a literature note | `[[templates/literature-note|literature-note]]` |
| Distilled from a research report | `[[09 Research Archive/report-name]]` |
| Distilled from raw material | `[[sources/README\|sources]]` |

> [!warning] **A knowledge note without a source is an opinion.** Cite or mark `[UNSOURCED]`.

---

## Knowledge ↔ Principles

When a knowledge note yields a behavioral rule, the rule graduates to [[02 Principles|02 Principles]] and links back to the knowledge note.

## Knowledge ↔ Frameworks

When a domain reveals a recurring pattern, the pattern graduates to [[05 Framework Library|05 Framework Library]].

## Knowledge ↔ Projects

Projects cite knowledge notes when they depend on domain facts.

---

## Promotion Criteria

A note graduates to a **knowledge note** when:

1. It answers a question, not a topic.
2. It cites at least one source.
3. It uses canonical terminology from [[schema/terminology|schema/terminology.md]].
4. It has been cross-checked against at least one other source.

A knowledge note is **deprecated** when:

1. New evidence contradicts it.
2. A higher-quality source supersedes it.
3. The operator no longer relies on it for decisions.

Deprecated knowledge notes move to `archive/knowledge/` with the date and reason.

---

## Retrieval Patterns

| Query | Start At |
|-------|----------|
| "What do I know about X?" | Domain taxonomy → subfield → notes |
| "Where did I learn X?" | Reverse lookup via `sources` field |
| "What's the strongest note on X?" | Sort by `referenced_by` |
| "Where is my knowledge thin?" | Domains with low note counts or low `referenced_by` |

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| Citation check | Monthly | [[schema/agents\|Auditor]] |
| Domain audit | Quarterly | Operator |
| Deprecation scan | Annually | [[schema/agents\|Auditor]] |

---

## Related

- [[wiki/__graph_index__\|Graph Index]]
- [[04 Knowledge Library\|04 Knowledge Library]] (Human Layer)
- [[schema/ontology\|schema/ontology.md]] — domain taxonomy
- [[schema/terminology\|schema/terminology.md]] — canonical terminology
- [[sources/README\|sources/README.md]] — raw material

---

*What you know is leverage. What you cite is credibility.*