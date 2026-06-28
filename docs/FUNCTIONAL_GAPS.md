# Functional Gaps & Known Limitations

> Honest assessment of what works, what's approximate, and what's still planned.
> Last updated: 2026-06-26 (v1.0.1 hardening pass)

## Verified Functional

| Component | Status | Evidence |
|-----------|--------|----------|
| Bash scripts (`setup.sh`, `verify.sh`) | ✅ | `bash -n` syntax passes; delegate to Python canonical entry points |
| Python scripts (`setup.py`, `verify.py`) | ✅ | `python3 -m py_compile` passes; `--help` works |
| Windows `.cmd` wrappers (`setup.cmd`, `verify.cmd`) | ✅ | Delegate to Python with `py -3` or `python` launcher selection |
| Windows PowerShell cron scripts (`cron/windows/*.ps1`) | ✅ | All 6 files present; `register-cron.ps1` resolves paths correctly |
| Cron JSON definitions (5) | ✅ | All 5 parse as valid JSON |
| Skill YAML frontmatter (10) | ✅ | All have `name`, `description`, `version` |
| Skill cross-references | ✅ | All cron→skill references resolve |
| Cross-platform CI matrix | ✅ | `.github/workflows/test.yml` covers ubuntu/macos/windows |
| Sanitization guard | ✅ | `scripts/sanitize-check.sh` — bash 3.2-compatible; HIGH blocks secrets/PII; --strict warns on template placeholders |
| Placeholder-free public docs | ✅ | No `<user>`, `your-email@example.com`, or `<your-username>` in user-facing files |

## Fixed in v1.0.1

| Issue | Fix |
|-------|-----|
| 15 trailing-slash wikilinks in 7 vault files | Removed trailing `/` from `[[path/to/note/]]` → `[[path/to/note]]` |
| `vault-import` references nonexistent `.ts` files | Changed "Parser" column to "Extraction Strategy" with descriptive text |
| `sanitize-check.sh` referenced in SECURITY.md but missing | Created script — bash 3.2-compatible, two-tier severity (HIGH blocks, LOW warns under `--strict`) |
| Personal info "Ali Darwish" + "makes money" leaked in `architecture.md` | Rewrote to make engine positioning sponsor-link-agnostic |
| `<user>` / `<your-username>` / `your-email@example.com` placeholders | Replaced with `YOUR_GITHUB_USERNAME` template; sanitize-check enforces |
| Duplicate "Adversarial Cases" section in `vault-query/SKILL.md` | Removed second copy |
| Windows docs reference wrong path `scripts\cron\windows\` | Fixed to `cron\windows\` to match actual file location |
| `register-cron.ps1` resolved wrong path | Fixed `RepoRoot` parent traversal + `WindowsCronDir` to `cron\windows` |

## Known Limitations

### 1. Human-Layer Folder Wikilinks (~30 instances)

Files like `Knowledge Archive Home.md` link to human-layer folders as `[[00 Inbox]]`, but no `00 Inbox.md` file exists at vault root — the landing page is `00 Inbox/README.md`. In Obsidian, this works if the user has folder-note plugins enabled, but it's not guaranteed for fresh installs.

**Impact**: Links to human-layer folders may appear as unresolved (gray) links in vanilla Obsidian until the user installs a folder-note plugin or explicitly links to the README files.

**Workaround**: Users should either:
- Enable Obsidian's built-in "Show folder notes" behavior
- Use `[[00 Inbox/README|00 Inbox]]` for explicit linking

### 2. `vault-update-profile` Skill (Planned, Not Built)

Referenced in `vault-init/SKILL.md` (lines 137, 255) and `docs/daily-workflow.md` as a future skill for re-running the profile interview. Currently the docs say "(or just re-run `vault-init`)" as a fallback.

**Impact**: Low. The `vault-init` skill can be re-run to update profiles. A dedicated `vault-update-profile` skill would be more surgical.

### 3. Semantic Search (Keyword-Only, No Embeddings)

`vault-query` uses keyword matching via `search_files`. Vector/semantic search with embeddings is documented as a future enhancement. The CHANGELOG lists this as a known limitation.

**Impact**: Query results may miss conceptually related notes that use different vocabulary. Adequate for vaults under ~500 notes.

### 4. `vault-import` Parsers (LLM-Executed, Not Compiled Code)

The `vault-import` skill describes extraction strategies executed by the LLM at runtime. There are no separate parser code files — the LLM reads the skill instructions and implements extraction inline. This is the standard Hermes pattern.

**Impact**: Extraction quality depends on the LLM model used. Better models = better extraction. Not deterministic.

### 5. Cron Jobs Require Running Hermes Instance

Cron jobs fire only when Hermes is running. On Windows, `register-cron.ps1` registers tasks with Task Scheduler that invoke Hermes on a schedule. There is no standalone scheduler.

**Impact**: Inbox won't be processed during Hermes downtime. Manual `/vault-sync` can catch up.

### 6. No End-to-End Test Suite

The repo has no automated test suite for the actual skills against real vaults. The CI matrix validates scripts parse correctly and JSON is valid, but does not exercise skills end-to-end.

**Impact**: First-time users serve as testers for skill quality. Recommend adding a test vault with known inputs/expected outputs in a future release.

## Recommendation

The repo is **functional for early adopters** who:
- Are comfortable with Obsidian plugin configuration
- Understand Hermes skill execution patterns
- Accept LLM-driven (non-deterministic) extraction quality
- Are willing to report issues as they encounter them

The repo is **not yet production-grade** for non-technical users who expect:
- Zero-config Obsidian linking
- Deterministic import results
- Guaranteed uptime without Hermes running

## v1.0.1 Audit Trail

The following files were reviewed and updated in the v1.0.1 hardening pass:

- `README.md` — placeholder cleanup
- `SECURITY.md` — removed personal email placeholder
- `docs/architecture.md` — removed personal-monetization section
- `scripts/setup.sh` — wrapper docstring updated
- `scripts/setup.py` — placeholder cleanup, kept cross-platform Python entry point
- `scripts/sanitize-check.sh` — **new file**, added as referenced by SECURITY.md
- `skills/vault-query/SKILL.md` — removed duplicate section
- `cron/windows/register-cron.ps1` — path resolution fixed
- `docs/installation-windows.md` — path references corrected
- `CONTRIBUTING.md` — path references corrected