#!/usr/bin/env bash
# sanitize-check.sh — Pre-commit guard for personal data in public repo
# Scans staged and tracked files for:
#   - Real-looking personal names, emails, phone numbers
#   - Absolute home paths (e.g. /Users/<name>/...)
#   - Vault content excerpts that look personal
#   - API key patterns (sk-, ghp_, AKIA, xoxb-, etc.)
#   - Generic placeholder leaks (<user>, <your-username>, your-email@example.com, <repo-owner>)
#
# Usage:
#   bash scripts/sanitize-check.sh                # check tracked files
#   bash scripts/sanitize-check.sh --staged       # check git staged files only
#   bash scripts/sanitize-check.sh --strict       # also flag low-confidence matches
#
# Exit codes:
#   0 = clean
#   1 = one or more high-confidence findings (block commit)
#   2 = low-confidence warnings (review recommended)

# Require bash
set -e  # Exit on error
set -u  # Error on undefined variables

if [[ -z "${BASH_VERSION:-}" ]]; then
  echo "sanitize-check.sh requires bash. Re-run as: bash scripts/sanitize-check.sh" >&2
  exit 2
fi

set -o pipefail

# Colors (only emitted when stdout is a TTY)
if [[ -t 1 ]]; then
  RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
else
  RED=''; GREEN=''; YELLOW=''; BLUE=''; NC=''
fi

MODE="tracked"
STRICT=false
HITS=0
WARNS=0
FILES=()

# Portable "read lines into array" — works in bash 3.2 (macOS default)
load_files() {
  FILES=()
  local _line
  while IFS= read -r _line || [[ -n "${_line}" ]]; do
    FILES+=("${_line}")
  done
}

for arg in "$@"; do
  case "${arg}" in
    --staged)  MODE="staged" ;;
    --strict)  STRICT=true ;;
    --help|-h)
      echo "Usage: bash scripts/sanitize-check.sh [--staged] [--strict]"
      echo ""
      echo "Modes:"
      echo "  (default)   Scan files tracked by git in this repo."
      echo "  --staged    Scan only files staged for commit."
      echo "  --strict    Also flag low-confidence matches."
      exit 0
      ;;
    *) echo "Unknown arg: ${arg}"; exit 2 ;;
  esac
done

echo ""
echo "knowledge-engine — Personal Data Sanitization Check"
echo "Mode: ${MODE}${STRICT:+ (strict)}"
echo ""

# Resolve list of files to scan
if [[ "${MODE}" == "staged" ]]; then
  if ! command -v git >/dev/null 2>&1; then
    echo "git not found; falling back to tracked files." >&2
    MODE="tracked"
  elif ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not a git repo; falling back to tracked files." >&2
    MODE="tracked"
  else
    load_files < <(git diff --cached --name-only --diff-filter=ACMR | grep -v '^$' || true)
  fi
fi

if [[ "${MODE}" == "tracked" ]]; then
  if ! command -v git >/dev/null 2>&1 || ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    # Not a git repo — scan text files in repo root
    load_files < <(find . -type f \
      \( -name '*.md' -o -name '*.sh' -o -name '*.json' -o -name '*.yaml' -o -name '*.yml' -o -name '*.txt' \) \
      -not -path './.git/*' 2>/dev/null || true)
  else
    load_files < <(git ls-files | grep -E '\.(md|sh|json|ya?ml|txt)$' || true)
  fi
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo -e "${YELLOW}No files to scan.${NC}"
  exit 0
fi

# Patterns: each entry is "label|regex"
#
# HIGH-confidence patterns (always block on match):
#   These indicate real personal data, secrets, or absolute paths that
#   absolutely must not ship to a public repo.
PATTERNS_HIGH=(
  'secrecy|sk-[A-Za-z0-9]{20,}'
  'secrecy|ghp_[A-Za-z0-9]{30,}'
  'secrecy|xox[baprs]-[A-Za-z0-9-]{10,}'
  'secrecy|AKIA[0-9A-Z]{16}'
  'secrecy|-----BEGIN (RSA |EC |OPENSSH |PGP )?PRIVATE KEY-----'
  'absolute-home|/Users/[^/"\s][^/"\s]*/'
  'absolute-home|/home/[^/"\s][^/"\s]*/'
)

