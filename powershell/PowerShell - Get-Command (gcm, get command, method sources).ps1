# ------------------------------------------------------------
#
# Get-Command  (PowerShell)

Get-Command | Where-Object { $_.Name -Like 'Get-*' };

Get-Command | Where-Object { $_.Name -Like '*-Service*' } | Select-Object -First 20;


#
# Get ALL commands (on the target machine)
#
If ($True) {
	$Logfile = "${Home}\Desktop\Get-Command_$($(${Env:USERNAME}).Trim())@$($(${Env:COMPUTERNAME}).Trim())" + $(If(${Env:USERDNSDOMAIN}){Write-Output ((".") + ($(${Env:USERDNSDOMAIN}).Trim()))}) +"_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log.txt"; `
	Get-Command `
		| Select-Object Name, Version, CommandType, RemotingCapability, Source `
		| Sort-Object -Property Name `
		| Format-Table -AutoSize `
		| Out-File -Width 16384 -Append "${Logfile}";
	Get-Command `
		| Select-Object Source, Name, Version, CommandType, RemotingCapability `
		| Sort-Object -Property Source, Name `
		| Format-Table -AutoSize `
		| Out-File -Width 16384 -Append "${Logfile}";
	Notepad "${Logfile}";
}
 

#
# Get unique command sources (on the target machine)
#
If ($True) {
	Get-Command | Select-Object Source | Sort-Object -Property Source | Get-Unique -AsString;
}


#
# Locate the filepath currently defining a given command-name
#
If ($True) {
	$CommandName = "which";
	$CommandExists = $(Get-Command -Name $CommandName 1>$NULL 2>&1; Write-Output $?;);
	If ($CommandExists -Eq $True) {
		$ResolvedType = (Get-Command -Name $CommandName).CommandType;
		$ResolvedName = (Get-Command -Name $CommandName).Name;
		If ($ResolvedType -Eq "Alias") { `
			$ResolvedCommand = (Get-Command -Name $CommandName).ResolvedCommand;
			Write-Output "`n`nCommand `"${CommandName}`" resolved as an alias of command `"${ResolvedCommand}`"`n";
		} Else {
			$ResolvedFilepath = (Get-Command -Name $CommandName).Source;
			Write-Output "`n`nCommand `"${CommandName}`" resolved to Source-filepath:`n${ResolvedFilepath}`n`n";
		}
	} Else {
		Write-Output "`n`nCommand not found:  `"${CommandName}`"`n`n";
	}
}
 
 
# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Command (Microsoft.PowerShell.Core) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-command?view=powershell-5.1
#
#   docs.microsoft.com  |  "Get-Unique (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-unique?view=powershell-5.1
#
#   stackoverflow.com  |  "IIS: Display all sites and bindings in PowerShell - Stack Overflow"  |  https://stackoverflow.com/a/15529399
#
#------------------------------------------------------------