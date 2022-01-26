# ------------------------------------------------------------
# PowerShell - Scheduled Task - Run script block as Administrator (without referencing a script file)
# ------------------------------------------------------------
#
# QuickNoteSniper  (Runs as NON-Admin)
#

$Args_SchedTask=@{ TaskName="QuickNoteSniper"; Description="QuickNoteSniper"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command If (Get-Process -Name ONENOTEM -ErrorAction SilentlyContinue) { Stop-Process -Name ONENOTEM -Force -ErrorAction SilentlyContinue; Start-Sleep 1; Remove-Item -Path (Write-Output ~\AppData\Roaming\Microsoft\Windows\Start` Menu\Programs\Startup\Send` to` OneNote*) -Force; Start-Sleep 1; Remove-Item -Path (Write-Output ~\Documents\OneNote` Notebooks\Quick` Notes*.one) -Force; }') -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# SetHomepage_Chrome  (Runs as Admin)
#

$Args_SchedTask=@{ TaskName="SetHomepage_Chrome"; Description="SetHomepage_Chrome"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command New-ItemProperty -LiteralPath ((Write-Output Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs)) -Name (1) -Value ((Write-Output https://google.com)) -PropertyType ((Write-Output String)) -ErrorAction SilentlyContinue; Set-ItemProperty -LiteralPath ((Write-Output Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs)) -Name (1) -Value ((Write-Output https://google.com)) -ErrorAction SilentlyContinue;') -Verb 'RunAs' -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# SetHomepage_Edge  (Runs as Admin)
#

$Args_SchedTask=@{ TaskName="SetHomepage_Edge"; Description="SetHomepage_Edge"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command New-ItemProperty -LiteralPath ((Write-Output Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\RestoreOnStartupURLs)) -Name (1) -Value ((Write-Output https://google.com)) -PropertyType ((Write-Output String)) -ErrorAction SilentlyContinue; Set-ItemProperty -LiteralPath ((Write-Output Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\RestoreOnStartupURLs)) -Name (1) -Value ((Write-Output https://google.com)) -ErrorAction SilentlyContinue;') -Verb 'RunAs' -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# Startup_StopProcesses  (Runs as Admin)
#

$Args_SchedTask=@{ TaskName="Startup_StopProcesses"; Description="Startup_StopProcesses"; Trigger=(New-ScheduledTaskTrigger -AtStartup); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command While (1) { Get-Process -Name redcloak* 2>`$Null | Stop-Process -Force <# redcloak #>; Get-Process -Name flow 2>`$Null | Stop-Process -Force <# bang & olufsen #>; Get-Process -Name smartaudio* 2>`$Null | Stop-Process -Force <# bang & olufsen #>; Get-Process -Name tanium* 2>`$Null | Stop-Process -Force <# tanium #>; Get-Process -Name fc* 2>`$Null | Stop-Process -Force <# mcafee #>; Start-Sleep -Seconds (1); };') -Verb 'RunAs' -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "New-ScheduledTaskAction (ScheduledTasks) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskaction
#
#   docs.microsoft.com  |  "New-ScheduledTaskTrigger (ScheduledTasks) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger
#
#   docs.microsoft.com  |  "Register-ScheduledTask (ScheduledTasks) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/register-scheduledtask
#
#   docs.microsoft.com  |  "Start-ScheduledTask (ScheduledTasks) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/start-scheduledtask
#
#   docs.microsoft.com  |  "Unregister-ScheduledTask (ScheduledTasks) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/unregister-scheduledtask
#
#   stackoverflow.com  |  "windows - How to run a process as non-admin from an elevated PowerShell console? - Stack Overflow"  |  https://stackoverflow.com/a/37335079
#
# ------------------------------------------------------------