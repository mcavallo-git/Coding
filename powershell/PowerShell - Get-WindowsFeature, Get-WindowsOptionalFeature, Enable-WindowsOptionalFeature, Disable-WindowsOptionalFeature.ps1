# ------------------------------------------------------------
#
# Checks and installs Windows Features
#
# ***  REQUIRES ELEVATED PRIVILEGES  ***
#
# ------------------------------------------------------------

# Get-WindowsFeature

Get-WindowsFeature | Select-Object -Property Name,Installed | Format-Table > "${ENV:USERPROFILE}\Desktop\Get-WindowsFeature.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.log";

Get-WindowsFeature | Where-Object { $_.Installed -match "True" } | Select-Object -Property Name,Installed | Format-Table > "${ENV:USERPROFILE}\Desktop\Get-WindowsFeature.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.log";

# Get-WindowsFeature | Where-Object {$_.Installed -match “True”} | Select-Object -Property Name


# ------------------------------------------------------------
# Get-WindowsOptionalFeature

Get-WindowsOptionalFeature -Online | Sort | Format-Table > "${ENV:USERPROFILE}\Desktop\Get-WindowsOptionalFeature.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.log";

DISM /Online /Get-Features /Format:Table | More > "${ENV:USERPROFILE}\Desktop\DISM Online Get-Features.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.log";

If ( ((Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux").State) -Eq "Disabled" ) { 
	# If the WSL Feature is currently set to Disabled, Enable it
	Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux";
}


# ------------------------------------------------------------

Enable-WindowsOptionalFeature

Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3";
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45";
Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux";


# ------------------------------------------------------------

Disable-WindowsOptionalFeature -Online -FeatureName "NetFx3";
Disable-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45";
Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux";


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