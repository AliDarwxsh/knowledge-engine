"""Basic tests for knowledge-engine."""
import os
import sys
import importlib.util
import pytest
from pathlib import Path


def load_module(name, path):
    """Load a module by file path to avoid naming conflicts."""
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


class TestModulesLoad:
    """Test that modules can be imported."""
    
    def test_verify_module_loads(self):
        """Test verify module loads successfully."""
        verify_path = Path(__file__).parent.parent / "scripts" / "verify.py"
        mod = load_module("verify_script", verify_path)
        assert mod is not None
    
    def test_setup_module_loads(self):
        """Test setup module loads successfully."""
        setup_path = Path(__file__).parent.parent / "scripts" / "setup.py"
        mod = load_module("setup_script", setup_path)
        assert mod is not None


class TestRepositoryStructure:
    """Tests for repository structure."""
    
    def test_repo_root_exists(self):
        """Test repository root exists."""
        repo_root = Path(__file__).parent.parent
        assert repo_root.exists()
    
    def test_readme_exists(self):
        """Test README.md exists."""
        repo_root = Path(__file__).parent.parent
        assert (repo_root / "README.md").exists()
    
    def test_docs_directory_exists(self):
        """Test docs/ directory exists."""
        repo_root = Path(__file__).parent.parent
        assert (repo_root / "docs").is_dir()
    
    def test_scripts_directory_exists(self):
        """Test scripts/ directory exists."""
        repo_root = Path(__file__).parent.parent
        assert (repo_root / "scripts").is_dir()


class TestScriptsExist:
    """Tests for script files."""
    
    def test_setup_py_exists(self):
        """Test setup.py exists."""
        scripts_dir = Path(__file__).parent.parent / "scripts"
        assert (scripts_dir / "setup.py").exists()
    
    def test_verify_py_exists(self):
        """Test verify.py exists."""
        scripts_dir = Path(__file__).parent.parent / "scripts"
        assert (scripts_dir / "verify.py").exists()
    
    def test_setup_sh_exists(self):
        """Test setup.sh exists."""
        scripts_dir = Path(__file__).parent.parent / "scripts"
        assert (scripts_dir / "setup.sh").exists()
    
    def test_verify_sh_exists(self):
        """Test verify.sh exists."""
        scripts_dir = Path(__file__).parent.parent / "scripts"
        assert (scripts_dir / "verify.sh").exists()
    
    def test_sanitize_check_sh_exists(self):
        """Test sanitize-check.sh exists."""
        scripts_dir = Path(__file__).parent.parent / "scripts"
        assert (scripts_dir / "sanitize-check.sh").exists()
