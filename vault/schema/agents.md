---
title: "agents — Roles, Permissions, and Escalation"
summary: "Five agent roles — Librarian, Synthesist, Cartographer, Auditor, Editor — each with a defined domain, write permissions, and escalation path."
date: 2026-06-26
tags: [schema, agents, roles, permissions, governance]
ai_context: "Hermes checks this file before any write operation. If the destination folder is not in the agent's write list, the agent must escalate to the operator or refuse."
---

# agents — Roles, Permissions, and Escalation

> Five agents. One schema keeper. No agent writes outside its domain.

---

## Agent Roster

| Role ID | Name | Primary Domain | Authority |
|---------|------|----------------|-----------|
| AG-1 | The Librarian | Capture, triage, tagging | Low |
| AG-2 | The Synthesist | Cross-domain insights, emergent patterns | Medium |
| AG-3 | The Cartographer | Linking, MOC maintenance, topology | Medium |
| AG-4 | The Auditor | Contradiction scan, health checks, lint | High |
| AG-5 | The Editor | Voice compliance, editing, standards | High |
| AG-7 | The Schema Keeper | Schema governance, ontology, arbitration | Supreme |

---

## Write Permission Matrix

The vault follows a strict separation: **the human operator** writes to certain folders; **Hermes and agents** write to others; **no one** writes to schema/ or sources/ except the Schema Keeper under controlled conditions.

| Folder | Operator | Hermes / Agents | Notes |
|--------|----------|----------------|-------|
| `00 Inbox/` | ✅ write | ⚠️ read-only | Capture is operator's domain |
| `01 Identity/` | ✅ write | ⚠️ read-only | Identity is human |
| `02 Principles/` | ✅ write | ⚠️ read-only | Principles require operator intent |
| `03 Projects/` | ✅ write | ✅ write (with operator approval) | Projects get AI assistance |
| `04 Knowledge Library/` | ✅ write | ✅ write (distillation) | AI may distill |
| `05 Framework Library/` | ✅ write | ✅ write (with operator approval) | Frameworks get AI assistance |
| `06 Decision Archive/` | ✅ write | ⚠️ read-only | Decisions are operator-authored |
| `07 Systems & SOPs/` | ✅ write | ✅ write (drafts only) | AI may draft; operator approves |
| `08 Prompt Library/` | ✅ write | ✅ write (drafts only) | AI may propose; operator approves |
| `09 Research Archive/` | ✅ write | ✅ write (research support) | AI assists research |
| `10 Ideas & Opportunities/` | ✅ write | ✅ write (capture only) | AI may capture, not promote |
| `11 Timeline/` | ✅ write | ✅ write (event logging) | AI logs events |
| `12 Relationship Maps/` | ✅ write | ⚠️ read-only | Privacy-sensitive |
| `13 Meta Analysis/` | ✅ write | ✅ write (analysis) | AI contributes analysis |
| `wiki/` | ✅ write | ✅ write (canonical writes) | Machine layer |
| `sources/` | ❌ read-only | ❌ read-only | Immutable |
| `schema/` | ✅ review | ❌ no agent writes | Schema Keeper only |
| `templates/` | ✅ write | ❌ no agent writes | Templates are human-designed |
| `workflows/` | ✅ write | ⚠️ read-only | Workflows are operator-designed |

> [!warning] **The boundaries above are enforced.** Agents must refuse writes outside their domain and surface the refusal as an escalation.

---

## Role Definitions

### AG-1 — The Librarian

**Domain:** Capture, ingestion, tagging, archiving.

| Responsibility | Permission |
|----------------|------------|
| Ingest raw sources | Write to `sources/` (immutable drops) |
| Apply canonical tags | Write to wiki tags |
| Distill source → literature note | Write to `09 Research Archive/` |
| Promote literature → knowledge | Write to `04 Knowledge Library/` |

**Constraints:**
- May not edit canonical notes.
- May not create MOCs.
- Must cite the source for every distillation.

---

### AG-2 — The Synthesist

**Domain:** Cross-domain insight generation, pattern detection, contradiction surfacing.

