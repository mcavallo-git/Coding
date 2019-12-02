# ------------------------------------------------------------
#
#   Windows Server 2016 - Enable Roles & Features for:
#     |
#     |--> IIS Web-Server
#     |
#     |--> FTP File-Server
#
# ------------------------------------------------------------

If ($False) { # Download this script from GitHub, Run it, then Clean-up/Remove the temporary downloaded script-file

Install-WindowsFeature -Name ((Get-WindowsFeature | Where-Object { @("FileAndStorage-Services", "File-Services", "FS-FileServer", "FS-SMB1", "NET-Framework-45-ASPNET", "NET-Framework-45-Core", "NET-Framework-45-Features", "NET-Framework-Core", "NET-Framework-Features", "NET-HTTP-Activation", "NET-WCF-HTTP-Activation45", "NET-WCF-Services45", "NET-WCF-TCP-PortSharing45", "PowerShell", "PowerShell-ISE", "PowerShellRoot", "PowerShell-V2", "Storage-Services", "WAS", "WAS-Config-APIs", "WAS-NET-Environment", "WAS-Process-Model", "Web-App-Dev", "Web-Asp-Net", "Web-Asp-Net45", "Web-Basic-Auth", "Web-Common-Http", "Web-Default-Doc", "Web-Digest-Auth", "Web-Dir-Browsing", "Web-Filtering", "Web-Ftp-Server", "Web-Ftp-Service", "Web-Health", "Web-Http-Errors", "Web-Http-Logging", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Console", "Web-Mgmt-Tools", "Web-Net-Ext", "Web-Net-Ext45", "Web-Performance", "Web-Security", "Web-Server", "Web-Stat-Compression", "Web-Static-Content", "Web-WebServer", "Web-Windows-Auth", "Windows-Defender", "Windows-Defender-Features", "Windows-Defender-Gui", "WoW64-Support").Contains($_.Name) -Eq $True } | Where-Object { ( $_.Installed -Match "False" ) } | Select-Object -Property ("Name")).Name) -Source ("wim:D:\sources\install.wim:2") -IncludeManagementTools; Get-WindowsOptionalFeature -Online | Where-Object { $_.State -Eq "Disabled" } | Where-Object { @("CoreFileServer", "FileAndStorage-Services", "File-Services", "IIS-ApplicationDevelopment", "IIS-ASPNET", "IIS-ASPNET45", "IIS-BasicAuthentication", "IIS-CommonHttpFeatures", "IIS-DefaultDocument", "IIS-DigestAuthentication", "IIS-DirectoryBrowsing", "IIS-FTPServer", "IIS-FTPSvc", "IIS-HealthAndDiagnostics", "IIS-HttpCompressionStatic", "IIS-HttpErrors", "IIS-HttpLogging", "IIS-ISAPIExtensions", "IIS-ISAPIFilter", "IIS-ManagementConsole", "IIS-NetFxExtensibility", "IIS-NetFxExtensibility45", "IIS-Performance", "IIS-RequestFiltering", "IIS-Security", "IIS-StaticContent", "IIS-WebServer", "IIS-WebServerManagementTools", "IIS-WebServerRole", "IIS-WindowsAuthentication", "Internet-Explorer-Optional-amd64", "KeyDistributionService-PSH-Cmdlets", "MediaPlayback", "Microsoft-Hyper-V-Common-Drivers-Package", "Microsoft-Hyper-V-Guest-Integration-Drivers-Package", "Microsoft-Windows-Client-EmbeddedExp-Package", "Microsoft-Windows-NetFx-VCRedist-Package", "MicrosoftWindowsPowerShell", "MicrosoftWindowsPowerShellISE", "MicrosoftWindowsPowerShellRoot", "MicrosoftWindowsPowerShellV2", "Microsoft-Windows-Printing-PrintToPDFServices-Package", "Microsoft-Windows-Printing-XPSServices-Package", "NetFx3", "NetFx3ServerFeatures", "NetFx4", "NetFx4Extended-ASPNET45", "NetFx4ServerFeatures", "Printing-Client", "Printing-Client-Gui", "Printing-PrintToPDFServices-Features", "Printing-XPSServices-Features", "RSAT", "SearchEngine-Client-Package", "ServerCore-Drivers-General", "ServerCore-Drivers-General-WOW64", "ServerCore-EA-IME", "ServerCore-EA-IME-WOW64", "ServerCore-WOW64", "Server-Drivers-General", "Server-Drivers-Printers", "Server-Gui-Mgmt", "Server-Psh-Cmdlets", "Server-Shell", "SMB1Protocol", "SmbDirect", "Storage-Services", "TlsSessionTicketKey-PSH-Cmdlets", "Tpm-PSH-Cmdlets", "WAS-ConfigurationAPI", "WAS-NetFxEnvironment", "WAS-ProcessModel", "WAS-WindowsActivationService", "WCF-HTTP-Activation", "WCF-HTTP-Activation45", "WCF-Services45", "WCF-TCP-PortSharing45", "Windows-Defender", "Windows-Defender-Features", "Windows-Defender-Gui", "WindowsMediaPlayer", "WindowsServerBackupSnapin").Contains($_.FeatureName) -Eq $True } | Enable-WindowsOptionalFeature -Online -NoRestart -All -Source ("D:\sources\sxs");

}


# ------------------------------------------------------------

$Revert_BackgroundColor = [System.Console]::BackgroundColor;
[System.Console]::BackgroundColor = "Black";

# ------------------------------------------------------------

[String[]]$EnableFeatures = @();
$EnableFeatures += "FileAndStorage-Services";
$EnableFeatures += "File-Services";
$EnableFeatures += "FS-FileServer";
$EnableFeatures += "FS-SMB1";
$EnableFeatures += "NET-Framework-45-ASPNET";
$EnableFeatures += "NET-Framework-45-Core";
$EnableFeatures += "NET-Framework-45-Features";
$EnableFeatures += "NET-Framework-Core";
$EnableFeatures += "NET-Framework-Features";
$EnableFeatures += "NET-HTTP-Activation";
$EnableFeatures += "NET-WCF-HTTP-Activation45";
$EnableFeatures += "NET-WCF-Services45";
$EnableFeatures += "NET-WCF-TCP-PortSharing45";
$EnableFeatures += "PowerShell";
$EnableFeatures += "PowerShell-ISE";
$EnableFeatures += "PowerShellRoot";
$EnableFeatures += "PowerShell-V2";
$EnableFeatures += "Storage-Services";
$EnableFeatures += "WAS";
$EnableFeatures += "WAS-Config-APIs";
$EnableFeatures += "WAS-NET-Environment";
$EnableFeatures += "WAS-Process-Model";
$EnableFeatures += "Web-App-Dev";
$EnableFeatures += "Web-Asp-Net";  # ASP.NET 3.5
$EnableFeatures += "Web-Asp-Net45";
$EnableFeatures += "Web-Basic-Auth";
$EnableFeatures += "Web-Common-Http";
$EnableFeatures += "Web-Default-Doc";
$EnableFeatures += "Web-Digest-Auth";
$EnableFeatures += "Web-Dir-Browsing";
$EnableFeatures += "Web-Filtering";
$EnableFeatures += "Web-Ftp-Server";
$EnableFeatures += "Web-Ftp-Service";
$EnableFeatures += "Web-Health";
$EnableFeatures += "Web-Http-Errors";
$EnableFeatures += "Web-Http-Logging";
$EnableFeatures += "Web-ISAPI-Ext";
$EnableFeatures += "Web-ISAPI-Filter";
$EnableFeatures += "Web-Mgmt-Console";
$EnableFeatures += "Web-Mgmt-Tools";
$EnableFeatures += "Web-Net-Ext";
$EnableFeatures += "Web-Net-Ext45";
$EnableFeatures += "Web-Performance";
$EnableFeatures += "Web-Security";
$EnableFeatures += "Web-Server";
$EnableFeatures += "Web-Stat-Compression";
$EnableFeatures += "Web-Static-Content";
$EnableFeatures += "Web-WebServer";
$EnableFeatures += "Web-Windows-Auth";
$EnableFeatures += "Windows-Defender";
$EnableFeatures += "Windows-Defender-Features";
$EnableFeatures += "Windows-Defender-Gui";
$EnableFeatures += "Wireless-Networking";  # Wireless LAN Service
$EnableFeatures += "WoW64-Support";

$FeaturesToEnable = ( `
Get-WindowsFeature `
| Where-Object { $EnableFeatures.Contains($_.Name) -Eq $True } `
| Where-Object { ( $_.Installed -Match "False" ) } `
| Select-Object -Property ("Name") `
);

$InstallSource = "D:\sources\sxs";
$InstallSource = "wim:D:\sources\install.wim:2";
If ((Test-Path "${InstallSource}") -Eq $True ) {
Install-WindowsFeature -Name (${FeaturesToEnable}.Name) -Source ("${InstallSource}") -IncludeManagementTools;
} Else {
Install-WindowsFeature -Name (${FeaturesToEnable}.Name) -IncludeManagementTools;
}

# ------------------------------------------------------------

[String[]]$EnableOptionalFeatures = @();
$EnableOptionalFeatures += "CoreFileServer";
$EnableOptionalFeatures += "FileAndStorage-Services";
$EnableOptionalFeatures += "File-Services";
$EnableOptionalFeatures += "IIS-ApplicationDevelopment";
$EnableOptionalFeatures += "IIS-ASPNET";    # 3.5
$EnableOptionalFeatures += "IIS-ASPNET45";
$EnableOptionalFeatures += "IIS-BasicAuthentication";
$EnableOptionalFeatures += "IIS-CommonHttpFeatures";
$EnableOptionalFeatures += "IIS-DefaultDocument";
$EnableOptionalFeatures += "IIS-DigestAuthentication";
$EnableOptionalFeatures += "IIS-DirectoryBrowsing";
$EnableOptionalFeatures += "IIS-FTPServer";
$EnableOptionalFeatures += "IIS-FTPSvc";
$EnableOptionalFeatures += "IIS-HealthAndDiagnostics";
$EnableOptionalFeatures += "IIS-HttpCompressionStatic";
$EnableOptionalFeatures += "IIS-HttpErrors";
$EnableOptionalFeatures += "IIS-HttpLogging";
$EnableOptionalFeatures += "IIS-ISAPIExtensions";
$EnableOptionalFeatures += "IIS-ISAPIFilter";
$EnableOptionalFeatures += "IIS-ManagementConsole";
$EnableOptionalFeatures += "IIS-NetFxExtensibility";
$EnableOptionalFeatures += "IIS-NetFxExtensibility45";
$EnableOptionalFeatures += "IIS-Performance";
$EnableOptionalFeatures += "IIS-RequestFiltering";
$EnableOptionalFeatures += "IIS-Security";
$EnableOptionalFeatures += "IIS-StaticContent";
$EnableOptionalFeatures += "IIS-WebServer";
$EnableOptionalFeatures += "IIS-WebServerManagementTools";
$EnableOptionalFeatures += "IIS-WebServerRole";
$EnableOptionalFeatures += "IIS-WindowsAuthentication";
$EnableOptionalFeatures += "Internet-Explorer-Optional-amd64";
$EnableOptionalFeatures += "KeyDistributionService-PSH-Cmdlets";
$EnableOptionalFeatures += "MediaPlayback";
$EnableOptionalFeatures += "Microsoft-Hyper-V-Common-Drivers-Package";
$EnableOptionalFeatures += "Microsoft-Hyper-V-Guest-Integration-Drivers-Package";
$EnableOptionalFeatures += "Microsoft-Windows-Client-EmbeddedExp-Package";
$EnableOptionalFeatures += "Microsoft-Windows-NetFx-VCRedist-Package";
$EnableOptionalFeatures += "MicrosoftWindowsPowerShell";
$EnableOptionalFeatures += "MicrosoftWindowsPowerShellISE";
$EnableOptionalFeatures += "MicrosoftWindowsPowerShellRoot";
$EnableOptionalFeatures += "MicrosoftWindowsPowerShellV2";
$EnableOptionalFeatures += "Microsoft-Windows-Printing-PrintToPDFServices-Package";
$EnableOptionalFeatures += "Microsoft-Windows-Printing-XPSServices-Package";
$EnableOptionalFeatures += "NetFx3";
$EnableOptionalFeatures += "NetFx3ServerFeatures";
$EnableOptionalFeatures += "NetFx4";
$EnableOptionalFeatures += "NetFx4Extended-ASPNET45";
$EnableOptionalFeatures += "NetFx4ServerFeatures";
$EnableOptionalFeatures += "Printing-Client";
$EnableOptionalFeatures += "Printing-Client-Gui";
$EnableOptionalFeatures += "Printing-PrintToPDFServices-Features";
$EnableOptionalFeatures += "Printing-XPSServices-Features";
$EnableOptionalFeatures += "RSAT";
$EnableOptionalFeatures += "SearchEngine-Client-Package";
$EnableOptionalFeatures += "ServerCore-Drivers-General";
$EnableOptionalFeatures += "ServerCore-Drivers-General-WOW64";
$EnableOptionalFeatures += "ServerCore-EA-IME";
$EnableOptionalFeatures += "ServerCore-EA-IME-WOW64";
$EnableOptionalFeatures += "ServerCore-WOW64";
$EnableOptionalFeatures += "Server-Drivers-General";
$EnableOptionalFeatures += "Server-Drivers-Printers";
$EnableOptionalFeatures += "Server-Gui-Mgmt";
$EnableOptionalFeatures += "Server-Psh-Cmdlets";
$EnableOptionalFeatures += "Server-Shell";
$EnableOptionalFeatures += "SMB1Protocol";
$EnableOptionalFeatures += "SmbDirect";
$EnableOptionalFeatures += "Storage-Services";
$EnableOptionalFeatures += "TlsSessionTicketKey-PSH-Cmdlets";
$EnableOptionalFeatures += "Tpm-PSH-Cmdlets";
$EnableOptionalFeatures += "WAS-ConfigurationAPI";
$EnableOptionalFeatures += "WAS-NetFxEnvironment";
$EnableOptionalFeatures += "WAS-ProcessModel";
$EnableOptionalFeatures += "WAS-WindowsActivationService";
$EnableOptionalFeatures += "WCF-HTTP-Activation";
$EnableOptionalFeatures += "WCF-HTTP-Activation45";
$EnableOptionalFeatures += "WCF-Services45";
$EnableOptionalFeatures += "WCF-TCP-PortSharing45";
$EnableOptionalFeatures += "Windows-Defender";
$EnableOptionalFeatures += "Windows-Defender-Features";
$EnableOptionalFeatures += "Windows-Defender-Gui";
$EnableOptionalFeatures += "WindowsMediaPlayer";
$EnableOptionalFeatures += "WindowsServerBackupSnapin";

$OptionalFeatures_ToEnable = (`
Get-WindowsOptionalFeature -Online `
| Where-Object { ( $_.State -Eq "Disabled" ) } `
| Where-Object { $EnableOptionalFeatures.Contains($_.FeatureName) -Eq $True } `
| Select-Object -Property ("FeatureName")`
);

Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName (${OptionalFeatures_ToEnable}.FeatureName) -All -Source "D:\sources\sxs";

Write-Host "Installing Windows Features Optional-Features [ ${OptionalFeatures_ToEnable} ]..." -ForegroundColor "Cyan";

# ------------------------------------------------------------

$Revert_ForegroundColor = [System.Console]::ForegroundColor;
[System.Console]::ForegroundColor = "Yellow";

Write-Host "------------------------------------------------------------";
Write-Host "";
Write-Host "   FEATURES ACTIVATATION COMPLETE";
Write-Host "";
Write-Host "   PLEASE REBOOT THE WORKSTATION/SERVER, NOW";
Write-Host "";
Write-Host "------------------------------------------------------------";
Write-Host "";

[System.Console]::ForegroundColor = "${Revert_ForegroundColor}";

# ------------------------------------------------------------

[System.Console]::BackgroundColor = "${Revert_BackgroundColor}";

# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "New-ItemProperty - Creates a new property for an item and sets its value"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-itemproperty
#
#   github.com  |  "Web Cache - Everything you need to know"  |  https://github.com/kamranahmedse/kamranahmedse.github.io/blob/master/blog/_posts/2017-03-14-quick-guide-to-http-caching.md
#
#   microsoft.com  |  "Enable-WindowsOptionalFeature - Enables a feature in a Windows image"  |  https://docs.microsoft.com/en-us/powershell/module/dism/enable-windowsoptionalfeature
#
#   microsoft.com  |  "Install-WindowsFeature - Installs one or more roles, role services, or features on either the local or a specified remote..."  |  https://docs.microsoft.com/en-us/powershell/module/servermanager/install-windowsfeature?view=winserver2012r2-ps
#
#   microsoft.com  |  "Group Policy Settings Reference for Windows and Windows Server"  |  https://www.microsoft.com/en-us/download/confirmation.aspx?id=25250
#
#   serverfault.com  |  "How to edit Local Group Policy with script?"  |  https://serverfault.com/questions/848388/how-to-edit-local-group-policy-with-script
#
#   systemmanagement.ro  |  "Install-WindowsFeature Web-Net-Ext failed. Source files could not be found"  |  https://systemmanagement.ro/2018/08/13/install-windowsfeature-web-net-ext-failed-source-files-could-not-be-found/
#
#   thewindowsclub.com  |  "DISM fails in Windows 10. The source files could not be found"  |  https://www.thewindowsclub.com/dism-fails-source-files-could-not-be-found
#
#   vandriel.me  |  "Disabling Caching For System.Net.WebClient In .NET"  |  https://www.vandriel.me/disabling-caching-for-system-net-webclient-in-dotnet
#
# ------------------------------------------------------------