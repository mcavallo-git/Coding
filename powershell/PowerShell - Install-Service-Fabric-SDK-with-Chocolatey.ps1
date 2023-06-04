# ------------------------------------------------------------
# PowerShell - Install the Azure Service Fabric SDK (via Chocolatey)
# ------------------------------------------------------------

If ($True) {
  # Install Chocolatey
  Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force;
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
  # Install the Azure Service Fabric SDK
  choco install service-fabric-sdk -y
  # Update the system PATH environment variable to include the Service Fabric SDK
  Write-Host "##vso[task.prependpath]${Env:ProgramFiles}\Microsoft Service Fabric\bin\Fabric\Fabric.Code";
}


# ------------------------------------------------------------