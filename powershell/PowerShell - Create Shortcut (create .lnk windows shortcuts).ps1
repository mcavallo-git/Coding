
<# Example - Create a shortcut on current user's Desktop which triggers Windows Updates' "Check for updates" command #>
$NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Home}\Desktop\Check for Updates.lnk");
$NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe");
$NewShortcut.Arguments=("-Command `"((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());`"");
$NewShortcut.WorkingDirectory=("");
$NewShortcut.Save();
