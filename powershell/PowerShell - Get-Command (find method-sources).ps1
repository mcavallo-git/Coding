
#
# Get-Command  (PowerShell)
#		--> Find the sources which define command(s)
#


#
# Locate the source-filepath currently defining a given command-name
#

$CommandName = "which"; `
`
$CommandExists = $(Get-Command -Name $CommandName 1>$NULL 2>&1; Write-Output $?;); `
`
If ($CommandExists -Eq $True) { `
	$ResolvedType = (Get-Command -Name $CommandName).CommandType; `
	$ResolvedName = (Get-Command -Name $CommandName).Name; `
	If ($ResolvedType -Eq "Alias") { `
		$ResolvedCommand = (Get-Command -Name $CommandName).ResolvedCommand; `
		Write-Output "`n`nCommand `"${CommandName}`" resolved as an alias of command `"${ResolvedCommand}`"`n"; `
	} Else { `
		$ResolvedFilepath = (Get-Command -Name $CommandName).Source; `
		Write-Output "`n`nCommand `"${CommandName}`" resolved to Source-filepath:`n${ResolvedFilepath}`n`n"; `
	} `
} Else { `
	Write-Output "`n`nCommand not found:  `"${CommandName}`"`n`n"; `
}


#------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Command"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-command
#
#------------------------------------------------------------