ForEach ($EachItem In ((Get-ChildItem -File -Path ($Home) -Include ("*\GitHub\*") -Recurse).GetEnumerator())) {
Write-Host "EachItem.FullName"; $EachItem.FullName;
}

#
# Get-ChildItem switch-parameter "-Directory" returns items with type "System.IO.FileSystemInfo.DirectoryInfo"
#
# Get-ChildItem switch-parameter "-File" returns items with type "System.IO.FileSystemInfo.FileInfo"
#


#
#
#
#
#		https://docs.microsoft.com/en-us/dotnet/api/system.io.directoryinfo
#
#
#	Citation(s)
#		
#		Icon file "GitSyncAll.ico" thanks-to:  https://docs.microsoft.com/en-us/dotnet/api/system.io.directoryinfo

#

#		docs.microsoft.com
#			"DirectoryInfo Class"
#		 	 https://docs.microsoft.com/en-us/dotnet/api/system.io.directoryinfo
#
#		docs.microsoft.com
#			"FileInfo Class"
#		 	 https://docs.microsoft.com/en-us/dotnet/api/system.io.fileinfo
#
