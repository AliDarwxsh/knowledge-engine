# Daily Workflow

> What happens each day in the knowledge engine. Read this once, then let the system handle itself.

## The 30-Second Version

You capture. The engine organizes. You review. The engine compounds.

That's the whole loop. Everything else is detail.

## The Daily Timeline

### 7:00 AM — Morning Brief Delivered

Hermes delivers your morning brief via your connected channel (Telegram, Discord, Slack, or email). It contains:

- Yesterday's vault activity (notes added, items processed)
- 🔴 Items needing attention today
- 🟡 Things worth knowing
- 🟢 Informational updates
- Open loops (stalled projects, upcoming deadlines)
- One question to carry into the day

You read it in 30 seconds. You know what to focus on.

### Throughout the Day — Capture

You have a thought. You drop it into `00 Inbox/`. Methods:

**In Obsidian:**
1. Open your vault
2. Navigate to `00 Inbox/`
3. Create new note with today's date as title
4. Type the raw thought
5. Save. Done.

**Via Hermes command (CLI or chat):**
```
/capture "Mastery emerges when constraint becomes the creative engine"
```

**Via Hermes Desktop:**
- Open Hermes Desktop
- Type `/capture` followed by your thought
- Hit enter

The capture takes <3 seconds. No folder selection. No tag choosing. No frontmatter editing. Just the raw thought.

### Every 6 Hours — Inbox Processor Runs

At 12am, 6am, 12pm, 6pm, the inbox processor cron fires. It:

1. Scans `00 Inbox/` for unprocessed items
2. For each, invokes `vault-capture`
3. The engine classifies, tags, links
4. Moves the original to `00 Inbox/_processed/YYYY-MM-DD/`

You don't have to do anything. The engine files your thoughts.

If the engine is uncertain about classification, it adds a `## Review` section to the note asking you to confirm.

### Evening — 5-Minute Review

You open your vault. You scroll through what the engine did today.

**What to look for:**
- Notes classified into wrong folders → move them
- Notes with `## Review` section → confirm or correct
- Stale inbox items (still unprocessed) → check why

**What NOT to do:**
- Re-classify every note manually (defeats the purpose)
- Add elaborate frontmatter (engine handles it)
- Create new folders for every new theme (let the engine propose)

Time budget: 5 minutes. If you're spending more, something's off.

### Optional — End-of-Day Reflection

In your daily note (if you use them), answer three questions:

1. **What moved forward today?**
2. **What stalled?**
3. **What carries to tomorrow?**

Five minutes. Compounds into a useful personal record over months.

### 2:00 AM — Nightly Lint

The vault-lint cron fires. It runs 7 audit checks:

1. Frontmatter completeness
2. Orphan detection
3. Tag compliance
4. Link rot
5. Contradiction scan
6. Duplicate detection
7. Forward reference inventory

It writes a health scorecard to `wiki/journal/sync-logs/YYYY-MM-DD-lint.md`.

If health drops below 60, you get a notification.

### 3:00 AM — Connection Finder

The vault-link cron fires. It:

1. Reads notes created or modified in the last 7 days
2. Searches the entire vault for non-obvious connections
3. Proposes wikilinks the user didn't make consciously
4. Creates forward references where concepts should exist but don't
5. Generates a connection report

You wake up to a vault that's more connected than when you went to sleep.

### Sunday 6:00 PM — Weekly Digest

The vault-digest cron fires. It:

1. Reads all notes from the past week
2. Identifies themes (recurring concepts, domain clusters)
3. Generates 3-7 cross-domain insights
4. Surfaces contradictions and tensions
5. Writes a weekly synthesis note

You read it Sunday evening. You see what the week meant.

## The Weekly Maintenance

### Sunday (After Digest)

- Read the weekly digest (5 minutes)
- Check connection report (2 minutes)
- Run `/vault-sync` if you want proactive MOC updates
- Review any contradictions flagged during the week

Total: ~15 minutes.

### Monthly

- Run `/vault-lint` manually for a thorough health audit
- Review vault health trend (is it improving?)
- Triage forward references (or let `/vault-forward-refs` cron handle it)
- Archive completed projects

Total: ~30 minutes.

### Quarterly

- Read the timeline MOC to see your intellectual evolution
- Review the synthesis hub for cross-domain patterns
- Audit the ontology — are tags still serving you?
- Restructure folders if patterns have shifted

Total: ~60 minutes.

### Annually

- Full archive audit — eliminate duplicates, merge similar notes
- Review the year's digests for meta-patterns
- Update `CLAUDE.md` if your goals have shifted
- Decide if the vault structure still serves you

Total: ~3 hours spread over a weekend.

## The "Capture Friction" Test

Every capture should take <3 seconds. If it takes longer, you're doing it wrong.

**Friction sources to eliminate:**

| Friction | Fix |
|----------|-----|
| Choosing a folder | Use inbox only. Engine classifies. |
| Choosing tags | Engine tags from ontology. |
| Writing frontmatter | Engine generates. |
| Linking related notes | Engine suggests wikilinks. |
| Naming the file | Engine derives name from content. |

If you find yourself making decisions at capture time, you're adding friction. Move those decisions to processing time.

## The "Value Proof" Test

Within your first week, the engine should surface something you would have forgotten.

Examples:
- A principle you wrote 3 months ago, surfaced because you wrote a related note today
- A contradiction in your thinking, flagged by the lint
- A connection between a project and a research note, proposed by the link finder

If you don't see this happen, the engine isn't doing its job. Check:

1. Are cron jobs actually running? (`hermes cron list`)
2. Are you capturing enough? (<3 notes/week → not enough signal)
3. Is your AI provider responding? (check `hermes skill run vault-lint`)
4. Is the engine getting your permission level? (check `CLAUDE.md`)

## The Permission Decision

When you set up the engine, you chose Conservative, Moderate, or Aggressive. Here's when to revisit:

**Move toward Aggressive if:**
- You've been using it 3+ months
- The engine has >85% accuracy on classification
- You trust the link suggestions
- You want less manual review time

**Move toward Conservative if:**
- The engine keeps misclassifying your notes
- You're finding its links irrelevant
- You're anxious about losing control
- You want to understand what it does before letting it act

The permission level is in `CLAUDE.md`. Edit it any time. Run `/vault-update-profile` (or just re-run vault-init) to re-interview.

## The "Kill Switch"

If you want to stop the engine temporarily without uninstalling:

```bash
hermes cron pause morning-brief
hermes cron pause inbox-processor
hermes cron pause connection-finder
hermes cron pause nightly-lint
hermes cron pause weekly-digest
```

Your vault still works in Obsidian. The engine just stops running.

To resume: `hermes cron resume <job-name>`

## The "Reset" Option

If the engine has gone off the rails:

```bash
# Pause all jobs
for job in morning-brief inbox-processor connection-finder nightly-lint weekly-digest; do
  hermes cron pause $job
done

# Manually review the schema
cat schema/CLAUDE.md
cat schema/agents.md

# Check your profile
cat CLAUDE.md

# Re-run vault-init to reset the interview
hermes skill run vault-init
```

The vault itself never gets wiped. Only the engine's automation gets reset.

---

*For architecture details, see [docs/architecture.md](architecture.md).*
*For AI provider setup, see [docs/ai-models.md](ai-models.md).*
*For customization, see [docs/customization.md](customization.md).*