CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""If (Get-Process -Name 'ONENOTEM' -ErrorAction 'SilentlyContinue') { Stop-Process -Name 'ONENOTEM' -Force -ErrorAction 'SilentlyContinue'; Start-Sleep 1; Remove-Item -Path ('~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Send to OneNote*') -Force; Start-Sleep 1; Remove-Item -Path ('~\Documents\OneNote Notebooks\Quick Notes*.one') -Force; Exit 200; } Else { Exit 404; }"" ", 0, True

' Program/script:   C:\Windows\System32\wscript.exe
' Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\QuickNoteSniperNonAdmin.vbs"

' Trigger: Every [ 5 Minutes ] for a duration of [ 1436 Minutes ] - Stop task if it runs longer than [ 30 seconds ]