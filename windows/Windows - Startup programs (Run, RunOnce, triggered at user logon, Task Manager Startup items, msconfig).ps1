# ------------------------------------------------------------
# Windows - Startup programs (Run, RunOnce, triggered at user logon, Task Manager Startup items, msconfig)
# ------------------------------------------------------------
#
# Microsoft: "Use Run or RunOnce registry keys to make a program run when a user logs on."
#

#  Run  (System)    -  Run a given command the next time ANY user logs on       ⚠️ Startup Program(s) ⚠️
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run

#  Run  (System)    -  Run a given command the next time CURRENT user logs on   ⚠️ Startup Program(s) ⚠️
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run


#  RunOnce  (User)  -  Run a given command the next time ANY user logs on (but first remove the command from the "RunOnce" registry key)
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce

#  RunOnce  (User)  -  Run a given command the next time CURRENT user logs on (but first remove the command from the "RunOnce" registry key)
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Run and RunOnce Registry Keys - Windows applications | Microsoft Docs"  |  https://learn.microsoft.com/en-us/windows/win32/setupapi/run-and-runonce-registry-keys
#
# ------------------------------------------------------------