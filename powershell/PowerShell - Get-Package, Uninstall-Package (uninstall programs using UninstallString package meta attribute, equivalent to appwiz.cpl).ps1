# ------------------------------------------------------------
# PowerShell - Get-Package, Uninstall-Package (uninstall programs using UninstallString package meta attribute, equivalent to appwiz.cpl)
# ------------------------------------------------------------
#
# Uninstall packages (attempt to use more reliable "UninstallString" package meta attribute, fallback to "Uninstall-Package" method)
#

@(
# "AI Suite 3", 
"AMD Software", 
# "AMD_Chipset_Drivers", 
"ARMOURY CRATE Lite Service", 
"ASUS Framework Service", 
"AURA", 
"AURA lighting effect add-on", 
"AURA lighting effect add-on x64", 
"AURA Service", 
"GALAX GAMER RGB", 
"ROG Live Service"
) | ForEach-Object {
  $EACH_PACKAGE_CONTAINS="${_}";
  Get-Package `
  | Where-Object { $_.Name -Like ("*${EACH_PACKAGE_CONTAINS}*"); } `
  | ForEach-Object {

    Write-Host "`nInfo: Uninstalling package w/ Name=`"$($_.Name)`", Version=`"$($_.Version)`"...  " -ForegroundColor "Yellow";

    $UninstallString=(${_}.Meta.Attributes["UninstallString"]);
    # $UninstallString=(([xml](${_}.SwidTagText)).SoftwareIdentity.Meta.UninstallString);
    Write-Host "`nInfo:  Calling [ cmd /c $UninstallString /quiet /norestart ]..." -ForegroundColor "Yellow";
    cmd /c $UninstallString /quiet /norestart
    Start-Sleep -Milliseconds (250);

    If (Get-Package -Name "$($_.Name)") {
      # Fallback uninstall approach
      Write-Host "`nInfo: Attempting uninstall using fallback method `"Uninstall-Package`"..." -ForegroundColor "Yellow";
      # Uninstall-Package -Name "$($_.Name)" -AllVersions -Force;
      ${_} | Uninstall-Package;
      Start-Sleep -Milliseconds (250);
    }

    If (Get-Package -Name "$($_.Name)") {
      Write-Host "`nError: Failed to uninstall package w/ Name=`"$($_.Name)`", Version=`"$($_.Version)`"...  " -ForegroundColor "Magenta";
    }

  }
};


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spiceworks.com  |  "[SOLVED] uninstall a program via powershell - Spiceworks"  |  https://community.spiceworks.com/topic/1966595-uninstall-a-program-via-powershell?page=1#entry-6649944
#
#   docs.microsoft.com  |  "Get-Package (PackageManagement) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/packagemanagement/get-package?view=powershell-5.1
#
#   docs.microsoft.com  |  "Uninstall-Package (PackageManagement) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/packagemanagement/uninstall-package?view=powershell-5.1
#
# ------------------------------------------------------------