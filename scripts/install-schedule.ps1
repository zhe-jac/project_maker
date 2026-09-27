<#
.SYNOPSIS
  Registers (or removes) a Windows Scheduled Task that runs a cycle every N hours.
  Runs as the current user, only while logged in (no password stored).

.EXAMPLE
  .\scripts\install-schedule.ps1 -Project my-hack -EveryHours 2
  .\scripts\install-schedule.ps1 -Project my-hack -Uninstall
#>
param(
  [string]$Project = "",
  [double]$EveryHours = 2,
  [int]$TimeoutMinutes = 150,
  [double]$MaxBudgetUsd = 0,
  [switch]$Uninstall
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$name = if ($Project) { "project_maker-$Project" } else { "project_maker" }

if ($Uninstall) {
  Unregister-ScheduledTask -TaskName $name -Confirm:$false
  Write-Host "Removed scheduled task '$name'."
  return
}

$script = Join-Path $PSScriptRoot "run-cycle.ps1"
$taskArgs = "-NoProfile -ExecutionPolicy Bypass -File `"$script`" -TimeoutMinutes $TimeoutMinutes"
if ($Project)          { $taskArgs += " -Project `"$Project`"" }
if ($MaxBudgetUsd -gt 0) { $taskArgs += " -MaxBudgetUsd $MaxBudgetUsd" }

$action   = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $taskArgs -WorkingDirectory $Root
$trigger  = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) `
              -RepetitionInterval (New-TimeSpan -Minutes ([int]($EveryHours * 60)))
$settings = New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -StartWhenAvailable `
              -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
              -ExecutionTimeLimit (New-TimeSpan -Minutes ($TimeoutMinutes + 15))

Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger -Settings $settings `
  -Description "project_maker orchestration cycle every $EveryHours h" -Force | Out-Null

Write-Host "Scheduled '$name': every $EveryHours h, first run in ~1 minute."
Write-Host "Logs: $Root\logs   Report: $Root\REVIEW_ME.md"
Write-Host "Stop with: .\scripts\install-schedule.ps1 $(if ($Project) { "-Project $Project " })-Uninstall"
