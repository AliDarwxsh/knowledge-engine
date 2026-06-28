# Security Policy

This is a local-first tool. Your vault never leaves your machine unless you push it. The single largest risk in this project is not a code exploit — it is a contributor accidentally committing personal vault data to a public repo.

## Supported versions

Security fixes land on the latest minor release. Older lines do not receive backports.

| Version | Supported |
| ------- | --------- |
| 1.x     | Yes       |
| < 1.0   | No        |

## Report a vulnerability privately

Do not open a public issue for a security problem. Public issues are visible to everyone before a fix ships.

Use one of these private channels:

- **GitHub private advisory** (preferred) — open a draft advisory at `https://github.com/YOUR_GITHUB_USERNAME/knowledge-engine/security/advisories/new`. This keeps the report private until you and the maintainers agree to publish.
- **Email** — `security@example.com`. Use the subject line `SECURITY: <short summary>`.

Include in your report:

- What the vulnerability is and the impact you observed.
- Exact steps to reproduce, with a minimal vault or command sequence.
- The version, OS, and AI provider you ran.
- Any logs or output — with personal data redacted first.

> [!warning]
> Strip every real name, path, email, and vault excerpt from your report before you send it. A vulnerability report is the easiest place to leak the exact data this project tells users to protect.

## Response-time expectations

| Stage | Target |
| ----- | ------ |
| Acknowledge receipt | 3 business days |
| Initial assessment (severity, scope) | 10 business days |
| Fix or mitigation for confirmed high-severity issues | 30 days |
| Public disclosure | After a fix ships, coordinated with the reporter |

These are targets for a volunteer-maintained project, not a contractual SLA. If you do not hear back within the acknowledgement window, send a follow-up email.

## Scope — the real attack surface

This project reads and writes plain Markdown files and calls an AI provider with your own key. There is no server, no database, and no telemetry. That shapes what counts as a vulnerability.

**In scope:**

- A skill or script that writes outside the vault directory.
- A skill that sends vault content to a network endpoint other than the AI provider you configured.
- A path-traversal or injection flaw in `vault-import` or any script that reads untrusted files.
- A `.gitignore` or sanitization gap that lets personal vault data reach a commit.
- Credential or API-key handling that writes a key to a tracked file.

**Out of scope:**

- Vulnerabilities in your AI provider's service. Report those to the provider.
- Issues that require an attacker to already have write access to your local filesystem.
- Personal data you chose to commit after disabling the guardrails below.

## The data-leak guardrails

Two mechanisms keep personal vault data out of commits. Run both before you push, and report any gap in either as a security issue.

- **`scripts/sanitize-check.sh`** — scans staged and tracked files for real-looking names, emails, absolute home paths, and vault excerpts. Run it before every commit. A non-zero exit means something personal is about to ship.
- **`.gitignore` rules** — the vault content directories are ignored by default so a `git add .` cannot stage your notes. If you find a path that should be ignored but is not, that is a security gap — report it.

> [!important]
> If `sanitize-check.sh` passes but you still spot personal data in a diff, treat that as a high-severity finding and report it privately. A bypass of the sanitization guardrail is the most damaging bug this project can have.

## Branch protection (maintainers)

If you fork this repo and maintain it with collaborators, enable these settings on `main`:

- **Require pull request reviews** — at least 1 approval before merge.
- **Require status checks** — `sanitize-check` and `pytest` must pass.
- **Restrict push** — only allow merges via PR, no direct push.
- **Require signed commits** — GPG or SSH signature verification.
- **Dependabot alerts** — enable in Settings → Security → Code security.

## Dependency security

This project has zero runtime dependencies. The only Python packages used are from the standard library (`json`, `os`, `sys`, `subprocess`, `pathlib`, `argparse`). No `requirements.txt`, no `package.json`, no supply-chain attack surface from third-party packages.

If you install optional dev tools (pytest, mypy, ruff), keep them updated:

```bash
# Check for known CVEs in your local environment
pip-audit --local
# or
uv pip list | pip-audit --requirement /dev/stdin
```

## GitHub Actions security

CI workflows in `.github/workflows/` follow these hardening practices:

- **Pin actions to commit SHA** — not floating tags. Prevents supply-chain attacks if an action is compromised.
- **Least-privilege `GITHUB_TOKEN`** — workflows use `permissions: contents: read` only, no write access.
- **No secrets in workflow files** — all API keys come from GitHub Secrets, never hardcoded.
- **No `pull_request_target` on untrusted PRs** — prevents exfiltration of secrets from fork PRs.

## PGP key for encrypted reports (optional)

If you prefer to encrypt your vulnerability report, use this PGP key. Fingerprint: `TBD — request via email if needed.`

## Security changelog

| Date | Finding | Severity | Fix |
|------|---------|----------|-----|
| 2026-06-26 | `ghp_` token exposed in `.git/config` working tree | High | Removed token, reset remote URL, added `sanitize-check.sh` |
| 2026-06-26 | Personal name in `README.md` and `docs/architecture.md` | Medium | Redacted to community attribution |
| 2026-06-26 | `<user>` placeholder in setup scripts | Low | Replaced with `YOUR_GITHUB_USERNAME` |
| 2026-06-29 | `.gitignore` missing coverage/secret patterns | Low | Added `.coverage`, `*.pem`, `*.key`, `.tox/` |