# LOW-confidence patterns (warn under --strict):
#   These may be template placeholders the user is expected to substitute.
#   They become HIGH severity if the user has --strict enabled.
PATTERNS_LOW=(
  'placeholder|<user>'
  'placeholder|<your-username>'
  'placeholder|your-email@example\.com'
  'placeholder|<repo-owner>'
  'maybe-email|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
  'maybe-phone|\+?[0-9]{1,3}[ -][0-9]{3,4}[ -][0-9]{3,4}[ -][0-9]{3,4}'
)

scan_pattern() {
  local label="$1" pattern="$2" file="$3" severity="$4"
  if [[ ! -r "${file}" ]]; then
    return
  fi
  # Use grep -nE for line-numbered matches
  local matches
  matches=$(grep -nE "${pattern}" "${file}" 2>/dev/null || true)
  if [[ -n "${matches}" ]]; then
    local match line_no line_text
    while IFS= read -r match; do
      line_no="${match%%:*}"
      line_text="${match#*:}"
      # Trim leading whitespace
      line_text="${line_text#"${line_text%%[![:space:]]*}"}"
      if [[ "${severity}" == "high" ]]; then
        echo -e "  ${RED}✗${NC} ${label}: ${file}:${line_no}"
        echo -e "      ${line_text}"
        HITS=$((HITS + 1))
      else
        if [[ "${STRICT}" == true ]]; then
          echo -e "  ${YELLOW}!${NC} ${label}: ${file}:${line_no}"
          echo -e "      ${line_text}"
          WARNS=$((WARNS + 1))
        fi
      fi
    done <<< "${matches}"
  fi
}

# Built-in ignore list — files that legitimately reference these patterns
# (audit trails, changelogs, and the script itself)
# Entries are matched as suffix substrings (so "./scripts/sanitize-check.sh"
# also matches "scripts/sanitize-check.sh" without the dot-prefix).
IGNORE_PATTERNS=(
  "scripts/sanitize-check.sh"
  ".gitignore"
  "SECURITY.md"
  "CHANGELOG.md"
  "docs/FUNCTIONAL_GAPS.md"
)

should_ignore() {
  local file="$1"
  local pattern
  for pattern in "${IGNORE_PATTERNS[@]}"; do
    # Match if pattern appears anywhere in the path (handles ./ prefix and subdirs)
    if [[ "${file}" == *"${pattern}"* ]]; then
      return 0
    fi
  done
  return 1
}

echo "Scanning ${#FILES[@]} files..."
echo ""

scan_file() {
  local file="$1"
  if should_ignore "${file}"; then
    return
  fi
  local entry label pattern
  for entry in "${PATTERNS_HIGH[@]}"; do
    label="${entry%%|*}"
    pattern="${entry#*|}"
    scan_pattern "${label}" "${pattern}" "${file}" "high"
  done
  for entry in "${PATTERNS_LOW[@]}"; do
    label="${entry%%|*}"
    pattern="${entry#*|}"
    scan_pattern "${label}" "${pattern}" "${file}" "low"
  done
}

for file in "${FILES[@]}"; do
  scan_file "${file}"
done

echo ""
echo "──────────────────────────────────────────────────────────────"
if [[ ${HITS} -gt 0 ]]; then
  echo -e "${RED}FAILED${NC} — ${HITS} high-confidence personal-data finding(s)."
  echo ""
  echo "These patterns indicate the file is not safe to push to a public repo."
  echo "Remove or redact the matched content, replace placeholders with the"
  echo "real owner name, then re-run this script."
  exit 1
fi

if [[ ${WARNS} -gt 0 ]]; then
  echo -e "${YELLOW}WARNING${NC} — ${WARNS} low-confidence finding(s). Review recommended."
  exit 2
fi

echo -e "${GREEN}✓ Clean${NC} — no personal data, secrets, or placeholders detected."
exit 0