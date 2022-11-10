# ------------------------------------------------------------
# PowerShell - Invoke-WebRequest, System.Net.WebClient (Download File, Get HTTP Response)
# ------------------------------------------------------------

<# Invoke-WebRequest #>

# Force TLS1.2 (otherwise often throws error in Win2016)
[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;
# Hide Invoke-WebRequest's progress bar
$ProgressPreference='SilentlyContinue';
# Download AZ CLI Installer
Invoke-WebRequest -UseBasicParsing -Uri ("https://aka.ms/installazurecliwindows") -OutFile ("${Home}\Downloads\AzureCLI.msi");


<# System.Net.WebClient #>

# Force TLS1.2 (otherwise often throws error in Win2016)
[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;
# Hide Invoke-WebRequest's progress bar
$ProgressPreference='SilentlyContinue';
# Download AZ CLI Installer
$(New-Object System.Net.WebClient).DownloadFile(([Net.HttpWebRequest]::Create("https://github.com/winsw/winsw/releases/download/v2.7.0/WinSW.NET4.exe").GetResponse().ResponseUri.AbsoluteUri),"${Home}\Downloads\AzureCLI.msi");


# ------------------------------------------------------------
#
# Ex) Download "NotepadReplacer.exe" to the current user's "Downloads" directory
#

$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $(New-Object Net.WebClient).DownloadFile(([Net.HttpWebRequest]::Create("https://www.binaryfortress.com/Data/Download/?package=notepadreplacer").GetResponse().ResponseUri.AbsoluteUri),"${Home}\Downloads\NotepadReplacerSetup.exe"); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


# ------------------------------------------------------------
#
# Invoke-WebRequest
#   |
#   |--> Has pre-built-in timeout parameter [ -TimeoutSec ]
#   |
#   |--> Make sure to set preference variable [ $ProgressPreference='SilentlyContinue'; ] <-- Hides Invoke-WebRequest's progress bar, increasing speed by 10x or more #>
#

# Example 1 - Download Azure Pipelines Agent (for Azure DevOps, previously VSTS, previously previously VSO)
If ($True) {

# Setup Runtime vars for remote URI(s) && local filepath(s)
$URL_AgentZip='https://vstsagentpackage.azureedge.net/agent/2.184.2/vsts-agent-win-x64-2.184.2.zip';
$FullPath_WorkingDir = ((${Home})+('\Downloads\agent'));
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
Invoke-WebRequest -UseBasicParsing -Uri ("https://www.binaryfortress.com/Data/Download/?package=notepadreplacer") -OutFile ("${Home}\Downloads\NotepadReplacerSetup.exe") -TimeoutSec (7.5);


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