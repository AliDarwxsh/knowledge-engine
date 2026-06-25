---
title: "03 Projects"
summary: "Active work and its architecture. Every project flows through Inputs → Process → Outputs → Feedback."
date: 2026-06-26
tags: [projects, pipeline, execution, human-layer]
---

# 03 Projects

> A project is a closed loop: inputs in, process through, outputs out, feedback back.

---

## Purpose

This folder holds the operator's **active and archived projects** — each as a single canonical note tracking purpose, status, pipeline, and next action. A project is anything the operator is actively shipping, planning, or maintaining. If it consumes weekly attention, it belongs here.

The Human Layer holds individual project notes. The Machine Layer ([[wiki/entities/projects/project-moc|Project MOC]]) holds the structured cross-project index.

---

## The Inputs / Process / Outputs / Feedback Pipeline

Every project follows the same four-stage pipeline. This is the canonical structure for any [[templates/project-note|project note]].

```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌───────────┐
│ INPUTS  │───▶│ PROCESS │───▶│ OUTPUTS │───▶│ FEEDBACK  │
│         │    │         │    │         │    │           │
│ • Brief │    │ • Steps │    │ • Asset │    │ • Metric  │
│ • Spec  │    │ • Tools │    │ • Draft │    │ • Lesson  │
│ • Ask   │    │ • Cadence│   │ • Ship  │    │ • Pivot   │
└─────────┘    └─────────┘    └─────────┘    └─────┬─────┘
                                                    │
                                                    └──────▶ back to INPUTS
```

| Stage | Question It Answers | Examples |
|-------|---------------------|----------|
| **Inputs** | What does this project require to start? | Brief, audience, constraints, dependencies, prior work |
| **Process** | How does work flow from input to output? | Steps, cadence, tools, collaborators |
| **Outputs** | What does "done" look like? | Artifact, format, distribution, deadline |
| **Feedback** | How does the project learn from itself? | Metrics, qualitative review, pivot triggers |

> [!tip] **A project without a feedback loop is a task list.** Always close the loop.

---

## Project Status

Every project carries one of five statuses in its frontmatter:

| Status | Meaning |
|--------|---------|
| `planning` | Defined, not yet started |
| `active` | Receiving weekly attention |
| `paused` | Deliberately stopped; resumable |
| `shipping` | Outputs going out the door this week |
| `archived` | Closed; preserved for reference |

---

## When to Open

- During weekly review of active projects
- When a new project emerges (capture first in [[00 Inbox]], promote here)
- When deciding whether to start, continue, pause, or archive
- When pulling context for a project-specific conversation

---

## How to Use

1. **One canonical note per project.** Updates append in place.
2. **Always link to principles.** Every project cites the [[02 Principles|principles]] it embodies.
3. **Always link to inputs.** Sources, briefs, and dependencies live as wikilinks.
4. **Always declare next action.** A project note without a next action is dormant.
5. **Quarterly prune.** Move dormant projects to `archive/`.

---

## Project Note Anatomy

A complete [[templates/project-note|project note]] contains:

- **One-line pitch** — what this is and why it matters
- **Status** — one of the five above
- **Next concrete action** — the single thing to do next
- **Inputs** — what it depends on
- **Process** — how work flows
- **Outputs** — what "done" looks like
- **Feedback loop** — how the project learns
- **Linked principles** — which [[02 Principles|principles]] it embodies
- **Linked notes** — sources, decisions, related projects

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[00 Inbox]] | New projects originate here before promotion |
| [[02 Principles]] | Projects cite the principles they embody |
| [[06 Decision Archive]] | Major project decisions get archived with reasoning |
| [[07 Systems & SOPs]] | Recurring project patterns become SOPs |
| [[11 Timeline]] | Project milestones are logged as dated entries |
| [[wiki/entities/projects/project-moc\|Project MOC]] | The machine-layer structured index |

---

*Projects are loops, not lists. The feedback stage is what makes them alive.*