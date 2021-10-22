CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Stop-Process -Name nginx -ErrorAction SilentlyContinue;"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     NGINX_KillAll
'
'   Trigger:
'     [ Manually triggered ]
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\NGINX_KillAll.vbs"
'
'   Run only when user is logged on (UN-CHECKED)
'   Run with highest privileges (UN-CHECKED)
'
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   nginx.org  |  "nginx: download"  |  https://nginx.org/en/download.html
'
' ------------------------------------------------------------