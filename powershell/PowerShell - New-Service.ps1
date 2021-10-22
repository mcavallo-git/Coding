# ------------------------------------------------------------
#
# PowerShell - Create/Add a new service
#


$NewService_SplatParams = @{
  Name = "TestService";
  DisplayName = "Test Service";
  BinaryPathName = "C:\WINDOWS\System32\svchost.exe -k netsvcs";
  DependsOn = "NetLogon";
  StartupType = "Automatic";  <# Valid values are [ Automatic, Disabled, Manual, Boot, System ] #>
  Description = "This is a test service.";
}
New-Service @NewService_SplatParams;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "New-Service (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-service
#
# ------------------------------------------------------------