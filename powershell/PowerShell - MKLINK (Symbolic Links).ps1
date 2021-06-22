# ------------------------------------------------------------
#
# PowerShell - MKLINK (Symbolic Links via CMD)
#
# ------------------------------------------------------------

<# MKLINK - Redirect one directory to another #>
$REDIRECT_FROM="${HOME}\Desktop\from";
$REDIRECT_TO="${HOME}\Desktop\to";
Start-Process -Filepath ("${env:COMSPEC}") -ArgumentList (@("/C","MKLINK /D `"${REDIRECT_FROM}`" `"${REDIRECT_TO}`"")) -NoNewWindow  -Wait -PassThru -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------

<# *** WINDOWS FAX AND SCAN *** - Dredirect scans going into [ My Documents -> Scanned Documents ] to be placed on the desktop, instead #>
If ($True) {
	$REDIRECT_FROM="${HOME}\Documents\Scanned Documents";
	$REDIRECT_TO="${HOME}\Desktop";
	<# Make sure destination directory exists #>
	If (-Not (Test-Path -PathType "Container" -Path ("${REDIRECT_TO}"))) { <# Ensure that the destination directory exists #>
		New-Item -ItemType "Directory" -Path ("${REDIRECT_TO}") | Out-Null;
	}
	If (Test-Path -PathType "Container" -Path ("${REDIRECT_FROM}")) { <# Ensure that the source directory (which will become a symbolic link) does NOT exist, and that if it DOES exist, that its files are copied to the destination directory before the source directory is removed #>
		Copy-Item -Path ("${REDIRECT_FROM}\*") -Destination ("${REDIRECT_TO}") -Force -Recurse;
		Remove-Item -Path ("$REDIRECT_FROM") -Recurse -Force -Confirm:$False;
	}
	Start-Process -Filepath ("${env:COMSPEC}") -ArgumentList (@("/C","MKLINK /D `"${REDIRECT_FROM}`" `"${REDIRECT_TO}`"")) -NoNewWindow  -Wait -PassThru -ErrorAction ("SilentlyContinue");
}


# ------------------------------------------------------------
#
# From OP:
#   "It is a pretty minimal implementation, but it should do the trick. Note that this doesn't distinguish between a hard link and a symbolic link. Underneath, they both just take advantage of NTFS reparse points, IIRC."
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
# ------------------------------------------------------------