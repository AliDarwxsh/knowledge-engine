<#
register-cron.ps1 — Register the five knowledge-engine jobs in Windows Task Scheduler.

Usage (run once after setup.cmd):
    powershell -ExecutionPolicy Bypass -File cron\windows\register-cron.ps1

Each task runs the matching .ps1 file under cron\windows\ on the schedule
from cron/*.json. Times are interpreted in the user's local timezone.

Run with -Unregister to remove all knowledge-engine tasks.
#>

[CmdletBinding()]
param(
    [switch]$Unregister
)

$ErrorActionPreference = "Stop"

# --- Locate repo (this script lives in <repo>\cron\windows\) ---
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = (Resolve-Path (Join-Path $ScriptDir "..\..")).Path
$WindowsCronDir = Join-Path $RepoRoot "cron\windows"

if (-not (Test-Path $WindowsCronDir)) {
    throw "Cron script directory not found: $WindowsCronDir"
}

# --- Schedule definitions (mirror cron/*.json) ---
$Schedules = @(
    @{ Name = "ke-morning-brief";     Script = "morning-brief.ps1";     Time = "07:00";  Days = "*";  Desc = "Daily 7am morning brief" },
    @{ Name = "ke-inbox-processor";   Script = "inbox-processor.ps1";   Time = "00:00";  Days = "*";  Desc = "Every 6h inbox processing (00, 06, 12, 18)" },
    @{ Name = "ke-connection-finder"; Script = "connection-finder.ps1"; Time = "03:00";  Days = "*";  Desc = "Daily 3am link discovery" },
    @{ Name = "ke-nightly-lint";      Script = "nightly-lint.ps1";      Time = "02:00";  Days = "*";  Desc = "Daily 2am vault health check" },
    @{ Name = "ke-weekly-digest";     Script = "weekly-digest.ps1";     Time = "18:00";  Days = "SUN"; Desc = "Sunday 6pm weekly synthesis" }
)

# --- Inbox processor runs every 6h — register four sub-tasks ---
$InboxTimes = @("00:00", "06:00", "12:00", "18:00")

function Unregister-KnowledgeEngineTasks {
    Write-Host "Unregistering knowledge-engine tasks..." -ForegroundColor Yellow
    $tasks = & schtasks /Query /FO CSV 2>$null | Select-Object -Skip 1 |
             ForEach-Object { ($_ -split ',')[0] -replace '"', '' }
    foreach ($t in $tasks) {
        if ($t -like "ke-*") {
            & schtasks /Delete /TN $t /F | Out-Null
            Write-Host "  removed: $t"
        }
    }
}

if ($Unregister) {
    Unregister-KnowledgeEngineTasks
    exit 0
}

# --- Ensure OBSIDIAN_VAULT is set ---
if (-not $env:OBSIDIAN_VAULT) {
    Write-Host "OBSIDIAN_VAULT is not set in this session." -ForegroundColor Yellow
    Write-Host "Set it with:  `$env:OBSIDIAN_VAULT = 'C:\Users\you\Documents\Obsidian\MainVault'"
    Write-Host "Or re-run scripts\setup.cmd which persists it for you."
    exit 1
}

# --- Ensure hermes is on PATH ---
if (-not (Get-Command hermes -ErrorAction SilentlyContinue)) {
    Write-Host "hermes CLI not found on PATH. Install Hermes first." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "knowledge-engine — Windows Task Scheduler registration" -ForegroundColor Cyan
Write-Host ""

$Registered = 0
$Failed = 0

# Register the daily jobs (one schedule each)
foreach ($s in $Schedules | Where-Object { $_.Name -ne "ke-inbox-processor" }) {
    $ScriptPath = Join-Path $WindowsCronDir $s.Script
    $TaskName = $s.Name
    $Time = $s.Time
    $Days = $s.Days

    # schtasks /Create expects a single HH:MM time
    & schtasks /Create /TN $TaskName /TR "powershell -NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`"" `
        /SC DAILY /ST $Time /F 2>$null | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  registered: $TaskName ($($s.Desc))" -ForegroundColor Green
        $Registered++
    } else {
        Write-Host "  FAILED:     $TaskName" -ForegroundColor Red
        $Failed++
    }
}

# Register the four inbox-processor runs
foreach ($Time in $InboxTimes) {
    $TaskName = "ke-inbox-processor-$($Time -replace ':', '')"
    $ScriptPath = Join-Path $WindowsCronDir "inbox-processor.ps1"

    & schtasks /Create /TN $TaskName /TR "powershell -NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`"" `
        /SC DAILY /ST $Time /F 2>$null | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  registered: $TaskName (every 6h @ $Time)" -ForegroundColor Green
        $Registered++
    } else {
        Write-Host "  FAILED:     $TaskName" -ForegroundColor Red
        $Failed++
    }
}

Write-Host ""
Write-Host "Summary: $Registered registered, $Failed failed." -ForegroundColor $(if ($Failed -gt 0) { "Red" } else { "Green" })
Write-Host ""
Write-Host "Manage tasks with: taskschd.msc, or:"
Write-Host "  schtasks /Query /FO TABLE | findstr ke-"
Write-Host ""
Write-Host "To remove all knowledge-engine tasks, run:"
Write-Host "  powershell -ExecutionPolicy Bypass -File cron\windows\register-cron.ps1 -Unregister"
Write-Host ""
exit $Failed