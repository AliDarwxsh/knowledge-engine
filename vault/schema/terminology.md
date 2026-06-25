---
title: "terminology — Canonical Glossary"
summary: "One term, one definition, used everywhere. The glossary is the authoritative source for vault vocabulary."
date: 2026-06-26
tags: [schema, terminology, glossary, definitions, governance]
ai_context: "Hermes checks this file before introducing a new term. Every glossary entry below must be used consistently across the vault. Synonyms are flagged as terminology drift."
---

# terminology — Canonical Glossary

> One term, one meaning. Use the canonical word, or define a new one.

---

## Purpose

The glossary is the **authoritative source of definitions** for terms used throughout the vault. When a note introduces a term that appears here, it must use the canonical definition. When a note needs a term that does not appear here, the term is proposed for addition.

> [!warning] **Synonyms are not neutral.** They fragment the graph and confuse retrieval. Use the canonical term or propose a new one.

---

## How to Add an Entry

1. Capture the term and proposed definition in [[00 Inbox|00 Inbox]].
2. Promote to [[13 Meta Analysis|13 Meta Analysis]] as a proposal note.
3. Schema Keeper reviews for placement and overlap with existing terms.
4. Operator approves if the term is load-bearing.
5. Add to this file.
6. Update affected notes.

---

## Glossary Entries

Entries are alphabetized by canonical term. Each entry includes the term, part of speech, definition, source, and related terms.

### Operator
**Part of speech:** noun
**Definition:** The single human who owns and operates this vault.
**Source:** [[CLAUDE|CLAUDE.md]]
**Related:** [[01 Identity|Identity]], [[schema/agents|Agents]]
**Notes:** "Operator" replaces older variants like "user," "owner," "principal." Use "operator" consistently.

### Vault
**Part of speech:** noun
**Definition:** The complete Obsidian directory governed by this schema.
**Source:** [[README|README.md]]
**Related:** [[Knowledge Archive Home|Knowledge Archive Home]]
**Notes:** "Vault" refers to the entire directory, not to a single folder.

### Human Layer
**Part of speech:** noun phrase
**Definition:** The numbered folders `00 Inbox` through `13 Meta Analysis` used by the operator for daily workflow.
**Source:** [[README|README.md]]
**Related:** [[Machine Layer]]
**Notes:** "Human Layer" is capitalized when used as a proper noun for this layer of the system.

### Machine Layer
**Part of speech:** noun phrase
**Definition:** The directories `wiki/`, `sources/`, and `schema/` maintained primarily by AI agents.
**Source:** [[README|README.md]]
**Related:** [[Human Layer]]
**Notes:** The Machine Layer is still human-readable and human-editable, but its primary maintainer is the agent swarm.

### Capture
**Part of speech:** verb / noun
**Definition:** The act of placing new material into [[00 Inbox|00 Inbox]] without structuring or categorizing.
**Source:** [[workflows/inbox-triage|inbox-triage.md]]
**Related:** [[Triage]]
**Notes:** "Capture" implies zero friction. If you are pausing to file, you are not capturing.

### Triage
**Part of speech:** verb / noun
**Definition:** The decision process that assigns each inbox item to one of four paths: DO, KEEP, FILE, DELETE.
**Source:** [[workflows/inbox-triage|inbox-triage.md]]
**Related:** [[Capture]]
**Notes:** "Triage" is a verb that runs during the [[workflows/daily-rhythm|evening pass]].

### Project
**Part of speech:** noun
**Definition:** A closed-loop pipeline of Inputs → Process → Outputs → Feedback that produces durable value.
**Source:** [[03 Projects|03 Projects]]
**Related:** [[Task]], [[Idea]]
**Notes:** A project without a feedback loop is a task list.

### Principle
**Part of speech:** noun
**Definition:** A load-bearing behavioral rule that has survived contact with reality in at least three unrelated decisions.
**Source:** [[02 Principles|02 Principles]]
**Related:** [[Framework]], [[Heuristic]]
**Notes:** A principle is not a wish, platitude, or single observation.

### Framework
**Part of speech:** noun
**Definition:** A named, attributable mental model with a defined domain of applicability.
**Source:** [[05 Framework Library|05 Framework Library]]
**Related:** [[Principle]], [[Heuristic]]
**Notes:** A framework is a lens; pick the right one before analyzing.

### Decision
**Part of speech:** noun
**Definition:** A specific choice, made at a known time, with stated alternatives, applied principles, and a stated prediction.
**Source:** [[06 Decision Archive|06 Decision Archive]]
**Related:** [[Reversibility]]
**Notes:** A decision is not a memory of an outcome; it is the reasoning trail captured at the moment of choice.

### Reversibility
**Part of speech:** noun
**Definition:** The cost of undoing a decision, on a scale of `reversible | costly-reversible | irreversible`.
**Source:** [[wiki/journal/decisions/decision-archive-moc|Decision Archive MOC]]
**Related:** [[Decision]]
**Notes:** Reversibility drives decision weight. Reversible decisions can be made on less evidence.

