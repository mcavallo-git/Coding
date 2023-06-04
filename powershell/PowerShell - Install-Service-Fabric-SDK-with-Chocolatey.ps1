# ------------------------------
#
# PowerShell - Install Service Fabric SDK + Chocolatey
#
# ------------------------------

If ($True) {

  # If Choco is already installed, move it's directory and reinstall it
  $Choco_InstallDir = "C:\ProgramData\chocolatey";
  If (Test-Path -Path ("${Choco_InstallDir}")) {
    $Choco_RenamedDir = "${Choco_InstallDir}.$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz')";
    Write-Host "##[debug] ------------------------------";
    Write-Host "##[debug] Info: Choco directory already exists at path `"${Choco_InstallDir}`"";
    Write-Host "##[debug] Info: Relocating existing directory to path `"${Choco_RenamedDir}`"...";
    Move-Item -Path ("${Choco_InstallDir}") -Destination ("${Choco_RenamedDir}") -Force;
  }

  # Runtime variables/settings
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
  Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force;

  # Chocolatey - Download & Install
  Write-Host "##[debug] ------------------------------";
  Write-Host "##[debug] Info: Downloading & Installing Chocolatey...";
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

  # Azure Service Fabric SDK - Install
  #  Service Fabric Runtime for Windows  -  https://download.microsoft.com/download/b/8/a/b8a2fb98-0ec1-41e5-be98-9d8b5abf7856/MicrosoftServiceFabric.9.1.1653.9590.exe
  #  Service Fabric SDK  -  https://download.microsoft.com/download/b/8/a/b8a2fb98-0ec1-41e5-be98-9d8b5abf7856/MicrosoftServiceFabricSDK.6.1.1653.msi
  Write-Host "##[debug] ------------------------------";
  Write-Host "##[debug] Info: Downloading & Installing the Azure Service Fabric SDK (via Chocolatey)...";
  choco install service-fabric-sdk -y

  # Update the system PATH to include the SDK
  $Exe_Dirname = "C:\Program Files\Microsoft Service Fabric\bin\Fabric\Fabric.Code";
  Write-Host "##[debug] ------------------------------";
  Write-Host "##[debug] Info: Adding the Azure Service Fabric SDK's parent directory to the PATH:  ${Exe_Dirname}";
  Write-Host "##vso[task.prependpath]${Exe_Dirname}";

  Write-Host "##[debug] ------------------------------";

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.chocolatey.org  |  "Chocolatey Software | Service Fabric SDK 6.1.1583"  |  https://community.chocolatey.org/packages/service-fabric-sdk
#
#   learn.microsoft.com  |  "Get started with Azure Service Fabric CLI - Azure Service Fabric | Microsoft Learn"  |  https://learn.microsoft.com/en-us/azure/service-fabric/service-fabric-cli
#
#   learn.microsoft.com  |  "Set up a Windows development environment - Azure Service Fabric | Microsoft Learn"  |  https://learn.microsoft.com/en-us/azure/service-fabric/service-fabric-get-started#install-the-sdk-and-tools
#
# ------------------------------------------------------------