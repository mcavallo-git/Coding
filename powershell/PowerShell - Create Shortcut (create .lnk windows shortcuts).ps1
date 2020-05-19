# ------------------------------------------------------------

<# Example Shortcut #>

<# Windows Updates (Creates a shortcut on the desktop) - Open, Check-for, and Download "Windows Updates" (let user select the "Install Now" button) #>
$NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Home}\Desktop\Check for Updates.lnk");
$NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe");
$NewShortcut.Arguments=("-Command `"Start-Process -Filepath ('C:\Windows\explorer.exe') -ArgumentList (@('ms-settings:windowsupdate')); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());`"");
$NewShortcut.WorkingDirectory=("");
$NewShortcut.Save();


# ------------------------------------------------------------