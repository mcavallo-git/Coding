
$params = @{
  Name = "TestService"
  BinaryPathName = "C:\WINDOWS\System32\svchost.exe -k netsvcs"
  DependsOn = "NetLogon"
  DisplayName = "Test Service"
  StartupType = "Manual"
  Description = "This is a test service."
}
New-Service @params


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "New-Service - Creates a new Windows service"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-service?view=powershell-7
#
# ------------------------------------------------------------