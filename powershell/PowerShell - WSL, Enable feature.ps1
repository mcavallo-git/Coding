# ------------------------------------------------------------
If ($False) {  # RUN THIS SCRIPT REMOTELY


Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/PowerShell%20-%20WSL,%20Enable%20feature.ps1")); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}
# ------------------------------------------------------------


# If the WSL Feature is currently set to Disabled, Enable it
If ( ((Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux").State) -Eq "Disabled" ) { 
	Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux";
}

