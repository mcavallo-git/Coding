
# Set-Content (overwrite or append target file's contents).ps1


# Ex) Create a test file on the desktop and run it

If ($True) {
	$Path_TestScript = "${Env:UserProfile}\Desktop\test_set-content_$(Get-Date -UFormat '%Y%m%d-%H%M%S').ps1";
	Set-Content -Path ("${Path_TestScript}") -Value ("Get-Item `"`${PSCommandPath}`" | Format-List *;");
	. "${Path_TestScript}";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Set-Content - Writes new content or replaces existing content in a file"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-content?view=powershell-5.1
#
#   stackoverflow.com  |  "How to list all properties of a PowerShell object - Stack Overflow"  |  https://stackoverflow.com/a/7259178
#
# ------------------------------------------------------------