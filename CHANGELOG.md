# Changelog

All notable changes to knowledge-engine will be documented in this file.

## [1.1.1] — 2026-06-26

### Added
- **`scripts/sanitize-check.sh`** — pre-commit guard for personal data leaks in public repo. Bash 3.2-compatible (works on macOS default shell). Two-tier severity: HIGH patterns (secrets, absolute paths) always block; LOW patterns (template placeholders) warn under `--strict`. Referenced from `SECURITY.md` as the second layer of personal-data guardrails.
- **`.gitignore`** now blocks `.DS_Store` files from being tracked (was already ignored but stray files existed in working tree).

### Fixed
- **Personal info leak** — removed "Ali Darwish" attribution + "makes money from" monetization paragraph from `docs/architecture.md`. Rewrote to position engine as free, open-source, with optional GitHub Sponsor link.
- **Personal info leak** — removed "Built by Ali Darwish" from `README.md` footer; replaced with community attribution.
- **Placeholder leaks** — replaced `<user>` with `YOUR_GITHUB_USERNAME` in `README.md` (4 places), `scripts/setup.py` (2 places), `docs/installation-windows.md`. Updated `setup.sh` comment to drop curl-pipe example that referenced the placeholder.
- **SECURITY.md placeholder** — replaced `your-email@example.com` with reference to GitHub repo "Support" section. Updated GitHub advisory URL placeholder from `OWNER` to `<repo-owner>`.
- **Duplicate section** — removed second "Adversarial Cases" block in `skills/vault-query/SKILL.md` (was identical to the first).
- **Windows path bug** — `cron/windows/register-cron.ps1` was looking for scripts under `scripts\cron\windows\` but they live under `cron\windows\`. Fixed `RepoRoot` parent traversal (was `..\..\..\`, now `..\..`) and updated path string. Updated docs/README/CONTRIBUTING that referenced the wrong path.

### Changed
- `sanitize-check.sh` placeholder patterns moved from HIGH (block) to LOW (warn) severity — template placeholders in a public template repo are legitimate content, not a leak. They still appear under `--strict` for review.
- `docs/FUNCTIONAL_GAPS.md` updated to reflect v1.1.1 state (cross-platform verified, placeholder-free, sanitize-check shipped).

## [1.1.0] — 2026-06-26

### Added
- **Windows support**: native Windows install path (no WSL/Git Bash required)
  - `scripts/setup.py` / `verify.py` — cross-platform Python canonical scripts (Python 3.8+)
  - `scripts/setup.cmd` / `verify.cmd` — Windows entry points that detect `py` / `python` / `python3`
  - `scripts/setup.sh` / `verify.sh` — now thin wrappers that delegate to Python
  - `cron/windows/*.ps1` — PowerShell equivalents for all five cron jobs
  - `cron/windows/register-cron.ps1` — registers the jobs with Windows Task Scheduler (8 tasks; inbox-processor fires at 00/06/12/18 to preserve the 6-hour cadence)
  - `docs/installation-windows.md` — full Windows install walkthrough + troubleshooting
- **Cross-platform CI matrix** — `.github/workflows/test.yml` runs on `ubuntu-latest`, `macos-latest`, and `windows-latest`. Every PR to `main` is tested on all three.

### Changed
- `setup.sh` / `verify.sh` rewritten as thin bash wrappers (delegate to Python). Behavior unchanged for existing curl-pipe installs.
- README "Quick Start" now shows both macOS/Linux and Windows paths.
- CONTRIBUTING.md cross-platform requirement: changes to `scripts/` must work on all three OSes; CI will block otherwise.

## [1.0.0] — 2026-06-26

### Added
- **Dual-layer Obsidian vault template**: Human Layer (00-13) + Machine Layer (wiki/sources/schema) with 50+ pre-built files
- **10 Hermes skills**: vault-init, vault-capture, vault-sync, vault-lint, vault-digest, vault-import, vault-query, vault-link, vault-morning-brief, vault-forward-refs
- **5 cron jobs**: morning-brief (7am), inbox-processor (every 6h), connection-finder (3am), nightly-lint (2am), weekly-digest (Sun 6pm)
- **setup.sh**: One-command installation script with color output and error handling
- **verify.sh**: Installation verification script with 8 check categories
- **Documentation**: architecture.md, daily-workflow.md, ai-models.md, customization.md, getting-started.md, faq.md, FUNCTIONAL_GAPS.md
- **Governance schema**: CLAUDE.md (3-layer rules), agents.md (permission boundaries), ontology.md (tag taxonomy), terminology.md, copywriting-standards.md (8 voice rules)
- **Workflow docs**: inbox-triage.md, daily-rhythm.md, forward-references.md, maintenance-protocol.md
- **Templates**: daily-note, evergreen-note, principle-note, project-note, literature-note, meeting-note
- **AI chat import pipeline**: vault-import skill supporting ChatGPT, Claude, Gemini, and generic formats
- **Forward reference system**: Gray-link philosophy and weekly triage workflow
- **Permission model**: Conservative/Moderate/Aggressive autonomy levels
- **Cost transparency**: Per-operation token estimates in every skill
- MIT License
- Community contributing guide
- `.gitignore` for public repo safety

### Fixed (pre-release review)
- Trailing-slash wikilinks in 7 vault files — removed, all links now resolve correctly
- vault-import parser column — changed from non-existent `.ts` file references to descriptive extraction strategies
- setup.sh CLI commands — updated to use correct Hermes CLI (`hermes skills install`, `hermes cron create`)
- verify.sh CLI commands — updated to use correct Hermes CLI with timeouts

### Design Decisions
- Hermes as automation engine (not custom CLI) — leveraging existing scheduling, memory, model routing
- Dual-layer architecture (human + machine) inspired by Karpathy's LLM Wiki pattern
- User-owned AI keys — engine never holds credits
- Local-first, offline-capable with Ollama support
- Skills as markdown files — forkable, editable without build steps
- Permission boundaries enforced per-skill (never touch schema/ or sources/)

### Known Limitations
- Vault-import supports text-based chat exports (JSON/markdown/txt); extraction is LLM-executed (non-deterministic)
- Semantic search uses keyword matching; vector embeddings are a future enhancement
- Cron jobs require Hermes running; no standalone scheduler
- Human-layer folder wikilinks require folder-note plugin in vanilla Obsidian
- `vault-update-profile` skill planned but not yet built (fallback: re-run vault-init)

---

*Versioning follows SemVer. See CONTRIBUTING.md for release process.*