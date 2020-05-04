# ------------------------------------------------------------
#
# Kick-off a scheduled task via PowerShell
#

Start-ScheduledTask -TaskName "GitSyncAll";


# ------------------------------------------------------------
#
# Rmotely Kick-Off one (or more) separate device's scheduled task(s)
#

$cimSession = New-CimSession -ComputerName SERVER1,SERVER2,SERVER3,SERVER4
Start-ScheduledTask TASKNAME -CimSession $cimSession;
Remove-CimSession $cimSession;


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
#  	www.granikos.eu  |  "Just can't get enough of IT | Start Scheduled Tasks remotely"  |  https://www.granikos.eu/en/justcantgetenough/PostId/184/start-scheduled-tasks-remotely
#
# ------------------------------------------------------------