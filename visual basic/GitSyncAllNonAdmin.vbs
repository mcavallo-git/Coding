CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/GitSyncAll/GitSyncAll.psm1')); GitSyncAll -Pull;"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'
'   General:
'     Name:  GitSyncAll -Pull
'     Location:  \
'     Author:  (WINDOWS USER TO PULL REPOS AT LOGON FOR)
'     Description:  GitSyncAll -Pull
'     Security Options:
'        When running the task, use the following user account:  (WINDOWS USER TO PULL REPOS AT LOGON FOR)
'        (SELECT) Run only when user is logged on
'        (UNCHECK)  Run with highest privileges
'
'
'   Trigger:
'     (1) Begin the task:  At log on
'          |--> Specific User:  (WINDOWS USER TO PULL REPOS AT LOGON FOR)
'          |--> Delay task for:  15 seconds
'          |--> Stop task if it runs loger than:  30 seconds
'          |--> (CHECK) Enabled
'     (2) Begin the task:  On workstation unlock
'          |--> Specific User:  (WINDOWS USER TO PULL REPOS AT LOGON FOR)
'          |--> (CHECK) Enabled
'
'
'   Action:
'     Action:          Start a program
'     Program/script:  C:\Windows\System32\wscript.exe
'     Add arguments:   "%USERPROFILE%\Documents\GitHub\Coding\visual basic\GitSyncAllNonAdmin.vbs"
'     Start in (optional):
'
'
'   Conditions:
'     (UNCHECK ALL)
'     (CHECK) Start only if the following network connection is available: [ Any connection ]
'
'
'   Settings:
'     (CHECK)    Allow task to be run on demand
'     (UNCHECK)  Run as soon as possible after a scheduled start is missed
'     (UNCHECK)  If the task fails, restart every: ...
'     (UNCHECK)  Stop this task if it runs longer than:
'     (CHECK)    If the running task does not end when requested, force it to stop
'     (UNCHECK)  If the task is not scheduled to run again, delete it after: ...
'
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   git-scm.com  |  "Git"  |  https://git-scm.com
'
' ------------------------------------------------------------