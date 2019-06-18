
#
# List all drivers installed on local workstation
#
# ***  REQUIRES ADMIN POWERSHELL PROMPT  ***
#

Get-WindowsDriver -Online -All > (("${HOME}\Desktop\Drivers_")+(${Env:COMPUTERNAME})+("_")+(Get-Date -UFormat "%Y-%m-%d_%H-%M-%S")+(".log"));
