"""Comprehensive tests for knowledge-engine."""
import os
import sys
import importlib.util
import subprocess
from pathlib import Path
import pytest


def load_module(name, path):
    """Load a module by file path to avoid naming conflicts."""
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


class TestRepositoryStructure:
    """Tests for repository structure."""
    
    @pytest.fixture
    def repo_root(self):
        return Path(__file__).parent.parent
    
    def test_readme_exists(self, repo_root):
        """Test README.md exists."""
        assert (repo_root / "README.md").exists()
    
    def test_docs_directory_exists(self, repo_root):
        """Test docs/ directory exists."""
        assert (repo_root / "docs").is_dir()
    
    def test_scripts_directory_exists(self, repo_root):
        """Test scripts/ directory exists."""
        assert (repo_root / "scripts").is_dir()
    
    def test_license_exists(self, repo_root):
        """Test LICENSE exists."""
        assert (repo_root / "LICENSE").exists()
    
    def test_changelog_exists(self, repo_root):
        """Test CHANGELOG.md exists."""
        assert (repo_root / "CHANGELOG.md").exists()


class TestScripts:
    """Tests for script files."""
    
    @pytest.fixture
    def scripts_dir(self):
        return Path(__file__).parent.parent / "scripts"
    
    def test_setup_py_exists(self, scripts_dir):
        """Test setup.py exists."""
        assert (scripts_dir / "setup.py").exists()
    
    def test_verify_py_exists(self, scripts_dir):
        """Test verify.py exists."""
        assert (scripts_dir / "verify.py").exists()
    
    def test_setup_sh_exists(self, scripts_dir):
        """Test setup.sh exists."""
        assert (scripts_dir / "setup.sh").exists()
    
    def test_verify_sh_exists(self, scripts_dir):
        """Test verify.sh exists."""
        assert (scripts_dir / "verify.sh").exists()
    
    def test_sanitize_check_sh_exists(self, scripts_dir):
        """Test sanitize-check.sh exists."""
        assert (scripts_dir / "sanitize-check.sh").exists()
    
    def test_shell_scripts_have_safety_settings(self, scripts_dir):
        """Test shell scripts have set -e and set -u."""
        for script in scripts_dir.glob("*.sh"):
            content = script.read_text()
            assert "set -e" in content or "set -o errexit" in content, (
                f"{script.name} missing set -e"
            )
            assert "set -u" in content or "set -o nounset" in content, (
                f"{script.name} missing set -u"
            )


class TestConfiguration:
    """Tests for configuration files."""
    
    @pytest.fixture
    def repo_root(self):
        return Path(__file__).parent.parent
    
    def test_env_example_exists(self, repo_root):
        """Test .env.example exists."""
        assert (repo_root / ".env.example").exists()
    
    def test_requirements_txt_exists(self, repo_root):
        """Test requirements.txt exists."""
        assert (repo_root / "requirements.txt").exists()
    
    def test_pyproject_toml_exists(self, repo_root):
        """Test pyproject.toml exists."""
        assert (repo_root / "pyproject.toml").exists()
    
    def test_editorconfig_exists(self, repo_root):
        """Test .editorconfig exists."""
        assert (repo_root / ".editorconfig").exists()
    
    def test_gitignore_exists(self, repo_root):
        """Test .gitignore exists."""
        assert (repo_root / ".gitignore").exists()


class TestGitHubActions:
    """Tests for GitHub Actions configuration."""
    
    @pytest.fixture
    def workflows_dir(self):
        return Path(__file__).parent.parent / ".github" / "workflows"
    
    def test_workflows_directory_exists(self, workflows_dir):
        """Test .github/workflows/ exists."""
        assert workflows_dir.is_dir()
    
    def test_test_yml_exists(self, workflows_dir):
        """Test test.yml exists."""
        assert (workflows_dir / "test.yml").exists()
    
    def test_actions_pinned(self, workflows_dir):
        """Test GitHub Actions are pinned to SHA."""
        test_yml = workflows_dir / "test.yml"
        content = test_yml.read_text()
        import re
        matches = re.findall(r"uses:\s+(\S+)", content)
        for action in matches:
            if action.startswith("actions/"):
                assert re.search(r"@[a-f0-9]{40}", action), (
                    f"Action {action} not pinned to SHA"
                )


class TestDocumentation:
    """Tests for documentation."""
    
    @pytest.fixture
    def docs_dir(self):
        return Path(__file__).parent.parent / "docs"
    
    def test_getting_started_exists(self, docs_dir):
        """Test getting-started.md exists."""
        assert (docs_dir / "getting-started.md").exists()
    
    def test_architecture_exists(self, docs_dir):
        """Test architecture.md exists."""
        assert (docs_dir / "architecture.md").exists()
    
    def test_faq_exists(self, docs_dir):
        """Test faq.md exists."""
        assert (docs_dir / "faq.md").exists()
    
    def test_all_docs_have_headers(self, docs_dir):
        """Test all docs have proper headers."""
        for doc in docs_dir.glob("*.md"):
            content = doc.read_text()
            assert content.startswith("#"), f"{doc.name} missing title header"


class TestSkills:
    """Tests for skills directory."""
    
    @pytest.fixture
    def skills_dir(self):
        return Path(__file__).parent.parent / "skills"
    
    def test_skills_directory_exists(self, skills_dir):
        """Test skills/ directory exists."""
        assert skills_dir.is_dir()
    
    def test_skills_have_skill_md(self, skills_dir):
        """Test all skills have SKILL.md."""
        for skill_dir in skills_dir.iterdir():
            if skill_dir.is_dir():
                skill_md = skill_dir / "SKILL.md"
                assert skill_md.exists(), f"{skill_dir.name} missing SKILL.md"
