

If ($True) {
Install-Module -Name "VMware.PowerCLI";
Add-EsxSoftwareDepot "https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml";
Add-EsxSoftwareDepot "https://vibsdepot.v-front.de/index.xml";
$Vibs = (Get-EsxSoftwarePackage);
$Vibs_Sorted = ($Vibs | Sort-Object -Property Name,@{Expression={$_.Version}; Ascending=$False});
$Vibs_Sorted | Format-List > "${Home}\Desktop\Vibs_FormatList.txt";
$Vibs_Sorted | Format-Table -Wrap > "${Home}\Desktop\Vibs_FormatTable.txt";

}

