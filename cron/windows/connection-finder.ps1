$ErrorActionPreference = "Stop"

$Vault = $env:OBSIDIAN_VAULT
if (-not $Vault) {
    Write-Host "! OBSIDIAN_VAULT is not set." -ForegroundColor Yellow
    exit 1
}

$Skill = "vault-link"
$Prompt = "Run vault-link. Scan the vault for unlinked notes that have semantic overlap with existing notes. Propose new [[wikilinks]] for orphaned content. Do not modify user-authored notes without logging the suggestion."

Write-Host "==> Running connection-finder..." -ForegroundColor Cyan
& hermes skill run $Skill --prompt $Prompt
exit $LASTEXITCODE