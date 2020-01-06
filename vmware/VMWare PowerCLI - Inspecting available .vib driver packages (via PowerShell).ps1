
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

# $Vibs.Depends | Where-Object { $_.Version -Eq $Null } | Select-Object -First 20

# ($Vibs | Where-Object { $_.Depends -Eq $Null } | Sort-Object -Property "Name").Depends

# ($Vibs | Where-Object { $_.Depends.Version -Eq $Null } | Sort-Object -Property "Name").Depends.Version

# $Vibs | Sort-Object -Property "Name" | Select-Object -Property Name,Depends | Select-Object -First 20

# $Vibs | Sort-Object -Property "Name" | Where-Object { $_.Depends.Version -Eq $Null } | Select-Object -Property Name,Depends | Select-Object -First 20

# ($Vibs | Sort-Object -Property "Name" | Where-Object { $_.Depends.Version -Eq $Null } | Select-Object -Property Name,Depends).Depends.Version | Select-Object -First 20

# ($Vibs | Sort-Object -Property "Name" | Where-Object { $_.Depends.Version -Ne $Null } | Select-Object -Property Name,Depends).Depends.Version | Select-Object -First 20

# $Vibs | Sort-Object -Property "Name" | Where-Object { ($_.Depends.Relation -Eq "<=") } | Select-Object -Property Name,Depends | Select-Object -First 20

# Clear-Host; Write-Host "`n`n`n`n`n"; $Vibs | Sort-Object -Property "Name" | Where-Object { ($_.Depends.Relation -Eq ">=") -And ($_.Depends.Version -NotLike "6.*") } | Select-Object -Property Name,Depends | Select-Object -First 50

# Clear-Host; Write-Host "`n`n`n`n`n"; $Vibs | Sort-Object -Property "Name" | Where-Object { ($_.Depends.Relation -Eq ">=") -And ($_.Depends.Version -NotLike "6.*") } | Select-Object -Property Name,Depends | Select-Object -First 60



# Clear-Host; Write-Host "`n`n`n`n`n"; $Vibs | Sort-Object -Property "Name" | Where-Object { $_.Depends.Relation -Eq ">=" } | Select-Object -First 60

# Clear-Host; Write-Host "`n`n`n`n`n"; $Vibs | Sort-Object -Property "Name" | ForEach-Object { $_.Depends | Where-Object { $_.Relation -Eq ">=" }} | Select-Object -First 60

# $obj1 | Foreach-Object { 
#     $myobj1 = $_
#     $obj2 | Where-Object { $_ .... }
# }

Clear-Host; Write-Host "`n`n`n`n`n"; $Vibs | Sort-Object -Property "Name" | Where-Object {
	(
		$_.Depends.Relation -Match ">=" -And
		$_.Depends.Version -Match "bnx2x"
	)
}

ForEach($item in $obj1){
    $obj | Where-Object{$_.arg -eq $item.arg}
}


Clear-Host; Write-Host "`n`n`n`n`n"; $Vibs | Sort-Object -Property "Name" | ForEach-Object { $_.Depends | Where-Object { $_.Relation -Eq ">=" }} | Select-Object -First 60




# ------------------------------------------------------------
#
#	Citation(s)
#
#   docs.microsoft.com  |  "about_Automatic_Variables - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables#using-enumerators
#
#   docs.microsoft.com  |  "about_Comparison_Operators - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators
#
#   docs.microsoft.com  |  "about_Foreach - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach
#
#   docs.microsoft.com  |  "about_Logical_Operators - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logical_operators
#
#   docs.microsoft.com  |  "ForEach-Object"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   stackoverflow.com  |  "Where-object $_ matches multiple criterias"  |  https://stackoverflow.com/a/23896434
#
# ------------------------------------------------------------