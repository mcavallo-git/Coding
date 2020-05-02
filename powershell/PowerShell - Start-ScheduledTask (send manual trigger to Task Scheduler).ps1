# ------------------------------------------------------------
#
# Kick-off a scheduled task via PowerShell
#

Start-ScheduledTask -TaskName "GitSyncAll";


# ------------------------------------------------------------
#
# Determine task names (to apply to Start-ScheduldTask once found)
#

(Get-ScheduledTask).TaskName;


# ------------------------------------------------------------
#
#	Citation(s)
#
#  	docs.microsoft.com  |  "Start-ScheduledTask - Starts one or more instances of a scheduled task"  |  https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/start-scheduledtask
#
# ------------------------------------------------------------