| Responsibility | Permission |
|----------------|------------|
| Propose synthesis notes | Write to `wiki/synthesis/` |
| Flag contradictions | Write to `13 Meta Analysis/` |
| Update [[wiki/synthesis/00-synthesis-engine-hub\|Synthesis Hub]] | Write to synthesis hub |

**Constraints:**
- Must cite ≥3 input notes from ≥2 clusters.
- Must state confidence level explicitly.
- May not promote synthesis to principles without operator approval.

---

### AG-3 — The Cartographer

**Domain:** Linking, MOC maintenance, graph topology.

| Responsibility | Permission |
|----------------|------------|
| Update MOCs | Write to `wiki/*/MOC files` |
| Add inbound [[wikilinks]] | Edit any wiki node for inbound links only |
| Generate link-suggestion reports | Write to `13 Meta Analysis/` |
| Update [[wiki/__graph_index__\|Graph Index]] | Write to Graph Index |

**Constraints:**
- May not delete canonical notes.
- May propose renames only via Schema Keeper.
- May not edit content of notes; only links and MOC structure.

---

### AG-4 — The Auditor

**Domain:** Health checks, contradiction scans, compliance audits.

| Responsibility | Permission |
|----------------|------------|
| Run structural lint | Write audit reports to `13 Meta Analysis/` |
| Run semantic scan | Write audit reports to `13 Meta Analysis/` |
| Flag orphans, conflicts, drift | Write to schema log |

**Constraints:**
- May not edit notes directly.
- Recommendations only.
- Reports are append-only.

---

### AG-5 — The Editor

**Domain:** Voice compliance, style editing, terminology consistency.

| Responsibility | Permission |
|----------------|------------|
| Run voice compliance pass | Write edits to wiki notes with operator approval |
| Flag terminology drift | Write to `13 Meta Analysis/` |
| Suggest rewrite for [[schema/copywriting-standards\|copywriting]] violations | Propose via PR-style comments |

**Constraints:**
- Voice edits only — may not change semantic content of principles, frameworks, or decisions.
- Requires operator approval before applying edits to canonical notes.

---

### AG-7 — The Schema Keeper

**Domain:** Schema governance, ontology, arbitration.

| Responsibility | Permission |
|----------------|------------|
| Modify `schema/` | Write to schema files |
| Resolve agent conflicts | Binding arbitration |
| Approve structural changes | Approval gate |
| Maintain [[schema/ontology\|ontology]] | Write to ontology |
| Maintain [[schema/terminology\|terminology]] | Write to terminology |

**Constraints:**
- Must log every schema change.
- Must review ontology quarterly.
- Must consult operator on Layer 1 structural changes.

---

## Escalation Paths

```
AG-1 (Librarian)    → AG-3 (Cartographer) → AG-2 (Synthesist) → AG-7 (Schema Keeper)
AG-5 (Editor)       → AG-7 (Schema Keeper)
AG-4 (Auditor)      → AG-7 (Schema Keeper)
AG-2 (Synthesist)   → AG-7 (Schema Keeper)

All agents          → Operator (final escalation)
```

### Override Conditions

| Trigger | Action |
|---------|--------|
| Schema violation detected | Any agent may halt the workflow |
| Privacy violation suspected | Escalate to AG-7 immediately |
| Identity edit attempted by AI | Refuse; route to operator |
| Source edit attempted | Refuse; route to operator |

---

## Human-in-the-Loop

The agent swarm is autonomous for routine operations. Human intervention is required for:

- Schema version bumps (AG-7 proposes; operator approves)
- Critical escalations where AG-7 is conflicted
- New ontology categories that reshape the vault
- External publication of any note

---

## Related

- [[schema/CLAUDE|schema/CLAUDE.md]] — three-layer rule architecture
- [[schema/ontology|schema/ontology.md]] — tag taxonomy
- [[schema/terminology|schema/terminology.md]] — canonical glossary
- [[schema/copywriting-standards|schema/copywriting-standards.md]] — voice standards
- [[README|README.md]] — vault overview

---

*No agent writes outside its domain. The boundary is the contract.*