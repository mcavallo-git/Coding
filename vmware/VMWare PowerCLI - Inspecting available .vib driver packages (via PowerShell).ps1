
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
# 	$Depends = ($EachVib.Depends | Where-Object { (($_.Relation -Eq ">=") -And ($_.Version -Like "6.5*")) });
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
# 	$Depends = ($EachVib.Depends | Where-Object {
# 		(
# 			($_.PackageName -Eq "esx-base") -And (
# 				(($_.Relation -Eq ">=") -And ($_.Version -Like "6.5*")) -Or
# 				(($_.Relation -Eq "=") -And ($_.Version -Like "6.5*")) -Or
# 				(($_.Relation -Eq "<=") -And ($_.Version -Like "6.5*"))
# 		))
# 	});
# 	If ($Depends -Ne $Null) {
# 		$MatchingVibs += $EachVib;
# 	}
# }; `
# $MatchingVibs;


# ($Vibs.Depends.Version) -Match "(^6\.[12345])|(^[12345]\.)"


# $MatchingVibs = @(); `
# ForEach ($EachVib in $Vibs) {
# 	$AddVib = $True;
# 	# ForEach ($Depends in $EachVib.Depends) {
# 		$Depends = ($EachVib.Depends | Where-Object {
# 			(
# 				($_.PackageName -Eq "esx-base") -And (
# 					(($_.Relation -Eq ">=") -And ($_.Version -Match "(^6(\.[12345])?)|(^[12345]\.?)")) -Or
# 					(($_.Relation -Eq "=" ) -And ($_.Version -Match "(^6(\.5)?)")) -Or
# 					(($_.Relation -Eq "<=") -And ($_.Version -NotMatch "(^6(\.[1234])?)|(^[12345]\.?)"))
# 			))
# 		});
# 	# }
# 	If ($Depends -Ne $Null) {
# 		$MatchingVibs += $EachVib;
# 	}
# }; `
# $MatchingVibs.Depends;


# ForEach ($EachVib in $Vibs) {
# 	$Depends = ($EachVib.Depends | Where-Object {
# 		(($_.PackageName -Like "esx-*"))
# 	});
# 	If ($Depends -Ne $Null) {
# 		$Depends
# 	}
# };


# ForEach ($EachVib in $Vibs) {
# 	$InvalidDependency = $False;
# 	ForEach ($Depends in $EachVib.Depends) {
# 		If (@("esx-base","esx-update","esx-version") -Contains ($Depends.PackageName)) {
# 			If ($Relation -Eq ">=") {
# 			} ElseIf ($Relation -Eq "=") {
# 			} ElseIf ($Relation -Eq "<=") {
# 			} Else {
# 				$Depends;
# 			}
# 		}
# 	}
# };


# $Depends=@{Version="6.7"}; (([Int][String](($Version)[0]) -GE 6) -And (((($Version)[2]) -Eq $Null) -Or ([Int][String](($Version)[2]) -GE 5)))

# $Version="6.0.0-3.96"; ([Decimal](($Version.Split('.')[1])));

# $Version="6.0.0-3.96"; [Decimal](($Version.Split('.') | Select-Object -First 2) -Join ".");
# $Version="6.7"; [Decimal](($Version.Split('.') | Select-Object -First 2) -Join ".");
# $Version="6"; [Decimal](($Version.Split('.') | Select-Object -First 2) -Join ".");
# $Version=""; [Decimal](($Version.Split('.') | Select-Object -First 2) -Join ".");


