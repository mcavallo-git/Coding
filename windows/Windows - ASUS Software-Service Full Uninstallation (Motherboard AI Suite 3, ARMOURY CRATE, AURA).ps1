# ------------------------------------------------------------
# Windows - ASUS Software-Service Full Uninstallation (Motherboard AI Suite 3, ARMOURY CRATE, AURA)
# ------------------------------------------------------------
#
# ASUS SOFTWARE REMOVAL
#  |
#  |-->  https://rog.asus.com/forum/showthread.php?114773-Armoury-Crate-not-recognizing-devices-and-unable-to-control-RGB#post794749
#  |
#  |-->  https://www.reddit.com/r/pcmasterrace/comments/eyqieh/asus_armoury_crateaura_complete_removal/
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT REMOTELY:

$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/windows/Windows%20-%20ASUS%20Software-Service%20Full%20Uninstallation%20(Motherboard%20AI%20Suite%203,%20ARMOURY%20CRATE,%20AURA).ps1') ).Content);

}
# ------------------------------------------------------------
#
# Uninstall ASUS Programs
#  |
#  |--> Optionally perform this step by [ opening "appwiz.cpl" ("Programs and Features") and right-clicking -> selecting "Uninstall" on each (wait til all are uninstalled to restart) ]

If ($True) {

  # Remove Windows "Programs"

  If ((Get-Package | Where-Object { $_.Name -Eq ("AI Suite 3"); }) -NE $Null) {

    Write-Host "Windows program `"All MB`" must be uninstalled (and disabled) via the motherboard BIOS screen";
        <# *** UNINSTALL VIA BIOS - SEE BELOW FOR DETAILED INFO *** #>
    Write-Host "Windows Program `"AI Suite 3`" will need to be uninstalled manually (as, for some reason, Get-Package | Uninstall-Package doeesnt apply correctly do it.)";
    Write-Host "";
    Write-Host "Please run `"appwiz.cpl`" (via the start menu) to open the `"Programs and Features`" control panel window, then perform aforementioned manual uninstallation(s) before continuing";
    Start-Sleep -Seconds 60;
    Exit 1;

  } Else {

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

        If (Get-Package -Name "$($_.Name)" -EA:0) {
          # Fallback uninstall approach
          Write-Host "`nInfo: Attempting uninstall using fallback method `"Uninstall-Package`"..." -ForegroundColor "Yellow";
          # Uninstall-Package -Name "$($_.Name)" -AllVersions -Force;
          ${_} | Uninstall-Package;
          Start-Sleep -Milliseconds (250);
        }

        If (Get-Package -Name "$($_.Name)" -EA:0) {
          Write-Host "`nError: Failed to uninstall package w/ Name=`"$($_.Name)`", Version=`"$($_.Version)`"...  " -ForegroundColor "Magenta";
        }

      }
    };

  }

  Get-WmiObject -Class "win32_product" -Filter "Vendor like '%ASUS%'" `
  | ForEach-Object {
    Write-Host "`nInfo: Uninstalling Win32_Product w/ Name=`"$($_.Name)`", Version=`"$($_.Version)`"...  " -ForegroundColor "Yellow";
    ${_}.Uninstall();
  }

}

# ------------------------------------------------------------
#
# UNINSTALL ASUS APPS
#  |
#  |--> Optionally perform this by [ typing each app's name into the start menu, then right-clicking them and selecting "Uninstall" ]. Alternatively, uninstall them by [ opening "Apps & features" then left-clicking the app and selecing "Uninstall" ]:
#

If ($True) {

  <# Uninstall Windows "Apps" #>

  $ASUS_APPX_PACKAGES_CONTAINS=@();
  $ASUS_APPX_PACKAGES_CONTAINS+="ArmouryCrate";
  $ASUS_APPX_PACKAGES_CONTAINS+="AURACreator";
  $ASUS_APPX_PACKAGES_CONTAINS+="ASUS";
  $ASUS_APPX_PACKAGES_CONTAINS | ForEach-Object {
    $EACH_APPX_PACKAGE_CONTAINS="${_}";
    Get-AppxPackage `
      | Where-Object { $_.Name -Like ("*${EACH_APPX_PACKAGE_CONTAINS}*"); } `
      | ForEach-Object {
        Write-Host "`nInfo: Removing AppxPackage (Windows App) w/ Name=`"$($_.Name)`", Version=`"$($_.Version)`"...  " -ForegroundColor "Yellow";
        Remove-AppxPackage ${_};
        Start-Sleep -Milliseconds (250);
      }
  };

}

# ------------------------------------------------------------
#
# STOP & REMOVE ASUS SERVICES
#

If ($True) {

  <# FIND/REMOVE SERVICES #>
  Get-WmiObject -Class "win32_service" `
  | Where-Object { `
    (($_.Name -Like "ASUS*") -Or ($_.DisplayName -Like "ASUS*")) `
    -Or (($_.Name -Like "ROG Live*") -Or ($_.DisplayName -Like "ROG Live*")) `
    -Or (($_.Name -Like "ARMOURY CRATE*") -Or ($_.DisplayName -Like "ARMOURY CRATE*")) `
    -Or ($_.PathName -Like "*ASUS*") `
  } | ForEach-Object {
    $_ | Stop-Service;
    Start-Sleep -Milliseconds (250);
    Write-Host "`nInfo: Deleting Service w/ Name=`"$($_.Name)`", DisplayName=`"$($_.DisplayName)`"...  " -ForegroundColor "Yellow";
    Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList (@("delete","$($_.Name)")) -Verb ("RunAs") -EA:0;
    Start-Sleep -Milliseconds (250);
  };

}

# ------------------------------------------------------------
#
# STOP ASUS PROCESSES
#

If ($True) {

  # STOP LINGERING ASUS PROCESSES
  Get-Process -EA:0 `
  | Where-Object { `
    (($_.Name -Like "*ASUS*") -Or ($_.Name -Like "Armoury*")) `
  } | ForEach-Object {
    Write-Host "`nInfo: Stopping Process w/ Name=`"$($_.Name)`", Id = `"$($_.Id)`"...  " -ForegroundColor "Yellow";
    Stop-Process -Id (${_}.ID) -Force -EA:0;
    Start-Sleep -Milliseconds (250);
  };

}

# ------------------------------------------------------------
#
# REMOVE ASUS FILES & DIRECTORIES 
#

If ($True) {

  $Paths_ToDelete = @();

  $Paths_ToDelete += "C:\Program Files\ASUS";
  $Paths_ToDelete += "C:\Program Files (x86)\ASUS";
  $Paths_ToDelete += "C:\Program Files (x86)\InstallShield Installation Information\{93795eb8-bd86-4d4d-ab27-ff80f9467b37}"; # --> A --> Enter
  $Paths_ToDelete += "C:\Program Files (x86)\LightingService";
  $Paths_ToDelete += "C:\ProgramData\ASUS";
  $Paths_ToDelete += "${Env:LocalAppData}\ASUS";
  $Paths_ToDelete += "C:\Windows\System32\AsusDownloadAgent.exe";
  $Paths_ToDelete += "C:\Windows\System32\AsusDownLoadLicense.exe";
  $Paths_ToDelete += "C:\Windows\System32\AsusUpdateCheck.exe";

  $Paths_ToDelete | ForEach-Object {
    $Each_PathToDelete = "${_}";
    If (Test-Path -Path ("${Each_PathToDelete}")) {
      Write-Host "Removing Path `"${Each_PathToDelete}`"...";
      Remove-Item -Path ("${Each_PathToDelete}") -Recurse -Force -Confirm:$False;
    };
  };

}

