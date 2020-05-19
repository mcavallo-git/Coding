
$NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($EachResolvedArr.Shortcut_Location);
$NewShortcut.TargetPath=($EachResolvedArr.Shortcut_Target);
$NewShortcut.Arguments=("-Command ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());");
$NewShortcut.WorkingDirectory=($EachResolvedArr.Shortcut_WorkingDir);
$NewShortcut.Save();
$NewShortcut.FullName; # Show the filepath of the newly-created shortcut

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe "-Command ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());"