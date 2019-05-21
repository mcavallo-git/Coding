#
# ------------------------------------------------------------
#
#	Get-ChildItem
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
# Locate all files named "config" who have the parent directory ".git" which is located somewhere under the current-user's "${HOME}" directory
#
Get-ChildItem -Path "${HOME}" -Filter "config" -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq ".git"} | Foreach-Object { $_.Directory.Parent.FullName; }



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
