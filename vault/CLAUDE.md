---
title: "User Profile — CLAUDE.md"
summary: "Operator profile template filled by a Hermes interview. Defines identity, goals, communication preferences, active projects, decision style, capture pattern, and permission level for AI collaboration."
date: 2026-06-26
tags: [meta, profile, claude, hermes, onboarding, governance]
ai_context: "Hermes reads this file first when entering a session. Treat it as the operator's canonical self-description. Update only with explicit operator consent."
---

# User Profile — CLAUDE.md

> The operator's canonical self-description. Read this before any other file when starting a session.

---

## Purpose

This file is the **primary context loader** for AI assistants operating in this vault. It encodes who the operator is, how they think, what they are building toward, and the boundaries within which AI may act. Every section below is a placeholder until the [[workflows/onboarding|Hermes onboarding interview]] fills it.

> [!warning] **Do not invent content for this file.** AI must not fabricate personal details. If a section is empty, AI must ask.

---

## 1. Identity

```yaml
preferred_name:
pronouns:
role:
location:
timezone:
languages:
bio: |
  # 2–4 sentences. Who is this person, in plain prose.
values_top_five:
  -
  -
  -
  -
  -
```

### Anchor Questions for the Interview
- "How do you introduce yourself in one sentence?"
- "Which five values do you refuse to negotiate?"
- "Where do you live, and what timezone do you operate in?"
- "What languages do you work in?"

---

## 2. Goals

### Active Goals (this quarter)
```yaml
goal_1:
  statement:
  deadline:
  success_metric:
goal_2:
  statement:
  deadline:
  success_metric:
goal_3:
  statement:
  deadline:
  success_metric:
```

### Long-Term Direction (1–5 years)
```yaml
vision_statement: |
  # A paragraph describing where the operator is heading.
anti_goals:
  -
  -
  -
```

### Anchor Questions
- "What must be true in 90 days for you to call this quarter a win?"
- "Where do you want to be in five years?"
- "What outcomes do you explicitly want to avoid?"

---

## 3. Communication Preferences

```yaml
tone:           # formal | conversational | direct | socratic
verbosity:      # terse | balanced | expansive
format:         # prose | bullets | tables | mixed
humor_tolerance: # none | dry | frequent
emoji_policy:   # never | sparingly | freely
swearing_policy: # never | contextual | always
punctuation:
  em_dashes:    # yes | no
  semicolons:   # yes | no
  oxford_comma: # yes | no
```

### Channel Rules
- **Default response length:** [number] words or [duration]
- **Default format:** [prose | bullets | table]
- **Pushback protocol:** [never | always | only on principle violation]

### Anchor Questions
- "How do you want me to disagree with you?"
- "Do you prefer terse answers or full reasoning?"
- "What is your tolerance for filler language?"

---

## 4. Active Projects

```yaml
projects:
  - name:
    status:        # planning | active | paused | shipping | archived
    one_line_pitch:
    next_concrete_action:
    deadline:
    vault_path:    # link to the project note once created
  - name:
    status:
    one_line_pitch:
    next_concrete_action:
    deadline:
    vault_path:
```

### Anchor Questions
- "What projects are you actively shipping right now?"
- "Which project gets attention if you have 90 minutes tomorrow?"
- "Which project is on pause and why?"

---

## 5. Decision Style

```yaml
speed_vs_quality:    # fast-iterate | balanced | deliberate
risk_tolerance:      # low | medium | high
reversibility_bias:  # prefer_reversible | neutral | prefer_irreversible
information_style:   # synthesize_first | raw_then_synthesize | balanced
default_principle_under_uncertainty: |
  # Sentence stating which principle wins when in doubt.
```

### Heuristics the Operator Trusts
1. [e.g., "Prefer reversible decisions when stakes are unclear."]
2. [e.g., "Default to the option that compounds."]
3. [e.g., "Optimize for signal, not safety."]

### Anchor Questions
- "When stakes are unclear, do you prefer speed or deliberation?"
- "What decision rule do you fall back on under pressure?"

---

## 6. Capture Pattern

```yaml
inbox_volume:        # low (<5/day) | medium (5–20) | high (>20)
primary_capture_device:   # phone | laptop | tablet | voice
capture_format_preference: # short | long | mixed
triage_window:       # same_day | evening | weekly | monthly
languages_captured:  # list
```

### Capture Discipline
- **Default capture surface:** [[00 Inbox|00 Inbox]]
- **Triage cadence:** see [[workflows/daily-rhythm|daily-rhythm.md]]
- **Decision tree:** see [[workflows/inbox-triage|inbox-triage.md]]

### Anchor Questions
- "How many items land in your inbox per day?"
- "When do you process the inbox — same day, evening, weekly?"
- "Do you capture on phone, laptop, or both?"

---

## 7. Permission Level

This is the most important section. It defines what AI may do without asking and what requires confirmation.

```yaml
vault_writes:
  human_only:
    - "00 Inbox/"
    - "01 Identity/"
    - "templates/"
  hermes_may_write:
    - "wiki/"
    - "09 Research Archive/"
    - "06 Decision Archive/"
    - "13 Meta Analysis/"
  forbidden_for_everyone:
    - "schema/"        # except the Schema Keeper agent
    - "sources/"       # immutable raw material

read_scope: all    # AI may read every folder
cite_sources: true # AI must cite [[wikilinks]] for every claim
append_only_journal: true
```

### Escalation Rules
- **Auto-execute:** formatting, linking, lint, citation, summarization
- **Confirm before write:** new principles, new projects, voice changes, schema edits
- **Stop and ask:** identity claims, principle rewrites, deletions, anything irreversible

### Anchor Questions
- "Which folders can I write to without asking?"
- "Which actions require your explicit confirmation?"
- "What is the one thing you never want AI to do autonomously?"

---

## 8. Operator ↔ AI Working Agreement

A short paragraph stating the working relationship in plain language.

```yaml
agreement: |
  # E.g., "AI acts as a thinking partner. It drafts, links, audits, and synthesizes.
  # The operator reviews, decides, and edits. AI never publishes externally
  # without explicit approval."
```

---

## 9. How This File Gets Filled

This is a template. It is filled through a **Hermes onboarding interview** run on first session. The interview:

1. Reads the empty template.
2. Asks the anchor questions section by section.
3. Writes responses back into the YAML blocks under each heading.
4. Marks the file as `onboarded: true` once all sections are populated.
5. Logs the onboarding in [[13 Meta Analysis|13 Meta Analysis]].

> [!tip] **Hermes:** When this file is empty, prompt the operator for each section using the anchor questions. Do not skip. Do not invent. Confirm each section before moving to the next.

---

## Changelog

- **v1.0 — 2026-06-26** — Template published. Placeholders and anchor questions provided. Awaiting first operator onboarding.

---

*This file is the AI's first stop. Fill it carefully; it shapes every subsequent session.*