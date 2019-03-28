

$Target = "${Env:ProgramFiles}\Mozilla Firefox\firefox.exe";

$Arguments = "";

$Location = (($PSScriptRoot)+("/TestShortcut-")+(Get-Date -Format "%Y%m%d_%H%M%S")+(".lnk"));




$NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($Location);

$NewShortcut.TargetPath=($Target);

$NewShortcut.Arguments=($Arguments);

$NewShortcut.WorkingDirectory=('%cd%');

$NewShortcut.Save();




# Show the Shortcut's name
$NewShortcut.FullName;