$Vibs_Valid = @(); `
$Vibs_Invalid = @(); `
$ESXiVersion = "6.5"; `
$ESXiVersionDecimal = [Decimal](($ESXiVersion.Split('.') | Select-Object -First 2) -Join "."); `
ForEach ($EachVib in $Vibs) {
	$ValidVib = $True;
	ForEach ($Depends in $EachVib.Depends) {
		$ValidDependency = $True;
		$PackageName = $Depends.PackageName;
		$Relation = $Depends.Relation;
		$Version = $Depends.Version;
		If (($Version -NE $Null) -And ($Version.GetType().Name -Eq "String") -And (@("esx-base","esx-update","esx-version").Contains($PackageName))) {
			$ValidDependency = $False; <# Assume guilty until proven innocent #>
			If ($Version.Split.Count -Eq 1) {
				$MinorVersionSpecified = $False;
			} Else {
				$MinorVersionSpecified = $True;
			}
			$EachVersionDecimal = [Decimal](($Version.Split('.') | Select-Object -First 2) -Join ".");
			If (($Relation -Eq ">") -Or ($Relation -Eq ">>")) {
				<# Greater-Than Version #>
				If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -GT $EachVersionDecimal)) {
					$ValidDependency = $True;
				} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -GT ([Int]$EachVersionDecimal))) {
					$ValidDependency = $True;
				}
			} ElseIf ($Relation -Eq ">=") {
				<# Greater-Than / Equal-To Version #>
				If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -GE $EachVersionDecimal)) {
					$ValidDependency = $True;
				} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -GE ([Int]$EachVersionDecimal))) {
					$ValidDependency = $True;
				}
			} ElseIf ($Relation -Eq "=") {
				<# Equals Version #>
				If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -Eq $EachVersionDecimal)) {
					$ValidDependency = $True;
				} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -Eq ([Int]$EachVersionDecimal))) {
					$ValidDependency = $True;
				}
			} ElseIf ($Relation -Eq "<=") {
				<# Less-Than / Equal-To Version #>
				If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -LE $EachVersionDecimal)) {
					$ValidDependency = $True;
				} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -LE ([Int]$EachVersionDecimal))) {
					$ValidDependency = $True;
				}
			} ElseIf (($Relation -Eq "<") -Or ($Relation -Eq "<<")) {
				<# Less-Than Version #>
				If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -LT $EachVersionDecimal)) {
					$ValidDependency = $True;
				} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -LT ([Int]$EachVersionDecimal))) {
					$ValidDependency = $True;
				}
			} ElseIf ($Depends.Relation -NE $Null) {
				Write-Host "Unhandled .vib dependency-relation: "; $Relation; <# Output Un-handled Relations #>
			}
		}
		If ($ValidDependency -Eq $False) {
			$ValidVib = $False;
		}
	}
	If ($ValidVib -Eq $True) {
		$Vibs_Valid += $EachVib;
	} Else {
		$Vibs_Invalid += $EachVib;
	}
}; `
Write-Host "------------------------------------------------------------"; `
Write-Host "Vibs_Invalid:"; $Vibs_Invalid; `
Write-Host "------------------------------------------------------------"; `
Write-Host "Vibs_Valid:"; $Vibs_Valid; `
Write-Host "------------------------------------------------------------";


# ------------------------------------------------------------
#
#	Citation(s)
#
#   docs.microsoft.com  |  "about_Automatic_Variables - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables#using-enumerators
#
#   docs.microsoft.com  |  "about_Break - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_break
#
#   docs.microsoft.com  |  "about_Comparison_Operators - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators
#
#   docs.microsoft.com  |  "about_Foreach - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach
#
#   docs.microsoft.com  |  "about_Logical_Operators - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logical_operators
#
#   docs.microsoft.com  |  "About numeric literals - PowerShell - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_numeric_literals
#
#   docs.microsoft.com  |  "ForEach-Object"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object
#
#   stackoverflow.com  |  "How can check input value is in array or not in powershell"  |  https://stackoverflow.com/a/16965665
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   stackoverflow.com  |  "Where-object $_ matches multiple criterias"  |  https://stackoverflow.com/a/23896434
#
#   vdc-download.vmware.com  |  "Best Practices for Creating and Publishing VIBs"  |  https://vdc-download.vmware.com/vmwb-repository/dcr-public/9ec4b759-1f2a-49a9-93e3-7c31230cdbc1/2c177be4-c508-43e4-81fb-5fe3c448dc3a/Best%20Practices%20for%20Creating%20and%20Publishing%20VIBs%3D1%3DProduct%20Doc%20PDF%3Den.pdf
#
# ------------------------------------------------------------