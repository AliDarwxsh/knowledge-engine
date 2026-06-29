#!/usr/bin/env bash
# setup.sh — Knowledge Engine installer (thin wrapper around setup.py)
# Use this on macOS/Linux. On Windows, use scripts/setup.cmd instead.
#
# New installs should use the Python entry point directly:
#   python3 scripts/setup.py            # or: py scripts/setup.py on Windows
#
# This thin wrapper exists for users who still curl-pipe the installer.
# Quick install via curl (after forking, replace YOUR_GITHUB_USERNAME with your handle):
#   bash <(curl -fsSL https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/knowledge-engine/main/scripts/setup.sh)
set -u  # Error on undefined variables

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Pick a Python interpreter — prefer python3 (POSIX), fall back to python
if command -v python3 >/dev/null 2>&1; then
  PY=python3
elif command -v python >/dev/null 2>&1; then
  PY=python
else
  echo "✗ Python is not installed." >&2
  echo "  Download and install Python 3.8+ from:" >&2
  echo "  https://www.python.org/downloads/" >&2
  echo "  Then re-run this script." >&2
  exit 1
fi

echo "==> knowledge-engine setup (delegating to $PY)"
exec "$PY" "$SCRIPT_DIR/setup.py" "$@"