# Contributing to Knowledge Engine

> The engine is markdown files. Contributing is editing text. Welcome.

## Philosophy

Knowledge Engine is built on three principles:

1. **Files are truth.** Everything is markdown or JSON. No build steps. No compilation. Edit a file, the engine updates.

2. **Fork-friendly.** Every component is a self-contained directory. Fork one, modify it, run it independently.

3. **Community-extensible.** The best features come from users who needed them. If you solved a problem, share the solution.

## How to Contribute

### Reporting Bugs

Open a GitHub issue with:
- What you were trying to do
- What happened instead
- Your environment (OS, Hermes version, AI model)
- Relevant logs or error messages

### Suggesting Features

Open a GitHub issue with the `enhancement` label:
- What problem does this solve?
- Who else has this problem?
- What's the proposed solution?

### Contributing Code (Skills, Cron Jobs, Scripts)

1. Fork the repo
2. Create a branch: `git checkout -b feature/my-skill`
3. Add your skill/cron/script
4. Update relevant docs
5. Test against your own vault
6. Submit a PR

### Contributing Documentation

Docs live in `docs/`. To fix typos, clarify sections, or add examples:
1. Fork and edit
2. Submit a PR with a clear description of what changed

### Contributing Templates

Templates live in `vault/templates/`. Add new ones for:
- Note types not yet covered (research, podcast notes, etc.)
- Domain-specific templates (legal, medical, engineering)
- Workflow templates (weekly review format, etc.)

## Skill Development Guide

If you're adding a new skill, follow this structure:

```
skills/your-skill-name/
└── SKILL.md   (the only required file)
```

`SKILL.md` must have:

### Frontmatter

```markdown
---
name: your-skill-name
description: One-sentence description of what it does
version: 1.0.0
author: your-github-handle
tags: [relevant, tags]
---
```

### Required Sections

1. **Title and tagline** — what the skill is in one line
2. **When to Invoke** — exact triggers (user commands, auto-cron conditions)
3. **Prerequisites** — what must be true before running
4. **Execution** — numbered phases, each with clear steps
5. **Permission Boundaries** — explicit ✅/❌ list
6. **Adversarial Cases** — how to handle bad input
7. **Cost Estimation** — tokens and USD per run
8. **Related Skills** — links to other skills it composes with

### Quality Standards

- **Specific.** "Classifies notes into folders" not "Helps with organization"
- **Honest.** State limitations in the "What This Skill Does NOT Do" section
- **Safe.** Never edit `schema/` or `sources/`. Never delete notes.
- **Auditable.** Always write reports to `wiki/journal/sync-logs/`
- **Voice-compliant.** Follow `schema/copywriting-standards.md`

### Testing Your Skill

Before submitting:
1. Run against your own vault with sample inputs
2. Verify it doesn't violate permission boundaries
3. Verify it handles edge cases (empty input, malformed input)
4. Verify reports are readable

## Cron Job Development Guide

Cron jobs live in `cron/`. To add a new one:

```json
{
  "name": "my-cron",
  "description": "What this job does",
  "schedule": "0 9 * * 1",
  "timezone": "user-local",
  "skill": "vault-some-skill",
  "prompt": "What the skill should do when this cron fires",
  "delivery": "local",
  "enabled": true,
  "model": "inherit",
  "toolsets": ["file", "terminal", "skills"]
}
```

Cron schedules use standard cron syntax:
- `* * * * *` — every minute
- `0 * * * *` — every hour
- `0 7 * * *` — every day at 7am
- `0 18 * * 0` — every Sunday at 6pm
- `0 9 * * 1-5` — weekdays at 9am

Delivery options:
- `"local"` — save only, no notification
- `"origin"` — deliver to user's connected channel
- `"all"` — fan out to every channel

## Code of Conduct

- **Direct, not dismissive.** We value honest feedback over politeness.
- **Evidence over opinion.** Claims should be backed by usage data or examples.
- **Respect the schema.** Don't propose changes that violate the governance layer.
- **No AI slop.** Don't submit generated content without review.

## Release Process

1. PRs land on `main`
2. Maintainer reviews for: skill quality, permission compliance, voice standards
3. Approved PRs merge
4. Version bumps follow semver:
   - Patch: typo fixes, doc updates
   - Minor: new skills, new cron jobs, backward-compatible features
   - Major: schema changes, breaking skill API changes

## Recognition

Contributors are credited in the README's Contributors section and in release notes.

## Questions?

Open a GitHub Discussion. We respond within a week.

---

*Thank you for contributing to the future of personal knowledge management.*