# ------------------------------------------------------------

# MKLINK "NEW_LINK" "EXISTING_FILE"

# MKLINK /D "NEW_LINK" "EXISTING_DIR"

# ------------------------------------------------------------

If ($True) {
  <# *** WINDOWS FAX AND SCAN *** - Redirect scans going into [ "Documents\Scanned Documents" ] (default) to goto the Desktop, instead #>
  $REDIRECT_FROM_LINK="${HOME}\Documents\Scanned Documents";
  $REDIRECT_TO_EXISTING="${HOME}\Desktop";
  If ((Get-Item "${REDIRECT_FROM_LINK}").Attributes.ToString() -Match "ReparsePoint") {
    Write-Host "Path `"${REDIRECT_FROM_LINK}`" is already Symbolic Link / MKLink";
  } Else {
    <# Make sure destination directory exists #>
    If (-Not (Test-Path -PathType "Container" -Path ("${REDIRECT_TO_EXISTING}"))) { <# Ensure that the destination directory exists #>
      New-Item -ItemType "Directory" -Path ("${REDIRECT_TO_EXISTING}") | Out-Null;
    }
    If (Test-Path -PathType "Container" -Path ("${REDIRECT_FROM_LINK}")) { <# Ensure that the source directory (which will become a symbolic link) does NOT exist, and that if it DOES exist, that its files are copied to the destination directory before the source directory is removed #>
      Copy-Item -Path ("${REDIRECT_FROM_LINK}\*") -Destination ("${REDIRECT_TO_EXISTING}") -Force -Recurse;
      Remove-Item -Path ("${REDIRECT_FROM_LINK}") -Recurse -Force -Confirm:$False;
    }
    Start-Process -Filepath ("${env:COMSPEC}") -ArgumentList (@("/C","MKLINK /D `"${REDIRECT_FROM_LINK}`" `"${REDIRECT_TO_EXISTING}`"")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue");
  }
}


# ------------------------------------------------------------