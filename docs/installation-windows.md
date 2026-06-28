# Installing Knowledge Engine on Windows

Knowledge Engine runs natively on Windows 10/11. This guide walks you through the install, then the optional Windows-specific extras (Task Scheduler registration).

> **Already on macOS/Linux?** Use [`docs/getting-started.md`](getting-started.md) instead — it's simpler.

---

## Prerequisites

| Requirement | How to install | Verify |
|---|---|---|
| **Windows 10/11** (64-bit) | — | `winver` |
| **Python 3.8+** | Download from [python.org](https://www.python.org/downloads/windows/). **Tick "Add python.exe to PATH"** during install. | `python --version` |
| **Git** (optional, for cloning) | [git-scm.com](https://git-scm.com/download/win) | `git --version` |
| **Obsidian** (the UI) | [obsidian.md](https://obsidian.md/) | Open Obsidian → see your vault |
| **Hermes Agent** | `irm https://hermes-agent.nousresearch.com/install.ps1 \| iex` | `hermes --version` |

You do **not** need WSL, Git Bash, or any Linux subsystem. Everything in this repo is native Windows.

---

## 1. Clone the repo

```powershell
git clone https://github.com/Alidarwxsh/knowledge-engine.git
cd knowledge-engine
```

Or download the ZIP from GitHub and extract it anywhere.

---

## 2. Run setup

From the repo root in PowerShell or Command Prompt:

```powershell
scripts\setup.cmd
```

The installer will:

1. Verify Hermes is installed.
2. Prompt for your vault path (or accept the `OBSIDIAN_VAULT` env var).
3. Scaffold the dual-layer vault (00-13 + wiki/sources/schema).
4. Copy templates into the vault.
5. Install the 10 Hermes skills into `~/.hermes/skills/`.
6. Set `OBSIDIAN_VAULT` permanently for your user account.

**Non-interactive install** (e.g. for CI):

```powershell
scripts\setup.cmd --vault "C:\Users\you\Documents\Obsidian\MainVault"
```

**Skip cron registration** (Task Scheduler steps are documented below):

```powershell
scripts\setup.cmd --skip-cron
```

---

## 3. Verify

```powershell
scripts\verify.cmd
```

Should report green checks for: Hermes, vault structure, 11 critical files, all 10 skills.

---

## 4. (Optional) Register scheduled jobs

The repo includes both:
- `cron/*.json` — the canonical schedules (for macOS/Linux + Hermes's `hermes cron create`)
- `cron/windows/*.ps1` — PowerShell wrappers that do the same thing on Windows

### Register them with Windows Task Scheduler

```powershell
powershell -ExecutionPolicy Bypass -File cron\windows\register-cron.ps1
```

This creates six tasks under Task Scheduler (one per cron job, plus 4 daily runs of `inbox-processor` to preserve the "every 6 hours" cadence):

| Task name | When | What |
|---|---|---|
| `ke-morning-brief` | Daily 07:00 | Generate today's morning brief |
| `ke-inbox-processor-0000` | Daily 00:00 | Process inbox |
| `ke-inbox-processor-0600` | Daily 06:00 | Process inbox |
| `ke-inbox-processor-1200` | Daily 12:00 | Process inbox |
| `ke-inbox-processor-1800` | Daily 18:00 | Process inbox |
| `ke-connection-finder` | Daily 03:00 | Propose new vault links |
| `ke-nightly-lint` | Daily 02:00 | Vault health check |
| `ke-weekly-digest` | Sundays 18:00 | Weekly synthesis |

### Verify they're scheduled

```powershell
schtasks /Query /FO TABLE | findstr ke-
```

### Remove them

```powershell
powershell -ExecutionPolicy Bypass -File cron\windows\register-cron.ps1 -Unregister
```

---

## 5. Open your vault in Obsidian

1. Launch Obsidian.
2. **Open vault as folder** → select the path you gave `setup.cmd`.
3. Confirm you see the 00–13 folders in the sidebar.

---

## 6. Run the onboarding interview

In any Hermes session:

```
/vault-init
```

This walks you through naming the vault, setting up identity, and tuning the auto-classifier. Once it's done, your engine is alive.

---

## Troubleshooting

### "Python is not installed" from `setup.cmd`

Reinstall Python from [python.org](https://www.python.org/downloads/windows/) and make sure "Add python.exe to PATH" is checked. Open a new PowerShell window after install.

### "hermes is not installed"

Install Hermes:
```powershell
irm https://hermes-agent.nousresearch.com/install.ps1 | iex
```
Then close and reopen PowerShell so the new PATH entries take effect.

### PowerShell refuses to run scripts (`running scripts is disabled`)

Run once per user to allow local scripts:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Or invoke each script with `-ExecutionPolicy Bypass` as shown above.

### Colors look garbled in Windows Terminal

Windows Terminal and PowerShell 7 render ANSI colors correctly. If you're using `cmd.exe`, switch to Windows Terminal (free from the Microsoft Store) or PowerShell 7.

### Vault path has spaces

Wrap it in quotes everywhere:
```powershell
scripts\setup.cmd --vault "C:\Users\Jane Doe\Documents\Obsidian\MainVault"
$env:OBSIDIAN_VAULT = "C:\Users\Jane Doe\Documents\Obsidian\MainVault"
```

### Want to use WSL or Git Bash instead?

Both work — the `.sh` scripts delegate to Python, which runs fine in WSL and Git Bash. See [`docs/getting-started.md`](getting-started.md) and skip this guide.

---

## Where things live on Windows

| Item | Location |
|---|---|
| Your vault | `%USERPROFILE%\Documents\Obsidian\<vault-name>\` (or wherever you chose) |
| Hermes skills | `%USERPROFILE%\.hermes\profiles\default\skills\` |
| Cron JSON (canonical) | `<repo>\cron\*.json` |
| Cron PowerShell wrappers | `<repo>\cron\windows\*.ps1` |
| Python entry points | `<repo>\scripts\setup.py`, `verify.py` |
| Bash wrappers (for WSL/Git Bash) | `<repo>\scripts\setup.sh`, `verify.sh` |
| Windows entry points | `<repo>\scripts\setup.cmd`, `verify.cmd` |