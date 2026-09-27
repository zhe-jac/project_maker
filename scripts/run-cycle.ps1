<#
.SYNOPSIS
  Runs one unattended orchestration cycle with Claude Code (headless).

.EXAMPLE
  .\scripts\run-cycle.ps1                      # orchestrator picks the due project
  .\scripts\run-cycle.ps1 -Project my-hack     # a specific project
  .\scripts\run-cycle.ps1 -Project my-hack -MaxBudgetUsd 20 -Model opus
#>
param(
  [string]$Project = "",
  [int]$TimeoutMinutes = 150,
  [ValidateSet("auto", "acceptEdits", "dontAsk", "bypassPermissions")]
  [string]$PermissionMode = "auto",
  [string]$Model = "",
  [double]$MaxBudgetUsd = 0,
  [string[]]$AddDir = @()
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

# Locate the claude CLI: PATH first, then the newest VS Code extension's bundled binary.
$claude = (Get-Command claude -ErrorAction SilentlyContinue).Source
if (-not $claude) {
  $claude = Get-ChildItem "$env:USERPROFILE\.vscode\extensions" -Directory -Filter "anthropic.claude-code-*" -ErrorAction SilentlyContinue |
    Sort-Object { [version](($_.Name -replace '^anthropic\.claude-code-', '') -replace '-.*$', '') } -Descending |
    ForEach-Object { Join-Path $_.FullName "resources\native-binary\claude.exe" } |
    Where-Object { Test-Path $_ } |
    Select-Object -First 1
}
if (-not $claude) { throw "Claude Code CLI not found. Install it or add it to PATH." }

$logDir = Join-Path $Root "logs"
New-Item -ItemType Directory -Force $logDir | Out-Null
$stamp = Get-Date -Format "yyyy-MM-dd-HHmm"
$log = Join-Path $logDir "cycle-$stamp.log"
$errLog = Join-Path $logDir "cycle-$stamp.err.log"

$target = if ($Project) { "Project: $Project." } else { "No project named: pick the due one per PORTFOLIO.md." }
$prompt = "Run exactly one orchestration cycle. Read CLAUDE.md, GUARDRAILS.md, then ORCHESTRATOR.md and follow it from section 1 to section 8. $target " +
          "This is an unattended scheduled run: never wait for input or ask questions; record decisions in DECISIONS.md and questions in the summary with the default you took. " +
          "Current local time: $(Get-Date -Format 'yyyy-MM-dd HH:mm zzz')."

$argList = @("-p", "`"$prompt`"", "--permission-mode", $PermissionMode, "--output-format", "text")
if ($Model)            { $argList += @("--model", $Model) }
if ($MaxBudgetUsd -gt 0) { $argList += @("--max-budget-usd", "$MaxBudgetUsd") }
foreach ($d in $AddDir) { $argList += @("--add-dir", "`"$d`"") }

"[$(Get-Date -Format s)] starting cycle ($target) with $claude" | Tee-Object -FilePath $log -Append
$proc = Start-Process -FilePath $claude -ArgumentList $argList -WorkingDirectory $Root `
  -RedirectStandardOutput "$log.out" -RedirectStandardError $errLog -NoNewWindow -PassThru
$null = $proc.Handle  # cache the handle so ExitCode is available after exit (PS 5.1 quirk)

if (-not $proc.WaitForExit($TimeoutMinutes * 60 * 1000)) {
  "[$(Get-Date -Format s)] TIMEOUT after $TimeoutMinutes min - killing. The next cycle will treat the lock as stale." | Tee-Object -FilePath $log -Append
  & taskkill /PID $proc.Id /T /F | Out-Null
  exit 124
}

Get-Content "$log.out" -ErrorAction SilentlyContinue | Add-Content $log
Remove-Item "$log.out" -ErrorAction SilentlyContinue
"[$(Get-Date -Format s)] finished with exit code $($proc.ExitCode). Read REVIEW_ME.md." | Tee-Object -FilePath $log -Append
exit $proc.ExitCode
