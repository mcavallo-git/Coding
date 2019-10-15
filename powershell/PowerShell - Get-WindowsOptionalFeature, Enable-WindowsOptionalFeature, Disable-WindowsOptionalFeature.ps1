# ------------------------------------------------------------
#
# Checks and installs Windows Features
#
# ***  REQUIRES ELEVATED PRIVILEGES  ***
#
# ------------------------------------------------------------

Get-WindowsOptionalFeature -Online

PrivilegeEscalation -Command ("Get-WindowsOptionalFeature -Online | Sort | Format-Table > '${ENV:USERPROFILE}\Desktop\Get-WindowsOptionalFeature.txt'");


# ------------------------------------------------------------

Enable-WindowsOptionalFeature


# ------------------------------------------------------------

Disable-WindowsOptionalFeature


# ------------------------------------------------------------
# Citation(s)
#
#		docs.microsoft.com  |  "Get-WindowsOptionalFeature"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsoptionalfeature?view=win10-ps
#
#		docs.microsoft.com  |  "Enable-WindowsOptionalFeature"  |  https://docs.microsoft.com/en-us/powershell/module/dism/enable-windowsoptionalfeature?view=win10-ps
#
#		docs.microsoft.com  |  "Disable-WindowsOptionalFeature"  |  https://docs.microsoft.com/en-us/powershell/module/dism/disable-windowsoptionalfeature?view=win10-ps
#
# ------------------------------------------------------------