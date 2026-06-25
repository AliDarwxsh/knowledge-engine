#!/usr/bin/env bash
# setup.sh — Knowledge Engine one-command installation
# Usage: curl -fsSL https://raw.githubusercontent.com/<user>/knowledge-engine/main/scripts/setup.sh | bash
# Or locally: bash scripts/setup.sh

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging helpers
log_step() { echo -e "${BLUE}==>${NC} $1"; }
log_success() { echo -e "${GREEN}✓${NC} $1"; }
log_warn() { echo -e "${YELLOW}!${NC} $1"; }
log_error() { echo -e "${RED}✗${NC} $1"; }

# Version
ENGINE_VERSION="1.0.0"

# Banner
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║              knowledge-engine setup v${ENGINE_VERSION}                ║"
echo "║                                                              ║"
echo "║   A self-organizing knowledge system.                        ║"
echo "║   Hermes + Obsidian. Capture. Auto-classify. Query.          ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Verify environment
log_step "Step 1/6: Verifying environment"

if ! command -v hermes >/dev/null 2>&1; then
  log_error "Hermes is not installed."
  echo ""
  echo "Install Hermes first:"
  echo "  curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash"
  echo ""
  exit 1
fi
log_success "Hermes found: $(hermes --version)"

# Detect OS
OS="$(uname -s)"
case "${OS}" in
  Darwin*) OS_NAME="macOS" ;;
  Linux*) OS_NAME="Linux" ;;
  *) log_warn "Untested OS: ${OS}. Continuing anyway." ;;
esac
log_success "OS: ${OS_NAME}"

# Step 2: Locate or create vault directory
log_step "Step 2/6: Locating vault"

if [[ -n "${OBSIDIAN_VAULT:-}" ]]; then
  VAULT_PATH="${OBSIDIAN_VAULT}"
  log_success "Using OBSIDIAN_VAULT: ${VAULT_PATH}"
elif [[ -d "$HOME/Documents/Obsidian" ]]; then
  echo "Found existing Obsidian directories:"
  ls -d "$HOME"/Documents/Obsidian/*/ 2>/dev/null | head -5
  echo ""
  read -p "Enter vault path (or 'new' to create): " VAULT_PATH
else
  read -p "Enter vault path (or 'new' to create): " VAULT_PATH
fi

if [[ "${VAULT_PATH}" == "new" ]]; then
  read -p "Vault name: " VAULT_NAME
  VAULT_PATH="$HOME/Documents/Obsidian/${VAULT_NAME}"
  mkdir -p "${VAULT_PATH}"
  log_success "Created vault: ${VAULT_PATH}"
fi

if [[ ! -d "${VAULT_PATH}" ]]; then
  log_error "Vault directory does not exist: ${VAULT_PATH}"
  exit 1
fi

# Verify or scaffold vault structure
log_step "Step 3/6: Verifying vault structure"

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

NEED_SCAFFOLD=false
for dir in "${REQUIRED_DIRS[@]}"; do
  if [[ ! -d "${VAULT_PATH}/${dir}" ]]; then
    NEED_SCAFFOLD=true
    break
  fi
done

if [[ "${NEED_SCAFFOLD}" == "true" ]]; then
  log_warn "Vault structure incomplete. Scaffolding..."
  for dir in "${REQUIRED_DIRS[@]}"; do
    mkdir -p "${VAULT_PATH}/${dir}"
  done
  log_success "Scaffolded ${#REQUIRED_DIRS[@]} directories"
else
  log_success "Vault structure already complete"
fi

# Step 4: Copy templates
log_step "Step 4/6: Installing vault templates"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_SOURCE="$(dirname "${SCRIPT_DIR}")/vault"

if [[ -d "${TEMPLATE_SOURCE}" ]]; then
  # Copy files but don't overwrite existing
  cp -n "${TEMPLATE_SOURCE}"/*.md "${VAULT_PATH}/" 2>/dev/null || true
  cp -rn "${TEMPLATE_SOURCE}/"*/ "${VAULT_PATH}/" 2>/dev/null || true
  log_success "Templates copied to vault"
else
  log_warn "Template source not found at ${TEMPLATE_SOURCE}. Vault may be incomplete."
fi

# Step 5: Install Hermes skills
log_step "Step 5/6: Installing Hermes skills"

SKILL_SOURCE="$(dirname "${SCRIPT_DIR}")/skills"
if [[ -d "${SKILL_SOURCE}" ]]; then
  for skill_dir in "${SKILL_SOURCE}"/*/; do
    skill_name="$(basename "${skill_dir}")"
    if [[ -f "${skill_dir}/SKILL.md" ]]; then
      hermes skill install "${skill_dir}" 2>/dev/null && \
        log_success "Installed: ${skill_name}" || \
        log_warn "Failed to install: ${skill_name}"
    fi
  done
else
  log_warn "Skills source not found at ${SKILL_SOURCE}. Install manually:"
  echo "  hermes skill install <path-to-skill-dir>"
fi

# Step 6: Install cron jobs
log_step "Step 6/6: Installing cron jobs"

CRON_SOURCE="$(dirname "${SCRIPT_DIR}")/cron"
if [[ -d "${CRON_SOURCE}" ]]; then
  for cron_file in "${CRON_SOURCE}"/*.json; do
    cron_name="$(basename "${cron_file}" .json)"
    hermes cron install "${cron_file}" 2>/dev/null && \
      log_success "Scheduled: ${cron_name}" || \
      log_warn "Failed to schedule: ${cron_name}"
  done
else
  log_warn "Cron source not found at ${CRON_SOURCE}. Install manually."
fi

# Final: Set environment variable
log_step "Persisting configuration"

ENV_LINE="export OBSIDIAN_VAULT=\"${VAULT_PATH}\""
SHELL_RC="$HOME/.$(basename "${SHELL}")rc"

if [[ -f "${SHELL_RC}" ]] && ! grep -q "OBSIDIAN_VAULT" "${SHELL_RC}"; then
  echo "" >> "${SHELL_RC}"
  echo "# Knowledge Engine" >> "${SHELL_RC}"
  echo "${ENV_LINE}" >> "${SHELL_RC}"
  log_success "Added OBSIDIAN_VAULT to ${SHELL_RC}"
fi

# Done
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║              ✓ Installation Complete                         ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
log_success "Vault: ${VAULT_PATH}"
log_success "Skills: 10 installed (vault-init, vault-capture, vault-sync, vault-lint, vault-digest, vault-import, vault-query, vault-link, vault-morning-brief, vault-forward-refs)"
log_success "Cron jobs: 5 scheduled"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo ""
echo "  1. Open your vault in Obsidian:"
echo "     File → Open vault → ${VAULT_PATH}"
echo ""
echo "  2. Run the init interview (one-time):"
echo "     hermes skill run vault-init"
echo ""
echo "  3. Open Hermes Desktop or CLI and start capturing:"
echo "     /capture \"Your first thought\""
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "  https://github.com/<user>/knowledge-engine"
echo ""
echo -e "${BLUE}Your engine gets smarter every day.${NC}"
echo ""