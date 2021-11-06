# ------------------------------------------------------------
#
# PowerShell - New-Item
#

#
# Example)  Create a directory
#
New-Item -ItemType ("Directory") -Path ("${Home}\Desktop\ExampleDirectory_$(Get-Date -UFormat '%Y%m%d-%H%M%S')") | Out-Null;


# ------------------------------------------------------------
#
# PowerShell - New-ItemProperty
#

#
# Example)  Create registry key properties
#
$EachProp = @{
	Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
	Description="Show or hide seconds on the system tray clock. 0=[Hide], 1=[Show]";
	Name="ShowSecondsInSystemClock";
	Type="DWord";
	Value=1;
};
New-ItemProperty -Force -LiteralPath ($EachProp.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value) | Out-Null;


# ------------------------------------------------------------
#
# PowerShell - Set-ItemProperty
#

# Example)  Create registry keys & set registry key properties
#
# Creating Registry keys using  [ New-Item -Force ... ]
#   |--> Pros  : Creates ALL parent registry keys
#   |--> Cons  : DELETES all properties & child-keys if key already exists
#   |--> TL;DR : Always use  [ Test-Path ... ]  to verify registry keys don't exist before using  [ New-Item -Force ... ]  to create the key
#
If ((Test-Path -Path ('Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced')) -Eq $False) {
	### Explorer Settings - Setting to [ 0 ] selects "Show hidden files, folders, and drives", setting to [ 1 ] selects "Don't show hidden files, folders, or drives"
	New-Item -Force -Path ('Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced') | Out-Null;
}
Set-ItemProperty -Force -Path ('Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced') -Name ('Hidden') -Value (0) | Out-Null;


# ------------------------------------------------------------

<# Example)  Set Chrome Homepage #>
If ($True) {

	$RegEdit = @{};
	$RegEdit.Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs";
	$RegEdit.Name="1";
	$RegEdit.Type="String";
	$RegEdit.Description="Chrome Homepage URL, where the Registry Key's Property Name is equal to the corresponding tab opened (e.g. 1 for first tab opened, 2 for second, etc.)";
	$RegEdit.Value="https://www.google.com";

	If ((Test-Path -Path (${RegEdit}.Path)) -Eq $True) {
		$GetEachItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -ErrorAction ("Stop"));
		If ((${GetEachItemProp}) -Eq (${RegEdit}.Value)) {
			If ($DebugMode -Eq $True) { Write-Output "$(Get-Date -Format 'yyyy-MM-ddThh:mm:ss.fffzzz')  |  Info:  (Skipped) Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" is already set to value `"$(${RegEdit}.Value)`""; }
		} Else {
			If ($DebugMode -Eq $True) { Write-Output "$(Get-Date -Format 'yyyy-MM-ddThh:mm:ss.fffzzz')  |  Info:  Setting Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" to value `"$(${RegEdit}.Value)`"..."; }
			Set-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -Value (${RegEdit}.Value);
		}
	} Else {
		If ($DebugMode -Eq $True) { Write-Output "$(Get-Date -Format 'yyyy-MM-ddThh:mm:ss.fffzzz')  |  Info:  Creating Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" with type `"$(${RegEdit}.Type)`" and value `"$(${RegEdit}.Value)`"..."; }
		New-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -PropertyType (${RegEdit}.Type) -Value (${RegEdit}.Value);
	}

}


# ------------------------------------------------------------

<# Example)  Set Edge Homepage #>
If ($True) {

	$RegEdit = @{};
	$RegEdit.Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\RestoreOnStartupURLs";
	$RegEdit.Name="1";
	$RegEdit.Type="String";
	$RegEdit.Description="Chrome Homepage URL, where the Registry Key's Property Name is equal to the corresponding tab opened (e.g. 1 for first tab opened, 2 for second, etc.)";
	$RegEdit.Value="https://www.google.com";

	If ((Test-Path -Path (${RegEdit}.Path)) -Eq $True) {
		$GetEachItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -ErrorAction ("Stop"));
		If ((${GetEachItemProp}) -Eq (${RegEdit}.Value)) {
			If ($DebugMode -Eq $True) { Write-Output "$(Get-Date -Format 'yyyy-MM-ddThh:mm:ss.fffzzz')  |  Info:  (Skipped) Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" is already set to value `"$(${RegEdit}.Value)`""; }
		} Else {
			If ($DebugMode -Eq $True) { Write-Output "$(Get-Date -Format 'yyyy-MM-ddThh:mm:ss.fffzzz')  |  Info:  Setting Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" to value `"$(${RegEdit}.Value)`"..."; }
			Set-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -Value (${RegEdit}.Value);
		}
	} Else {
		If ($DebugMode -Eq $True) { Write-Output "$(Get-Date -Format 'yyyy-MM-ddThh:mm:ss.fffzzz')  |  Info:  Creating Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" with type `"$(${RegEdit}.Type)`" and value `"$(${RegEdit}.Value)`"..."; }
		New-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -PropertyType (${RegEdit}.Type) -Value (${RegEdit}.Value);
	}

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "New-Item (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item
#
#   docs.microsoft.com  |  "New-ItemProperty (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-itemproperty
#
#   docs.microsoft.com  |  "Set-ItemProperty (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-itemproperty
#
#   stackoverflow.com  |  "New-Item recursive registry keys"  |  https://stackoverflow.com/a/21770519
#
# ------------------------------------------------------------