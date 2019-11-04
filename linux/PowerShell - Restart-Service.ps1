@ECHO OFF


# Restart TeamCity Web-Server

TASKKILL /F /FI "IMAGENAME eq TeamCityService.exe"
Restart-Service -Name "TeamCity"

TIMEOUT /T 60



# Restart TeamCity Build-Server

TASKKILL /F /FI "IMAGENAME eq TeamCityAgentService-windows-x86-32.exe"
Restart-Service -Name "TCBuildAgent"

TIMEOUT /T 60



# Restart TeamCity Build-Server

TASKKILL /F /FI "IMAGENAME eq nginx.exe"
Restart-Service -Name "NGINX-Service"

TIMEOUT /T 60


# ------------------------------------------------------------
# Citation(s)
#
#  docs.microsoft.com  |  "Restart-Service"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-service?view=powershell-6
#
# ------------------------------------------------------------