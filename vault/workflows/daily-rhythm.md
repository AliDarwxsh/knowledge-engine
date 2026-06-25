---
title: "Daily Rhythm — The Five-Minute Evening Pass"
summary: "The core daily ritual: clear the inbox in five minutes using the four-path decision tree. Plus weekly review and monthly lint."
date: 2026-06-26
tags: [workflow, daily, rhythm, evening-pass, weekly, monthly]
---

# Daily Rhythm — Evening Pass, Weekly Review, Monthly Lint

> The system survives because of the daily pass. The pass survives because it is five minutes.

---

## Purpose

This workflow defines the operator's three core recurring cadences:

1. **Daily:** The five-minute evening inbox pass.
2. **Weekly:** The thirty-minute weekly review.
3. **Monthly:** The sixty-minute monthly lint.

All three are time-boxed. Time-boxing is the discipline.

---

## Part 1 — Daily Evening Pass (5 minutes)

### Preconditions

- The vault is open in Obsidian.
- The operator has five uninterrupted minutes.
- The day's [[templates/daily-note|daily note]] is open in a tab.

### Steps

| Step | Duration | Action |
|------|----------|--------|
| 1 | 30s | Open [[00 Inbox\|00 Inbox]]; scan items in capture order |
| 2 | 4 min | For each item, apply [[workflows/inbox-triage\|inbox-triage]] four-path tree |
| 3 | 30s | Log "Evening pass cleared N items" in daily note; close |

### Time Budget Enforcement

If the pass exceeds 5 minutes:

1. Stop. Do not continue.
2. Park remaining items in [[00 Inbox\|00 Inbox]] for tomorrow.
3. Log "pass exceeded budget; parked N items" in daily note.
4. Run a 15-minute deep-triage block the next morning.

> [!warning] **Time-boxing is non-negotiable.** A daily pass that takes 30 minutes will be skipped. A daily pass that takes 5 minutes will be done.

---

## Part 2 — Weekly Review (30 minutes)

The weekly review runs once per week, ideally on the same day. Recommended: Sunday evening.

### Preconditions

- All daily passes for the week are complete.
- The week's daily notes are open for reference.

### Steps

| Step | Duration | Action |
|------|----------|--------|
| 1 | 5 min | Review [[00 Inbox\|00 Inbox]] backlog; clear anything missed |
| 2 | 5 min | Review [[03 Projects\|03 Projects]] status; update each project's `last_action` |
| 3 | 5 min | Review [[06 Decision Archive\|06 Decision Archive]]; append outcomes to decisions with new evidence |
| 4 | 5 min | Review [[10 Ideas & Opportunities\|10 Ideas]]; promote triggered ideas to projects, archive dormant |
| 5 | 5 min | Review [[11 Timeline\|11 Timeline]]; ensure major events from the week are dated |
| 6 | 5 min | Update [[08 Prompt Library\|08 Prompt Library]] with any new prompts that worked |

### Outputs

- Each active project has an updated `last_action` and `next_action`.
- Decisions from the week are archived with reasoning.
- Promoted ideas are committed or archived.
- Timeline is current.

---

## Part 3 — Monthly Lint (60 minutes)

The monthly lint runs once per month. Recommended: first Sunday of the month.

### Preconditions

- The week's daily and weekly passes have been running.
- The vault is in a stable state.

### Steps

| Step | Duration | Action |
|------|----------|--------|
| 1 | 10 min | Orphan scan — run the [[schema/agents\|Cartographer]] orphan check; add inbound links to flagged notes |
| 2 | 10 min | Contradiction scan — review flagged contradictions in [[13 Meta Analysis\|13 Meta Analysis]] |
| 3 | 10 min | Citation check — verify every wiki note cites a source or carries `[UNSOURCED]` |
| 4 | 10 min | Voice audit — sample 10 notes and run the [[schema/copywriting-standards\|copywriting]] audit |
| 5 | 10 min | Drift report — write a `drift-YYYY-MM.md` note in [[13 Meta Analysis\|13 Meta Analysis]] with any issues found |
| 6 | 10 min | Schema review — check whether new tags or terms need [[schema/ontology\|ontology]] or [[schema/terminology\|terminology]] updates |

### Outputs

- Orphans remediated.
- Contradictions resolved or escalated.
- Citations verified.
- Drift report filed.
- Schema updates proposed (if any).

---

## Cadence Mismatch Recovery

| Symptom | Recovery |
|---------|----------|
| Daily passes skipped >2 days this week | Re-commit the next day; do not double up |
| Weekly review missed | Run it the next day; do not skip the month |
| Monthly lint missed | Run it the next week; flag in [[13 Meta Analysis\|13 Meta Analysis]] |
| Vault accumulating >30 untriaged inbox items | Run a 30-minute deep-triage; reset to inbox zero |

---

## Inputs and Outputs

| Cadence | Input | Output |
|---------|-------|--------|
| Daily | Items in [[00 Inbox\|00 Inbox]] | Items distributed to canonical folders |
| Weekly | Week's activity | Updated projects, decisions, ideas, prompts |
| Monthly | Vault state | Drift report, schema updates, link remediation |

---

## Related

- [[workflows/inbox-triage\|inbox-triage.md]] — the four-path tree
- [[workflows/forward-references\|forward-references.md]] — gray-link handling
- [[workflows/maintenance-protocol\|maintenance-protocol.md]] — broader quarterly and annual cadence
- [[07 Systems & SOPs/daily-rhythm\|07 Systems & SOPs/daily-rhythm.md]] — Human-Layer companion
- [[schema/agents\|schema/agents.md]] — Cartographer and Auditor roles

---

*Five minutes a day. Thirty minutes a week. Sixty minutes a month. The vault stays alive.*