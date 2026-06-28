$ErrorActionPreference = "Stop"

$Vault = $env:OBSIDIAN_VAULT
if (-not $Vault) {
    Write-Host "! OBSIDIAN_VAULT is not set." -ForegroundColor Yellow
    exit 1
}

$Skill = "vault-lint"
$Prompt = "Run vault-lint. Scan the vault for broken wikilinks, orphan notes, schema violations, and missing tags. Write a report to 13 Meta Analysis/YYYY-MM-DD-lint-report.md. Summary to stdout."

Write-Host "==> Running nightly-lint..." -ForegroundColor Cyan
& hermes skill run $Skill --prompt $Prompt
exit $LASTEXITCODE