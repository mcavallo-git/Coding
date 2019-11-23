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

Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; $SyncTemp="${Env:TEMP}\Enable-IIS-FTP-Features.$($(Date).Ticks).ps1"; New-Item -ItemType "File" -Path ("${SyncTemp}") -Value (($(New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Enable-IIS-FTP-Features.ps1?t=$((Date).Ticks)"))) | Out-Null; . "${SyncTemp}"; Remove-Item "${SyncTemp}";


# Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; $SyncTemp="${Env:TEMP}\Enable-IIS-FTP-Features.$($(Date).Ticks).ps1"; $WC=(New-Object System.Net.WebClient); $WC.CachePolicy=(New-Object System.Net.Cache.HttpRequestCachePolicy([System.Net.Cache.HttpRequestCacheLevel]::NoCacheNoStore)); New-Item -ItemType "File" -Path ("${SyncTemp}") -Value ($WC.DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Enable-IIS-FTP-Features.ps1?t=$((Date).Ticks)")) | Out-Null; . "${SyncTemp}"; Remove-Item "${SyncTemp}";


# # Attempting to avoid caching of the website

# While (1) {
# $WC=(New-Object System.Net.WebClient);
# $WC.Headers.Set("Cache-Control","no-store, no-cache, must-revalidate");
# $WC.CachePolicy=(New-Object System.Net.Cache.HttpRequestCachePolicy([System.Net.Cache.HttpRequestCacheLevel]::NoCacheNoStore));
# $WC_DL=($WC.DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Enable-IIS-FTP-Features.ps1?t=$((Date).Ticks)"));
# Write-Host $WC_DL | find /c /v "";
# Write-Host "======================";
# Date;
# Sleep 2;
# }

#  "${Env:windir}\WinSxS"


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
$EnableFeatures += "WoW64-Support";

NEED [ ASP.NET 3.5 ]



$FeaturesToEnable = ( `
Get-WindowsFeature `
| Where-Object { $EnableFeatures.Contains($_.Name) -Eq $True } `
| Where-Object { ( $_.Installed -Match "False" ) } `
| Select-Object -Property ("Name") `
);

$ISO_Media = "D:\sources\sxs";
If ((Test-Path "${ISO_Media}") -Eq $True ) {
Install-WindowsFeature -Name (${FeaturesToEnable}.Name) -Source (${ISO_Media}) -IncludeManagementTools;
} Else {
Install-WindowsFeature -Name (${FeaturesToEnable}.Name) -IncludeManagementTools;
}

# ------------------------------------------------------------

[String[]]$EnableOptionalFeatures = @();
$EnableOptionalFeatures += "CoreFileServer";
$EnableOptionalFeatures += "FileAndStorage-Services";
$EnableOptionalFeatures += "File-Services";
$EnableOptionalFeatures += "IIS-ApplicationDevelopment";
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