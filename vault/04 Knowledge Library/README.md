---
title: "04 Knowledge Library"
summary: "Domain knowledge, research, facts, and field references. The library is what the operator knows, organized for retrieval."
date: 2026-06-26
tags: [knowledge, library, research, references, human-layer]
---

# 04 Knowledge Library

> What the operator knows, organized for retrieval.

---

## Purpose

This folder holds the operator's **domain knowledge** — facts, references, distilled findings, and field-specific notes. It is the library of "things learned," distinct from [[05 Framework Library|05 Framework Library]] which holds "ways of thinking" and [[02 Principles|02 Principles]] which holds "rules of behavior."

| Layer | Folder | Contents |
|-------|--------|----------|
| **What is true** | [[04 Knowledge Library\|04 Knowledge Library]] | Domain knowledge, facts, references |
| **How to think** | [[05 Framework Library\|05 Framework Library]] | Mental models, frameworks |
| **How to act** | [[02 Principles\|02 Principles]] | Load-bearing behavioral rules |

---

## What Lives Here

| Note Type | Purpose | Format |
|-----------|---------|--------|
| Domain note | A field's distilled understanding | `domain-name.md` |
| Reference note | A specific concept, term, or fact | `concept-name.md` |
| Source distillation | Notes distilled from a [[templates/literature-note\|literature note]] | `distilled-source-name.md` |
| Glossary entry | A canonical definition (see [[schema/terminology\|schema/terminology.md]]) | `term-name.md` |

---

## Organization

Knowledge is grouped by **domain**, not by source. A single book may yield notes in multiple domains; multiple books may yield notes in one domain.

Example structure:
```
04 Knowledge Library/
├── cognitive-science/
│   ├── attention-and-focus.md
│   ├── memory-consolidation.md
│   └── decision-making-under-uncertainty.md
├── economics/
│   ├── supply-and-demand.md
│   └── information-asymmetry.md
└── systems/
    ├── feedback-loops.md
    └── emergence.md
```

---

## When to Open

- When learning a new domain (start a new subfolder)
- When needing a fact, reference, or definition
- When writing or researching — pull source citations from here
- When a [[templates/literature-note\|literature note]] graduates to permanent knowledge

---

## How to Use

1. **Capture raw in [[00 Inbox]]** when reading or researching.
2. **Distill into literature notes** using [[templates/literature-note\|literature-note.md]].
3. **Promote durable claims** into domain or reference notes here.
4. **Link forward to principles** when a domain insight becomes behavioral.
5. **Cite sources** with [[wikilinks]] to [[09 Research Archive\|09 Research Archive]] or [[sources/README\|sources]].

> [!tip] **A knowledge note answers a question, not a topic.** "How does X work?" beats "Notes on X."

---

## Editing Discipline

- Knowledge notes are **append-and-edit**. Older versions move to note footers with dates.
- Conflicting claims stay side-by-side; tag with `[CONFLICT]` and link to a synthesis note.
- Use [[schema/terminology\|schema/terminology.md]] to lock terminology before creating a concept note.

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[02 Principles]] | Knowledge supports principles; principles encode behavior |
| [[05 Framework Library]] | Knowledge is what; frameworks are how |
| [[09 Research Archive]] | Source material before distillation |
| [[sources/README\|sources]] | Immutable raw material before distillation |
| [[wiki/concepts/knowledge/knowledge-moc\|Knowledge MOC]] | The machine-layer structured index |

---

*The library is what you know. The frameworks are how you think. The principles are how you act.*