# ------------------------------------------------------------
#
# REMOVE ASUS REGISTRY ENTRIES
#

If ($True) {

  $Paths_ToDelete = @();

  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsRogAuraService.ServiceMediator.1";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsRogAuraService.ServiceMediator";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsRogAuraService.AuraSdkManager.1";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsRogAuraService.AuraSdkManager";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\asus.aura";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\asus.aura.1";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUS.OneClickCtrl.9";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUS.Update3WebControl.3";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\asusac";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraExtCardHal.Hal.1";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraMBHal.Hal";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraMBHal.Hal.1";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraOddHal.Hal";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraOddHal.Hal.1";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUS-Display.Hal";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUS-Display.Hal.1.0.2";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSGCDriverInitialClient";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSGCDriverUpdateClient";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsusGCGridServiceSetup";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoCreateAsync";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoCreateAsync.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoreClass";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoreClass.1";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoreMachineClass";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoreMachineClass.1";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CredentialDialogMachine";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CredentialDialogMachine.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassMachine";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassMachine.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassMachineFallback";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassMachineFallback.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassSvc";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassSvc.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.ProcessLauncher";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.ProcessLauncher.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3COMClassService";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3COMClassService.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebMachine";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebMachine.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebMachineFallback";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebMachineFallback.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebSvc";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebSvc.1.0";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\aura.sdk";
  $Paths_ToDelete += "Registry::HKEY_CLASSES_ROOT\aura.sdk.1";
  $Paths_ToDelete += "Registry::HKEY_CURRENT_USER\Software\ASUS";
  $Paths_ToDelete += "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\ASUS";
  $Paths_ToDelete += "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GameSDK Service";

  $Paths_ToDelete | ForEach-Object {
    $Each_PathToDelete = "$_";
    If (Test-Path -Path ("${Each_PathToDelete}")) {
      Write-Host "Removing Path `"${Each_PathToDelete}`"...";
      Remove-Item -Path ("$Each_PathToDelete") -Recurse -Force -Confirm:$false;
    };
  };

  #
  # Locating remaining registry keys to-delete (based on specific hardware)
  #   |
  #   |--> Download ASUS Aura (Zip file) - Do not install it, but rather open the packaged directory "LightingService\aac" and locate the target "Aac...exe" file for the hardware which you previously configured RGB/ARGB on. e.g. for motherboards, use "AacMBSetup.exe"
  #   |
  #   |--> Open a command prompt, change directory to the "LightingService\aac" directory, and run the following command (replacing associated .exe as-needed):
  #         |
  #         |--> AacMBSetup.exe -install -log log.txt
  #         |
  #         |--> Run the setup, walkthrough it as-normal, then open log.txt
  #         |
  #         |--> Search for lines containing, SPECIFICALLY:
  #         |      "Detected related package"   <-- These lines contain the {...GUIDs...} for old, deprecated versions of the ASUS AURA HAL AAC Driver which should be removed/uninstalled
  #         |
  #         |--> Search these lines for GUIDs wrapped with curly-braces within the log file, and copy the interior string (without the curly-braces).
  #         |
  #         |--> Open regedit.exe > select "Computer" (top-left) to select the entire registry
  #         |
  #         |--> Search (CTRL + F) the entire Computer (the "entire local registry") for the copied GUID
  #         |
  #         |--> For any keys that it finds, search for a nested property "UninstallString", then run that command in an admin CMD window. Follow it up by running all of its siblings' "UninstallString" commands in same CMD window
  #         |     |
  #         |     |--> Example) Under the key "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{9C9E903E-BBC7-4A0E-8326-ED6AC85B9FCC}\Instance\{E9BBD754-6CF4-492E-BA89-782177A2771B}\Instance", open each key and copy every command held in property "UninstallString" into an admin command prompt terminal
  #         |     |
  #         |     |--> Running just this key's uninstall commands removed all other registry keys tied to the invalid GUID as of 20200819T200238 run
  #         |
  #         |--> Once complete, reboot, then rerun the previous driver installation .exe command (the one using -install -log log.txt)
  #                 AacMBSetup.exe -install -log log.txt
  #

}

# ------------------------------------------------------------
#
# "All MB" - UNINSTALL / REMOVE APP
#
If ($True) {
  #
  # Application “All MB” must be disabled/uninstalled by stopping it from the BIOS
  #
  # Step 1/2 - Enter your device’s BIOS:
  #  |
  #  |--> From Windows:
  #  |     |--> Open the Start Menu
  #  |     |--> Type “UEFI” into start menu
  #  |     |--> Select “Change advanced startup options”
  #  |     |--> Select “Restart now”
  #  |     |--> Wait for blue screen options...
  #  |     |--> Select “Troubleshoot”
  #  |     |--> Select “Advanced options”
  #  |     |--> Select “UEFI Firmwate Settings”
  #  |     |--> Select “Restart”
  #  |
  #  |--> From POST (during your device’s power-on/boot up phase)
  #        |--> Spam either F2 or Delete (depending on your motherboard specification) on the keyboard to enter BIOS 
  #        |--> Stop spamming F2 or Delete (depending on your motherboard specification) if the windows loading icon appears (as it is too late by then, and BIOS likely needs to be entered thru windows - see previous step or retry by rebooting)
  #
  # Step 2/2 - Once you’re in the BIOS, disable Armoury Crate:
  #  |--> Hit F7 for Advanced
  #  |--> Goto tab “Tools”
  #  |--> Select “ASUS Armoury Crate”
  #  |--> Set option “Download & Install ARMOURY CRATE app” to “Disabled”
  #
}

# ------------------------------------------------------------
#
# Check for pending reboot
#

$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'CheckPendingRestart' -EA:0)) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\CheckPendingRestart\CheckPendingRestart.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
CheckPendingRestart;


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spiceworks.com  |  "Use UninstallString Powershell"  |  https://community.spiceworks.com/topic/2250963-use-uninstallstring-powershell
#
#   docs.microsoft.com  |  "Get-ChildItem - Gets the items and child items in one or more specified locations"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-5.1
#
#   docs.microsoft.com  |  "Remove-Item - Deletes the specified items"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-5.1
#
#   stackoverflow.com  |  "How can I extract "Path to executable" of all services with PowerShell - Stack Overflow"  |  https://stackoverflow.com/a/24449854
#
#   stackoverflow.com  |  "powershell - "Get-Package *notepad* | Uninstall-Package -Force" not working - Stack Overflow"  |  https://stackoverflow.com/a/54755801
#
# ------------------------------------------------------------