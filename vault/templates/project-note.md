---
title: "Project Note Template"
summary: "A reusable scaffold for project notes in 03 Projects. Every project flows through Inputs → Process → Outputs → Feedback."
date: 2026-06-26
tags: [template, project, pipeline, execution]
---

# Project Note Template

> A project is a loop, not a list. Close the loop with feedback.

---

## Filename Convention

`project-name.md` — placed in `03 Projects/`.

---

## Frontmatter

```yaml
---
title: "<Project Name>"
summary: "<One-line pitch: what this is and why it matters>"
date: YYYY-MM-DD
tags: [project, <domain>, execution]
status: planning | active | paused | shipping | archived
started: YYYY-MM-DD
last_action: YYYY-MM-DD
next_action: "<verb> <object>"
deadline: YYYY-MM-DD
health: green | yellow | red
---
```

| Field | Required | Purpose |
|-------|----------|---------|
| `title` | Yes | Project name |
| `summary` | Yes | One-line pitch |
| `status` | Yes | Lifecycle stage |
| `next_action` | Yes | Single next concrete action |
| `last_action` | Yes | Date of most recent action |
| `deadline` | Recommended | Target completion date |
| `health` | Yes | Current health |

---

## Template Body

```markdown
# <Project Name>

> <One-line pitch.>

## Status

- **Lifecycle:** <status>
- **Health:** <green | yellow | red>
- **Started:** <YYYY-MM-DD>
- **Last action:** <YYYY-MM-DD>
- **Next action:** <verb + object>
- **Deadline:** <YYYY-MM-DD>

## Inputs

What does this project require to start?

- **Brief / spec:** <link>
- **Audience:** <who>
- **Constraints:** <what limits us>
- **Dependencies:** <what we wait on>
- **Prior work:** [[link to relevant prior notes]]

## Process

How does work flow from input to output?

1. <step 1>
2. <step 2>
3. <step 3>
4. <step 4>
5. <step 5>

**Cadence:** <daily | weekly | sprint>
**Tools:** <list>
**Collaborators:** [[12 Relationship Maps/person-name]]

## Outputs

What does "done" look like?

- **Artifact:** <what we ship>
- **Format:** <format>
- **Distribution:** <how it reaches the audience>
- **Deadline:** <YYYY-MM-DD>

## Feedback

How does the project learn from itself?

- **Metric:** <what we measure>
- **Qualitative review:** <how we collect feedback>
- **Pivot trigger:** <condition that causes a redesign>
- **Last feedback captured:** <YYYY-MM-DD>

## Linked Principles

This project embodies:

- [[02 Principles/principle-name-1]]
- [[02 Principles/principle-name-2]]

## Linked Frameworks

This project applies:

- [[05 Framework Library/framework-name-1]]
- [[05 Framework Library/framework-name-2]]

## Linked Notes

- [[03 Projects/related-project]]
- [[06 Decision Archive/key-decision]]
- [[12 Relationship Maps/key-collaborator]]
- [[09 Research Archive/research-report]]

## Risks and Open Questions

- <risk 1>
- <open question 1>

## Changelog

- <YYYY-MM-DD> — project created.
- <YYYY-MM-DD> — <change>.
```

---

## Pipeline Discipline

Every project note MUST have all four pipeline stages populated. A project missing one stage is a task list, not a project.

| Stage | Question |
|-------|----------|
| Inputs | What does this require? |
| Process | How does work flow? |
| Outputs | What is "done"? |
| Feedback | How does it learn? |

---

## Status Discipline

A project's `status` field is updated weekly:

| Transition | When |
|------------|------|
| `planning` → `active` | When the first action is taken |
| `active` → `shipping` | When an output is going out the door this week |
| `active` → `paused` | When deliberately stopped |
| `paused` → `active` | When resumed |
| any → `archived` | When closed |

A dormant project (no `last_action` in 30+ days) is moved to `archive/projects/` during the [[workflows/maintenance-protocol|quarterly cadence]].

---

## Health Signals

| Color | Meaning |
|-------|---------|
| `green` | On track, recent action, next action clear |
| `yellow` | Stalled but recoverable, next action unclear, deadline at risk |
| `red` | Off track, no action in 30+ days, deadline blown, or pivot needed |

A `red` project must either be re-scoped, paused, or archived within 14 days.

---

## Related

- [[03 Projects\|03 Projects]] — the parent folder
- [[templates/evergreen-note\|evergreen-note.md]]
- [[workflows/maintenance-protocol\|workflows/maintenance-protocol.md]] — health checks
- [[wiki/entities/projects/project-moc\|Project MOC]] — the machine-layer index

---

*A project without a feedback loop is a task list. Always close the loop.*