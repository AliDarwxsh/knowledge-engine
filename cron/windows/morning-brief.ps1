# cron/windows/ — Windows Task Scheduler equivalents for the cron/*.json jobs
#
# Each .ps1 script mirrors a cron/*.json file. They do the same thing the
# Unix `hermes cron create` does, but invoke Hermes directly on a schedule
# managed by Windows Task Scheduler.
#
# Install with the bundled register-cron.ps1 helper:
#
#     powershell -ExecutionPolicy Bypass -File cron\windows\register-cron.ps1
#
# Or register them manually via Task Scheduler UI — see docs/installation-windows.md.

$ErrorActionPreference = "Stop"

# Resolve vault from env (set by setup.py via [Environment]::SetEnvironmentVariable)
$Vault = $env:OBSIDIAN_VAULT
if (-not $Vault) {
    Write-Host "! OBSIDIAN_VAULT is not set. Re-run scripts\setup.cmd." -ForegroundColor Yellow
    exit 1
}

# Find Hermes — prefer the Windows shim, fall back to PATH
$HermesCmd = Get-Command hermes -ErrorAction SilentlyContinue
if (-not $HermesCmd) {
    Write-Host "! hermes CLI not found on PATH." -ForegroundColor Yellow
    exit 1
}

# Skill for this job (matches the .json file of the same name)
$Skill = "vault-morning-brief"

# Prompt (matches the .json file's `prompt` field)
$Prompt = "Run vault-morning-brief. Read yesterday's vault activity. Generate the morning brief and write to 11 Timeline/YYYY-MM-DD-morning-brief.md. Deliver chat notification with 4-6 line summary."

Write-Host "==> Running morning-brief (one-shot)..." -ForegroundColor Cyan
& hermes skill run $Skill --prompt $Prompt
exit $LASTEXITCODE