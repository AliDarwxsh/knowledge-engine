# Customization

> How to adapt the engine to your specific needs. The defaults work for most people. This doc is for when they don't.

## What You Can Customize

| Component | Customization Method | Difficulty |
|-----------|---------------------|------------|
| Tag taxonomy | Edit `schema/ontology.md` | Easy |
| Voice standards | Edit `schema/copywriting-standards.md` | Easy |
| File structure | Add/remove folders, update schema docs | Medium |
| AI prompts (per skill) | Edit `skills/<skill>/SKILL.md` | Medium |
| Cron schedules | Edit `cron/*.json` | Easy |
| Permission boundaries | Edit `schema/agents.md` | Medium |
| Note templates | Edit `templates/*.md` | Easy |
| Frontmatter required fields | Edit `schema/CLAUDE.md` Layer 1 | Medium |

## Common Customizations

### 1. Add a New Tag Domain

Open `schema/ontology.md` and add a new entry to the taxonomy table.

**Example: Adding "biotech" domain for a researcher**

In `schema/ontology.md`, add a row:

```markdown
| Biotech | `biotech` | Biology, biotech, pharma, and life sciences research |
```

Then in any note's frontmatter:

```yaml
tags: [biotech, research, knowledge]
```

The engine will recognize `biotech` as a valid tag because it reads from the ontology.

### 2. Change Voice Style

Open `schema/copywriting-standards.md` and modify the standards.

**Example: For an academic audience**

Change Standard 2 (Specificity) to:

> Academic standard: cite papers, use precise technical terminology, include DOIs where applicable.

Change Standard 5 (Analogy Anchor) to:

> Academic standard: use established theoretical frameworks as anchors before introducing novel claims.

All generated notes will follow the new voice.

### 3. Add a New Top-Level Folder

**Example: Adding "04a Clients" for a freelancer**

1. Create the folder: `mkdir "vault/04a Clients"`
2. Add `04a Clients/README.md`:

```markdown
---
title: "Clients"
summary: "Client engagements, briefs, and communications."
date: 2026-06-26
tags: [meta, hub]
---

# Clients

Active client work. One folder per engagement.

## Conventions

- Client name as folder name (`acme-corp/`, `beta-llc/`)
- Each engagement has: brief.md, status.md, communications.md
- Reference related work via [[wikilinks]]
```

3. Update `schema/CLAUDE.md` to document the new layer
4. Update `Knowledge Archive Home.md` to link to it

The engine will respect the new folder's structure.

### 4. Customize a Skill's Behavior

Open `skills/<skill-name>/SKILL.md` and edit the relevant phase.

**Example: Making vault-capture prefer "principle" classification**

In `skills/vault-capture/SKILL.md`, find Phase 2 (Classify) and adjust the decision matrix:

```markdown
| **Principle** | Detect strong claims, load-bearing language | `02 Principles/` |
```

Make the criteria more inclusive:

```markdown
| **Principle** | Any insight, rule, or heuristic that could guide future decisions. Default to principle when in doubt. | `02 Principles/` |
```

The skill will now route more notes to Principles.

### 5. Change Cron Schedules

Open `cron/<job-name>.json` and edit the `schedule` field using standard cron syntax.

**Example: Run weekly digest on Friday instead of Sunday**

```json
{
  "name": "weekly-digest",
  "schedule": "0 18 * * 5",  // Was: "0 18 * * 0"
  ...
}
```

Then reinstall: `hermes cron install cron/weekly-digest.json`

### 6. Add a New Cron Job

Create `cron/<job-name>.json`:

```json
{
  "name": "my-custom-job",
  "description": "What this job does",
  "schedule": "0 9 * * 1",  // 9am every Monday
  "timezone": "user-local",
  "skill": "vault-digest",
  "prompt": "Run a monthly summary instead of weekly",
  "delivery": "local",
  "enabled": true,
  "model": "inherit",
  "toolsets": ["file", "terminal", "skills"]
}
```

Install: `hermes cron install cron/my-custom-job.json`

### 7. Add a New Skill

Create `skills/<skill-name>/SKILL.md`:

```markdown
---
name: my-skill
description: What this skill does and when to invoke
version: 1.0.0
author: you
tags: [category, tags]
---

# my-skill

> Description

---

## When to Invoke

The user says any of:
- "Do this thing"
- "/my-skill"

---

## Execution

### Phase 1: ...
### Phase 2: ...

---

## Permission Boundaries

This skill:
- ✅ Reads from ...
- ✅ Writes to ...
- ❌ Does NOT touch ...

---

*Engine version: 1.0.0*
```

Install: `hermes skill install skills/my-skill/`

The skill becomes available as `/my-skill`.

### 8. Customize the User Profile

Open `CLAUDE.md` and edit any section. Common customizations:

**Add new sections:**

```markdown
## Reading List

Current books I'm reading:
- [[book-1]]
- [[book-2]]

## Energy Patterns

I do deep work in the morning. I do admin in the afternoon.
Don't suggest deep work tasks after 3pm.
```

**Update over time:** Your profile is a living document. Update it as your situation changes.

## Advanced Customizations

### Multi-Vault Setups

Some users maintain multiple vaults (one for work, one for personal). The engine can handle this:

1. Create each vault with its own structure
2. Configure `OBSIDIAN_VAULT` env var to point to the active vault
3. Run skills with `vault=<path>` override

Or use Hermes profiles for clean separation:

```bash
hermes profile create work
hermes profile create personal
```

### Custom Embedding Models

The engine uses simple keyword similarity by default. For better semantic search:

1. Install a local embedding model (e.g., `nomic-embed-text` via Ollama)
2. Configure `vault-query` to use it
3. See `skills/vault-query/SKILL.md` for embedding integration points

### External Integrations

The engine can integrate with:

| Integration | How |
|-------------|-----|
| Calendar | Read calendar via MCP, auto-link meeting notes |
| Email | Import emails as inbox items |
| Web clipper | Drop articles directly into inbox |
| RSS feeds | Auto-ingest blog posts as research notes |
| Git | Version control the vault for history |

Each integration requires a custom skill. See "Add a New Skill" above.

### Backup Strategy

Recommended backup approaches:

**For local-only:**
```bash
# Add to crontab: backup vault daily
0 4 * * * rsync -av ~/Documents/Obsidian/MyVault/ ~/Backups/vault-$(date +\%Y\%m\%d)/
```

**For cloud sync:**
- Use Obsidian Sync (official, encrypted)
- Use iCloud Drive (the source uses this)
- Use Syncthing (self-hosted, free)
- Use Git with Obsidian Git plugin

**For disaster recovery:**
- Export vault as ZIP monthly
- Store in cloud storage (S3, Google Cloud, etc.)

## When to Customize vs Fork

**Customize** (edit in place):
- Tag taxonomy
- Voice standards
- Cron schedules
- Templates

**Fork** (create your own version):
- New skills that don't exist
- Different folder structure
- Different permission model
- New integrations

The default engine is designed for general use. Forks are expected and encouraged.

## Getting Help

If you're stuck on a customization:

1. Check the relevant `SKILL.md` — most questions are answered there
2. Check `schema/CLAUDE.md` for governance rules
3. Open a GitHub issue with the `customization` label
4. Join the community Discord (link in main README)

---

*For architecture details, see [docs/architecture.md](architecture.md).*
*For daily workflow, see [docs/daily-workflow.md](daily-workflow.md).*
*For AI provider setup, see [docs/ai-models.md](ai-models.md).*