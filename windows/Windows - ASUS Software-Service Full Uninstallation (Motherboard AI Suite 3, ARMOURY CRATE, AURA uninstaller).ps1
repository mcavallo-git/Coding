# ------------------------------------------------------------
#
# ASUS SOFTWARE REMOVAL
#  |
#  |-->  https://rog.asus.com/forum/showthread.php?114773-Armoury-Crate-not-recognizing-devices-and-unable-to-control-RGB#post794749
#  |
#  |-->  https://www.reddit.com/r/pcmasterrace/comments/eyqieh/asus_armoury_crateaura_complete_removal/
#
#
# ------------------------------------------------------------
#
# UNINSTALL THE FOLLOWING PROGRAM(S) (Win7 style exes) by opening "appwiz.cpl" ("Programs and Features") and right-clicking -> selecting "Uninstall" on each (wait til all are uninstalled to restart)
#

#  > FIND IN "appwiz.cpl", THEN UNINSTALL:

All MB   <# *** UNINSTALL VIA BIOS - SEE BELOW FOR DETAILED INFO *** #>

AI Suite 3
AMD Software
AMD_Chipset_Drivers
ARMOURY CRATE Lite Service
ASUS Framework Service
AURA
AURA lighting effect add-on
AURA lighting effect add-on x64
AURA Service
GALAX GAMER RGB
ROG Live Service


# ------------------------------------------------------------
#
# UNINSTALL THE FOLLOWING APPLICATION(S) (Win10 style apps) by [ typing their name into the start menu, then right-clicking them and selecting "Uninstall" ]. Alternatively, uninstall them by [ opening "Apps & features" then left-clicking the app and selecing "Uninstall" ]:
#

#  > FIND VIA START-MENU, THEN UNINSTALL:

ARMOURY CRATE
AURA Creator


# ------------------------------------------------------------
#
# REMOVE ASUS SERVICES
#

If ($True) {
	
	<# FIND/REMOVE SERVICES #>
	Get-Service -ErrorAction "SilentlyContinue" `
	| Where-Object { `
		(($_.Name -Like "ASUS*") -Or ($_.DisplayName -Like "ASUS*")) `
		-Or (($_.Name -Like "ROG Live*") -Or ($_.DisplayName -Like "ROG Live*")) `
		-Or (($_.Name -Like "ARMOURY CRATE*") -Or ($_.DisplayName -Like "ARMOURY CRATE*")) `
	} | ForEach-Object {
		$_ | Stop-Service;
		Start-Sleep -Milliseconds (250);
		Write-Host "`nInfo: Deleting Service w/ Name = `"$($_.Name)`", DisplayName = `"$($_.DisplayName)`" ...  " -ForegroundColor "Yellow";
		Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList (@("delete","$($_.Name)")) -Verb ("RunAs") -ErrorAction ("SilentlyContinue");
		Start-Sleep -Milliseconds (250);
	};

}


# ------------------------------------------------------------
#
# REMOVE ASUS FILES & DIRECTORIES 
#
If ($True) {

	<# SYSTEM-32 #>
	$Parent_Directory = "C:\Windows\System32";
	$Filenames_To_Remove = @();
	$Filenames_To_Remove += ("AsusDownloadAgent.exe");
	$Filenames_To_Remove += ("AsusDownLoadLicense.exe");
	$Filenames_To_Remove += ("AsusUpdateCheck.exe");
	Get-ChildItem -Path ("${Parent_Directory}") -File -Recurse -Depth (1) -Force -ErrorAction "SilentlyContinue" `
	| Where-Object { (${Filenames_To_Remove}) -Contains ("$($_.Name)"); } `
	| ForEach-Object {
		$Each_Fullpath = ("$($_.FullName)");
		Write-Host "Removing file with path  `"${Each_Fullpath}`" ...";
		Remove-Item -Path ("${Each_Fullpath}") -Force;
	};

	<# !!  Note: I had to boot into Safe Mode (w/o networking or command prompt) to delete the Prog-Files / Prof-Files-X86 directories, below  !! #>

	<# Remove the "All MB" app's directory - Afterwards, reboot, then attempt to uninstall from "appwiz.cpl", at which point it won't find the "Setup.exe" runtime and will ask if you wish to remove it from the list of installed programs > Confirm via "Yes"/etc.  #>
	# $Parent_Directory = "C:\Program Files (x86)\InstallShield Installation Information";
	# $Filenames_To_Remove = @();
	# $Filenames_To_Remove += ("{93795eb8-bd86-4d4d-ab27-ff80f9467b37}");
	# Get-ChildItem -Path ("${Parent_Directory}") -Directory -Force -ErrorAction "SilentlyContinue" `
	# | Where-Object { (${Filenames_To_Remove}) -Contains ("$($_.Name)"); } `
	# | ForEach-Object {
	# 	$Each_Fullpath = ("$($_.FullName)");
	# 	Write-Host "Removing directory with path  `"${Each_Fullpath}`" ...";
	# 	Get-ChildItem -Path ("${Each_Fullpath}") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Remove-Item -Force;
	# 	Get-Item -Path ("${Each_Fullpath}") -ErrorAction "SilentlyContinue" | Remove-Item -Path ("${Each_Fullpath}") -Force;
	# };

	<# PROG-FILES #>
	Remove-Item "C:\Program Files\ASUS"; # Hit "A" then Enter (to select 'Yes to all' deletion option) 
	Remove-Item "C:\Program Files (x86)\ASUS"; # --> A --> Enter
	Remove-Item "C:\Program Files (x86)\InstallShield Installation Information\{93795eb8-bd86-4d4d-ab27-ff80f9467b37}"; # --> A --> Enter
	Remove-Item "C:\ProgramData\ASUS"; # --> A --> Enter
	Remove-Item "${Env:LocalAppData}\ASUS"; # --> A --> Enter

}


