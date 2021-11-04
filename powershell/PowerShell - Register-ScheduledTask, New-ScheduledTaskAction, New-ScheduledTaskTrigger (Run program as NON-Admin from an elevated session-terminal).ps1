
#
# Permissions Step-Down / De-Escalation / De-Elevation 
#  |
#  |--> Remove admin-permissions by creating a temporary scheduled task which runs [target runtime] with NON-elevated permissions
#
If (1 -Eq 1) {
	SV TEMP_Command C:\Windows\System32\notepad.exe;
	SV TEMP_Name (Get-Date -UFormat (([String][Char]37)+([String][Char]115)));
	SV TEMP_Action (New-ScheduledTaskAction -Execute ((GV TEMP_Command).Value));
	SV TEMP_Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date));
	Register-ScheduledTask -Action ((GV TEMP_Action).Value) -Trigger ((GV TEMP_Trigger).Value) -TaskName ((GV TEMP_Name).Value) | Out-Null;
	Start-ScheduledTask -TaskName ((GV TEMP_Name).Value);
	Start-Sleep -Seconds 1;
	Unregister-ScheduledTask -TaskName ((GV TEMP_Name).Value) -Confirm:([Boolean](0));
}

# As a one-liner:
If (1 -Eq 1) { SV TEMP_Command C:\Windows\System32\notepad.exe; SV TEMP_Name (Get-Date -UFormat (([String][Char]37)+([String][Char]115))); SV TEMP_Action (New-ScheduledTaskAction -Execute ((GV TEMP_Command).Value)); SV TEMP_Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date)); Register-ScheduledTask -Action ((GV TEMP_Action).Value) -Trigger ((GV TEMP_Trigger).Value) -TaskName ((GV TEMP_Name).Value) | Out-Null; Start-ScheduledTask -TaskName ((GV TEMP_Name).Value); Start-Sleep -Seconds 1; Unregister-ScheduledTask -TaskName ((GV TEMP_Name).Value) -Confirm:([Boolean](0)); };


# As a nested command intended to be used from an external app kicking off this command through cmd
cmd.exe /C "powershell.exe -WindowStyle Hidden -Command ""If (1 -Eq 1) { SV TEMP_Command C:\Windows\System32\notepad.exe; SV TEMP_Name (Get-Date -UFormat (([String][Char]37)+([String][Char]115))); SV TEMP_Action (New-ScheduledTaskAction -Execute ((GV TEMP_Command).Value)); SV TEMP_Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date)); Register-ScheduledTask -Action ((GV TEMP_Action).Value) -Trigger ((GV TEMP_Trigger).Value) -TaskName ((GV TEMP_Name).Value); Start-ScheduledTask -TaskName ((GV TEMP_Name).Value); Start-Sleep -Seconds 1; Unregister-ScheduledTask -TaskName ((GV TEMP_Name).Value) -Confirm:([Boolean](0)); };"""


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