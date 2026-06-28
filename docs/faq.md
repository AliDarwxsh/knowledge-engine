# FAQ

## General

### What is the Knowledge Engine?

A self-organizing knowledge system. You capture thoughts into an Obsidian vault. Hermes (an AI agent) classifies, tags, links, and organizes them automatically. The vault gets smarter every day.

### Who is this for?

Anyone who thinks a lot and wants those thoughts organized without doing the organizing themselves. Knowledge workers, researchers, founders, writers, engineers, and anyone who has ideas scattered across notes, chats, and browser tabs.

### How is this different from Notion, Evernote, or Roam?

- **Local-first**: Your notes are plain Markdown files on your machine. No vendor lock-in.
- **AI-native**: The engine actively organizes your notes, not just stores them.
- **Bring your own AI**: Use OpenAI, Anthropic, or local Ollama. You control the model and costs.
- **Open-source**: MIT licensed. Fork it, modify it, own it.

## Setup

### Do I need Hermes running all the time?

For automated processing (cron jobs), yes. The inbox processor fires every 6 hours, the morning brief at 7am, the connection finder at 3am, and the nightly lint at 2am. Without Hermes running, these won't execute. You can always run them manually: `/vault-sync`, `/vault-lint`, etc.

### Can I use the engine without Hermes?

The vault works in Obsidian without Hermes. You can capture, read, and link notes manually. But the automation (classification, tagging, linking, cron jobs) requires Hermes.

### Which AI model should I use?

- **Budget**: GPT-4o-mini or Claude Haiku (~$0.15/month for daily use)
- **Quality**: GPT-4o or Claude Sonnet (~$1.50/month)
- **Free/Private**: Ollama with llama3.1:8b (local, no data leaves your machine)

See [AI Models](ai-models.md) for full comparison.

### Does my data leave my machine?

If you use hosted models (OpenAI, Anthropic), your note content is sent to their API for processing. Read their data policies. If you use Ollama (local), nothing leaves your machine.

## Usage

### What happens when I capture a thought?

1. You type `/vault-capture "your thought"` or drop a note in `00 Inbox/`
2. The engine reads it
3. Classifies it: principle, idea, project note, knowledge, etc.
4. Generates frontmatter (title, summary, tags)
5. Finds related notes and adds wikilinks
6. Creates the note in the appropriate folder
7. Suggests forward references for concepts that don't exist yet

### How accurate is the classification?

Depends on your AI model. GPT-4o-mini gets ~85% accuracy on most notes. If the engine is uncertain, it adds a `## Review` section asking you to confirm.

### Can I train the engine to my preferences?

Yes, indirectly. When you move a note to a different folder or change its tags, the engine observes this through vault-sync. Over time, it adapts. You can also edit skill files directly to customize behavior.

### What if the engine misclassifies something?

Move the note to the correct folder. The engine learns from these corrections during the next sync.

### Can I delete notes the engine created?

Yes. You own every file. Delete, edit, merge, split — it's your vault.

### What are "forward references"?

Gray links to concepts that should exist but don't yet. When the engine sees a pattern across 3+ notes referencing the same concept, it creates a placeholder. Weekly triage either creates the missing note or removes the reference.

## Permissions

### What can the engine do without asking?

Depends on your permission level (set during onboarding):

- **Conservative**: Classify and link only. Never file without approval.
- **Moderate**: Classify, link, and file. Flag anything uncertain.
- **Aggressive**: Full automation.

Change this anytime in your vault's `CLAUDE.md`.

### What can the engine NEVER do?

- Edit `schema/` files (governance is human-owned)
- Modify `sources/` (immutable raw material)
- Delete notes without approval
- Use your AI credits for anything outside the vault
- Access files outside your vault

## Troubleshooting

### "Nothing is happening"

Check:
1. Is Hermes running? (`hermes --version`)
2. Are cron jobs scheduled? (`hermes cron list`)
3. Do you have an API key configured? (`echo $OPENAI_API_KEY`)
4. Is there content in `00 Inbox/`?
5. Run `/vault-sync` manually to force processing

### "The engine is using too many API credits"

1. Switch to a cheaper model (GPT-4o-mini or Claude Haiku)
2. Reduce cron frequency (edit `cron/*.json`)
3. Use Ollama locally for free processing
4. Check usage: `hermes usage`

### "Notes are being created but links are wrong"

The engine links based on semantic similarity. If links are consistently off:
1. Check that your vault has enough notes for meaningful linking (50+ minimum)
2. Try a better model for the vault-link skill
3. Add manual links to train the graph

### "I want to pause the engine"

```bash
hermes cron pause morning-brief
hermes cron pause inbox-processor
hermes cron pause connection-finder
hermes cron pause nightly-lint
hermes cron pause weekly-digest
```

Your vault still works. The engine just stops running.

### "I want to start over"

```bash
# Pause all cron jobs
for job in morning-brief inbox-processor connection-finder nightly-lint weekly-digest; do
  hermes cron pause $job
done

# Re-run onboarding
/vault-init
```

Your notes are preserved. Only the engine's automation resets.

### "Something is broken and I don't know what"

Hermes can read its own source code — the skills, the vault structure, the scripts. Just describe the problem:

- "My vault structure is broken — the wiki folder is missing."
- "The inbox processor isn't filing notes correctly."
- "I deleted a template by accident — rebuild it."

Hermes understands the architecture and can repair itself. You don't need to know what's wrong. You just need to describe what you're seeing.

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md). Skills are markdown. Cron jobs are JSON. Everything is editable. Fork it, modify it, submit a PR.
