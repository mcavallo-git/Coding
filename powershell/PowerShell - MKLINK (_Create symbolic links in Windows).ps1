# ------------------------------------------------------------
# PowerShell - MKLINK (_create symbolic links in Windows)
# ------------------------------------------------------------

# MKLINK "NEW_LINK" "EXISTING_FILE"

# MKLINK /D "NEW_LINK" "EXISTING_DIR"

# ------------------------------------------------------------

# MKLINK - Redirect one directory to another (via CMD)
$REDIRECT_FROM="${HOME}\Desktop\from";
$REDIRECT_TO="${HOME}\Desktop\to";
Start-Process -Filepath ("${env:COMSPEC}") -ArgumentList (@("/C", "MKLINK /D `"${REDIRECT_FROM}`" `"${REDIRECT_TO}`"")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------

# MKLINK - Show all symbolic links (via CMD)
Start-Process -Filepath ("${env:COMSPEC}") -ArgumentList (@("/C", "DIR /AL /S `"${HOME}\`"")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------

# MKLINK - Determine if target path is a Symbolic Link
If ((Get-Item "${Home}\Documents").Attributes.ToString() -Match "ReparsePoint") {
  Write-Host "Is a Symbolic Link / MKLink";
} Else {
  Write-Host "Is NOT a Symbolic Link / MKLink";
}


# ------------------------------------------------------------
#
# "It is a pretty minimal implementation, but it should do the trick. Note that this doesn't distinguish between a hard link and a symbolic link. Underneath, they both just take advantage of NTFS reparse points, IIRC." (From OP (from ??? reference))
#
Function Test-ReparsePoint([string]$path) {
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