' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     _EntertainmentHotkeys_NonAdmin
'
'   Security Options:
'     Run only when user is logged on (CHECKED)
'     Run whether user is logged on or not (UN-CHECKED)
'     Run with highest privileges (UN-CHECKED)
'
'   Trigger:
'     At log on of [current user]
'
'   Action:
'     Program/script:   "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe"
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\ahk\_EntertainmentHotkeys.ahkv2"
'
'   Conditions:
'     (UN-CHECK) Start the task only if the computer is on AC power
'
'   Settings:
'     (UN-CHECK) Stop this task if it runs longer than:  (UN-CHECK)
'     (CHECK)    If the task is already running, then the following rule applies: [ Do not start a new instance ]
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   www.autohotkey.com  |  "Autohotkey Version 2 Downloads"  |  https://www.autohotkey.com/download/2.0/
'
' ------------------------------------------------------------