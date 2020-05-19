

<# Open the "Windows Update" page within Windows' "Settings" App #>
Start-Process -Filepath ("C:\Windows\explorer.exe") -ArgumentList (@("ms-settings:windowsupdate"));


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Launch the Windows Settings app - UWP applications | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/uwp/launch-resume/launch-settings-app
#
#   www.windows-commandline.com  |  "Run command for Windows update"  |  https://www.windows-commandline.com/run-command-for-windows-update/
#
# ------------------------------------------------------------