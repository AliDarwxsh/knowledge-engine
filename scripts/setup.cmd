@echo off
REM setup.cmd — Knowledge Engine installer for Windows
REM
REM Usage:
REM     scripts\setup.cmd
REM     scripts\setup.cmd --vault "C:\Users\you\Documents\Obsidian\MainVault"
REM
REM Equivalent to: python scripts/setup.py [args]
REM See docs\installation-windows.md for prerequisites.

setlocal

REM Pick the best Python launcher available on Windows
where py >nul 2>nul
if %errorlevel% equ 0 (
  set "PY=py"
  goto :run
)

where python >nul 2>nul
if %errorlevel% equ 0 (
  set "PY=python"
  goto :run
)

where python3 >nul 2>nul
if %errorlevel% equ 0 (
  set "PY=python3"
  goto :run
)

echo X Python is not installed.
echo   Install Python 3.8+ from https://www.python.org/downloads/
echo   During install, tick "Add python.exe to PATH".
exit /b 1

:run
REM %~dp0 is the directory containing this .cmd file (with trailing backslash)
"%PY%" "%~dp0setup.py" %*
endlocal