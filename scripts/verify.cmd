@echo off
REM verify.cmd — Knowledge Engine installation verifier for Windows
REM Equivalent to: python scripts/verify.py

setlocal

where py >nul 2>nul
if %errorlevel% equ 0 (
  set "PY=py -3"
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
exit /b 1

:run
"%PY%" "%~dp0verify.py" %*
endlocal