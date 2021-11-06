# ------------------------------------------------------------
#
# PowerShell - WindowsPowerShell/profile.ps1 (default script ran when opening a powershell terminal - set default directory, etc.)
#
# ------------------------------------------------------------


$Fullpath_Profile_Ps1 = "${Home}\Documents\WindowsPowerShell\profile.ps1";
If ((Test-Path "${Fullpath_Profile_Ps1}") -Eq $False) {
	New-Item (Split-Path -Path ("${Fullpath_Profile_Ps1}") -Parent) -ItemType ("Directory");
	Set-Content -Path ("${Fullpath_Profile_Ps1}") -Value ("Set-Location `"`${HOME}\Desktop`";");
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "New-Item (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item
#
#   stackoverflow.com  |  "powershell equivalent of linux "mkdir -p"? - Stack Overflow"  |  https://stackoverflow.com/a/47357220
#
#   stackoverflow.com  |  "windows - How do you set PowerShell's default directory? - Stack Overflow"  |  https://stackoverflow.com/a/38375707
#
# ------------------------------------------------------------