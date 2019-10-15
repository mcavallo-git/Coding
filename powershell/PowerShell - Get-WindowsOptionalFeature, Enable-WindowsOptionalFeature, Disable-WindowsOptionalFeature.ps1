# ------------------------------------------------------------
#
# Checks and installs Windows Features
#
# ***  REQUIRES ELEVATED PRIVILEGES  ***
#
# ------------------------------------------------------------

Get-WindowsOptionalFeature -Online

# PrivilegeEscalation -Command ("Get-WindowsOptionalFeature -Online | Sort | Format-Table > '${ENV:USERPROFILE}\Desktop\Get-WindowsOptionalFeature.txt'");

Get-WindowsOptionalFeature -Online | Sort | Format-Table > "${ENV:USERPROFILE}\Desktop\Get-WindowsOptionalFeature.txt";

DISM /Online /Get-Features /Format:Table | More > "${ENV:USERPROFILE}\Desktop\DISM Online Get-Features.txt";


# ------------------------------------------------------------

Enable-WindowsOptionalFeature

Enable-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45"


# ------------------------------------------------------------

Disable-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45"


# ------------------------------------------------------------
# Citation(s)
#
#		docs.microsoft.com  |  "Get-WindowsOptionalFeature"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsoptionalfeature?view=win10-ps
#
#		docs.microsoft.com  |  "Enable-WindowsOptionalFeature"  |  https://docs.microsoft.com/en-us/powershell/module/dism/enable-windowsoptionalfeature?view=win10-ps
#
#		docs.microsoft.com  |  "Disable-WindowsOptionalFeature"  |  https://docs.microsoft.com/en-us/powershell/module/dism/disable-windowsoptionalfeature?view=win10-ps
#
#		docs.microsoft.com  |  "DISM Global Options for Command-Line Syntax"  |  https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-global-options-for-command-line-syntax
#
# ------------------------------------------------------------