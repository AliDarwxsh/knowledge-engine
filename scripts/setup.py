#!/usr/bin/env python3
"""
setup.py — Knowledge Engine one-command installation
Cross-platform: works on macOS, Linux, and Windows (with Python 3.8+).

Usage:
    python3 scripts/setup.py                # interactive install
    python3 scripts/setup.py --vault PATH   # non-interactive
    OBSIDIAN_VAULT=Path python3 setup.py    # use env var, no prompt

Prerequisites:
    - Hermes Agent: https://hermes-agent.nousresearch.com (free, open-source)
    - Obsidian: https://obsidian.md (free for personal use)
    - Python 3.8+: https://www.python.org/downloads/

After forking this repo, replace "YOUR_GITHUB_USERNAME" in this file
and the other docs with your actual GitHub handle.
"""
from __future__ import annotations

import argparse
import json
import os
import platform
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Optional

ENGINE_VERSION = "1.1.1"

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

SKILL_LIST = [
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


# ---------- ANSI color helpers (auto-disabled on non-TTY and Windows legacy) ----------

class C:
    if sys.platform == "win32":
        os.system("")  # nosec B605,B607
    RED = "\033[0;31m"
    GREEN = "\033[0;32m"
    YELLOW = "\033[1;33m"
    BLUE = "\033[0;34m"
    NC = "\033[0m"


def _emit(stream, msg):
    print(msg, file=stream, flush=True)


def log_step(msg):
    _emit(sys.stdout, f"{C.BLUE}==>{C.NC} {msg}")


def log_ok(msg):
    _emit(sys.stdout, f"{C.GREEN}✓{C.NC} {msg}")


def log_warn(msg):
    _emit(sys.stdout, f"{C.YELLOW}!{C.NC} {msg}")


def log_error(msg):
    _emit(sys.stderr, f"{C.RED}✗{C.NC} {msg}")


# ---------- OS / path helpers ----------

def detect_os_name() -> str:
    s = platform.system()
    if s == "Darwin":
        return "macOS"
    if s == "Linux":
        return "Linux"
    if s == "Windows":
        return "Windows"
    return f"{s} (untested)"


def user_home() -> Path:
    return Path.home()


def hermes_skills_dir() -> Path:
    """Resolve where this user's Hermes profile stores skills.
    Prefers ~/.hermes/profiles/default/skills (current Hermes),
    falls back to ~/.hermes/skills (legacy).
    """
    default_profile = user_home() / ".hermes" / "profiles" / "default" / "skills"
    legacy = user_home() / ".hermes" / "skills"
    if default_profile.exists():
        return default_profile
    return legacy


def detect_shell_rc() -> Optional[Path]:
    """Return the user's shell RC file (POSIX shells only).
    On Windows we don't write to a rc file — we print instructions instead.
    """
    if sys.platform == "win32":
        return None
    shell_path = os.environ.get("SHELL", "")
    shell_name = Path(shell_path).stem if shell_path else "bash"
    rc = user_home() / f".{shell_name}rc"
    return rc if rc.exists() else None


# ---------- Hermes detection ----------

def find_hermes() -> Optional[str]:
    return shutil.which("hermes")


def hermes_version() -> str:
    try:
        out = subprocess.run(  # nosec B603,B607
            ["hermes", "--version"], capture_output=True, text=True, timeout=10
        )
        return (out.stdout or out.stderr).strip() or "unknown"
    except Exception:
        return "unknown"


# ---------- Vault scaffolding ----------

def locate_vault(args_vault: Optional[str]) -> Path:
    if args_vault:
        p = Path(args_vault).expanduser()
        return p

    env_vault = os.environ.get("OBSIDIAN_VAULT")
    if env_vault:
        log_ok(f"Using OBSIDIAN_VAULT: {env_vault}")
        return Path(env_vault).expanduser()

    # Offer to discover an existing Obsidian vaults directory
    candidates: list[Path] = []
    if sys.platform == "win32":
        docs = user_home() / "Documents"
        if (docs / "Obsidian").is_dir():
            candidates = sorted(p for p in (docs / "Obsidian").iterdir() if p.is_dir())
    else:
        obs_root = user_home() / "Documents" / "Obsidian"
        if obs_root.is_dir():
            candidates = sorted(p for p in obs_root.iterdir() if p.is_dir())

    if candidates:
        log_step("Found existing Obsidian vaults:")
        for c in candidates[:5]:
            print(f"     {c}")
        print()
        prompt = "Enter vault path (or 'new' to create one): "
    else:
        prompt = "Enter vault path (or 'new' to create one): "

    try:
        raw = input(prompt).strip()
    except EOFError:
        log_error("No vault path provided and stdin is closed.")
        sys.exit(1)

    if not raw:
        log_error("Vault path required.")
        sys.exit(1)

    if raw.lower() == "new":
        name = input("Vault name: ").strip() or "MainVault"
        if sys.platform == "win32":
            new_path = user_home() / "Documents" / "Obsidian" / name
        else:
            new_path = user_home() / "Documents" / "Obsidian" / name
        new_path.mkdir(parents=True, exist_ok=True)
        log_ok(f"Created vault: {new_path}")
        return new_path

    p = Path(raw).expanduser()
    if not p.is_dir():
        log_error(f"Vault directory does not exist: {p}")
        sys.exit(1)
    return p


def scaffold_vault(vault: Path) -> None:
    missing = [d for d in REQUIRED_DIRS if not (vault / d).is_dir()]
    if not missing:
        log_ok("Vault structure already complete")
        return
    log_warn(f"Scaffolding {len(missing)} missing directory(ies)…")
    for d in REQUIRED_DIRS:
        (vault / d).mkdir(parents=True, exist_ok=True)
    log_ok(f"Scaffolded {len(REQUIRED_DIRS)} directories")


def copy_templates(template_source: Path, vault: Path) -> None:
    if not template_source.is_dir():
        log_warn(f"Template source not found at {template_source}.")
        return
    # Top-level .md files (don't overwrite existing)
    for md in template_source.glob("*.md"):
        dest = vault / md.name
        if not dest.exists():
            shutil.copy2(md, dest)
    # Recursive copy of subdirs (don't overwrite anything)
    for sub in template_source.iterdir():
        if sub.is_dir():
            dest = vault / sub.name
            dest.mkdir(parents=True, exist_ok=True)
            shutil.copytree(sub, dest, dirs_exist_ok=True)
    log_ok("Templates copied to vault")


# ---------- Skill installation ----------

def install_skills(skill_source: Path) -> None:
    if not skill_source.is_dir():
        log_warn(f"Skills source not found at {skill_source}.")
        log_warn("Install manually: cp -r skills/* ~/.hermes/skills/")
        return

    target = hermes_skills_dir()
    target.mkdir(parents=True, exist_ok=True)

    installed = 0
    for skill_dir in sorted(skill_source.iterdir()):
        if not skill_dir.is_dir():
            continue
        if not (skill_dir / "SKILL.md").is_file():
            continue
        dest = target / skill_dir.name
        try:
            shutil.copytree(skill_dir, dest, dirs_exist_ok=True)
            log_ok(f"Installed skill: {skill_dir.name}")
            installed += 1
        except Exception as e:
            log_warn(f"Failed to install {skill_dir.name}: {e}")
    if installed == 0:
        log_warn("No skills installed (check skills/ directory).")


# ---------- Cron installation ----------

def install_cron(cron_source: Path) -> None:
    hermes = find_hermes()
    if not hermes:
        log_warn("hermes CLI not found — skipping cron installation.")
        log_warn("After installing Hermes, run: hermes cron create for each cron/*.json")
        return

    if not cron_source.is_dir():
        log_warn(f"Cron source not found at {cron_source}.")
        return

    installed = 0
    for cron_file in sorted(cron_source.glob("*.json")):
        try:
            data = json.loads(cron_file.read_text())
        except Exception as e:
            log_warn(f"Could not parse {cron_file}: {e}")
            continue

        schedule = data.get("schedule")
        skill = data.get("skill")
        prompt = data.get("prompt", "")
        deliver = data.get("delivery") or data.get("deliver") or "local"
        name = cron_file.stem

        if not schedule or not skill:
            log_warn(f"Skipping {cron_file.name} — missing schedule or skill")
            continue

        cmd = [
            hermes, "cron", "create",
            schedule,
            prompt,
            "--name", name,
            "--skill", skill,
            "--deliver", deliver,
        ]
        try:
            subprocess.run(cmd, check=True, capture_output=True, text=True, timeout=30)  # nosec B603
            log_ok(f"Scheduled: {name}")
            installed += 1
        except subprocess.CalledProcessError as e:
            err = (e.stderr or e.stdout or "").strip()
            log_warn(f"Failed to schedule {name}: {err or e}")
        except Exception as e:
            log_warn(f"Failed to schedule {name}: {e}")

    if installed == 0:
        log_warn("No cron jobs scheduled. Install manually — see cron/*.json.")


# ---------- Env-var persistence ----------

def persist_env_var(vault: Path) -> None:
    if sys.platform == "win32":
        # On Windows we print instructions instead of editing registry/PSProfile
        log_step("Persisting OBSIDIAN_VAULT (Windows)")
        print()
        print("  Set this user environment variable so Hermes can find your vault:")
        print()
        print(f'     setx OBSIDIAN_VAULT "{vault}"')
        print()
        print("  PowerShell equivalent (current session only):")
        print()
        print(f'     $env:OBSIDIAN_VAULT = "{vault}"')
        print()
        print("  Or add it permanently via PowerShell:")
        print()
        print(f'     [Environment]::SetEnvironmentVariable("OBSIDIAN_VAULT","{vault}","User")')
        return

    rc = detect_shell_rc()
    if not rc:
        log_warn("Could not detect a shell rc file; skipping persistence.")
        return

    export_line = f'export OBSIDIAN_VAULT="{vault}"'
    try:
        existing = rc.read_text() if rc.exists() else ""
        if "OBSIDIAN_VAULT" in existing:
            log_ok(f"OBSIDIAN_VAULT already configured in {rc}")
            return
        with rc.open("a", encoding="utf-8") as f:
            f.write("\n# Knowledge Engine\n")
            f.write(export_line + "\n")
        log_ok(f"Added OBSIDIAN_VAULT to {rc}")
    except Exception as e:
        log_warn(f"Could not persist to {rc}: {e}")


# ---------- Banner ----------

def banner(title: str) -> None:
    bar = "═" * 62
    print()
    print(f"╔{bar}╗")
    print(f"║{title.center(62)}║")
    print(f"╚{bar}╝")
    print()


# ---------- Main ----------

def main() -> int:
    parser = argparse.ArgumentParser(description="Knowledge Engine installer")
    parser.add_argument(
        "--vault", metavar="PATH",
        help="Path to an existing vault (skips the interactive prompt)"
    )
    parser.add_argument(
        "--skip-cron", action="store_true",
        help="Skip installing scheduled jobs"
    )
    parser.add_argument(
        "--skip-env", action="store_true",
        help="Don't persist OBSIDIAN_VAULT to a shell rc"
    )
    args = parser.parse_args()

    banner(f"knowledge-engine setup v{ENGINE_VERSION}")
    print("    A self-organizing knowledge system.")
    print("    Hermes + Obsidian. Capture. Auto-classify. Query.")
    print()

    # Step 1: Environment
    log_step("Step 1/6: Verifying environment")
    hermes_path = find_hermes()
    if not hermes_path:
        log_error("Hermes is not installed.")
        print()
        print("Install Hermes first:")
        if sys.platform == "win32":
            print("  irm https://hermes-agent.nousresearch.com/install.ps1 | iex")
        else:
            print("  curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash")
        print()
        return 1
    log_ok(f"Hermes found: {hermes_version()} ({hermes_path})")
    log_ok(f"OS: {detect_os_name()} ({sys.platform})")

    # Step 2: Locate vault
    log_step("Step 2/6: Locating vault")
    vault = locate_vault(args.vault)
    log_ok(f"Vault: {vault}")

    # Step 3: Scaffold
    log_step("Step 3/6: Verifying vault structure")
    scaffold_vault(vault)

    # Step 4: Templates
    log_step("Step 4/6: Installing vault templates")
    script_dir = Path(__file__).resolve().parent
    repo_root = script_dir.parent
    template_source = repo_root / "vault"
    copy_templates(template_source, vault)

    # Step 5: Skills
    log_step("Step 5/6: Installing Hermes skills")
    skill_source = repo_root / "skills"
    install_skills(skill_source)

    # Step 6: Cron
    log_step("Step 6/6: Installing scheduled jobs")
    if args.skip_cron:
        log_warn("Skipped (--skip-cron)")
    else:
        cron_source = repo_root / "cron"
        install_cron(cron_source)

    # Persist env var
    if args.skip_env:
        log_warn("Skipped env-var persistence (--skip-env)")
    else:
        persist_env_var(vault)

    # Done
    banner("✓ Installation Complete")
    log_ok(f"Vault: {vault}")
    log_ok(f"Skills installed: {len(SKILL_LIST)} ({', '.join(SKILL_LIST)})")
    print()
    print(f"{C.BLUE}Next steps:{C.NC}")
    print()
    print("  1. Open your vault in Obsidian:")
    print(f"     File → Open vault → {vault}")
    print()
    print("  2. Start Hermes and type /vault-init to run the onboarding interview")
    print()
    print("  3. Start capturing: type /vault-capture \"Your first thought\" in Hermes")
    print()
    print(f"{C.BLUE}Documentation:{C.NC}")
    print("  https://github.com/YOUR_GITHUB_USERNAME/knowledge-engine")
    print()
    print(f"{C.BLUE}Your engine gets smarter every day.{C.NC}")
    print()
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print()
        log_error("Interrupted.")
        sys.exit(130)