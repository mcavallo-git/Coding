# ------------------------------------------------------------
#
# PowerShell - Remove a service via "Remove-Service"
#


<# Remove service(s) by name #>
$SERVICE_NAME="NGINX";
Get-Service -Name ("${SERVICE_NAME}") | ForEach-Object {
	If ("$($_.Status)" -Eq "Running") { Stop-Service -Name ($_.Name) -Force; }; <# Stop the service (if it is running) #> 
	$_ | Remove-Service -Confirm; <# Remove the service (require confirmation) #>
};


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Remove-Service - Creates a new Windows service"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-service
#
# ------------------------------------------------------------