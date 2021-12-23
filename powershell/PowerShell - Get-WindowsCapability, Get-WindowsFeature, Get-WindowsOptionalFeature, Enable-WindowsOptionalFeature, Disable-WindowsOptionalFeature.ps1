# ------------------------------------------------------------
#
# Check-for & install Windows Roles & Features
#
# ***  REQUIRES ELEVATED PRIVILEGES  ***
#
# ------------------------------------------------------------

If ($True) {

# [LIST ROLES]  Get-WindowsFeature & output to desktop (ALL)  (use DISM if 'Get-WindowsFeature' command is missing)
# ***  REQUIRES ADMIN  ***
If ($True) {
	$Features="";
	If ((Get-Command -Name "Get-WindowsFeature" 2>$Null) -NE $Null) {
		$Module="Get-WindowsFeature"; 	$Features=(Get-WindowsFeature | Select-Object -Property Name.Installed | Sort-Object -Property @{Expression={$_.Installed};Ascending=$False;},@{Expression={$_.Name};Ascending=$True;} | Format-Table -AutoSize);
	} ElseIf ((Get-Command -Name "Get-WindowsCapability" 2>$Null) -NE $Null) {
		$Module="Get-WindowsCapability"; $Features=(Get-WindowsCapability -Online | Select-Object -Property Name,State | Sort-Object -Property @{Expression={$_.State};Ascending=$False;},@{Expression={$_.Name};Ascending=$True;} | Format-Table -AutoSize);
	} Else {
		$Module="Dism"; $Features=(dism /online /get-features);
	};
	If ("${Features}" -NE "") {
		$LogFile="${ENV:USERPROFILE}\Desktop\${Module}.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}$(Get-Date -UFormat '%Y%m%d-%H%M%S').log";
		$Features | Out-File -Width 16384 -Append "${Logfile}";
		notepad.exe "${Logfile}"
	}
};


# [LIST ROLES]  Get-WindowsFeature & output to desktop (ONLY INSTALLED)
# ***  REQUIRES ADMIN  ***
If ($True) {
	$Features="";
	If ((Get-Command -Name "Get-WindowsFeature" 2>$Null) -NE $Null) {
		$Module="Get-WindowsFeature.list_installed"; $Features=(Get-WindowsFeature | Where-Object { $_.Installed -Match "True" } | Select-Object -Property Name,Installed | Sort-Object -Property Name | Format-Table -AutoSize);
	} ElseIf ((Get-Command -Name "Get-WindowsCapability" 2>$Null) -NE $Null) {
		$Module="Get-WindowsCapability.list_installed"; $Features=(Get-WindowsCapability -Online | Where-Object { $_.State -Match "Installed" } | Select-Object -Property Name,State | Sort-Object -Property Name | Format-Table -AutoSize);
	} Else {
		$Module="Dism.list_installed"; $Features=(dism /online /get-features);
	};
	If ("${Features}" -NE "") {
		$LogFile="${ENV:USERPROFILE}\Desktop\${Module}.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}$(Get-Date -UFormat '%Y%m%d-%H%M%S').log";
		$Features | Out-File -Width 16384 -Append "${Logfile}";
		notepad.exe "${Logfile}"
	};
};

}


# ------------------------------------------------------------

# [LIST FEATURES]  Get-WindowsOptionalFeature & output to desktop (ALL)
Get-WindowsOptionalFeature -Online | Sort-Object -Property FeatureName | Format-Table -AutoSize > "${ENV:USERPROFILE}\Desktop\Get-WindowsOptionalFeature.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.$(Get-Date -UFormat '%Y%m%d-%H%M%S').log";

# [LIST FEATURES]  Get-WindowsOptionalFeature & output to desktop (ONLY INSTALLED)
Get-WindowsOptionalFeature -Online | Where-Object { $_.State -Eq "Enabled" } | Select-Object -Property FeatureName | Sort-Object -Property FeatureName | Format-Table -AutoSize > "${ENV:USERPROFILE}\Desktop\Get-WindowsOptionalFeature.list_installed.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.$(Get-Date -UFormat '%Y%m%d-%H%M%S').log";

# Get-WindowsFeature | Where-Object {$_.Installed -match “True”} | Select-Object -Property Name


# ------------------------------------------------------------
#
# DISM /Online /Get-Features /Format:Table | More > "${ENV:USERPROFILE}\Desktop\DISM Online Get-Features.${ENV:USERDOMAIN}.${ENV:COMPUTERNAME}.log";
#

If ( ((Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux").State) -Eq "Disabled" ) {
	# If the WSL Feature is currently set to Disabled, Enable it
	Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux";
}

# ------------------------------------------------------------
#
# Enable/Disable (Add/Remove) Features via:
#   Add-WindowsCapability
#   Get-WindowsCapability
#   Remove-WindowsCapability
#


# Enable SNMP 
Get-WindowsCapability -Online | Where-Object { [Regex]::Match(($_.Name),(Write-Output ^SNMP.Client.+$)).Success } | Where-Object { $_.State -Eq (Write-Output NotPresent) } | Add-WindowsCapability -Online;  <# Enable the [ Simple Network Management Protocol (SNMP) ] Windows Optional Feature (does nothing if SNMP is already enabled) #>


# Disable SNMP 
Get-WindowsCapability -Online | Where-Object { [Regex]::Match(($_.Name),(Write-Output ^SNMP.Client.+$)).Success } | Where-Object { $_.State -Eq (Write-Output Installed) } | Remove-WindowsCapability -Online;  <# Enable the [ Simple Network Management Protocol (SNMP) ] Windows Optional Feature (does nothing if SNMP is already enabled) #>


# ------------------------------------------------------------
#
# Enable/Disable (Add/Remove) Features via:
#   Disable-WindowsOptionalFeature
#   Enable-WindowsOptionalFeature
#


Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3";
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45";
Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux";


Disable-WindowsOptionalFeature -Online -FeatureName "NetFx3";
Disable-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45";
Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux";


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "Add-WindowsCapability (DISM) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dism/add-windowscapability
#
#   docs.microsoft.com  |  "Disable-WindowsOptionalFeature (DISM) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dism/disable-windowsoptionalfeature
#
#   docs.microsoft.com  |  "DISM Global Options for Command-Line Syntax | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-global-options-for-command-line-syntax
#
#   docs.microsoft.com  |  "Get-WindowsCapability (DISM) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowscapability
#
#   docs.microsoft.com  |  "Get-WindowsFeature (ServerManager) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/servermanager/get-windowsfeature
#
#   docs.microsoft.com  |  "Get-WindowsOptionalFeature (DISM) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsoptionalfeature
#
#   docs.microsoft.com  |  "Enable-WindowsOptionalFeature (DISM) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dism/enable-windowsoptionalfeature
#
#   docs.microsoft.com  |  "Remove-WindowsCapability (DISM) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dism/remove-windowscapability
#
# ------------------------------------------------------------