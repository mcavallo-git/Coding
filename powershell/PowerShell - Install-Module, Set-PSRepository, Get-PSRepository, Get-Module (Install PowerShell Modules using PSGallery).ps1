# ------------------------------------------------------------
#
# PowerShell - Install a PowerShell Module from the "PSGallery" PowerShell Module Repository using the "NuGet" Package Management Provider
#
# ------------------------------------------------------------

If ($True) {
  $PSModule_Name=("SqlServer");
  # $PSModule_Name=("VMware.PowerCLI");
  If ($null -eq (Get-Module -ListAvailable -Name "${PSModule_Name}" -ErrorAction SilentlyContinue)) {
    [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;
    $ProgressPreference="SilentlyContinue";
    $PackageProvider_Name=("NuGet");
    Install-PackageProvider -Name ("${PackageProvider_Name}") -MinimumVersion ("2.8.5.208") -Force -Confirm:$False;
    $PSRepository_Name=("PSGallery");
    If ($null -eq (Get-PSRepository -Name ("${PSRepository_Name}") -ErrorAction SilentlyContinue)) {
      Register-PSRepository -Default -Verbose;
    }
    Set-PSRepository -Name ("${PSRepository_Name}") -PackageManagementProvider ("${PackageProvider_Name}") -InstallationPolicy ("Trusted") -ErrorAction SilentlyContinue;
    Install-Module -Name ("${PSModule_Name}") -Repository ("${PSRepository_Name}") -Scope ("CurrentUser") -AllowClobber -Force -Confirm:$False;
  }
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   addictivetips.com  |  "How To Add A Trusted Repository In PowerShell In Windows 10"  |  https://www.addictivetips.com/windows-tips/add-a-trusted-repository-in-powershell-windows-10/
#
#   docs.microsoft.com  |  "Install-Module (PowerShellGet) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershell-5.1
#
#   docs.microsoft.com  |  "Install-PackageProvider (PackageManagement) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/packagemanagement/install-packageprovider?view=powershell-5.1
#
#   docs.microsoft.com  |  "Set-PSRepository (PowerShellGet) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/powershellget/set-psrepository?view=powershell-5.1
#
# ------------------------------------------------------------