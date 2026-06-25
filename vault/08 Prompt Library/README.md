---
title: "08 Prompt Library"
summary: "AI prompts and interaction patterns, organized by use case. Each prompt is tested, dated, and tagged."
date: 2026-06-26
tags: [prompts, ai, llm, patterns, human-layer]
---

# 08 Prompt Library

> Prompts are code for AI. Version them.

---

## Purpose

This folder holds the operator's **curated AI prompts and interaction patterns** — tested prompts that consistently produce useful output. A prompt in this folder has been used at least three times and has a known failure mode.

The Human Layer (08 Prompt Library) holds narrative prompt notes. AI-callable commands live in [[workflows/\|workflows/]].

---

## What Lives Here

| Note Type | Purpose | Filename |
|-----------|---------|----------|
| Prompt | A tested AI prompt with usage notes | `prompt-name.md` |
| Pattern | A reusable interaction pattern (multi-prompt flows) | `pattern-name.md` |
| Failure mode | A known prompt failure and how to recover | `failure-name.md` |

---

## Anatomy of a Prompt Note

Every prompt note contains:

1. **Purpose** — what this prompt produces
2. **Use case** — when to invoke
3. **Prompt body** — the exact text to send to AI
4. **Variables** — what to substitute
5. **Expected output** — what good looks like
6. **Failure modes** — what goes wrong and how to recover
7. **Last tested** — date of most recent successful run

> [!warning] **Prompts rot.** LLMs change. A prompt that worked in March may not work in June. Always include a last-tested date.

---

## When to Open

- When starting a recurring AI-assisted task
- When a prompt fails and a known pattern might help
- When onboarding an AI assistant to the vault
- When sharing prompts with collaborators

---

## How to Use

1. **Capture new prompts in [[00 Inbox\|00 Inbox]]**, then promote here after three successful uses.
2. **Version explicitly.** A prompt that changed gets a `v2`, `v3` suffix in filename or frontmatter.
3. **Cite the model.** Behavior varies across models; record which model the prompt was tested against.
4. **Capture failure modes.** A prompt without known failures hasn't been used enough.
5. **Pair with SOPs.** SOPs in [[07 Systems & SOPs\|07 Systems & SOPs]] may embed prompts from here.

---

## Example Categories

| Category | Examples |
|----------|----------|
| Capture | "Summarize this article into 5 bullets" |
| Synthesis | "Find the common pattern across these three notes" |
| Audit | "Find contradictions between notes A and B" |
| Generation | "Draft an outline for X using principles Y and Z" |
| Editorial | "Rewrite this for active voice and zero filler" |

---

## Relationship to Other Folders

| Folder | Relationship |
|--------|--------------|
| [[07 Systems & SOPs]] | SOPs may invoke prompts |
| [[workflows/\|workflows/]] | Workflows orchestrate multi-prompt sequences |
| [[schema/copywriting-standards\|copywriting-standards]] | Prompt outputs pass copywriting audit |
| [[wiki/synthesis/00-synthesis-engine-hub\|Synthesis Hub]] | Prompts feed the synthesis engine |

---

*A prompt is a hypothesis. Running it three times turns it into a tool.*