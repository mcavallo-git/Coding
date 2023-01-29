# ------------------------------------------------------------
# Windows - Startup programs (Run, RunOnce, triggered at user logon, Task Manager Startup items, msconfig)
# ------------------------------------------------------------
#
# Note:  All startup application sources are grouped together and shown under Task Manager's "Startup" tab
#
# Microsoft:  "Use Run or RunOnce registry keys to make a program run when a user logs on."
#

# Run  (System)  -  Run a given command the next time ANY user logs on
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run

# RunOnce  (System)  -  Run a given command the next time ANY user logs on (but first remove the command from the "RunOnce" registry key)
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce


# Run  (User)  -  Run a given command the next time CURRENT user logs on
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run

# RunOnce  (User)  -  Run a given command the next time CURRENT user logs on (but first remove the command from the "RunOnce" registry key)
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce


# Start menu startup directory (System)
%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp

# Start menu startup directory (User)
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup    # Shortcut:  shell:startup


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Run and RunOnce Registry Keys - Windows applications | Microsoft Docs"  |  https://learn.microsoft.com/en-us/windows/win32/setupapi/run-and-runonce-registry-keys
#
#   stackoverflow.com  |  "authentication - What's the order of Windows startup? - Stack Overflow"  |  https://stackoverflow.com/a/13686964
#
#   superuser.com  |  "boot - What is the difference between Run registry key and Startup Folder (in Start Menu)? - Super User"  |  https://superuser.com/a/300116
#
#   support.microsoft.com  |  "authentication - What's the order of Windows startup? - Stack Overflow"  |  https://support.microsoft.com/en-us/windows/add-an-app-to-run-automatically-at-startup-in-windows-10-150da165-dcd9-7230-517b-cf3c295d89dd
#
# ------------------------------------------------------------