---
title: "13 Meta Analysis"
summary: "The vault analyzing itself. Notes about the system, by the system, for the operator."
date: 2026-06-26
tags: [meta, analysis, system, self-reflection, human-layer]
---

# 13 Meta Analysis

> The system that does not examine itself decays without noticing.

---

## Purpose

This folder holds **meta-analysis notes** — the operator's reflection on the vault itself, on workflows, on patterns of capture and decision, and on whether the system is serving its purpose. A meta-analysis note is about the vault, not about the operator's external work.

| Layer | Subject |
|-------|---------|
| [[13 Meta Analysis\|13 Meta Analysis]] | Reflection on the vault as a system |
| [[01 Identity\|01 Identity]] | Reflection on the operator as a person |
| [[schema/CLAUDE\|schema/CLAUDE.md]] | The rules governing the system |

---

## What Lives Here

| Note Type | Purpose | Filename |
|-----------|---------|----------|
| Vault audit | Periodic review of vault health | `audit-YYYY-MM.md` |
| Workflow review | Effectiveness of an SOP or workflow | `review-workflow-name.md` |
| Drift report | Where the system is degrading | `drift-topic.md` |
| Improvement proposal | A proposed change to the system | `proposal-change-name.md` |

---

## Anatomy of a Meta Note

A meta-analysis note answers four questions:

1. **What is being analyzed?** — the system, workflow, or pattern
2. **What is the observed state?** — measured or described
3. **What is the gap?** — between observed and ideal
4. **What is the proposed change?** — actionable proposal

> [!tip] **Meta notes propose, [[schema/CLAUDE\|schema]] decides.** Improvements go through [[schema/agents\|Schema Keeper]] review before activation.

---

## When to Open

- During the monthly meta review
- When a workflow feels broken or slow
- When the vault's quality drifts (duplicates, orphans, contradictions)
- During the annual full audit
- When proposing any change to [[schema/CLAUDE\|schema]], workflows, or folder structure

---

## How to Use

1. **Capture drift early.** A meta note the day something feels off beats a quarterly audit.
2. **Propose changes with evidence.** "The inbox passes take 12 minutes instead of 5" is evidence; "the inbox is slow" is not.
3. **Route improvements to schema.** Approved changes get codified in [[schema/CLAUDE\|schema/CLAUDE.md]] or [[workflows/\|workflows/]].
4. **Tag with severity.** `low | medium | high` indicates urgency.
5. **Close loops.** Every proposal has an `accepted | rejected | deferred` status.

---

## Meta Review Cadence

| Cadence | Focus |
|---------|-------|
| Weekly | One-question reflection: "What is the vault doing well this week?" |
| Monthly | Workflow effectiveness review |
| Quarterly | Drift report and improvement proposals |
| Annually | Full audit and structural review |

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[schema/CLAUDE\|schema/CLAUDE.md]] | Approved improvements update schema |
| [[workflows/\|workflows/]] | Approved improvements update workflows |
| [[07 Systems & SOPs\|07 Systems & SOPs]] | SOPs are themselves subjects of meta analysis |
| [[06 Decision Archive\|06 Decision Archive]] | System-level decisions get archived here |

---

*The vault is a tool. Tools are improved or they rust.*