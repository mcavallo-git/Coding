# ------------------------------------------------------------
#
# PowerShell - Test-Path
#
# ------------------------------------------------------------

# Test if directory exists

$DIR_PATH_TO_TEST="${env:COMSPEC}";
If (Test-Path -PathType "Container" -Path ("${DIR_PATH_TO_TEST}")) {
	Write-Host "Info - Directory found: `"${DIR_PATH_TO_TEST}`"";
} Else {
	Write-Host "Error - Directory not found: `"${DIR_PATH_TO_TEST}`"";
	Write-Host "Info - Creating directory `"${DIR_PATH_TO_TEST}`"...";
	New-Item -ItemType "Directory" -Path ("${DIR_PATH_TO_TEST}") | Out-Null;
}

# ------------------------------------------------------------

# Test if file exists

$FILE_PATH_TO_TEST="${env:COMSPEC}";
If (Test-Path -PathType "Leaf" -Path ("${FILE_PATH_TO_TEST}")) {
	Write-Host "Info - File found: `"${FILE_PATH_TO_TEST}`"";
} Else {
	Write-Host "Error - File not found: `"${FILE_PATH_TO_TEST}`"";
}



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Test-Path (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-5.1
#
# ------------------------------------------------------------