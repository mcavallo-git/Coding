# ------------------------------------------------------------
#
# PowerShell - MKLINK (Symbolic Links via CMD)
#
# ------------------------------------------------------------

<# MKLINK - Redirect one directory to another (via CMD) #>
$REDIRECT_FROM="${HOME}\Desktop\from";
$REDIRECT_TO="${HOME}\Desktop\to";
Start-Process -Filepath ("${env:COMSPEC}") -ArgumentList (@("/C", "MKLINK /D `"${REDIRECT_FROM}`" `"${REDIRECT_TO}`"")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------

<# MKLINK - Show all symbolic links (via CMD) #>
Start-Process -Filepath ("${env:COMSPEC}") -ArgumentList (@("/C", "DIR /AL /S `"${HOME}\`"")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------

<# MKLINK - Determine if target path is a Symbolic Link #>
If ((Get-Item "${Home}\Documents").Attributes.ToString() -Match "ReparsePoint") {
  Write-Host "Is a Symbolic Link / MKLink";
} Else {
  Write-Host "Is NOT a Symbolic Link / MKLink";
}


# ------------------------------------------------------------

<# Ex)  *** WINDOWS FAX AND SCAN *** - Dredirect scans going into [ My Documents -> Scanned Documents ] to be placed on the desktop, instead #>
If ($True) {
<# *** WINDOWS FAX AND SCAN *** - Dredirect scans going into [ My Documents -> Scanned Documents ] to be placed on the desktop, instead #>
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
#
# "It is a pretty minimal implementation, but it should do the trick. Note that this doesn't distinguish between a hard link and a symbolic link. Underneath, they both just take advantage of NTFS reparse points, IIRC." (From OP (from ??? reference))
#
function Test-ReparsePoint([string]$path) {
  $file = Get-Item $path -Force -ea SilentlyContinue;
  return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint);
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "symlink - Find out whether a file is a symbolic link in PowerShell - Stack Overflow"  |  https://stackoverflow.com/a/818054
#
#   thomasrayner.ca  |  "Quick Tip - Use PowerShell To Detect If A Location Is A Directory Or A Symlink – Thomas Rayner – Writing code & automating IT"  |  https://thomasrayner.ca/quick-tip-use-powershell-to-detect-if-a-location-is-a-directory-or-a-symlink/
#
# ------------------------------------------------------------