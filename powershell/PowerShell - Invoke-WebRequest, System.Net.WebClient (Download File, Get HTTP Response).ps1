# ------------------------------------------------------------
# PowerShell - Invoke-WebRequest, System.Net.WebClient (Download File, Get HTTP Response)
# ------------------------------------------------------------
#
# GET WEB RESPONSE
#

# Invoke-WebRequest - Get a web response
If ($True) {
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2 (otherwise often throws error in Win2016)
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
  $ResponseObj=(Invoke-WebRequest -UseBasicParsing -Uri ("https://storage.googleapis.com/kubernetes-release/release/stable.txt")); # Get the latest stable version of kubectl
  $LatestVersion=(${ResponseObj}.Content);
  Write-Host "Info:  kubectl - latest available version = [ ${LatestVersion} ]";
}


# ------------------------------------------------------------
#
# DOWNLOAD FILE(S)
#

# Invoke-WebRequest - Download a file
If ($True) {
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2 (otherwise often throws error in Win2016)
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
  Invoke-WebRequest -UseBasicParsing -Uri ("https://aka.ms/installazurecliwindows") -OutFile ("${HOME}\Downloads\AzureCLI.msi"); # Download AZ CLI Installer
}


# System.Net.WebClient - Download a file (ex 1)
If ($True) {
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2 (otherwise often throws error in Win2016)
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
  $(New-Object System.Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("https://github.com/winsw/winsw/releases/download/v2.7.0/WinSW.NET4.exe").GetResponse().ResponseUri.AbsoluteUri),"${HOME}\Downloads\AzureCLI.msi"); # Download AZ CLI Installer
}

# System.Net.WebClient - Download a file (ex 2)
If ($True) {
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2 (otherwise often throws error in Win2016)
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
  $(New-Object System.Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("https://www.binaryfortress.com/Data/Download/?package=notepadreplacer").GetResponse().ResponseUri.AbsoluteUri),"${HOME}\Downloads\NotepadReplacerSetup.exe"); # Download "NotepadReplacer.exe"
}


# ------------------------------------------------------------
#
# Ex) Determine latest stable version of utility "kubectl" via web request, then download the latest binary for it
#

If ($True) {

  # Invoke-WebRequest - Get a web response
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2 (otherwise often throws error in Win2016)
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar

  $ResponseObj=(Invoke-WebRequest -UseBasicParsing -Uri ("https://storage.googleapis.com/kubernetes-release/release/stable.txt")); # Get the latest stable version of kubectl
  $LatestVersion=(${ResponseObj}.Content);
  Write-Host "Info:  kubectl - latest available version = [ ${LatestVersion} ]";

  # Invoke-WebRequest - Download a file
  $DownloadUrl=("https://dl.k8s.io/release/${LatestVersion}/bin/windows/amd64/kubectl.exe");
  $ResolvedUrl=([System.Net.HttpWebRequest]::Create("${DownloadUrl}").GetResponse().ResponseUri.AbsoluteUri); # Resolve any forwards that the HTTP endpoint may do before reaching the final URL of the file(s) to download
  $DownloadOutput=("${HOME}\Downloads\kubectl.exe");
  Write-Host "Info:  Downloading kubectl.exe (${LatestVersion}) from endpoint [ ${ResolvedUrl} ] to local filepath [ `"${DownloadOutput}`" ]";
  Invoke-WebRequest -UseBasicParsing -Uri ("${ResolvedUrl}") -OutFile ("${DownloadOutput}"); # Download kubectl for Windows

}

# Oneliner for command(s) above (download latest version of kubectl for Windows
Invoke-WebRequest -UseBasicParsing -Uri ([System.Net.HttpWebRequest]::Create((write https://dl.k8s.io/release/)+((Invoke-WebRequest -UseBasicParsing -Uri (write https://storage.googleapis.com/kubernetes-release/release/stable.txt)).Content)+(write /bin/windows/amd64/kubectl.exe)).GetResponse().ResponseUri.AbsoluteUri) -OutFile (write C:\ISO\PATH\kubectl.exe); # Download the latest version of kubectl.exe for Windows


# ------------------------------------------------------------
#
# Invoke-WebRequest Tips
#   |
#   |--> Has pre-built-in timeout parameter [ -TimeoutSec ]
#   |--> Make sure to set preference variable [ $ProgressPreference='SilentlyContinue'; ] <-- Hides Invoke-WebRequest's progress bar, increasing speed by 10x or more #>
#

# Example 1 - Download Azure Pipelines Agent (for Azure DevOps, previously VSTS, previously previously VSO)
If ($True) {

# Setup Runtime vars for remote URI(s) && local filepath(s)
$URL_AgentZip='https://vstsagentpackage.azureedge.net/agent/2.184.2/vsts-agent-win-x64-2.184.2.zip';
$FullPath_WorkingDir = ((${HOME})+('\Downloads\agent'));
$FullPath_AgentZip=((${FullPath_WorkingDir})+('\')+(Split-Path -Path (${URL_AgentZip}) -Leaf));

# Ensure the working directory exists
New-Item -ItemType 'Directory' -Path (${FullPath_WorkingDir}) | Out-Null;
Set-Location -Path (${FullPath_WorkingDir});

# Download the pipeline agent's zip archive
$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol;
[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;
# Hide Invoke-WebRequest's progress bar
$ProgressPreference='SilentlyContinue';
Measure-Command { Invoke-WebRequest -UseBasicParsing -Uri (${URL_AgentZip}) -OutFile ("${FullPath_AgentZip}") -TimeoutSec (15) };
[System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;

# Extract the pipeline agent's zip archive
Add-Type -AssemblyName ('System.IO.Compression.FileSystem');
[System.IO.Compression.ZipFile]::ExtractToDirectory((${FullPath_AgentZip}),(${FullPath_WorkingDir}));

}


# Example 2 - Download Notepad Replacer
Invoke-WebRequest -UseBasicParsing -Uri ("https://www.binaryfortress.com/Data/Download/?package=notepadreplacer") -OutFile ("${HOME}\Downloads\NotepadReplacerSetup.exe") -TimeoutSec (7.5);


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