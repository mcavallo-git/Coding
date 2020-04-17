

If ($True) {
Add-EsxSoftwareDepot "https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml";
Add-EsxSoftwareDepot "https://vibsdepot.v-front.de/index.xml";
$Vibs = (Get-EsxSoftwarePackage);
}

