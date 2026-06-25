---
title: "Meeting Note Template"
summary: "A reusable scaffold for meeting notes — captures attendees, decisions, action items, and follow-ups in a single page."
date: 2026-06-26
tags: [template, meeting, notes, action-items]
---

# Meeting Note Template

> A meeting without a note is a meeting that did not happen.

---

## Filename Convention

`YYYY-MM-DD-meeting-topic.md` — placed in `12 Relationship Maps/` or `11 Timeline/`.

---

## Frontmatter

```yaml
---
title: "YYYY-MM-DD — <Meeting Topic>"
summary: "<One sentence: the meeting's outcome>"
date: YYYY-MM-DD
tags: [meeting, timeline, <project-tag>]
attendees:
  - "[[12 Relationship Maps/person-name-1]]"
  - "[[12 Relationship Maps/person-name-2]]"
duration: <minutes>
meeting_type: kickoff | planning | review | decision | retrospective | 1:1
linked_project: "[[03 Projects/project-name]]"
status: scheduled | held | cancelled
---
```

---

## Template Body

```markdown
# YYYY-MM-DD — <Meeting Topic>

> <One-sentence outcome.>

---

## Attendees

- [[12 Relationship Maps/person-name-1]]
- [[12 Relationship Maps/person-name-2]]
- [[12 Relationship Maps/person-name-3]]

**Duration:** <minutes> minutes
**Type:** <kickoff | planning | review | decision | retrospective | 1:1>

## Context

<Why this meeting exists. What triggered it. What was the desired outcome going in.>

## Agenda

1. <topic 1>
2. <topic 2>
3. <topic 3>
4. <topic 4>

## Discussion

### <Topic 1>

<Summary of discussion. Capture positions, not transcripts.>

### <Topic 2>

<Summary of discussion.>

### <Topic 3>

<Summary of discussion.>

## Decisions

- [[06 Decision Archive/decision-1]] — <what was decided>
- [[06 Decision Archive/decision-2]] — <what was decided>

## Action Items

| Action | Owner | Deadline |
|--------|-------|----------|
| <verb + object> | [[12 Relationship Maps/person-name]] | <YYYY-MM-DD> |
| <verb + object> | [[12 Relationship Maps/person-name]] | <YYYY-MM-DD> |
| <verb + object> | [[12 Relationship Maps/person-name]] | <YYYY-MM-DD> |

## Open Questions

- <question 1>
- <question 2>

## Follow-Up

- **Next meeting:** <YYYY-MM-DD or "none">
- **Cadence:** <daily | weekly | biweekly | monthly | ad-hoc>

## Related

- [[03 Projects/project-name]]
- [[06 Decision Archive/decision-name]]
- [[12 Relationship Maps/person-name]]

## Changelog

- <YYYY-MM-DD> — meeting held; notes captured.
- <YYYY-MM-DD> — action item <X> completed; updated in table.
```

---

## When to Use

- After every meeting, internal or external.
- For one-on-ones (1:1s).
- For async decision-making conversations that warrant a record.
- For retrospectives after projects or sprints.

> [!warning] **Capture within 24 hours.** Notes older than 24 hours lose fidelity.

---

## Anatomy Guidance

| Section | Purpose |
|---------|---------|
| Context | Why the meeting existed |
| Discussion | Positions, not transcripts |
| Decisions | What was committed |
| Action Items | What happens next, by whom, by when |
| Open Questions | What is still unresolved |

---

## Action Item Discipline

Action items are **SMART by default**:

| Component | Definition |
|-----------|------------|
| Specific | Verb + concrete object |
| Measurable | Completion is observable |
| Assigned | Owner is a named person |
| Relevant | Tied to a [[03 Projects\|project]] or decision |
| Time-bound | Deadline is a date, not "soon" |

A vague action item is no action item.

---

## Privacy Discipline

Meeting notes may include:

- Decisions and reasoning
- Action items and owners
- Public context (project, agenda)

Meeting notes must NOT include:

- Personal assessments of attendees
- Off-the-record remarks
- Sensitive personal or commercial information

When in doubt, summarize rather than quote.

---

## Related

- [[12 Relationship Maps\|12 Relationship Maps]] — where person notes live
- [[03 Projects\|03 Projects]] — meeting linked to project
- [[06 Decision Archive\|06 Decision Archive]] — decisions archived separately
- [[11 Timeline\|11 Timeline]] — meeting date anchors timeline
- [[templates/daily-note\|daily-note.md]] — light-weight alternative for informal meetings

---

*A meeting note is a promise that the decisions will be remembered.*