# ------------------------------------------------------------
# PowerShell - Copy-Item (copy files and directories recursively, cp)
# ------------------------------------------------------------
#
# PowerShell - Copy file(s) from Source filepath to Destination filepath
#

Copy-Item -Path ("${Source}") -Destination ("${Destination}") -Force;


# ------------------------------------------------------------
#
# PowerShell - Copy files and directories from Source directory to Destination directory
#

If ($True) {
  [string]$Source="${env:USERPROFILE}\Desktop\Source\*";
  [string]$Destination="${env:USERPROFILE}\Desktop\Destination\";
  # Ensure destination directory exists
  If (($False) -Eq (Test-Path -PathType "Container" -Path ("${Destination}"))) {
    New-Item -ItemType "Directory" -Path ("${Destination}") | Out-Null;
  }
  # Copy files & directories from source to destination
  Copy-Item -Force -Recurse -Path ("${Source}") -Destination ("${Destination}");
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Copy-Item (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-5.1
#
#   learn.microsoft.com  |  "New-Item (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-5.1
#
#   stackoverflow.com  |  "How to copy content of a folder to another specific folder using powershell? - Stack Overflow"  |  https://stackoverflow.com/a/36310667
#
# ------------------------------------------------------------