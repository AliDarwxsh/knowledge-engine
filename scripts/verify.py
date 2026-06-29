#!/usr/bin/env python3
"""
verify.py — Check that the knowledge-engine is properly installed and functional.
Cross-platform: works on macOS, Linux, and Windows (with Python 3.8+).

Usage:
    python3 scripts/verify.py
    OBSIDIAN_VAULT=/path/to/vault python3 scripts/verify.py
"""
from __future__ import annotations

import json
import os
import platform
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Callable

# Force UTF-8 on Windows to avoid cp1252 codec errors
if sys.platform == "win32" and hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")
    sys.stderr.reconfigure(encoding="utf-8")

REQUIRED_DIRS = [
    "00 Inbox",
    "01 Identity",
    "02 Principles",
    "03 Projects",
    "04 Knowledge Library",
    "05 Framework Library",
    "06 Decision Archive",
    "07 Systems & SOPs",
    "08 Prompt Library",
    "09 Research Archive",
    "10 Ideas & Opportunities",
    "11 Timeline",
    "12 Relationship Maps",
    "13 Meta Analysis",
    "wiki",
    "sources",
    "schema",
    "workflows",
    "templates",
]

CRITICAL_FILES = [
    "README.md",
    "Knowledge Archive Home.md",
    "CLAUDE.md",
    "schema/CLAUDE.md",
    "schema/ontology.md",
    "schema/agents.md",
    "schema/copywriting-standards.md",
    "workflows/inbox-triage.md",
    "workflows/daily-rhythm.md",
    "templates/daily-note.md",
    "templates/evergreen-note.md",
]

EXPECTED_SKILLS = [
    "vault-init",
    "vault-capture",
    "vault-sync",
    "vault-lint",
    "vault-digest",
    "vault-import",
    "vault-query",
    "vault-link",
    "vault-morning-brief",
    "vault-forward-refs",
]

EXPECTED_CRON = [
    "morning-brief",
    "inbox-processor",
    "connection-finder",
    "nightly-lint",
    "weekly-digest",
]


class C:
    if sys.platform == "win32":
        os.system("")  # nosec B605,B607
    RED = "\033[0;31m"
    GREEN = "\033[0;32m"
    YELLOW = "\033[1;33m"
    BLUE = "\033[0;34m"
    NC = "\033[0m"


PASS = 0
FAIL = 0
WARN = 0


def log_step(msg):
    print(f"{C.BLUE}==>{C.NC} {msg}", flush=True)


def log_ok(msg):
    print(f"{C.GREEN}✓{C.NC} {msg}", flush=True)


def log_warn(msg):
    print(f"{C.YELLOW}!{C.NC} {msg}", flush=True)
    global WARN
    WARN += 1


def log_fail(msg):
    print(f"{C.RED}✗{C.NC} {msg}", flush=True)
    global FAIL
    FAIL += 1


def user_home() -> Path:
    return Path.home()


def hermes_skills_dir() -> Path:
    default_profile = user_home() / ".hermes" / "profiles" / "default" / "skills"
    legacy = user_home() / ".hermes" / "skills"
    if default_profile.exists():
        return default_profile
    return legacy


def check(description: str, predicate: Callable[[], bool]) -> bool:
    global PASS
    try:
        ok = bool(predicate())
    except Exception:
        ok = False
    if ok:
        log_ok(description)
        PASS += 1
        return True
    log_fail(description)
    global FAIL
    FAIL += 1
    return False


def banner(title: str) -> None:
    bar = "=" * 62
    print()
    print(f"+{bar}+")
    print(f"|{title.center(62)}|")
    print(f"+{bar}+")
    print()


def section(title: str) -> None:
    print()
    print(f"{C.BLUE}── {title} ──{C.NC}")


