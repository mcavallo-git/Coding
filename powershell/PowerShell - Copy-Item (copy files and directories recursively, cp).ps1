# ------------------------------------------------------------
# PowerShell - Copy-Item (copy files and directories recursively, cp)
# ------------------------------------------------------------
#
# Copy file
#

Copy-Item -Path (${Source}) -Destination (${Destination}) -Force;


# ------------------------------------------------------------
#
# Copy directory & all contents
#

If ($True) {
  [String]$Source="${env:USERPROFILE}\Desktop\Source\*";
  [String]$Destination="${env:USERPROFILE}\Desktop\Destination\";
  # Ensure destination directory exists
  If (($False) -Eq (Test-Path -PathType "Container" -Path ("${Destination}"))) {
    New-Item -ItemType "Directory" -Path ("${Destination}") | Out-Null;
  }
  # Copy files & directories from source to destination
  Copy-Item -Force -Recurse -Path (${Source}) -Destination (${Destination});
}


# ------------------------------------------------------------
#
# Copy directory & contents >>ONLY<< matching one or more extensions  (only seems to work 1 directory deep?)
#

If ($True) {
  [String]$Source="${env:USERPROFILE}\Desktop\Source\*";
  [String]$Destination="${env:USERPROFILE}\Desktop\Destination\";
  [String[]]$Includes=@("*.ico","*.url");
  # Ensure destination directory exists
  If (($False) -Eq (Test-Path -PathType "Container" -Path ("${Destination}"))) {
    New-Item -ItemType "Directory" -Path ("${Destination}") | Out-Null;
  }
  # Copy files & directories from source to destination
  Copy-Item -Force -Recurse -Path (${Source}) -Destination (${Destination}) -Include (${Includes});
}


# ------------------------------------------------------------
#
# Copy directory & contents >>NOT<< matching one or more extensions
#

If ($True) {
  [String]$Source="${env:USERPROFILE}\Desktop\Source\*";
  [String]$Destination="${env:USERPROFILE}\Desktop\Destination\";
  [String[]]$Excludes=@("*.lnk","*.url");
  # Ensure destination directory exists
  If (($False) -Eq (Test-Path -PathType "Container" -Path ("${Destination}"))) {
    New-Item -ItemType "Directory" -Path ("${Destination}") | Out-Null;
  }
  # Copy files & directories from source to destination
  Copy-Item -Force -Recurse -Path (${Source}) -Destination (${Destination}) -Exclude (${Excludes});
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