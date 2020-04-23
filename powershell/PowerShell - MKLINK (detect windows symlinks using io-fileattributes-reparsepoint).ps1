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