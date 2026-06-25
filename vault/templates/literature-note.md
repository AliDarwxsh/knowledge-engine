---
title: "Literature Note Template"
summary: "A reusable scaffold for notes distilled from sources — books, articles, papers, podcasts, videos. Captures the source's claim and the operator's interpretation."
date: 2026-06-26
tags: [template, literature-note, source, distillation]
---

# Literature Note Template

> A literature note captures what a source says, in the operator's own words, with the operator's interpretation.

---

## Filename Convention

`source-author-keyword-YYYY.md` — placed in `09 Research Archive/` or `04 Knowledge Library/`.

---

## Frontmatter

```yaml
---
title: "<Source Title> — <Key Insight>"
summary: "<One sentence: the operator's takeaway from the source>"
date: YYYY-MM-DD
tags: [literature-note, source-distillation, <domain>]
source_type: book | article | paper | podcast | video | conversation
source_author: "<author>"
source_title: "<full title>"
source_year: YYYY
status: canonical | draft | disputed | deprecated
ai_context: "<one sentence telling AI when to load this note>"
---
```

---

## Template Body

```markdown
# <Source Title> — <Key Insight>

> <One-sentence takeaway.>

---

## Source

- **Type:** <book | article | paper | podcast | video | conversation>
- **Author:** <author>
- **Title:** <full title>
- **Year:** <YYYY>
- **Source link:** [[sources/path/to/source]]
- **Date read:** <YYYY-MM-DD>

## The Claim

<What does the source claim? State it clearly, in the operator's own words.>

## The Argument

<How does the source support the claim? Summarize the argument, not the data.>

## The Mechanism

<Why does the claim work? What is the underlying mechanism?>

## What the Operator Takes From It

<The operator's interpretation. What changes about how the operator thinks or acts after reading this source?>

## Quotes Worth Keeping

> "<exact quote>" — <page or timestamp>

> "<exact quote>" — <page or timestamp>

## Connections

- [[02 Principles/related-principle]]
- [[04 Knowledge Library/related-knowledge]]
- [[05 Framework Library/related-framework]]
- [[06 Decision Archive/related-decision]]

## Counter-Evidence and Limits

- <where the source is wrong or limited>
- <what the source does not address>

## Promoted To

- [[04 Knowledge Library/promoted-note]] — <what graduated from this note>
- [[02 Principles/promoted-principle]] — <what graduated from this note>

## Changelog

- <YYYY-MM-DD> — created from [[sources/path/to/source]].
```

---

## Purpose of the Literature Note

A literature note is **not** a summary. It is a **distillation**:

| Aspect | Summary | Literature Note |
|--------|---------|-----------------|
| Voice | Source's voice | Operator's voice |
| Length | Full coverage | Selective, by relevance |
| Purpose | Comprehension | Transfer to operator's thinking |
| Use | Reference | Foundation for principle/knowledge promotion |

> [!tip] **Write the note as if you are explaining the source to a future version of yourself.**

---

## Promotion Criteria

A literature note graduates when:

1. **A claim from the note becomes a knowledge note** — promote to [[04 Knowledge Library|04 Knowledge Library]] with full citation.
2. **A repeated insight becomes a principle** — promote to [[02 Principles|02 Principles]] after evidence threshold (≥3 decisions).
3. **A mental model becomes a framework** — promote to [[05 Framework Library|05 Framework Library]] if applicable across domains.

After promotion, the literature note stays in `09 Research Archive/` as a citation source. The promotion target cites it.

---

## Source Linkage

Every literature note MUST link to its source in [[sources/README|sources/]]:

```markdown
## Source

- **Source link:** [[sources/external/2024-09-12-paper-on-feedback-loops.pdf]]
```

A literature note without a source link is an opinion, not a finding.

---

## Failure Modes

| Failure | Recovery |
|---------|----------|
| Note is a verbatim summary | Rewrite in the operator's voice |
| Note duplicates an existing knowledge note | Merge; keep one canonical version |
| Note lacks source link | Add link or mark `[UNSOURCED]` for review |
| Note quotes too much | Reduce quotes; paraphrase in operator's voice |

---

## Related

- [[templates/evergreen-note\|evergreen-note.md]]
- [[09 Research Archive\|09 Research Archive]] — the parent folder
- [[04 Knowledge Library\|04 Knowledge Library]] — promotion destination
- [[02 Principles\|02 Principles]] — promotion destination for behavioral claims
- [[sources/README\|sources/README.md]] — the immutable source layer

---

*A literature note is a bridge. It moves a claim from the source into the operator's mind.*