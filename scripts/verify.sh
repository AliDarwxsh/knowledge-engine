#!/usr/bin/env bash
# verify.sh — Knowledge Engine installation verifier (thin wrapper around verify.py)
# Use this on macOS/Linux. On Windows, use scripts/verify.cmd instead.

set -u  # Error on undefined variables

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v python3 >/dev/null 2>&1; then
  PY=python3
elif command -v python >/dev/null 2>&1; then
  PY=python
else
  echo "✗ Python is not installed." >&2
  exit 1
fi

exec "$PY" "$SCRIPT_DIR/verify.py" "$@"