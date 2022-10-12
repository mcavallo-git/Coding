# ------------------------------------------------------------
# PowerShell - Scheduled Tasks (run script block (not file) as Admin, Register-ScheduledTask, New-ScheduledTaskAction, New-ScheduledTaskTrigger)
# ------------------------------------------------------------


# Template (NON-Admin)
$Args_SchedTask=@{ TaskName="____TASKNAME_____"; Description="____DESCRIPTION_____"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command ____POWERSHELL_CLI_____;') -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# Template (ADMIN)
$Args_SchedTask=@{ TaskName="____TASKNAME_____"; Description="____DESCRIPTION_____"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command ____POWERSHELL_CLI_____') -Verb 'RunAs' -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# QuickNoteSniper  (Runs as NON-Admin)
#

$Args_SchedTask=@{ TaskName="QuickNoteSniper"; Description="QuickNoteSniper"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command If (Get-Process -Name ONENOTEM -ErrorAction SilentlyContinue) { Stop-Process -Name ONENOTEM -Force -ErrorAction SilentlyContinue; Start-Sleep 1; Remove-Item -Path (Write-Output ~\AppData\Roaming\Microsoft\Windows\Start` Menu\Programs\Startup\Send` to` OneNote*) -Force; Start-Sleep 1; Remove-Item -Path (Write-Output ~\Documents\OneNote` Notebooks\Quick` Notes*.one) -Force; }') -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# SetHomepage_Chrome  (Runs as ADMIN)
#

$Args_SchedTask=@{ TaskName="SetHomepage_Chrome"; Description="SetHomepage_Chrome"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command New-ItemProperty -LiteralPath ((Write-Output Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs)) -Name (1) -Value ((Write-Output https://google.com)) -PropertyType ((Write-Output String)) -ErrorAction SilentlyContinue; Set-ItemProperty -LiteralPath ((Write-Output Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs)) -Name (1) -Value ((Write-Output https://google.com)) -ErrorAction SilentlyContinue;') -Verb 'RunAs' -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# SetHomepage_Edge  (Runs as ADMIN)
#

$Args_SchedTask=@{ TaskName="SetHomepage_Edge"; Description="SetHomepage_Edge"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command New-ItemProperty -LiteralPath ((Write-Output Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\RestoreOnStartupURLs)) -Name (1) -Value ((Write-Output https://google.com)) -PropertyType ((Write-Output String)) -ErrorAction SilentlyContinue; Set-ItemProperty -LiteralPath ((Write-Output Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\RestoreOnStartupURLs)) -Name (1) -Value ((Write-Output https://google.com)) -ErrorAction SilentlyContinue;') -Verb 'RunAs' -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# Startup_StopProcesses  (Runs as ADMIN)
#

$Args_SchedTask=@{ TaskName="Startup_StopProcesses"; Description="Startup_StopProcesses"; Trigger=(New-ScheduledTaskTrigger -AtStartup); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command While (1) { Get-Process -Name redcloak* 2>`$Null | Stop-Process -Force <# redcloak #>; Get-Process -Name flow 2>`$Null | Stop-Process -Force <# bang & olufsen #>; Get-Process -Name smartaudio* 2>`$Null | Stop-Process -Force <# bang & olufsen #>; Get-Process -Name tanium* 2>`$Null | Stop-Process -Force <# tanium #>; Get-Process -Name fc* 2>`$Null | Stop-Process -Force <# mcafee #>; Start-Sleep -Seconds (1); };') -Verb 'RunAs' -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# WakeOnLan  (Runs as NON-Admin)
#

$Args_SchedTask=@{ TaskName="WakeOnLan"; Description="WakeOnLan"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((GCM powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((GCM powershell).Source) -ArgumentList ('-Command sv mac (write A1:B2:C3:D4:E5:F6); sv split_mac (@(((gv mac).Value).split((write :)) | foreach {((gv _).Value).insert(0,(write 0x))})); sv mac_byte_array ([Byte[]](((gv split_mac).Value)[0],((gv split_mac).Value)[1],((gv split_mac).Value)[2],((gv split_mac).Value)[3],((gv split_mac).Value)[4],((gv split_mac).Value)[5])); sv magic_packet ([Byte[]](,0xFF * 102)); 6..101 | ForEach-Object { ((gv magic_packet).Value)[((gv _).Value)] = ((gv mac_byte_array).Value)[(((gv _).Value)%6)]}; sv UDPclient (New-Object System.Net.Sockets.UdpClient); ((gv UDPclient).Value).Connect(([System.Net.IPAddress]::Broadcast),4000); ((gv UDPclient).Value).Send(((gv magic_packet).Value), ((gv magic_packet).Value).Length) | Out-Null;') -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
#
# Run program as NON-Admin from an elevated session-terminal
#  |
#  |--> Permission Step-Down/De-Escalation/De-Elevation via a temporary NON-elevated scheduled task which runs desired runtime
#


If (1 -Eq 1) {
  SV TEMP_Execute C:\Windows\System32\notepad.exe;
  SV TEMP_Name (Get-Date -UFormat (([String][Char]37)+([String][Char]115)));
  SV TEMP_Action (New-ScheduledTaskAction -Execute ((GV TEMP_Execute).Value));
  SV TEMP_Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date));
  Register-ScheduledTask -Action ((GV TEMP_Action).Value) -Trigger ((GV TEMP_Trigger).Value) -TaskName ((GV TEMP_Name).Value) | Out-Null;
  Start-ScheduledTask -TaskName ((GV TEMP_Name).Value);
  Start-Sleep -Seconds 1;
  Unregister-ScheduledTask -TaskName ((GV TEMP_Name).Value) -Confirm:([Boolean](0));
}

# As a one-liner:
If (1 -Eq 1) { SV TEMP_Execute C:\Windows\System32\notepad.exe; SV TEMP_Name (Get-Date -UFormat (([String][Char]37)+([String][Char]115))); SV TEMP_Action (New-ScheduledTaskAction -Execute ((GV TEMP_Execute).Value)); SV TEMP_Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date)); Register-ScheduledTask -Action ((GV TEMP_Action).Value) -Trigger ((GV TEMP_Trigger).Value) -TaskName ((GV TEMP_Name).Value) | Out-Null; Start-ScheduledTask -TaskName ((GV TEMP_Name).Value); Start-Sleep -Seconds 1; Unregister-ScheduledTask -TaskName ((GV TEMP_Name).Value) -Confirm:([Boolean](0)); };


# As a nested command intended to be used from an external app kicking off this command through cmd
cmd.exe /C "powershell.exe -WindowStyle Hidden -Command ""If (1 -Eq 1) { SV TEMP_Execute C:\Windows\System32\notepad.exe; SV TEMP_Name (Get-Date -UFormat (([String][Char]37)+([String][Char]115))); SV TEMP_Action (New-ScheduledTaskAction -Execute ((GV TEMP_Execute).Value)); SV TEMP_Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date)); Register-ScheduledTask -Action ((GV TEMP_Action).Value) -Trigger ((GV TEMP_Trigger).Value) -TaskName ((GV TEMP_Name).Value); Start-ScheduledTask -TaskName ((GV TEMP_Name).Value); Start-Sleep -Seconds 1; Unregister-ScheduledTask -TaskName ((GV TEMP_Name).Value) -Confirm:([Boolean](0)); };"""


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