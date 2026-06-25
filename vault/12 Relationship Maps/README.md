---
title: "12 Relationship Maps"
summary: "People, networks, and the dynamics between them. A map, not a directory."
date: 2026-06-26
tags: [relationships, people, networks, dynamics, human-layer]
---

# 12 Relationship Maps

> A directory tells you who exists. A map tells you how the territory is shaped.

---

## Purpose

This folder holds the operator's **people and network knowledge** — individuals, groups, organizations, and the dynamics between them. A relationship map is more than a contact list; it captures context, history, and influence.

| Layer | Holds |
|-------|-------|
| [[12 Relationship Maps\|12 Relationship Maps]] | Narrative notes about people and networks |
| [[wiki/entities/people/relationship-moc\|Relationship MOC]] | Machine-layer structured index |

---

## What Lives Here

| Note Type | Purpose | Filename |
|-----------|---------|----------|
| Person | A single individual with context | `person-name.md` |
| Organization | A company, team, or institution | `organization-name.md` |
| Network map | A diagram of relationships | `network-name.md` |
| Relationship dynamic | A pattern between the operator and others | `dynamic-name.md` |

---

## Anatomy of a Person Note

A person note answers the following questions:

1. **Who is this person?** — role, context
2. **How did we connect?** — origin
3. **What is the current state of the relationship?** — active, dormant, professional, personal
4. **What have we built together?** — shared projects, decisions, history
5. **What is the next expected interaction?** — cadence, context
6. **Which [[01 Identity|identity]] dimensions does this relationship activate?** — tags

> [!warning] **Respect privacy.** Person notes may include private context. Treat them as confidential. AI may read but must not export them externally.

---

## When to Open

- Before a meeting or interaction with a known person
- When planning a collaboration or partnership
- When reflecting on a relationship pattern
- When deciding whether to invest further in a connection

---

## How to Use

1. **One canonical note per person.** Updates append in place.
2. **Link forward.** Person notes should link to relevant [[06 Decision Archive|decisions]] and [[03 Projects|projects]].
3. **Date the first contact.** The "met on" date anchors the relationship.
4. **Tag the relationship type.** `personal`, `professional`, `mentor`, `peer`, `collaborator`, `client`.
5. **Quarterly refresh.** Dormant relationships need an update or a `low-priority` tag.

---

## Relationship Map Anatomy

A network map is a [[wikilinks|-linked]] diagram. Structure:

```markdown
# Network — Domain Name

## Central Node
- [[person-x]]

## Direct Connections
- [[person-x]] ↔ [[person-y]] (shared project: [[03 Projects/example]])
- [[person-x]] ↔ [[person-z]] (introduced by [[person-w]])

## Indirect Connections
- [[person-y]] → [[org-a]] → [[person-v]]

## Dynamics
- Trust gradient: high in [[person-x]], medium in [[person-y]]
- Communication cadence: weekly with [[person-x]], monthly with [[person-y]]
```

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[01 Identity]] | Relationships shape identity; identity shapes who we relate to |
| [[03 Projects]] | Many projects depend on relationships |
| [[06 Decision Archive]] | Major decisions about people get archived |
| [[wiki/entities/people/relationship-moc\|Relationship MOC]] | The machine-layer structured index |

---

*People are not nodes in a graph. They are the reasons the graph exists.*