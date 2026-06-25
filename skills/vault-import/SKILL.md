---
name: vault-import
description: Imports AI chat exports (ChatGPT, Claude, Gemini, generic). Extracts decisions, principles, questions, and knowledge from conversations. Creates structured notes with source citations. Transforms forgotten chat history into searchable knowledge.
version: 1.0.0
author: knowledge-engine
tags: [import, ingestion, chat-export, migration]
---

# vault-import — Chat Export Ingestion

> Transforms your AI conversation history into a structured knowledge graph. The killer feature for adoption.

---

## When to Invoke

- User: "/import <path>", "/vault-import <path>"
- User: "Import my ChatGPT data", "Process this Claude export"
- User: "Ingest this AI chat log"

---

## Prerequisites

1. Vault is initialized (`CLAUDE.md` exists at root)
2. User provides a valid file path or pasted content
3. `schema/ontology.md` has been read (for tag validation)
4. `sources/_imports/` directory exists

---

## Supported Formats

| Format | Detection | Parser |
|--------|-----------|--------|
| ChatGPT data export | `conversations.json` from OpenAI takeout | `chatgpt.ts` |
| Claude conversation export | `.json` from claude.ai export | `claude.ts` |
| Gemini / Google Takeout | `MyActivity.json` or `Bard` format | `gemini.ts` |
| Generic markdown chat | `.md` with `**Human:**` / `**Assistant:**` or `User:` / `Assistant:` patterns | `generic.ts` |
| Plain text log | `.txt` with conversation-like structure | `generic.ts` (text mode) |

Auto-detect by file structure. If ambiguous, ask user.

---

## Execution — Six Phases

### Phase 1: Stage The Source

1. Validate the input path exists and is readable
2. Create a staging directory: `sources/_imports/YYYY-MM-DD-<source-name>/`
3. Copy the original file there (NEVER modify the original)
4. Parse the file into a normalized conversation structure:
   ```typescript
   interface Conversation {
     id: string;
     title: string;
     date: string;
     messages: Array<{
       role: 'user' | 'assistant';
       content: string;
       timestamp?: string;
     }>;
   }
   ```

### Phase 2: Extract Insights Per Conversation

For each conversation, run an extraction pass:

1. **Identify decisions made**: "We decided X", "Going with Y", "The choice is..."
2. **Identify principles stated**: "The rule is", "Always", "Never", "The principle..."
3. **Identify questions explored**: complex multi-message exchanges where user is researching
4. **Identify knowledge shared**: factual content, explanations, definitions
5. **Identify projects discussed**: mentions of active work
6. **Identify commitments made**: "I will", "Tomorrow I'll", "Next steps..."

Output per conversation:
```json
{
  "conversation_id": "...",
  "insights": [
    {
      "type": "decision|principle|question|knowledge|project|commitment",
      "content": "extracted statement",
      "message_index": 3,
      "confidence": 0.85
    }
  ]
}
```

### Phase 3: Deduplicate Across Conversations

Many insights recur across conversations (user asked similar things). For each insight:

1. Compute semantic similarity vs all existing vault notes
2. If >0.85 match → add to existing note (extend content, cite new source)
3. If 0.5-0.85 → check if it's a new instance of known concept, or new concept
4. If <0.5 → new note

### Phase 4: Create Notes

For each unique insight, invoke [[vault-capture]] with these adjustments:

1. **Frontmatter additions**:
   ```yaml
   source:
     - type: chat-export
       platform: chatgpt|claude|gemini|generic
       conversation_id: <id>
       message_index: <n>
       date: <conversation date>
       import_batch: YYYY-MM-DD
   ```

2. **Title format**: `<insight-statement> (from <platform> <date>)` — until promoted, then strip the suffix

3. **Initial location**: `00 Inbox/_imported/YYYY-MM-DD/` — let sync promote them

4. **Body opening**: Start with source citation, then the insight, then context

Example body:
```markdown
> Source: ChatGPT conversation, 2024-11-15, message 4

# <Title>

The user's insight as stated in the conversation:
> "<original quote>"

## Context
<what was being discussed>

## The Idea
<expanded per copywriting standards>

## Related
- <links to other notes in vault>
```

### Phase 5: Build The Import Map

For transparency, create a meta-note documenting what was imported:

`wiki/journal/import-logs/YYYY-MM-DD-<source>-import.md`

Structure:
```markdown
---
title: "Import Log: <Source> <Date>"
summary: "<N> conversations processed. <M> insights extracted. <K> new notes created. <J> merged with existing."
date: <date>
tags: [audit, import-log]
source: <platform>
---

# Import Log: <Source> <Date>

## Summary

- Conversations processed: <N>
- Insights extracted: <M>
- New notes created: <K>
- Merged with existing: <J>
- Skipped (low confidence): <L>

## Notable Extractions

- <List 5-10 most significant insights extracted>

## Duplicate Themes

- <Themes that recurred across multiple conversations>

## Recommended Review

- <Conversations with highest insight density — worth re-reading>
- <Insights that contradict existing vault notes>
```

### Phase 6: Report

Final summary:

```
## Import Complete: <Source>

**Conversations processed**: <N>
**Insights extracted**: <M>
**New notes created**: <K>
**Merged with existing**: <J>
**Skipped (low confidence)**: <L>

### Top Insights
- <insight 1>
- <insight 2>
- <insight 3>

### Next Steps
1. Review notes in `00 Inbox/_imported/<date>/`
2. Run `/vault-sync` to promote them to canonical folders
3. Check import log at `wiki/journal/import-logs/<date>-<source>-import.md`

Your forgotten conversations are now searchable knowledge.
```

---

## Permission Boundaries

This skill:
- ✅ Reads from any input file the user provides
- ✅ Writes to `sources/_imports/` (immutable staging)
- ✅ Writes to `00 Inbox/_imported/` (pending sync)
- ✅ Writes to `wiki/journal/import-logs/` (audit trail)
- ❌ Does NOT directly write to canonical folders (sync does that)
- ❌ Does NOT modify or delete the original source file

---

## Adversarial Cases

| Case | Response |
|------|----------|
| File is huge (>100MB) | Process in chunks of 100 conversations, create import logs per chunk |
| Format unrecognized | Detect and ask user: "Is this ChatGPT, Claude, Gemini, or generic?" |
| File contains PII (emails, phones, addresses) | Warn: "Found PII. Recommend redaction before import." Provide option to skip PII blocks |
| User pastes single conversation inline | Process as one-conversation import, no staging |
| Conversation in non-English | Detect language, import as-is, keep language preserved |

---

## Privacy

The engine imports YOUR OWN data. It does not:
- Transmit chat data to external services beyond the configured AI model
- Share chat data between users
- Train any model on imported content

The user owns and controls all imported material. Delete from `sources/_imports/` to remove.

---

## Cost Estimation

- Tokens per import (100 conversations): ~30,000-60,000
- Cost: ~$0.10-0.30 per import run with hosted models
- For a full ChatGPT export (3,000+ conversations): $3-10 one-time

---

## Related Skills

- [[vault-capture]] — invoked during Phase 4 with adjusted parameters
- [[vault-sync]] — runs after import to promote `_imported/` notes to canonical folders
- [[vault-lint]] — validates the import doesn't break vault health

---

*Engine version: 1.0.0*