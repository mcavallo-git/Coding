If ($False) {
# RUN THIS SCRIPT REMOTELY / ON-THE-FLY:


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/CodeSigning/CodeSigning.psm1?t=$((Date).Ticks)")); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; CodeSigning;


}
#
#	PowerShell - CodeSigning
#		|
#		|--> Description:
#		|      Perform dynamic code-signing based on current environment variable states
#   |       > Pulls the code-signing cert from the 'Local Machine' Windows user's certficiate store
#   |       > Built to be compatible with Jenkins & TeamCity's default env-vars, by-default
#		|
#		|--> Example:
#		       PowerShell -Command ("CodeSigning")
#
Function CodeSigning() {
	Param(
		[Switch]$Path,
		[Switch]$Recurse,
		[Switch]$Quiet,
		[Switch]$DelaySigning,
		[Switch]$Force,
		[Int]$DelaySeconds = 60,
		[Int]$Depth = 4096,
		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args
	)

	$Do_DelayedSigning = $False;
	$Do_DelayedSigning = (($Do_DelayedSigning) -Or ($PSBoundParameters.ContainsKey('DelaySigning')));
	$Do_DelayedSigning = (($Do_DelayedSigning) -Or ((Test-Path -Path ("Env:IsFinalStep") -PathType ("Leaf")) -And ((${Env:IsFinalStep} -Eq $True) -Or (${Env:IsFinalStep} -Eq 1))));

	$Forced = ($PSBoundParameters.ContainsKey('Force'));
	$SingleTarget = (-Not $PSBoundParameters.ContainsKey('Recurse'));
	
	$ErrorMessage__NoTarget = "";
	$ErrorMessage__NoTarget += "`n";
	$ErrorMessage__NoTarget += "`nError:  Target could not be resolved - Insufficient environment variable & parameter data given to determine target path automatically";
	$ErrorMessage__NoTarget += "`nInfo:  To sign a single target, use parameter: `"-Path ('STRING_FILE_FULLPATH')`"";
	$ErrorMessage__NoTarget += "`nInfo:  To sign multiple targets, use parameters: `"-Path ('STRING_DIR_FULLPATH') -Recurse -Depth (INTEGER_MAX_DEPTH)`"";
	$ErrorMessage__NoTarget += "`n";

	<# Get the first non-expired code signing certificate found in the windows certificate store which has been imported onto the current Local Machine #>
	$FirstCert_CodeSigning = $Null;
	$LocalMachineCerts_CodeSigning = (Get-ChildItem "Cert:\LocalMachine\My" -CodeSigningCert | Where-Object { ($_ -NE $Null) } | Where-Object { ($_.NotAfter) -GT (Get-Date) });
	If ($LocalMachineCerts_CodeSigning -NE $Null) {
		$FirstCert_CodeSigning = (${LocalMachineCerts_CodeSigning}[0]);
	}
	If ($null -eq $FirstCert_CodeSigning) {
		<# No code signing certs found in the [ local machine ] certificate store #>
		Write-Output "`nError:  No code signing certificate(s) found in the Local Machine certificate store.`n`nInfo:  Please retry after installing a code-signing (.pfx) certificate onto the Local Machine certificate store`n";

	} Else { <# Determine Target Path to-be-signed #>

		$TargetPath = $Null;

		<# Inline '-Path' parameter #>
		If (($PSBoundParameters.ContainsKey('Path')) -And ("${Path}" -Ne $Null) -And (Test-Path -Path ("${Path}"))) {
			$TargetPath = "${Path}";
			Write-Output "`nSigning target: [ Inline '-Path' parameter ] with value `"${TargetPath}`"`n";
		}

		<# TeamCity build's working directory 'system.teamcity.build.checkoutDir' #>
		If (($null -eq $TargetPath) -And (("%system.teamcity.build.checkoutDir%") -NE (("%")+(@("system","teamcity","build","checkoutDir") -join ".")+("%")))) {
			$TargetPath = "%system.teamcity.build.checkoutDir%";
			Write-Output "`nSigning target: [ TeamCity build's working directory 'system.teamcity.build.checkoutDir' ] with value `"${TargetPath}`"`n";
		}
	
		<# TeamCity build's working directory 'system.teamcity.build.workingDir' #>
		If (($null -eq $TargetPath) -And (("%system.teamcity.build.workingDir%") -NE (("%")+(@("system","teamcity","build","workingDir") -join ".")+("%")))) {
			$TargetPath = "%system.teamcity.build.workingDir%";
			Write-Output "`nSigning target: [ TeamCity build's working directory 'system.teamcity.build.workingDir' ] with value `"${TargetPath}`"`n";
		}
	
		<# Jenkins build's working directory '`${Env:WORKSPACE}' #>
		If (($null -eq $TargetPath) -And (Test-Path -Path ("Env:WORKSPACE") -PathType ("Leaf"))) {
			$TargetPath = "${Env:WORKSPACE}";
			Write-Output "`nSigning target: [ Jenkins build's working directory '`${Env:WORKSPACE}' ] with value `"${TargetPath}`"`n";
		}
	
		<# TeamCity build's artifact output directory  -->  orking directory 'system.teamcity.build.workingDir' #>
		If (($null -eq $TargetPath) -And ((Test-Path -Path ("%env.TEAMCITY_DATA_PATH%\system\artifacts\%teamcity.project.id%\%system.teamcity.buildConfName%\%teamcity.build.id%") -PathType ("Leaf") -ErrorAction ("SilentlyContinue")) -Eq $True)) {
			<# TeamCity's artifact-output-directory exists #>
			$TargetPath = "%env.TEAMCITY_DATA_PATH%\system\artifacts\%teamcity.project.id%\%system.teamcity.buildConfName%\%teamcity.build.id%";
			Write-Output "`nSigning target: [ TeamCity build's artifact output directory  -->  'env.TEAMCITY_DATA_PATH' + '\system\artifacts\' + 'teamcity.project.id' + '\' 'system.teamcity.buildConfName' + '\' + 'teamcity.build.id' ] with value `"${TargetPath}`"`n";
		}

		Write-Output "`nInfo:  Using code signing certificate from the Local Machine certificate store:`n";
		$FirstCert_CodeSigning | Format-List;

		If ($null -eq $TargetPath) {
			Write-Output "${ErrorMessage__NoTarget}";

		} Else {

			$InfoMessage__DelayedSign = "";
			$InfoMessage__DelayedSign += "`n";
			$InfoMessage__DelayedSign += "`nCreating background/sleeper process then continuing-on without waiting for its completion";
			$InfoMessage__DelayedSign += "`nBackground job will awaken in ${DelaySeconds}s (at $(Get-Date -Date ((Get-Date).AddSeconds(${DelaySeconds})) -UFormat ('%H : %M : %S')))";
			$InfoMessage__DelayedSign += "`nUpon awakening, this 'sleeper' job will do code signing using target path of `"${TargetPath}`"";
			$InfoMessage__DelayedSign += "`n";

			If ($SingleTarget -Eq $True) {
				<# Use the code signing certificate to sign one, single file/target #>
				If (Test-Path -PathType "Leaf" -Path ("${TargetPath}")) {
					If ($Do_DelayedSigning -Eq $True) {
						<# Run a Background job and delay it by ${DelaySeconds} seconds, then attempt to sign the artifacts found in a given target directory #>
						Write-Output "${InfoMessage__DelayedSign}";
						Start-Process -NoNewWindow -Filepath ("C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe") -ArgumentList (@('-Command', (('Start-Sleep -Seconds ')+("${DelaySeconds}")+('; Get-Item -Path ("')+("${TargetPath}")+('" -Force | Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } | ForEach-Object { Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate ((Get-ChildItem "Cert:\LocalMachine\My" -CodeSigningCert | Where-Object { ($_.NotAfter) -GT (Get-Date) })[0]) -IncludeChain All -TimestampServer ("http://timestamp.digicert.com") | Out-Null; }'))));
					} Else {

						$FileToSign = ( `
							Get-Item -Path ("${TargetPath}") -Force `
							| Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } `
						);
						If ($FileToSign -Ne $Null) {
							# | Where-Object { ($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.sys") } `
							${FileToSign} | ForEach-Object { `
								Write-Output "Info:  Signing file `"$(${FileToSign}.FullName)`"";
								Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${FirstCert_CodeSigning}) -IncludeChain All -TimestampServer ("http://timestamp.digicert.com") | Out-Null;
							};
						} Else {
							Write-Output "`nInfo: File at filepath `"${TargetPath}`" does not require signing`n";
							Write-Output "`nFile's certificate info:`n $(Get-AuthenticodeSignature -FilePath ("$(${TargetPath})"))";

						}
					}
				} ElseIf (Test-Path -PathType "Container" -Path ("${TargetPath}")) {
					Write-Output "`nError:  Target filepath `"${TargetPath}`" found to be a directory`n";
					Write-Output "`nInfo:  To perform a recursive search + sign, please use argument `"-Recurse`"`n";

				} Else {
					Write-Output "`nError:  Target filepath not found: `"${TargetPath}`"`n";

				}

			} Else {

				If ($Do_DelayedSigning -Eq $True) {
					<# Run a Background job and delay it by ${DelaySeconds} seconds, then attempt to sign the artifacts found in a given target directory #>
					Write-Output "${InfoMessage__DelayedSign}";
					Start-Process -NoNewWindow -Filepath ("C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe") -ArgumentList (@('-Command', (('Start-Sleep -Seconds ')+("${DelaySeconds}")+('; Get-ChildItem -Path ("')+("${TargetPath}")+('" -Recurse -Force -File | Where-Object { ("$($_.FullName)" -Like "*.dll") -Or ("$($_.FullName)" -Like "*.exe") -Or ("$($_.FullName)" -Like "*.msi") -Or ("$($_.FullName)" -Like "*.sys") } | Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } | ForEach-Object { Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate ((Get-ChildItem "Cert:\LocalMachine\My" -CodeSigningCert | Where-Object { ($_.NotAfter) -GT (Get-Date) })[0]) -IncludeChain All -TimestampServer ("http://timestamp.digicert.com") | Out-Null; }'))));

				} Else {

					$FilesToSign = ( `
						Get-ChildItem -Path ("${TargetPath}") -Recurse -Depth (${Depth}) -Force -File `
						| Where-Object { ($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.sys") } `
						| Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } `
					);
					If ($FilesToSign.Count -Eq 0) {
						Write-Output "`nInfo:  No files found under path `"${TargetPath}`" which require signing`n";

					} Else {

						Write-Output "`nInfo:  Found $($FilesToSign.Count) file(s) to sign`n";

						If (($FilesToSign.Count -Gt 10) -And ($Forced -NE $True)) {
							$SecondsToTimeoutAfter = (10 * ($FilesToSign.Count)); # Make the wait-time to sign a ton of files be exorbitant if unintentially signing, say, your whole C:\ drive
							$SecondsAlreadyWaited = 0;
							Write-Output "`n`n  Press any key to confirm, or retry command using parameter '-Force' to perform a manual override of this message`n`n";
							While ((!$Host.UI.RawUI.KeyAvailable) -And (${SecondsAlreadyWaited}++ -LT ${SecondsToTimeoutAfter})) {
								[Threading.Thread]::Sleep(1000);
							}
						}

						<# Use the code signing certificate to sign all unsigned { .dll, .exe, .msi, & .sys } files found under the directory specified by "${Env:WORKSPACE}" #>
						$FilesToSign | ForEach-Object {
							Write-Output "Info:  Signing file `"$($_.FullName)`"...";
							Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${FirstCert_CodeSigning}) -IncludeChain All -TimestampServer ("http://timestamp.digicert.com") | Out-Null;
						};

					}
				}
			}
		}
	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "CodeSigning";
}


# ------------------------------------------------------------
# Checking the signature(s) on signed files:
#
#
#   Get-ChildItem -Path ("${Home}\Downloads") -Recurse -Force -File | Where-Object { ($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.sys") } | ForEach-Object { Get-AuthenticodeSignature -FilePath ("$($_.FullName)") };
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Set-AuthenticodeSignature"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-authenticodesignature?view=powershell-5.1
#
#   docs.microsoft.com  |  "Test-Path - Determines whether all elements of a path exist"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-5.1
#
#   docs.microsoft.com  |  "Microsoft SmartScreen & Extended Validation (EV) Code Signing Certificates | Microsoft Docs"  |  https://docs.microsoft.com/en-us/archive/blogs/ie/microsoft-smartscreen-extended-validation-ev-code-signing-certificates
#
#   docs.microsoft.com  |  "Windows SmartScreen prevented an unrecognized app from running. Running this app might put your PC at risk | Microsoft Docs"  |  https://docs.microsoft.com/en-us/archive/blogs/vsnetsetup/windows-smartscreen-prevented-an-unrecognized-app-from-running-running-this-app-might-put-your-pc-at-risk
#
#   stackoverflow.com  |  "installation - How to avoid the 'Windows Defender SmartScreen prevented an unrecognized app from starting warning' - Stack Overflow"  |  https://stackoverflow.com/a/51113771
#
#
# ------------------------------------------------------------