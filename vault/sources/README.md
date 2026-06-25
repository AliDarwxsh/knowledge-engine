---
title: "sources — Immutable Raw Material"
summary: "The bedrock layer. Everything that enters the vault starts here. Once written, sources are never edited."
date: 2026-06-26
tags: [sources, raw-material, immutable, machine-layer]
ai_context: "Hermes reads sources/ for citation, never for editing. If a source contains an error, the correction happens in a distillation note, not in the source file."
---

# sources — Immutable Raw Material

> The source is the truth. Distillation is interpretation. Edit the interpretation, never the truth.

---

## Purpose

`sources/` holds **immutable raw material** — original transcripts, exports, scans, downloaded PDFs, and external artifacts that form the empirical bedrock of the vault. Once a file lands in `sources/`, it is **never edited**. Corrections, distillations, and improvements happen in derivative notes, never in the source itself.

```
sources/ (immutable)
   ↓
research archive (time-bounded investigation)
   ↓
knowledge library (durable domain notes)
   ↓
principles (behavioral rules derived from knowledge)
```

---

## Immutability Rule

| Rule | Reason |
|------|--------|
| No file in `sources/` may be edited after creation | Preserve evidentiary value |
| No file in `sources/` may be deleted (without archive) | Maintain history |
| Corrections are written as separate distillation notes | Distinguish claim from correction |
| The source's timestamp and checksum are preserved | Auditability |

> [!warning] **The immutability rule has exactly one exception:** the [[schema/agents|Schema Keeper]] may move a file to `sources/archive/` if it is genuinely redundant. This is the only mutation permitted.

---

## What Lives Here

| Subdirectory | Contents | Format |
|--------------|----------|--------|
| `sources/chatgpt/` | ChatGPT conversation exports | `.json`, `.md` |
| `sources/claude/` | Claude conversation exports | `.json`, `.md` |
| `sources/takeout/` | Google Takeout and other exports | `.zip`, `.mbox` |
| `sources/pipeline/` | Extraction, categorization, analysis artifacts | `.csv`, `.json`, `.md` |
| `sources/external/` | External downloads, articles, papers, books | `.pdf`, `.epub`, `.md` |

These subdirectories are conventions, not enforcement. The immutability rule applies regardless of location.

---

## Naming Convention

`sources/<subdir>/<YYYY-MM-DD>-<source-name>-<id>.<ext>`

| Component | Purpose |
|-----------|---------|
| `<subdir>` | Top-level category |
| `<YYYY-MM-DD>` | Date of source capture |
| `<source-name>` | Human-readable name |
| `<id>` | Optional hash or sequence number for collisions |

---

## When to Open

- When a note needs a citation
- When a contradiction or dispute requires checking the original
- During research that draws on prior raw material
- When an AI agent needs ground truth

---

## When NOT to Open

- During a routine vault session
- When looking for current state — sources are historical, not state
- When generating new content — sources inform, they do not generate

---

## Citation Convention

Every wiki note that draws on a source must cite it via [[wikilinks]]:

```markdown
## Sources
- [[sources/chatgpt/2024-03-15-conversation-on-systems-thinking-001]]
- [[sources/external/2025-09-12-paper-on-feedback-loops.pdf]]
```

A note without source links is an opinion, not a finding.

---

## Distillation Workflow

1. **Capture raw** — file goes into `sources/<subdir>/`.
2. **Create literature note** — distill the source into `[[templates/literature-note|literature-note.md]]`.
3. **Promote to knowledge** — graduate durable claims into [[04 Knowledge Library|04 Knowledge Library]].
4. **Cite forward** — knowledge notes link back to the literature notes and sources.
5. **Never modify the source** — corrections are new notes, not edits.

---

## Audit

| Action | Frequency | Owner |
|--------|-----------|-------|
| Immutability check | Quarterly | [[schema/agents\|Auditor]] |
| Source citation audit | Monthly | [[schema/agents\|Auditor]] |
| Archive review | Annually | [[schema/agents\|Schema Keeper]] |

---

## Related

- [[README|README.md]] — vault overview
- [[schema/CLAUDE|schema/CLAUDE.md]] — three-layer governance
- [[schema/agents|schema/agents.md]] — Schema Keeper powers
- [[04 Knowledge Library|04 Knowledge Library]] — distillation destination
- [[09 Research Archive|09 Research Archive]] — research projects that use sources

---

*Sources are the vault's memory of the world. Memory is sacred.*