# ------------------------------------------------------------
#
# REMOVE ASUS REGISTRY ENTRIES
#
If ($True) {

Remove-Item -Force -Path ($EachRegEdit.Path) | Out-Null;

Registry::HKEY_CLASSES_ROOT\

$RegistryKeys_ToDelete = @();
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsRogAuraService.ServiceMediator.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsRogAuraService.ServiceMediator";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsRogAuraService.AuraSdkManager.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsRogAuraService.AuraSdkManager";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\asus.aura";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\asus.aura.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUS.OneClickCtrl.9";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUS.Update3WebControl.3";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\asusac";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraExtCardHal.Hal.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraMBHal.Hal";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraMBHal.Hal.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraOddHal.Hal";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSAuraOddHal.Hal.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUS-Display.Hal";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUS-Display.Hal.1.0.2";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSGCDriverInitialClient";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSGCDriverUpdateClient";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\AsusGCGridServiceSetup";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoCreateAsync";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoCreateAsync.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoreClass";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoreClass.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoreMachineClass";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CoreMachineClass.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CredentialDialogMachine";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.CredentialDialogMachine.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassMachine";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassMachine.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassMachineFallback";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassMachineFallback.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassSvc";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.OnDemandCOMClassSvc.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.ProcessLauncher";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.ProcessLauncher.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3COMClassService";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3COMClassService.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebMachine";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebMachine.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebMachineFallback";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebMachineFallback.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebSvc";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\ASUSUpdate.Update3WebSvc.1.0";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\aura.sdk";
$RegistryKeys_ToDelete += "Registry::HKEY_CLASSES_ROOT\aura.sdk.1";
$RegistryKeys_ToDelete += "Registry::HKEY_CURRENT_USER\Software\ASUS";
$RegistryKeys_ToDelete += "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\ASUS";

<# Delete all associated registry keys #>
$RegistryKeys_ToDelete | ForEach-Object { Remove-Item -Force -Path ("$_") | Out-Null; };

# Locating remaining registry keys to-delete (based on specific hardware) #>
#   |
#   |--> Download ASUS Aura (Zip file) - Do not install it, but rather open the packaged directory "LightingService\aac" and locate the target "Aac...exe" file for the hardware which you previously configured RGB/ARGB on. e.g. for motherboards, use "AacMBSetup.exe" #>
#   |
#   |--> Open a command prompt, change directory to the "LightingService\aac" directory, and run the following command (replacing associated .exe as-needed): #>
#   |     |
#   |     |-->   AacMBSetup.exe -install -log aac-log.txt
#   |
#   |--> Once the program has ran, open it, search for GUIDs wrapped with curly-braces within the log file, and copy the interior string (without the curly-braces). Then, open regedit.exe, select "Computer" (at the top of the left area of regedit) to select the entire registry, then search it (CTRL + F) for the copied GUID  -->  Delete any keys it finds


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
# Citation(s)
#
#   docs.microsoft.com  |  "Get-ChildItem - Gets the items and child items in one or more specified locations"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-5.1
#
#   docs.microsoft.com  |  "Remove-Item - Deletes the specified items"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-5.1
#
# ------------------------------------------------------------