### Synthesis
**Part of speech:** noun
**Definition:** A note that produces a claim not contained in any single source note, by combining at least three notes from at least two clusters.
**Source:** [[wiki/synthesis/00-synthesis-engine-hub|Synthesis Hub]]
**Related:** [[Pattern]], [[Contradiction]]
**Notes:** Synthesis is not summary.

### Contradiction
**Part of speech:** noun
**Definition:** A pair of nodes whose claims cannot both be true under the same conditions.
**Source:** [[wiki/synthesis/00-synthesis-engine-hub|Synthesis Hub]]
**Related:** [[Synthesis]]
**Notes:** Contradictions are surfaced by the [[schema/agents|Auditor]] monthly.

### Pattern
**Part of speech:** noun
**Definition:** A recurrence observed across at least three unrelated contexts.
**Source:** [[wiki/concepts/principles/principles-moc|Principles MOC]]
**Related:** [[Synthesis]]
**Notes:** A pattern that has been applied in three or more decisions becomes a candidate principle.

### Hermeneutic Debt
**Part of speech:** noun
**Definition:** The accumulated cost of unread, untriaged, or uninterpreted material in the vault.
**Source:** [[13 Meta Analysis|Meta Analysis]]
**Related:** [[Inbox Backlog]]
**Notes:** Hermeneutic debt compounds quietly and surfaces as decision paralysis.

### Daily Note
**Part of speech:** noun
**Definition:** A dated note following [[templates/daily-note|the daily template]], with one EOD reflection.
**Source:** [[templates/daily-note|daily-note.md]]
**Related:** [[Daily Rhythm]]
**Notes:** Daily notes are append-only.

### Source
**Part of speech:** noun
**Definition:** A raw, immutable artifact in `sources/` that has not been edited since capture.
**Source:** [[sources/README|sources/README.md]]
**Related:** [[Distillation]]
**Notes:** Sources are never edited; corrections happen in derivative notes.

### Distillation
**Part of speech:** noun
**Definition:** The process of converting raw source material into structured notes (literature, knowledge, principle).
**Source:** [[09 Research Archive|09 Research Archive]]
**Related:** [[Source]]
**Notes:** Distillation always cites its source.

### Forward Reference
**Part of speech:** noun
**Definition:** A [[wikilinks|wikilink]] to a note that does not yet exist, used to mark intent.
**Source:** [[workflows/forward-references|forward-references.md]]
**Related:** [[Wikilink]]
**Notes:** Forward references are gray links; they are encouraged but must resolve within 30 days.

### Wikilink
**Part of speech:** noun
**Definition:** An Obsidian-style internal link of the form `[[path/to/file|Display Text]]`.
**Source:** [[schema/CLAUDE|schema/CLAUDE.md]]
**Related:** [[Forward Reference]]
**Notes:** Display text must be descriptive and scannable.

### MOC
**Part of speech:** noun (acronym)
**Definition:** Map of Content — a structured, machine-queryable index file in `wiki/`.
**Source:** [[wiki/__graph_index__|Graph Index]]
**Related:** [[Cluster]]
**Notes:** Plural: MOCs.

### Cluster
**Part of speech:** noun
**Definition:** A group of related wiki nodes under a common directory (`entities/`, `concepts/`, `synthesis/`, `journal/`).
**Source:** [[wiki/__graph_index__|Graph Index]]
**Related:** [[MOC]]
**Notes:** Every cluster has a MOC as its entry point.

### Schema Keeper
**Part of speech:** noun (role)
**Definition:** The agent with supreme authority over `schema/`, ontology, terminology, and arbitration.
**Source:** [[schema/agents|schema/agents.md]]
**Related:** [[Auditor]], [[Editor]]
**Notes:** The Schema Keeper is the only role authorized to edit `schema/`.

### Orphan
**Part of speech:** noun
**Definition:** A note with no incoming [[wikilinks]].
**Source:** [[schema/CLAUDE|schema/CLAUDE.md]]
**Related:** [[Wikilink]]
**Notes:** Orphans are flagged in monthly audits and remediated by adding inbound links.

---

## Maintenance

| Action | Frequency | Owner |
|--------|-----------|-------|
| New term review | Per proposal | [[schema/agents\|Schema Keeper]] |
| Synonym scan | Quarterly | [[schema/agents\|Auditor]] |
| Definition refresh | Annually | Operator |

---

## Related

- [[schema/CLAUDE|schema/CLAUDE.md]] — three-layer rule architecture
- [[schema/agents|schema/agents.md]] — agent roles
- [[schema/ontology|schema/ontology.md]] — tag taxonomy
- [[schema/copywriting-standards|schema/copywriting-standards.md]] — voice standards

---

*One term. One definition. One vault.*