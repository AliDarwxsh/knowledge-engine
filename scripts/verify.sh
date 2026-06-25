#!/usr/bin/env bash
# verify.sh — Check that the knowledge-engine is properly installed and functional
# Usage: bash scripts/verify.sh

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_step() { echo -e "${BLUE}==>${NC} $1"; }
log_ok() { echo -e "${GREEN}✓${NC} $1"; }
log_warn() { echo -e "${YELLOW}!${NC} $1"; }
log_fail() { echo -e "${RED}✗${NC} $1"; }

PASS=0
FAIL=0
WARN=0

check() {
  local description="$1"
  local test_command="$2"
  
  if eval "${test_command}" >/dev/null 2>&1; then
    log_ok "${description}"
    PASS=$((PASS + 1))
    return 0
  else
    log_fail "${description}"
    FAIL=$((FAIL + 1))
    return 1
  fi
}

warn() {
  local description="$1"
  log_warn "${description}"
  WARN=$((WARN + 1))
}

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║          knowledge-engine — Installation Verification         ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Check 1: Hermes installation
log_step "Hermes installation"
check "Hermes is installed" "command -v hermes"
check "Hermes responds to --version" "hermes --version"

# Check 2: Vault path
log_step "Vault configuration"
if [[ -n "${OBSIDIAN_VAULT:-}" ]]; then
  log_ok "OBSIDIAN_VAULT is set: ${OBSIDIAN_VAULT}"
  PASS=$((PASS + 1))
else
  log_fail "OBSIDIAN_VAULT is not set"
  FAIL=$((FAIL + 1))
fi

VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/Documents/Obsidian/MainVault}"

# Check 3: Vault structure
log_step "Vault structure"

REQUIRED_DIRS=(
  "00 Inbox"
  "01 Identity"
  "02 Principles"
  "03 Projects"
  "04 Knowledge Library"
  "05 Framework Library"
  "06 Decision Archive"
  "07 Systems & SOPs"
  "08 Prompt Library"
  "09 Research Archive"
  "10 Ideas & Opportunities"
  "11 Timeline"
  "12 Relationship Maps"
  "13 Meta Analysis"
  "wiki"
  "sources"
  "schema"
  "workflows"
  "templates"
)

for dir in "${REQUIRED_DIRS[@]}"; do
  check "Directory exists: ${dir}" "[[ -d '${VAULT_PATH}/${dir}' ]]"
done

# Check 4: Critical files
log_step "Critical vault files"

CRITICAL_FILES=(
  "README.md"
  "Knowledge Archive Home.md"
  "CLAUDE.md"
  "schema/CLAUDE.md"
  "schema/ontology.md"
  "schema/agents.md"
  "schema/copywriting-standards.md"
  "workflows/inbox-triage.md"
  "workflows/daily-rhythm.md"
  "templates/daily-note.md"
  "templates/evergreen-note.md"
)

for file in "${CRITICAL_FILES[@]}"; do
  check "File exists: ${file}" "[[ -f '${VAULT_PATH}/${file}' ]]"
done

# Check 5: Hermes skills
log_step "Hermes skills"

EXPECTED_SKILLS=(
  "vault-init"
  "vault-capture"
  "vault-sync"
  "vault-lint"
  "vault-digest"
  "vault-import"
  "vault-query"
  "vault-link"
  "vault-morning-brief"
  "vault-forward-refs"
)

for skill in "${EXPECTED_SKILLS[@]}"; do
  check "Skill installed: ${skill}" "hermes skill list | grep -q '${skill}'"
done

# Check 6: Cron jobs
log_step "Cron jobs"

EXPECTED_CRON=(
  "morning-brief"
  "inbox-processor"
  "connection-finder"
  "nightly-lint"
  "weekly-digest"
)

for cron in "${EXPECTED_CRON[@]}"; do
  check "Cron scheduled: ${cron}" "hermes cron list | grep -q '${cron}'"
done

# Check 7: AI model configuration
log_step "AI model configuration"

if [[ -n "${OPENAI_API_KEY:-}" ]] || [[ -n "${ANTHROPIC_API_KEY:-}" ]] || [[ -n "${OPENROUTER_API_KEY:-}" ]]; then
  log_ok "At least one AI provider API key is configured"
  PASS=$((PASS + 1))
else
  log_warn "No AI provider API key found in environment"
  WARN=$((WARN + 1))
  echo "    Set OPENAI_API_KEY, ANTHROPIC_API_KEY, or OPENROUTER_API_KEY"
fi

# Check 8: Vault health (if linter is available)
log_step "Vault health (optional)"

if command -v hermes >/dev/null 2>&1 && hermes skill list | grep -q "vault-lint"; then
  warn "Run /vault-lint for detailed health scorecard"
fi

# Summary
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                      Verification Summary                     ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo -e "  ${GREEN}Passed:${NC}   ${PASS}"
echo -e "  ${YELLOW}Warnings:${NC} ${WARN}"
echo -e "  ${RED}Failed:${NC}   ${FAIL}"
echo ""

if [[ ${FAIL} -eq 0 ]]; then
  echo -e "${GREEN}✓ Knowledge Engine is properly installed and ready.${NC}"
  echo ""
  echo "Next steps:"
  echo "  1. Run: hermes skill run vault-init (one-time setup interview)"
  echo "  2. Open Obsidian at: ${VAULT_PATH}"
  echo "  3. Start capturing: /capture \"your first thought\""
  exit 0
else
  echo -e "${RED}✗ Some checks failed. Run scripts/setup.sh to fix.${NC}"
  exit 1
fi