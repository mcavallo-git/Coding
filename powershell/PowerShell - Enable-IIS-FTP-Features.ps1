# ------------------------------------------------------------
#
#   Enable Windows Optional Features for:
#     |
#     |--> IIS Web-Server
#     |
#     |--> FTP File-Server
#
# ------------------------------------------------------------

If ($False) {

# Download script from GitHub, Run it, then Clean-up/Remove the downloaded script-file

# Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; Start-Process PowerShell.exe $(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Enable-IIS-FTP-Features.ps1?$((Date).Ticks)") -Verb RunAs;

Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; $SyncTemp="${Env:TEMP}\Enable-IIS-FTP-Features.$($(Date).Ticks).ps1"; New-Item -ItemType "File" -Path ("${SyncTemp}") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Enable-IIS-FTP-Features.ps1?$((Date).Ticks)"))) | Out-Null; . "${SyncTemp}"; Remove-Item "${SyncTemp}";

}

Get-WindowsFeature | Select-Object -Property Name,Installed


Get-WindowsFeature -name Web-Server -IncludeManagementTools

Install-WindowsFeature -name Web-Server -IncludeManagementTools




[string[]]$EnableFeatures = @()

$EnableFeatures += "CoreFileServer";
$EnableFeatures += "FileAndStorage-Services";
$EnableFeatures += "File-Services";
$EnableFeatures += "IIS-ApplicationDevelopment";
$EnableFeatures += "IIS-ASPNET45";
$EnableFeatures += "IIS-BasicAuthentication";
$EnableFeatures += "IIS-CommonHttpFeatures";
$EnableFeatures += "IIS-DefaultDocument";
$EnableFeatures += "IIS-DigestAuthentication";
$EnableFeatures += "IIS-DirectoryBrowsing";
$EnableFeatures += "IIS-FTPExtensibility";
$EnableFeatures += "IIS-FTPServer";
$EnableFeatures += "IIS-FTPSvc";
$EnableFeatures += "IIS-HealthAndDiagnostics";
$EnableFeatures += "IIS-HttpCompressionStatic";
$EnableFeatures += "IIS-HttpErrors";
$EnableFeatures += "IIS-HttpLogging";
$EnableFeatures += "IIS-IIS6ManagementCompatibility";
$EnableFeatures += "IIS-ISAPIExtensions";
$EnableFeatures += "IIS-ISAPIFilter";
$EnableFeatures += "IIS-LegacySnapIn";
$EnableFeatures += "IIS-ManagementConsole";
$EnableFeatures += "IIS-Metabase";
$EnableFeatures += "IIS-NetFxExtensibility";
$EnableFeatures += "IIS-NetFxExtensibility45";
$EnableFeatures += "IIS-ODBCLogging";
$EnableFeatures += "IIS-Performance";
$EnableFeatures += "IIS-RequestFiltering";
$EnableFeatures += "IIS-Security";
$EnableFeatures += "IIS-StaticContent";
$EnableFeatures += "IIS-WebServer";
$EnableFeatures += "IIS-WebServerManagementTools";
$EnableFeatures += "IIS-WebServerRole";
$EnableFeatures += "IIS-WindowsAuthentication";
$EnableFeatures += "Internet-Explorer-Optional-amd64";
$EnableFeatures += "KeyDistributionService-PSH-Cmdlets";
$EnableFeatures += "MediaPlayback";
$EnableFeatures += "Microsoft-Hyper-V-Common-Drivers-Package";
$EnableFeatures += "Microsoft-Hyper-V-Guest-Integration-Drivers-Package";
$EnableFeatures += "Microsoft-Windows-Client-EmbeddedExp-Package";
$EnableFeatures += "Microsoft-Windows-NetFx-VCRedist-Package";
$EnableFeatures += "MicrosoftWindowsPowerShell";
$EnableFeatures += "MicrosoftWindowsPowerShellISE";
$EnableFeatures += "MicrosoftWindowsPowerShellRoot";
$EnableFeatures += "MicrosoftWindowsPowerShellV2";
$EnableFeatures += "Microsoft-Windows-Printing-PrintToPDFServices-Package";
$EnableFeatures += "Microsoft-Windows-Printing-XPSServices-Package";
$EnableFeatures += "NetFx3";
$EnableFeatures += "NetFx3ServerFeatures";
$EnableFeatures += "NetFx4";
$EnableFeatures += "NetFx4Extended-ASPNET45";
$EnableFeatures += "NetFx4ServerFeatures";
$EnableFeatures += "Printing-Client";
$EnableFeatures += "Printing-Client-Gui";
$EnableFeatures += "Printing-PrintToPDFServices-Features";
$EnableFeatures += "Printing-XPSServices-Features";
$EnableFeatures += "RSAT";
$EnableFeatures += "SearchEngine-Client-Package";
$EnableFeatures += "ServerCore-Drivers-General";
$EnableFeatures += "ServerCore-Drivers-General-WOW64";
$EnableFeatures += "ServerCore-EA-IME";
$EnableFeatures += "ServerCore-EA-IME-WOW64";
$EnableFeatures += "ServerCore-WOW64";
$EnableFeatures += "Server-Drivers-General";
$EnableFeatures += "Server-Drivers-Printers";
$EnableFeatures += "Server-Gui-Mgmt";
$EnableFeatures += "ServerManager-Core-RSAT";
$EnableFeatures += "ServerManager-Core-RSAT-Feature-Tools";
$EnableFeatures += "Server-Psh-Cmdlets";
$EnableFeatures += "Server-Shell";
$EnableFeatures += "SMB1Protocol";
$EnableFeatures += "SmbDirect";
$EnableFeatures += "Smtpsvc-Admin-Update-Name";
$EnableFeatures += "Storage-Services";
$EnableFeatures += "TlsSessionTicketKey-PSH-Cmdlets";
$EnableFeatures += "Tpm-PSH-Cmdlets";
$EnableFeatures += "WAS-ConfigurationAPI";
$EnableFeatures += "WAS-NetFxEnvironment";
$EnableFeatures += "WAS-ProcessModel";
$EnableFeatures += "WAS-WindowsActivationService";
$EnableFeatures += "WCF-HTTP-Activation";
$EnableFeatures += "WCF-HTTP-Activation45";
$EnableFeatures += "WCF-Services45";
$EnableFeatures += "WCF-TCP-PortSharing45";
$EnableFeatures += "Windows-Defender";
$EnableFeatures += "Windows-Defender-Features";
$EnableFeatures += "Windows-Defender-Gui";
$EnableFeatures += "WindowsMediaPlayer";
$EnableFeatures += "WindowsServerBackupSnapin";
$EnableFeatures += "WirelessNetworking";

# DISM /Online /Get-Features | ForEach-Object {
Get-WindowsOptionalFeature -Online `
| Where-Object { $EnableFeatures.Contains($_.FeatureName) } `
| Where-Object { $_.State -Eq "Disabled" } `
| ForEach-Object {
	Write-Output "------------------------------------------------------------";
	Write-Output "Enabling Feature: $($_.FeatureName)";
	Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName ("$($_.FeatureName)");
}

Write-Output "------------------------------------------------------------";
Write-Output "";
Write-Output "   FEATURES ACTIVATED";
Write-Output "";
Write-Output "   PLEASE REBOOT THE WORKSTATION/SERVER, NOW";
Write-Output "";