def main() -> int:
    global PASS, FAIL, WARN
    import argparse
    parser = argparse.ArgumentParser(
        description="Verify that knowledge-engine is properly installed"
    )
    parser.add_argument(
        "--vault", metavar="PATH",
        help="Override OBSIDIAN_VAULT for this run"
    )
    parser.add_argument(
        "--quiet", action="store_true",
        help="Only print the summary line (for CI)"
    )
    args = parser.parse_args()

    if args.vault:
        os.environ["OBSIDIAN_VAULT"] = str(args.vault)

    banner("knowledge-engine — Installation Verification")

    # Check 1: Hermes installation
    section("Hermes installation")
    hermes_path = shutil.which("hermes")
    if hermes_path:
        log_ok("Hermes is installed")
        PASS += 1
    else:
        log_warn("Hermes is not installed (optional — run setup.py to install)")

    def hermes_responds() -> bool:
        if not hermes_path:
            return False
        try:
            r = subprocess.run(  # nosec B603
                [hermes_path, "--version"],
                capture_output=True, text=True, timeout=10
            )
            return r.returncode == 0
        except Exception:
            return False

    if hermes_responds():
        log_ok("Hermes responds to --version")
        PASS += 1
    else:
        log_warn("Hermes not responding (optional — run setup.py to install)")

    # Check 2: Vault configuration
    section("Vault configuration")
    vault_env = os.environ.get("OBSIDIAN_VAULT")
    if vault_env:
        log_ok(f"OBSIDIAN_VAULT is set: {vault_env}")
        PASS += 1
    else:
        log_warn("OBSIDIAN_VAULT is not set (optional — only needed for active vault sync)")
        # Suggest platform-appropriate command
        if sys.platform == "win32":
            log_warn("Set with: setx OBSIDIAN_VAULT \"C:\\path\\to\\vault\"")
        else:
            log_warn('Add to ~/.zshrc or ~/.bashrc: export OBSIDIAN_VAULT="/path/to/vault"')

    vault_path = Path(vault_env) if vault_env else (
        user_home() / "Documents" / "Obsidian" / "MainVault"
    )

    # Check 3: Vault structure (skip if vault not configured)
    section("Vault structure")
    if vault_env:
        for d in REQUIRED_DIRS:
            target = vault_path / d
            check(f"Directory exists: {d}", lambda t=target: t.is_dir())

        # Check 4: Critical files
        section("Critical vault files")
        for f in CRITICAL_FILES:
            target = vault_path / f
            check(f"File exists: {f}", lambda t=target: t.is_file())
    else:
        log_warn("Vault not configured — skipping vault structure checks")
        log_warn("Run: python3 scripts/setup.py to configure vault")

    # Check 4a: Repo structure (always check repo root for template files)
    section("Repo template structure")
    repo_root = Path(__file__).resolve().parent.parent
    for d in REQUIRED_DIRS:
        target = repo_root / "vault" / d
        if target.is_dir():
            log_ok(f"Repo template: {d}/")
        else:
            log_warn(f"Repo template missing: {d}/")
    for f in CRITICAL_FILES:
        target = repo_root / "vault" / f
        if target.is_file():
            log_ok(f"Repo template: {f}")
        else:
            log_warn(f"Repo template missing: {f}")

    # Check 5: Hermes skills
    section("Hermes skills")
    skills_dir = hermes_skills_dir()
    for skill in EXPECTED_SKILLS:
        target = skills_dir / skill
        if target.is_dir():
            log_ok(f"Skill installed: {skill}")
            PASS += 1
        else:
            log_warn(
                f"Skill not installed: {skill} "
                f"(run python3 scripts/setup.py to install)"
            )

    # Check 6: Cron jobs
    section("Cron jobs")
    if hermes_path:
        try:
            r = subprocess.run(  # nosec B603
                [hermes_path, "cron", "list"],
                capture_output=True, text=True, timeout=15
            )
            cron_listing = r.stdout if r.returncode == 0 else ""
        except Exception:
            cron_listing = ""
    else:
        cron_listing = ""

    for cron in EXPECTED_CRON:
        if cron in cron_listing:
            log_ok(f"Cron scheduled: {cron}")
            PASS += 1
        else:
            log_warn(
                f"Cron not scheduled: {cron} "
                f"(run python3 scripts/setup.py to install)"
            )

    # Check 7: AI provider configuration
    section("AI provider configuration")
    has_key = any(
        os.environ.get(k) for k in (
            "OPENAI_API_KEY",
            "ANTHROPIC_API_KEY",
            "OPENROUTER_API_KEY",
            "GOOGLE_API_KEY",
            "DEEPSEEK_API_KEY",
            "MISTRAL_API_KEY",
            "COHERE_API_KEY",
            "XAI_API_KEY",
        )
    )
    if has_key:
        log_ok("At least one AI provider API key is configured")
        PASS += 1
    else:
        log_warn("No AI provider API key found in environment")
        log_warn("  Set one of: OPENAI_API_KEY, ANTHROPIC_API_KEY, OPENROUTER_API_KEY, GOOGLE_API_KEY, DEEPSEEK_API_KEY, MISTRAL_API_KEY, COHERE_API_KEY, XAI_API_KEY")

    # Check 8: Vault health reminder
    section("Vault health (optional)")
    if hermes_path:
        log_warn("Run /vault-lint for detailed health scorecard")

    # Summary
    banner("Verification Summary")
    print(f"  {C.GREEN}Passed:{C.NC}   {PASS}")
    print(f"  {C.YELLOW}Warnings:{C.NC} {WARN}")
    print(f"  {C.RED}Failed:{C.NC}   {FAIL}")
    print()

    if FAIL == 0:
        print(f"{C.GREEN}✓ Knowledge Engine is properly installed and ready.{C.NC}")
        print()
        print("Next steps:")
        print("  1. Start Hermes and type /vault-init (one-time setup interview)")
        print(f"  2. Open Obsidian at: {vault_path}")
        print("  3. Start capturing: /vault-capture \"your first thought\"")
        return 0

    print(f"{C.RED}✗ Some checks failed. Run python3 scripts/setup.py to fix.{C.NC}")
    return 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print()
        print(f"{C.RED}✗{C.NC} Interrupted.")
        sys.exit(130)