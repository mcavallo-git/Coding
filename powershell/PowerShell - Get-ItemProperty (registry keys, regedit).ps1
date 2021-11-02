# ------------------------------------------------------------
#
# Get-ItemProperty
#   |
#   |--> Example: Check registry "HKEY_CURRENT_USER:\" for user-specific "Path" environment variables 
#         |--> Note: Powershell's built-in environment variable $Env:Path is a combination of system & user-specific environment-variables)
#
# ------------------------------------------------------------

If ($True) {

$RegEdit = @{
	Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Search";
	Name="BingSearchEnabled";
	Type="DWord";
	Description="Enables (1) or Disables (0) Cortana's ability to send search-resutls to Bing.com. Set to '1' to resolve high-cpu bug from Windows-Update KB4512941 (2019-Sept).";
	Value=0;
};

If ((Test-Path -Path (${RegEdit}.Path)) -Eq $True) {
	$GetEachItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -ErrorAction ("Stop"));
	If ((${GetEachItemProp}) -Eq (${RegEdit}.Value)) {
		Write-Host "`nInfo:  (Skipped) Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" is already set to value `"$(${RegEdit}.Value)`"";
	} Else {
		Write-Host "`nInfo:  Setting Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" to value `"$(${RegEdit}.Value)`"...";
		Set-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -Value (${RegEdit}.Value);
	}
} Else {
	Write-Host "`nInfo:  Creating Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" with type `"$(${RegEdit}.Type)`" and value `"$(${RegEdit}.Value)`"...";
	New-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -PropertyType (${RegEdit}.Type) -Value (${RegEdit}.Value);
}
Write-Host "`nInfo:  Getting info for Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`"...";
Get-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name);

}


<# Example - Separate vs Combined [ Registry Key Path ] & [ Registry Key Property Name ] #>
<#  |-->  DEPRECATED ??? Not sure where this works (or what cmdlets/modules it applies to) ???
# Path="Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Terminal Services!MaxCompressionLevel";


# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "Get-ItemProperty (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty
#
#		ss64.com  |  "New-ItemProperty - Set a new property, for an item at a given location"  |  https://ss64.com/ps/new-itemproperty.html
#
# ------------------------------------------------------------