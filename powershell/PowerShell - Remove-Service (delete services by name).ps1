# ------------------------------------------------------------
# PowerShell - Remove-Service (delete services by name)
# ------------------------------------------------------------


# Remove service(s) starting with "Corsair"  (case insensitive) - Used for iCUE full uninstallation
Get-Service -Name ("Corsair*") | ForEach-Object {
  $Service_Name=($_.Name);
  Write-Host "Service Name: `"${Service_Name}`"";
  # Stop the service (if it is running)
  If ("$($_.Status)" -Eq "Running") {
    Write-Host "  |--> Stopping Service...";
    Stop-Service -Name ($_.Name) -Force;
  };
  Write-Host "  |--> Removing Service...";
  $_ | Remove-Service; <# Remove the service (don't require confirmation) #>
};


# Remove service(s) named "NGINX" (case insensitive)
Get-Service -Name ("NGINX") | ForEach-Object {
  $Service_Name=($_.Name);
  Write-Host "Service Name: `"${Service_Name}`"";
  # Stop the service (if it is running)
  If ("$($_.Status)" -Eq "Running") {
    Write-Host "  |--> Stopping Service...";
    Stop-Service -Name ($_.Name) -Force;
  };
  Write-Host "  |--> Removing Service...";
  $_ | Remove-Service; <# Remove the service (don't require confirmation) #>
};


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Remove-Service (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-service
#
# ------------------------------------------------------------