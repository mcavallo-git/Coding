# ------------------------------------------------------------
#
#   PowerShell - ForEach-Object (For & ForEach Loops)
#
# ------------------------------------------------------------

Get-WindowsOptionalFeature -Online `
| ForEach-Object {
	Write-Output "------------------------------------------------------------";
	$_ | Format-Table;
	Write-Output "------------------------------------------------------------";
}

#
# ------------------------------------------------------------
#
#	Get-ChildItem
#		PowerShell's [ Get-ChildItem ] command is essentially a equivalent to Linux's [ find ] command
#		(barring case-sensitivty by default & much more - just relating at a high-level)
#		
#		Parameters
#				-Directory		returns items with type "System.IO.FileSystemInfo.DirectoryInfo"   (see "DirectoryInfo Class", below)
#				-File					returns items with type "System.IO.FileSystemInfo.FileInfo"   (see "FileInfo Class", below)
#				-Filter				used to perform narrowed, more-specific searches than -Include (second-stage matching, essentially)
#				-Force				searches for hidden & non-hidden items   (may vary depending on provider - see "About Providers", below)
#				-Include			used to perform general searches, commonly with wildcards
#
#
# ------------------------------------------------------------
#
#		Example
#			|--> Overview: Find files with multiple different levels of depth, parent-filenames, basenames, etc. matching multiple different criteria, all in one query
#			|--> Use: Lock-Screen background fix - Used this script to locate files to-be-deleted
#
$Basename="*";
$Parent_1="Settings"; # one step back (first directory name)
$Parent_2="Microsoft.Windows.ContentDeliveryManager_*"; # another step back
$Parent_X="${Env:USERPROFILE}\AppData\Local\Packages\"; # remaining steps-back to the root directory ("/" in linux, or the drive letter, such as "C:\", in Windows)
(`
Get-ChildItem `
-Path ("$Parent_X") `
-Depth (3) `
-File `
-Recurse `
-Force `
-ErrorAction "SilentlyContinue" `
| Where-Object { $_.Directory.Parent.Name -Like "$Parent_2" } `
| Where-Object { $_.Directory.Name -Like "$Parent_1" } `
| Where-Object { $_.Name -Like "$Basename" } `
| ForEach-Object { $_.FullName; } `
);


# ------------------------------------------------------------
#
#		Example
#			|--> Overview: Search for any git-repositories located within the ${HOME} directory (same as %USERPROFILE% on cmd)
#			|--> Note: Syntax performs a lookup by beginning at the users ${HOME} directory and searching for files named "config" who have an immediate-parent directory named ".git"
#			|--> Use: Used for finding git-config files
#
Get-ChildItem -Path "${HOME}" -Filter "config" -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq ".git"} | Foreach-Object { $_.Directory.Parent.FullName; }


# ------------------------------------------------------------
#
#		Example
# 		|--> Overview: Search the main drive for files named 'gpg.exe'
#			|--> Note: On windows devices, "/" resolves to the systemdrive (commonly "C:") with a backslash ("\") appended, by default
#			|--> Use: Used for syncing all GnuPG (gpg.exe) configs found on a given workstation, so that they all contain the same config-vals (... e.g. 'synced')
#
Get-ChildItem -Path "/" -Filter "gpg.exe" -File -Recurse -Force -ErrorAction "SilentlyContinue" | Foreach-Object { $_.FullName; }


# ------------------------------------------------------------
#
#	Citation(s)
#
#
#		Source: docs.microsoft.com
#
#			"DirectoryInfo Class"
#		 		 https://docs.microsoft.com/en-us/dotnet/api/system.io.directoryinfo
#
#			"FileInfo Class"
#		 		 https://docs.microsoft.com/en-us/dotnet/api/system.io.fileinfo
#
#			"About Providers"
#		 		 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers
#
#			"About Wildcards" (using the -Filter parameter)
#		 		 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_wildcards
#
# ------------------------------------------------------------
