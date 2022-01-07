# ------------------------------------------------------------
#
# PowerShell - Restart service(s) by name 
#


# Restart TeamCity Web Server
TASKKILL /F /FI "IMAGENAME eq TeamCityService.exe"
Restart-Service -Name "TeamCity"
TIMEOUT /T 60


# Restart TeamCity Build Server
TASKKILL /F /FI "IMAGENAME eq TeamCityAgentService-windows-x86-32.exe"
Restart-Service -Name "TCBuildAgent"
TIMEOUT /T 60


# Restart TeamCity Build Server
TASKKILL /F /FI "IMAGENAME eq nginx.exe"
Restart-Service -Name "NGINX-Service"
TIMEOUT /T 60


# ------------------------------------------------------------


# Bulk-Stop multiple services
$IRSA_Enterprise_Services = @("World Wide Web Publishing Service", "MongoDB", "MinIO Server", "Microsoft FTP Service"); `
$ExistingServices = (Get-Service); `
ForEach ($EachService In $IRSA_Enterprise_Services) { `
	$ExistingServices | Where-Object { $_.DisplayName -Eq "${EachService}" } | Stop-Service; `
}


# Bulk-Start multiple services
$IRSA_Enterprise_Services = @("World Wide Web Publishing Service", "MongoDB", "MinIO Server", "Microsoft FTP Service"); `
$ExistingServices = (Get-Service); `
ForEach ($EachService In $IRSA_Enterprise_Services) { `
	$ExistingServices | Where-Object { $_.DisplayName -Eq "${EachService}" } | Start-Service; `
}


# Bulk-Restart multiple services
$IRSA_Enterprise_Services = @("World Wide Web Publishing Service", "MongoDB", "MinIO Server", "Microsoft FTP Service"); `
$ExistingServices = (Get-Service); `
ForEach ($EachService In $IRSA_Enterprise_Services) { `
	$ExistingServices | Where-Object { $_.DisplayName -Eq "${EachService}" } | Restart-Service; `
}


# ------------------------------------------------------------
#
# Citation(s)
#
#  docs.microsoft.com  |  "Restart-Service (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-service
#
# ------------------------------------------------------------