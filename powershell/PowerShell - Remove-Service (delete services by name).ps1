# ------------------------------------------------------------
# PowerShell - Remove-Service (delete services by name)
# ------------------------------------------------------------


# Remove service(s) starting with "Corsair"  (case insensitive) - Used for iCUE full uninstallation
Get-Service -Name ("Corsair*") | ForEach-Object {
	If ("$($_.Status)" -Eq "Running") { Stop-Service -Name ($_.Name) -Force; }; <# Stop the service (if it is running) #> 
	$_ | Remove-Service -Confirm; <# Remove the service (require confirmation) #>
};


# Remove service(s) named "NGINX" (case insensitive)
Get-Service -Name ("NGINX") | ForEach-Object {
	If ("$($_.Status)" -Eq "Running") { Stop-Service -Name ($_.Name) -Force; }; <# Stop the service (if it is running) #> 
	$_ | Remove-Service -Confirm; <# Remove the service (require confirmation) #>
};


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Remove-Service (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-service
#
# ------------------------------------------------------------