# ------------------------------------------------------------
# PowerShell - Create shortcut, get shortcut properties (create .lnk windows shortcuts, get .lnk info)
# ------------------------------------------------------------


<# Create a "Windows Updates" shortcut on the desktop #> 
$Filepath_NewShortcut = "${Home}\Desktop\Check for Updates.lnk";
$NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Filepath_NewShortcut}");
$NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe");
$NewShortcut.Arguments=("-Command `"Start-Process -Filepath ('C:\Windows\explorer.exe') -ArgumentList (@('ms-settings:windowsupdate')); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());`"");
$NewShortcut.WorkingDirectory=("");
$NewShortcut.Save();

<# Run the shortcut as Admin #>
$Bytes_NewShortcut = [System.IO.File]::ReadAllBytes("${Filepath_NewShortcut}");
$Bytes_NewShortcut[0x15] = ($Bytes_NewShortcut[0x15] -bor 0x20); <# Perform a Bitwise-OR which checks the "Run as administrator" option on the shortcut #>
[System.IO.File]::WriteAllBytes("${Filepath_NewShortcut}", ${Bytes_NewShortcut});


# ------------------------------------------------------------
#
# Get shortcut properties
#

Function Get-DesktopShortcuts {
  $Shortcuts = (Get-ChildItem -Recurse "${HOME}\Desktop" -Include *.lnk);
  $Shell = New-Object -ComObject WScript.Shell;
  foreach ($Shortcut in $Shortcuts) {
    $Properties = @{
      ShortcutName = $Shortcut.Name;
      ShortcutFull = $Shortcut.FullName;
      ShortcutPath = $shortcut.DirectoryName;
      Target = $Shell.CreateShortcut($Shortcut).targetpath;
    }
    New-Object PSObject -Property $Properties;
  }
  [Runtime.InteropServices.Marshal]::ReleaseComObject($Shell) | Out-Null;
};

Get-DesktopShortcuts | Format-List *;





# ------------------------------------------------------------
#
# Citation(s)
#
#   social.technet.microsoft.com  |  "get target path of shortcuts"  |  https://social.technet.microsoft.com/Forums/en-US/fddb6ec0-cc48-43f0-929e-bf25d07fbf48
#
#   stackoverflow.com  |  "windows - How to create a Run As Administrator shortcut using Powershell - Stack Overflow"  |  https://stackoverflow.com/a/29002207
#
# ------------------------------------------------------------