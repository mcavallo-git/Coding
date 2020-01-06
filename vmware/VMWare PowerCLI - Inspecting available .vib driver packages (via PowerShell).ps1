
# ------------------------------------------------------------

Install-Module -Name ("VMware.PowerCLI") -Scope ("CurrentUser") -Force;  <# Call  [ Get-DeployCommand ]  to inspect service(s) #> `
$Array_VibDepos = @(); `
$Array_VibDepos += ("https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml"); 	<# VMware Depot #> `
$Array_VibDepos += ("https://vibsdepot.v-front.de/index.xml");  <# V-Front Depot#> `
Write-Host "Pulling updated list of ESXi software packages (.vib drivers) from remote depot `"$($Array_VibDepos[0])`""; Add-EsxSoftwareDepot ($Array_VibDepos[0]); `
Write-Host "Pulling updated list of ESXi software packages (.vib drivers) from remote depot `"$($Array_VibDepos[1])`""; Add-EsxSoftwareDepot ($Array_VibDepos[1]); `
Write-Host "Searching available ESXi software packages (as .vib extensioned drivers)"; $Vibs = (Get-EsxSoftwarePackage);




# ------------------------------------------------------------

$Vibs

# ------------------------------------------------------------

# $Vibs.Name

# ($Vibs | Select-Object -Property "Name" -Unique | Sort-Object -Property "Name").Name

# ------------------------------------------------------------

# $Vibs.Version

# ($Vibs | Where-Object { $_.Version -Like "6.5*" })[1]

# $Vibs | Where-Object { $_.Version -Like "6.5*" } | Select-Object -Property "Name" -Unique | Sort-Object -Property "Name"

# ($Vibs | Select-Object -Property "Version" -Unique | Sort-Object -Property "Version").Version

# ------------------------------------------------------------

# $Vibs.Depends

# $Vibs[0].Depends

# $Vibs.Depends | Select-Object -First 20

# $Vibs.Depends | Select-Object -First 20 | Where-Object { $_.Version -Eq $Null } 

# ($Vibs | Where-Object { $_.Depends -Eq $Null } | Sort-Object -Property "Name").Depends

# ($Vibs | Where-Object { $_.Depends.Version -Eq $Null } | Sort-Object -Property "Name").Depends.Version

$Vibs.Depends | Select-Object -Property Name,Depends | Select-Object -First 20


# ------------------------------------------------------------
