---
title: "07 Systems & SOPs"
summary: "Repeatable processes, rituals, and standard operating procedures. SOPs turn recurring work into muscle memory."
date: 2026-06-26
tags: [systems, sops, processes, rituals, human-layer]
---

# 07 Systems & SOPs

> If you do it twice, write it down. If you do it three times, systemize it.

---

## Purpose

This folder holds the operator's **repeatable processes** — standard operating procedures (SOPs), rituals, checklists, and recurring workflows. A SOP is a sequence of steps that produces a consistent output when followed by anyone, including the operator's future self.

| Folder | Holds |
|--------|-------|
| [[07 Systems & SOPs\|07 Systems & SOPs]] | Human-facing SOPs and rituals |
| [[workflows/\|workflows/]] | AI-callable procedural scripts |
| [[08 Prompt Library\|08 Prompt Library]] | AI prompts used inside SOPs |

---

## What Lives Here

| Note Type | Purpose |
|-----------|---------|
| SOP | A repeatable process with steps |
| Ritual | A daily / weekly / monthly practice |
| Checklist | A short verification list |
| Cadence | A schedule definition (e.g., "every Monday at 9am") |

---

## Core SOPs in This Vault

| SOP | Cadence | Time Budget |
|-----|---------|-------------|
| [[07 Systems & SOPs/daily-rhythm\|Daily Rhythm]] | Daily | 5 min |
| Weekly Review | Weekly | 30 min |
| Monthly Lint | Monthly | 60 min |
| Quarterly Reconciliation | Quarterly | 2 hours |
| Annual Audit | Annually | 1 day |

See [[workflows/maintenance-protocol\|maintenance-protocol.md]] for the full schedule.

---

## Anatomy of an SOP

Every SOP note contains:

1. **Purpose** — what this process produces
2. **Cadence** — how often it runs
3. **Preconditions** — what must be true before starting
4. **Steps** — numbered, atomic, no compound steps
5. **Time budget** — expected duration
6. **Outputs** — what the SOP produces
7. **Failure modes** — what goes wrong and how to recover

> [!tip] **A good SOP can be delegated.** If it cannot, it is not yet a system.

---

## When to Open

- When starting recurring work — find the existing SOP first
- When a process has drifted — capture the corrected version here
- When delegating or handing off a task
- When AI is being asked to do something repeatedly

---

## How to Use

1. **Search before creating.** Many SOPs already exist as workflows in [[workflows/\|workflows/]].
2. **Link the workflow.** Human SOPs may invoke [[workflows/\|workflow commands]] for AI execution.
3. **Time-box the SOP.** Every step has a budget.
4. **Capture failure modes.** An SOP without failure modes is wishful thinking.
5. **Revisit quarterly.** Outdated SOPs become noise.

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[workflows/\|workflows/]] | Workflows are AI-callable; SOPs are human-readable |
| [[03 Projects]] | Project execution may invoke SOPs |
| [[08 Prompt Library]] | AI-assisted SOPs embed prompts |
| [[13 Meta Analysis]] | SOP quality is analyzed quarterly |

---

*An SOP is the operator's promise to their future self.*