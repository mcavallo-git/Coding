CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""If (Get-Process -Name 'ONENOTEM' -ErrorAction 'SilentlyContinue') { Stop-Process -Name 'ONENOTEM' -Force -ErrorAction 'SilentlyContinue'; Start-Sleep 1; Remove-Item -Path ('~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Send to OneNote*') -Force; Start-Sleep 1; Remove-Item -Path ('~\Documents\OneNote Notebooks\Quick Notes*.one') -Force; Exit 200; } Else { Exit 404; }"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     QuickNoteSniper_NonAdmin
'
'   Security Options:
'     Run only when user is logged on (UN-CHECKED)
'     Run whether user is logged on or not (CHECKED)
'     Run with highest privileges (UN-CHECKED)
'
'   Trigger:
'     At log on of any user - After triggered, repeat every [ 5 minutes ] for a duration of [ 1436 minutes ]
'
'   Settings:
'     (CHECK)    Stop this task if it runs longer than:  2 minutes
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\QuickNoteSniper_NonAdmin.vbs"
'
'
' ------------------------------------------------------------