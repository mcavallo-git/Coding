
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

# $Vibs | Sort-Object -Property "Name" | Where-Object { ($_.Depends.Relation -Eq ">=") -And ($_.Depends.Version -NotLike "6.*") } | Select-Object -Property Name,Depends | Select-Object -First 50

# $Vibs | Sort-Object -Property "Name" | Where-Object { ($_.Depends.Relation -Eq ">=") -And ($_.Depends.Version -NotLike "6.*") } | Select-Object -Property Name,Depends | Select-Object -First 60

# $Vibs | Sort-Object -Property "Name" | Where-Object { $_.Depends.Relation -Eq ">=" } | Select-Object -First 60

# $Vibs | Sort-Object -Property "Name" | ForEach-Object { $_.Depends | Where-Object { $_.Relation -Eq ">=" }} | Select-Object -First 60

# $Vibs | Sort-Object -Property "Name" | Where-Object { $_.Depends | ForEach-Object { $_ | Where-Object { (($_.Relation -Eq ">=") -And ($_.Version -Like "6.5*")) } } }

# ForEach ($EachVib in $Vibs) {
# 	$EachDepends = ($EachVib.Depends | Where-Object { (($_.Relation -Eq ">=") -And ($_.Version -Like "6.5*")) });
# 	Write-Host "EachDepends = [ ${EachDepends} ]";
# };

# ForEach ($EachVib in $Vibs) {
# 	$EachVib.Depends | Where-Object {
# 		(($_.Relation -Ne $Null) -And ($_.Version -Ne $Null))
# 	}
# }

# Show $Vibs.Depends[0]


# $MatchingVibs = @(); `
# ForEach ($EachVib in $Vibs) {
# 	$EachDepends = ($EachVib.Depends | Where-Object {
# 		(
# 			($_.PackageName -Eq "esx-base") -And (
# 				(($_.Relation -Eq ">=") -And ($_.Version -Like "6.5*")) -Or
# 				(($_.Relation -Eq "=") -And ($_.Version -Like "6.5*")) -Or
# 				(($_.Relation -Eq "<=") -And ($_.Version -Like "6.5*"))
# 		))
# 	});
# 	If ($EachDepends -Ne $Null) {
# 		$MatchingVibs += $EachVib;
# 	}
# }; `
# $MatchingVibs;


# ($Vibs.Depends.Version) -Match "(^6\.[12345])|(^[12345]\.)"


# $MatchingVibs = @(); `
# ForEach ($EachVib in $Vibs) {
# 	$AddVib = $True;
# 	# ForEach ($EachDepends in $EachVib.Depends) {
# 		$EachDepends = ($EachVib.Depends | Where-Object {
# 			(
# 				($_.PackageName -Eq "esx-base") -And (
# 					(($_.Relation -Eq ">=") -And ($_.Version -Match "(^6(\.[12345])?)|(^[12345]\.?)")) -Or
# 					(($_.Relation -Eq "=" ) -And ($_.Version -Match "(^6(\.5)?)")) -Or
# 					(($_.Relation -Eq "<=") -And ($_.Version -NotMatch "(^6(\.[1234])?)|(^[12345]\.?)"))
# 			))
# 		});
# 	# }
# 	If ($EachDepends -Ne $Null) {
# 		$MatchingVibs += $EachVib;
# 	}
# }; `
# $MatchingVibs.Depends;


# ForEach ($EachVib in $Vibs) {
# 	$EachDepends = ($EachVib.Depends | Where-Object {
# 		(($_.PackageName -Like "esx-*"))
# 	});
# 	If ($EachDepends -Ne $Null) {
# 		$EachDepends
# 	}
# };


# ForEach ($EachVib in $Vibs) {
# 	$InvalidDependency = $False;
# 	ForEach ($EachDepends in $EachVib.Depends) {
# 		If (@("esx-base","esx-update","esx-version") -Contains ($EachDepends.PackageName)) {
# 			If ($EachDepends.Relation -Eq ">=") {
# 				# Greater-Than / Equal-To Version
# 				If ($EachDepends.Version -Match "^6\.[6789]") {
# 					$EachDepends;
# 					$InvalidDependency = $True;
# 				}
# 			}
# 		}
# 	}
# };


$MatchingVibs = @(); `
ForEach ($EachVib in $Vibs) {
	$InvalidDependency = $False;
	ForEach ($EachDepends in $EachVib.Depends) {
		If (@("esx-base","esx-update","esx-version") -Contains ($EachDepends.PackageName)) {
			If ($EachDepends.Relation -Eq ">=") {
				# Greater-Than / Equal-To Version
				If ($EachDepends.Version -Match "^6\.[6789]") {
					$EachDepends;
					$InvalidDependency = $True;
				}
			} Else If ($EachDepends.Relation -Eq "=") {
				# Equals Version
				If ($EachDepends.Version -Match "(^6(\.5)|$)") {
					$EachDepends;
					$InvalidDependency = $True;
				}
			} Else If ($EachDepends.Relation -Eq "<=") {
				# Less-Than / Equal-To Version
				If ($EachDepends.Version -Match "(^6(\.[1234])|$)|(^[12345](\.)|$)") {
					$EachDepends;
					$InvalidDependency = $True;
				}
			} Else {
				$EachDepends.Relation;
			}
		}
	}
	If ($InvalidDependency -Eq $True) {
		$MatchingVibs += $EachVib;
	}
};




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
#   stackoverflow.com  |  "How can check input value is in array or not in powershell"  |  https://stackoverflow.com/a/16965665
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   stackoverflow.com  |  "Where-object $_ matches multiple criterias"  |  https://stackoverflow.com/a/23896434
#
# ------------------------------------------------------------