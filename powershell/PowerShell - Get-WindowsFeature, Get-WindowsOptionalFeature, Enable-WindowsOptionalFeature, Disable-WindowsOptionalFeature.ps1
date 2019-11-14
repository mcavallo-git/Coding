# ------------------------------------------------------------
#
# Checks and installs Windows Features
#
# ***  REQUIRES ELEVATED PRIVILEGES  ***
#
# ------------------------------------------------------------

# Get-WindowsFeature (Roles) & Get-WindowsOptionalFeature (Features)


Get-WindowsFeature | Select-Object -Property Name,Installed | Format-Table > "${ENV:USERPROFILE}\Desktop\Get-WindowsFeature.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}$(Get-Date -UFormat '%Y%m%d-%H%M%S').log"; `
Get-WindowsOptionalFeature -Online | Format-Table > "${ENV:USERPROFILE}\Desktop\Get-WindowsOptionalFeature.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.$(Get-Date -UFormat '%Y%m%d-%H%M%S').log";


Get-WindowsFeature | Where-Object { $_.Installed -Match "True" } | Select-Object -Property Name | Format-Table > "${ENV:USERPROFILE}\Desktop\Get-WindowsFeature.Installed_True.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.$(Get-Date -UFormat '%Y%m%d-%H%M%S').log"; `
Get-WindowsOptionalFeature -Online | Where-Object { $_.State -Eq "Enabled" } | Select-Object -Property FeatureName | Format-Table > "${ENV:USERPROFILE}\Desktop\Get-WindowsOptionalFeature.State_Enabled.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.$(Get-Date -UFormat '%Y%m%d-%H%M%S').log";


# Get-WindowsFeature | Where-Object {$_.Installed -match “True”} | Select-Object -Property Name


# DISM /Online /Get-Features /Format:Table | More > "${ENV:USERPROFILE}\Desktop\DISM Online Get-Features.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.log";


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