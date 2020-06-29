# ------------------------------------------------------------


<# Windows Updates - Open, Check-for, and Download "Windows Updates" (let user select the "Install Now" button) #>
Start-Process -Filepath ("C:\Windows\explorer.exe") -ArgumentList (@("ms-settings:windowsupdate")); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());


<# Windows Updates - Open the "Windows Update" page within Windows' "Settings" App #>
Start-Process -Filepath ("C:\Windows\explorer.exe") -ArgumentList (@("ms-settings:windowsupdate"));


# ------------------------------------------------------------

<# Create a "Windows Updates" shortcut on the desktop #> $Filepath_NewShortcut = "${Home}\Desktop\Check for Updates.lnk"; $NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Filepath_NewShortcut}"); $NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"); $NewShortcut.Arguments=("-Command `"Start-Process -Filepath ('C:\Windows\explorer.exe') -ArgumentList (@('ms-settings:windowsupdate')); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());`""); $NewShortcut.WorkingDirectory=(""); $NewShortcut.Save(); <# Enable/Check the Advanced Property [ Run as administrator ] on the shortcut #> $Bytes_NewShortcut = [System.IO.File]::ReadAllBytes("${Filepath_NewShortcut}"); $Bytes_NewShortcut[0x15] = ($Bytes_NewShortcut[0x15] -bor 0x20); [System.IO.File]::WriteAllBytes("${Filepath_NewShortcut}", ${Bytes_NewShortcut});


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Launch the Windows Settings app - UWP applications | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/uwp/launch-resume/launch-settings-app
#
#   www.windows-commandline.com  |  "Run command for Windows update"  |  https://www.windows-commandline.com/run-command-for-windows-update/
#
# ------------------------------------------------------------