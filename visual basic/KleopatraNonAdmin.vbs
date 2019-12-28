CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""EnsureProcessIsRunning -Name 'kleopatra' -Path 'C:\Program Files (x86)\Gpg4win\bin\kleopatra.exe' -Quiet -WindowStyle 'Hidden';"" ", 0, True

' Program/script:   C:\Windows\System32\wscript.exe
' Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\KleopatraNonAdmin.vbs"

' Trigger: At log on
