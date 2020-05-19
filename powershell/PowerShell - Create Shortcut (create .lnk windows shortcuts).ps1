
<# Example Shortcut #>

<# Create a shortcut on current user's Desktop which triggers Windows Updates' "Check for updates" command then opens the "Windows Update" page within Windows' "Settings" App #>
$NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Home}\Desktop\Check for Updates.lnk");
$NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe");
$NewShortcut.Arguments=("-Command `"((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()); Start-Process -Filepath ('C:\Windows\explorer.exe') -ArgumentList (@('ms-settings:windowsupdate'));`"");
$NewShortcut.WorkingDirectory=("");
$NewShortcut.Save();

