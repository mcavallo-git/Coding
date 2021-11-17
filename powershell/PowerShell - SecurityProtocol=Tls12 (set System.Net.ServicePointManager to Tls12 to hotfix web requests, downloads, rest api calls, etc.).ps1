# ------------------------------------------------------------
#
# PowerShell - [System.Net.ServicePointManager]::SecurityProtocol
#  |
#  |--> Set the SSL/TLS (HTTPS) web request protocol(s)
#  |
#  |--> Set to TLS 1.2 to hotfix errors thrown when performing web requests via PowerShell (namely in Windows Server 2016 (near-stock)) 
#


# Append TLS 1.2 to any existing SSL/TLS (HTTPS) web request protocol(s)
[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12;


# Force TLS 1.2 for SSL/TLS (HTTPS) web request protocol(s)
[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;

$ProgressPreference='SilentlyContinue'; <# Hide Invoke-WebRequest's progress bar #>

$WebResponse = (Invoke-WebRequest -URI "https://www.google.com");


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "about_Preference_Variables - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-5.1#progresspreference
#
#   docs.microsoft.com  |  "Invoke-WebRequest (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-5.1
#
#   docs.microsoft.com  |  "SecurityProtocolType Enum (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.securityprotocoltype?view=net-5.0
#
#   docs.microsoft.com  |  "WebClient.DownloadFile Method (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfile
#
#   stackoverflow.com  |  "powershell - The response content cannot be parsed because the Internet Explorer engine is not available, or - Stack Overflow"  |  https://stackoverflow.com/a/38054505
#
#   stackoverflow.com  |  "powershell could not create ssl/tsl secure - Stack Overflow"  |  https://stackoverflow.com/a/62389502
#
# ------------------------------------------------------------