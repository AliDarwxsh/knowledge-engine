$ErrorActionPreference = "Stop"

$Vault = $env:OBSIDIAN_VAULT
if (-not $Vault) {
    Write-Host "! OBSIDIAN_VAULT is not set." -ForegroundColor Yellow
    exit 1
}

$Skill = "vault-digest"
$Prompt = "Run vault-digest. Read the past week's vault activity. Produce a weekly synthesis: what I learned, what I built, what's still open. Write to 11 Timeline/YYYY-Www-weekly-digest.md. Deliver chat notification with 6-8 line summary."

Write-Host "==> Running weekly-digest..." -ForegroundColor Cyan
& hermes skill run $Skill --prompt $Prompt
exit $LASTEXITCODE