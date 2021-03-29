<# ------------------------------------------------------------ #>
<#                                                              #>
<#    Install required roles & features for IIS (Web) Server    #>
<#                                                              #>
<# ------------------------------------------------------------ #>
If ($False) { <# RUN THIS SCRIPT REMOTELY #>


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/Roles-Features/Enable-IIS-Roles-Features.ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}
<# ------------------------------------------------------------ #>

<# Install roles #>
$Features_ToInstall = ((Get-WindowsFeature | Where-Object { ($_.Name -NE $Null) -And (@("FileAndStorage-Services", "File-Services", "FS-FileServer", "FS-SMB1", "NET-Framework-45-ASPNET", "NET-Framework-45-Core", "NET-Framework-45-Features", "NET-Framework-Core", "NET-Framework-Features", "NET-WCF-HTTP-Activation45", "NET-WCF-Pipe-Activation45", "NET-WCF-Services45", "NET-WCF-TCP-Activation45", "NET-WCF-TCP-PortSharing45", "PowerShell", "PowerShell-ISE", "PowerShellRoot", "PowerShell-V2", "RSAT", "RSAT-Feature-Tools", "RSAT-SMTP", "Server-Gui-Mgmt-Infra", "Server-Gui-Shell", "SMTP-Server", "SNMP-Service", "SNMP-WMI-Provider", "Storage-Services", "Telnet-Client", "User-Interfaces-Infra", "WAS", "WAS-Config-APIs", "WAS-Process-Model", "Web-App-Dev", "Web-ASP", "Web-Asp-Net", "Web-Asp-Net45", "Web-Common-Http", "Web-Custom-Logging", "Web-DAV-Publishing", "Web-Default-Doc", "Web-Dir-Browsing", "Web-Filtering", "Web-Health", "Web-Http-Errors", "Web-Http-Logging", "Web-Http-Redirect", "Web-Http-Tracing", "Web-IP-Security", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Lgcy-Mgmt-Console", "Web-Log-Libraries", "Web-Metabase", "Web-Mgmt-Compat", "Web-Mgmt-Console", "Web-Mgmt-Service", "Web-Mgmt-Tools", "Web-Net-Ext", "Web-Net-Ext45", "Web-ODBC-Logging", "Web-Performance", "Web-Security", "Web-Server", "Web-Stat-Compression", "Web-Static-Content", "Web-WebServer", "WoW64-Support").Contains($_.Name) -Eq $True) } | Where-Object { ( $_.Installed -Match "False" ) } | Select-Object -Property ("Name")).Name);
If (${Features_ToInstall} -NE $Null) {
	$WindowsFeatures_Installed = (Install-WindowsFeature -Name (${Features_ToInstall}) -IncludeManagementTools -ErrorAction "SilentlyContinue");
}

<# Install features #>
$OptionalFeat_ToInstall = ((Get-WindowsOptionalFeature -Online | Where-Object { $_.State -Eq "Disabled" } | Where-Object { ($_.FeatureName -NE $Null) -And (@("CoreFileServer", "DSC-Service", "FileAndStorage-Services", "File-Services", "IIS-ApplicationDevelopment", "IIS-ASP", "IIS-ASPNET", "IIS-ASPNET45", "IIS-CommonHttpFeatures", "IIS-CustomLogging", "IIS-DefaultDocument", "IIS-DirectoryBrowsing", "IIS-HealthAndDiagnostics", "IIS-HttpCompressionStatic", "IIS-HttpErrors", "IIS-HttpLogging", "IIS-HttpRedirect", "IIS-HttpTracing", "IIS-IIS6ManagementCompatibility", "IIS-IPSecurity", "IIS-ISAPIExtensions", "IIS-ISAPIFilter", "IIS-LegacySnapIn", "IIS-LoggingLibraries", "IIS-ManagementConsole", "IIS-ManagementService", "IIS-Metabase", "IIS-NetFxExtensibility", "IIS-NetFxExtensibility45", "IIS-ODBCLogging", "IIS-Performance", "IIS-RequestFiltering", "IIS-Security", "IIS-StaticContent", "IIS-WebDAV", "IIS-WebServer", "IIS-WebServerManagementTools", "IIS-WebServerRole", "Internet-Explorer-Optional-amd64", "KeyDistributionService-PSH-Cmdlets", "MicrosoftWindowsPowerShell", "MicrosoftWindowsPowerShellISE", "MicrosoftWindowsPowerShellRoot", "MicrosoftWindowsPowerShellV2", "MicrosoftWindowsPowerShellV3", "NetFx3", "NetFx3ServerFeatures", "NetFx4", "NetFx4Extended-ASPNET45", "NetFx4ServerFeatures", "Printing-Client", "Printing-Client-Gui", "Printing-XPSServices-Features", "RSAT", "ServerCore-Drivers-General", "ServerCore-EA-IME", "ServerCore-EA-IME-WOW64", "ServerCore-FullServer", "ServerCore-WOW64", "Server-Drivers-General", "Server-Drivers-Printers", "Server-Gui-Mgmt", "Server-Gui-Shell", "ServerManager-Core-RSAT", "ServerManager-Core-RSAT-Feature-Tools", "Server-Psh-Cmdlets", "SMB1Protocol", "SmbDirect", "Smtpsvc-Admin-Update-Name", "Smtpsvc-Service-Update-Name", "SNMP", "Storage-Services", "TelnetClient", "TlsSessionTicketKey-PSH-Cmdlets", "User-Interfaces-Infra", "WAS-ConfigurationAPI", "WAS-ProcessModel", "WAS-WindowsActivationService", "WCF-HTTP-Activation45", "WCF-Pipe-Activation45", "WCF-Services45", "WCF-TCP-Activation45", "WCF-TCP-PortSharing45", "WindowsRemoteManagement", "WindowsRemoteManagement-ServerOnly", "WindowsServerBackupSnapin", "WMISnmpProvider").Contains($_.FeatureName) -Eq $True) }).FeatureName);
If (${OptionalFeat_ToInstall} -NE $Null) {
	$OptionalFeat_Installed = (Enable-WindowsOptionalFeature -FeatureName (${OptionalFeat_ToInstall}) -Online -NoRestart -All -ErrorAction "SilentlyContinue");
}

<# Check for pending reboot #>
If ($False) {
	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	CheckPendingRestart -AutoApprove;
}

<# Exit cleanly #>
Exit 0;

<# ------------------------------------------------------------ #>