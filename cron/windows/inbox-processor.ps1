$ErrorActionPreference = "Stop"

$Vault = $env:OBSIDIAN_VAULT
if (-not $Vault) {
    Write-Host "! OBSIDIAN_VAULT is not set." -ForegroundColor Yellow
    exit 1
}

$Skill = "vault-sync"
$Prompt = "Run vault-sync. Process all items in 00 Inbox/ — classify each note, tag it, link it to related notes in the vault, then move to the correct folder. Report a count of items processed."

Write-Host "==> Running inbox-processor..." -ForegroundColor Cyan
& hermes skill run $Skill --prompt $Prompt
exit $LASTEXITCODE