If ($True) {
  #
  # PowerShell - Sync "_icons_du_dope" to System32 directory
  #
  [String]$Source="${env:REPOS_DIR}\Coding\windows\windows-icons\_icons_du_dope\*";
  [String]$Destination="${env:windir}\System32\_icons_du_dope\";
  # Ensure source directory exists
  If (($True) -Eq (Test-Path -PathType "Container" -Path (${Source} -split {($_ -Eq "*") -Or ($_ -Eq "]")} -join ""))) {
    # Ensure destination directory exists
    If (($False) -Eq (Test-Path -PathType "Container" -Path ("${Destination}"))) {
      New-Item -ItemType "Directory" -Path ("${Destination}") | Out-Null;
    }
    # Copy files & directories from source to destination
    Copy-Item -Force -Recurse -Path (${Source}) -Destination (${Destination});
  }
}