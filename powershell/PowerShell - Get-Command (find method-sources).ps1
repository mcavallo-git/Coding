
#
# Get-Command  (PowerShell)
#		--> Find the sources which define command(s)
#


#
# Locate the source-filepath currently defining a given command-name
#

$CommandName = "powershell.exe";

$PowerShellExe_Filepath = (Get-Command -Name $CommandName).Source;

Write-Host (("`n`nSource of Command `"")+($CommandName)+("`":`n")); Write-Host (($PowerShellExe_Filepath)+("`n`n")) -ForegroundColor green;



# Citation(s)
#
#		docs.microsoft.com, "Get-Command"
#			https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-command
#
