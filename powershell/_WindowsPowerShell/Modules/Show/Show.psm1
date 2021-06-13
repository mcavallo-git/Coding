# ------------------------------------------------------------
#
#	PowerShell - Show
#		|
#		|--> Description:  Shows extended variable information to user
#		|
#		|--> Example:     PowerShell -Command ("Show `$MyInvocation -Methods")
#
# ------------------------------------------------------------

Function Show() {
	Param(
		[Switch]$AlwaysGetHelp,
		[Switch]$NoGetHelp,
		[Switch]$NoMethods,
		[Switch]$NoOther,
		[Switch]$NoProperties,
		[Switch]$NoRegistry,
		[Switch]$NoValue,
		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:


		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/Show/Show.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Show' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Show\Show.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		Show @{"a"="b";"c"="d";};


	}
	# ------------------------------------------------------------
	$ForceGetHelp = ($PSBoundParameters.ContainsKey('AlwaysGetHelp'));
	$ShowGetHelp = (-Not $PSBoundParameters.ContainsKey('NoGetHelp'));
	$ShowMethods = (-Not $PSBoundParameters.ContainsKey('NoMethods'));
	$ShowOther = (-Not $PSBoundParameters.ContainsKey('NoOther'));
	$ShowProperties = (-Not $PSBoundParameters.ContainsKey('NoProperties'));
	$ShowRegistry = (-Not $PSBoundParameters.ContainsKey('NoRegistry'));
	$ShowValue = (-Not $PSBoundParameters.ContainsKey('NoValue'));

	ForEach ($EachArg in ($inline_args+$args)) {
		If ($EachArg -Eq $Null) {
			Write-Output "`$Null"
		} Else {
			$AnyValueDetected = $False;
			If ($ShowMethods -Eq $True) {
				#
				# METHODS
				#
				$ListMethods = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Method")) -Eq $True } `
				);
				Write-Output "`n=====  METHODS  =====  ( hide via -NoMethods )  ============`n";
				If ($ListMethods -Ne $Null) {
					$ListMethods | ForEach-Object { Write-Output "    $($_.Name)"; };
					$AnyValueDetected = $True;
				} Else {
					Write-Output "    (no methods found)";
				}
			}
			If ($ShowOther -Eq $True) {
				#
				# OTHER MEMBERTYPES
				#
				$ListOthers = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Propert")) -Eq $False } `
						| Where-Object { ("$($_.MemberType)".Contains("Method")) -Eq $False } `
				);
				If ($ListOthers -Ne $Null) {
					Write-Output "`n=====  OTHER TYPES  =====  ( hide via -NoOther )  ==========`n";
					$ListOthers | ForEach-Object { Write-Output $_; };
					$AnyValueDetected = $True;
				}
			}
			If ($ShowProperties -Eq $True) {
				#
				# PROPERTIES
				#
				$ListProperties = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Propert")) -Eq $True <# Matches *Property* and *Properties* #>; }
				);
				Write-Output "`n=====  PROPERTIES  =====  ( hide via -NoProperties )  ======`n";
				If ($ListProperties -Ne $Null) {
					$ListProperties | ForEach-Object {
						$EachVal = If ($EachArg.($($_.Name)) -eq $Null) { "`$NULL" } Else { $EachArg.($($_.Name)) };
						Write-Output "    $($_.Name) = $($EachVal)";
						$AnyValueDetected = $True;
					};
				} Else {
					Write-Output "    (no properties found)";
				}
			}
			If (($ForceGetHelp -Eq $True) -Or (($AnyValueDetected -Eq $False) -And ($ShowGetHelp -Eq $True))) {
				#
				# GET-HELP (only shown if no other values are detected)
				#
				Write-Output "`n=====  GET-HELP  =====  ( hide via -NoGetHelp, always show via -AlwaysGetHelp )  ======`n";
				Get-Help (${EachArg}) | Out-Host -Paging;
			}
			If ($ShowRegistry -eq $True) {
				If (($EachArg.GetType()).Name -Eq "String") {
					$Pattern_UUID  = '^{[0-9A-Fa-f]{8}\b-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-\b[0-9A-Fa-f]{12}}$';
					If (([Regex]::Match($EachArg, ${Pattern_UUID})).Success -ne $False) {
						Write-Output "`n=====  REGISTRY  =====  ( hide via -NoRegistry )  ==========`n";
						# Check for Registry Key
						$Revertable_ErrorActionPreference = $ErrorActionPreference; $ErrorActionPreference = 'SilentlyContinue';

						$Check_APPID = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AppID\$EachArg";
						$RegistryKey_APPID = Get-Item -Path "${Check_APPID}";
						$RetCode_APPID = If($?){0}Else{1};

						$Check_CLSID = "Registry::HKEY_CLASSES_ROOT\CLSID\$EachArg";
						$RegistryKey_CLSID = Get-Item -Path "${Check_CLSID}";
						$RetCode_CLSID = If($?){0}Else{1};

						$ErrorActionPreference = $Revertable_ErrorActionPreference;

						# Write-Output "    `${Check_APPID} = [${Check_APPID}]";
						# Write-Output "    `${RetCode_APPID} = [${RetCode_APPID}]";
						# Write-Output "    `${RegistryKey_APPID} = [${RegistryKey_APPID}]";
						# Write-Output "`n";
						# Write-Output "    `${Check_CLSID} = [${Check_CLSID}]";
						# Write-Output "    `${RetCode_CLSID} = [${RetCode_CLSID}]";
						# Write-Output "    `${RegistryKey_CLSID} = [${RegistryKey_CLSID}]";
						# Write-Output "`n";

						If ($RetCode_APPID -Eq 0)	{
							Write-Output "!!  Detected  [ APPID ]  UUID w/ Path `"${Check_APPID}`":";
							$RegistryKey_APPID | Format-List;
							# Show $RegistryKey_APPID;
						}
						If ($RetCode_CLSID -Eq 0)	{
							Write-Output "!!  Detected  [ CLSID ]  UUID w/ Path `"${Check_CLSID}`":";
							$RegistryKey_CLSID | Format-List;
							# Show $RegistryKey_CLSID;
						}
						If (($RetCode_APPID -Ne 0) -And ($RetCode_CLSID -Ne 0))	{
							Write-Output "    (no matching CLSID or APPID Keys found)";
						}
					}
				}
			}
			If ($ShowValue -eq $True) {
				Write-Output "`n=====  VALUE  =====  ( hide via -NoValue )  ================`n";
				# $EachArg | Format-List; <# Less Verbose #>
				$EachArg | Format-List -Property ([String][Char]42); <# More Verbose - Equivalent to [ $EachArg | Format-List *; ] #>
			}
		Write-Output "`n------------------------------------------------------------";
		}
	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Show";
}


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Member"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member?view=powershell-6
#
#   powershellexplained.com  |  "Powershell: Everything you wanted to know about arrays"  |  https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/#write-output--noenumerate
#
#   stackoverflow.com  |  "Searching for UUIDs in text with regex"  |  https://stackoverflow.com/a/6640851
#
# ------------------------------------------------------------