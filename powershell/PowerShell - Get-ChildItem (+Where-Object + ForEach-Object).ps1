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
# ------------------------------------------------------------
#
# Example 1 (Git oriented)
#		Search for any git-repositories located within the ${HOME} directory (same as %USERPROFILE% on cmd)
#		 |--> Syntax performs a lookup by beginning at the users ${HOME} directory and searching for files named "config" who have an immediate-parent directory named ".git"
#
Get-ChildItem -Path "${HOME}" -Filter "config" -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq ".git"} | Foreach-Object { $_.Directory.Parent.FullName; }
#
# ------------------------------------------------------------
#
#	Example 2 (GnuPG oriented)
# 	Search the main drive for files named 'gpg.exe'
#		 |--> Note: On windows devices, "/" resolves to the systemdrive (commonly "C:") with a backslash ("\") appended, by default
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
