---
title: "Maintenance Protocol — Weekly / Monthly / Quarterly / Annual"
summary: "The complete maintenance schedule for the vault. Each cadence has a defined time budget, a defined scope, and a defined owner."
date: 2026-06-26
tags: [workflow, maintenance, schedule, governance]
---

# Maintenance Protocol — Weekly / Monthly / Quarterly / Annual

> The vault decays without maintenance. Maintenance is a discipline, not an event.

---

## Purpose

This workflow defines the complete maintenance schedule for the vault. It expands [[workflows/daily-rhythm|daily-rhythm.md]] to cover the weekly, monthly, quarterly, and annual cadences. Every cadence has:

- A defined scope
- A defined time budget
- A defined owner
- A defined output

---

## Cadence Overview

| Cadence | Time Budget | Scope | Owner |
|---------|-------------|-------|-------|
| Daily | 5 minutes | [[00 Inbox\|00 Inbox]] triage | Operator |
| Weekly | 30 minutes | Project / decision / idea review | Operator |
| Monthly | 60 minutes | Lint, contradiction scan, drift report | Operator + [[schema/agents\|Auditor]] |
| Quarterly | 2 hours | Cluster reconciliation, synthesis pass | Operator + [[schema/agents\|Synthesist]] |
| Annual | 1 day | Full audit, structural review | Operator |

---

## Daily — 5 Minutes

**See:** [[workflows/daily-rhythm|daily-rhythm.md]]

**Output:** Zero inbox; one-line daily note entry.

---

## Weekly — 30 Minutes

**See:** [[workflows/daily-rhythm|daily-rhythm.md#part-2-weekly-review-30-minutes|Weekly Review section]]

**Output:** Updated projects, archived decisions, promoted or archived ideas, new prompts catalogued.

---

## Monthly — 60 Minutes

**See:** [[workflows/daily-rhythm|daily-rhythm.md#part-3-monthly-lint-60-minutes|Monthly Lint section]]

**Output:** Drift report in [[13 Meta Analysis|13 Meta Analysis]], orphan and contradiction resolutions, schema proposal queue.

### Owner Tasks

| Task | Owner | Output |
|------|-------|--------|
| Orphan scan | [[schema/agents\|Cartographer]] | Inbound links added to flagged notes |
| Contradiction scan | [[schema/agents\|Auditor]] | Contradictions resolved or escalated |
| Citation check | [[schema/agents\|Auditor]] | Source links added; `[UNSOURCED]` tags added where appropriate |
| Voice audit (sample) | [[schema/agents\|Editor]] | Voice report in [[13 Meta Analysis\|13 Meta Analysis]] |
| Drift report | Operator | `drift-YYYY-MM.md` filed |
| Schema review | [[schema/agents\|Schema Keeper]] | Schema change proposals (if any) |

---

## Quarterly — 2 Hours

The quarterly cadence runs a **deep reconciliation** of the vault. It is heavier than monthly because it examines cross-cluster relationships and forces analogical transfer between distant domains.

### Preconditions

- The monthly lint has been running.
- The vault is stable.

### Steps

| Step | Duration | Action |
|------|----------|--------|
| 1 | 20 min | Cluster reconciliation — re-validate the [[wiki/__graph_index__\|Graph Index]]; add missing hubs |
| 2 | 20 min | Synthesis pass — force analogical transfer between two distant clusters |
| 3 | 20 min | Principle promotion review — promote ideas that have reached ≥3 decisions |
| 4 | 20 min | Decision outcome pass — append outcomes to all decisions missing them |
| 5 | 20 min | Relationship network check — update [[12 Relationship Maps\|12 Relationship Maps]] cadence statuses |
| 6 | 20 min | Forward-reference resolution — close all gray links >30 days old |

### Outputs

- Updated [[wiki/__graph_index__|Graph Index]]
- One new [[wiki/synthesis/|synthesis note]] from the analogical transfer
- Promoted or archived principles
- Updated decision archive
- Forward-reference backlog cleared

### Owner

| Task | Owner |
|------|-------|
| Cluster reconciliation | [[schema/agents\|Cartographer]] |
| Synthesis pass | [[schema/agents\|Synthesist]] |
| Principle review | Operator |
| Outcome capture | Operator |
| Relationship check | Operator |
| Forward-reference resolution | Operator + [[schema/agents\|Cartographer]] |

---

## Annual — 1 Day

The annual cadence is the **structural audit**. It reviews the vault's overall health, the schema's continued fitness, and the operator's evolving relationship to the system.

### Preconditions

- Quarterly cadences for the year have been running.
- The operator has a quiet day to commit.

### Steps

| Step | Duration | Action |
|------|----------|--------|
| 1 | 1 hour | Full audit — review every folder; flag drift, redundancy, obsolescence |
| 2 | 1 hour | Schema fitness — does [[schema/CLAUDE\|schema/CLAUDE.md]] still describe the system? |
| 3 | 1 hour | Principle prune — deprecate principles unused for 12+ months |
| 4 | 1 hour | Identity review — does [[01 Identity\|01 Identity]] reflect the current operator? |
| 5 | 1 hour | Synthesis year-in-review — write an annual synthesis note |
| 6 | 1 hour | Next-year setup — propose structural changes for the upcoming year |

### Outputs

- Annual audit report in [[13 Meta Analysis|13 Meta Analysis]]
- Schema updates proposed
- Principles deprecated or revised
- Identity claims updated
- Annual synthesis note filed
- Annual plan with structural proposals

### Owner

The annual audit is operator-led, with each agent providing their domain report:

| Agent | Report |
|-------|--------|
| [[schema/agents\|Librarian]] | Source ingestion stats, distillation throughput |
| [[schema/agents\|Cartographer]] | Graph health, top orphans, top dead-end nodes |
| [[schema/agents\|Synthesist]] | Major cross-domain patterns discovered |
| [[schema/agents\|Auditor]] | Drift and conflict summary for the year |
| [[schema/agents\|Editor]] | Voice compliance trend |
| [[schema/agents\|Schema Keeper]] | Schema change history and pending proposals |

---

## Failure Recovery

| Symptom | Recovery |
|---------|----------|
| Cadence skipped | Resume at the next opportunity; do not double up |
| Cadence takes >2x budget | Stop; log what was missed; re-schedule |
| Multiple cadences missed | Declare a "recovery week"; reduce scope; catch up gradually |
| Cadence consistently skipped | Reduce cadence frequency or merge with another |

---

## Inputs and Outputs

| Cadence | Output Location |
|---------|-----------------|
| Daily | [[11 Timeline\|11 Timeline]] entry |
| Weekly | Updates to projects, decisions, ideas |
| Monthly | [[13 Meta Analysis\|13 Meta Analysis]] drift report |
| Quarterly | Updated [[wiki/__graph_index__\|Graph Index]], new synthesis notes |
| Annual | Annual audit report and synthesis note |

---

## Related

- [[workflows/daily-rhythm\|daily-rhythm.md]] — daily / weekly / monthly details
- [[workflows/inbox-triage\|inbox-triage.md]] — daily triage logic
- [[workflows/forward-references\|forward-references.md]] — forward-reference resolution
- [[schema/CLAUDE\|schema/CLAUDE.md]] — three-layer governance
- [[schema/agents\|schema/agents.md]] — agent roles for each cadence

---

*Maintenance is the price of a live vault. Pay it daily, weekly, monthly, quarterly, annually.*