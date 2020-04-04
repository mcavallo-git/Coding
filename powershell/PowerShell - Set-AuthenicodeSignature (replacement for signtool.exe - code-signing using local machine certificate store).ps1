# ------------------------------------------------------------
#
# Perform dynamic code-signing based on current environment
#   |
#   |--> Gets the code signing cert to use from the Local Machine certficiate store
#   |
#   |--> Compatible with either TeamCity or Jenkins build environments
#
# ------------------------------------------------------------
If ($False) { ### RUN THIS SCRIPT:


Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Set-AuthenicodeSignature%20(replacement%20for%20signtool.exe%20-%20code-signing%20using%20local%20machine%20certificate%20store).ps1'));


}
# ------------------------------------------------------------

<# Determine Working Directory #>
$WorkingDir = $Null;
$ArtifactsDir = $Null;
If (("%system.teamcity.build.workingDir%") -NE (("%")+(@("system","teamcity","build","workingDir") -join ".")+("%"))) {
	<# TeamCity build-environment #>
	$WorkingDir = "%system.teamcity.build.workingDir%";
	$ArtifactsDir = $Null;
	If ((Test-Path -Path ("%env.TEAMCITY_DATA_PATH%\system\artifacts\%teamcity.project.id%\%system.teamcity.buildConfName%\%teamcity.build.id%") -PathType ("Leaf") -ErrorAction ("SilentlyContinue")) -Eq $True) {
		<# TeamCity's artifact-output-directory exists #>
		$ArtifactsDir = "%env.TEAMCITY_DATA_PATH%\system\artifacts\%teamcity.project.id%\%system.teamcity.buildConfName%\%teamcity.build.id%";
	}

} ElseIf (Test-Path -Path ("Env:WORKSPACE") -PathType ("Leaf")) {
	<# Jenkins (or manually-defined) build-environment #>
	$WorkingDir = "${Env:WORKSPACE}";

}

<# Get the first non-expired code signing certificate found in the windows certificate store which has been imported onto the current Local Machine #>
$Cert_CodeSigning = ((Get-ChildItem "Cert:\LocalMachine\My" -CodeSigningCert | Where-Object { ($_.NotAfter) -GT (Get-Date) })[0]);

If ($Cert_CodeSigning -Eq $Null) {
	Write-Output "`nError - No code signing certificate(s) found in the Local Machine certificate store. Please retry after installing a code-signing (.pfx) certificate onto the Local Machine certificate store`n";
	Start-Sleep 10;

} Else {
	Write-Output "`nInfo - Using code signing certificate from the Local Machine certificate store:`n";
	$Cert_CodeSigning | Format-List;

	If ($WorkingDir -Eq $Null) {
		Write-Output "`nError - Unable to detetermine working directory. You may manually define the working directory by setting it as the value of environment variable `${Env:WORKSPACE}`n";
		Start-Sleep 10;
	} Else {
		<# Use the code signing certificate to sign all unsigned { .dll, .exe, .msi, & .sys } files found under the directory specified by "${Env:WORKSPACE}" #>
		Get-Item "${WorkingDir}\**\*" `
		| Where-Object { ($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.sys") } `
		| Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } `
		| ForEach-Object { `
			Write-Output "Info - Signing working-dir file `"$($_.FullName)`"";
			Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${Cert_CodeSigning}) -IncludeChain All -TimestampServer ("http://tsa.starfieldtech.com") | Out-Null;
		};
	}

	If ($ArtifactsDir -NE $Null) {
		<# Use the code signing certificate to sign all unsigned { .dll, .exe, .msi, & .sys } files found under the directory specified by "${Env:WORKSPACE}" #>
		Get-Item "${ArtifactsDir}\**\*" `
		| Where-Object { ($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.sys") } `
		| Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } `
		| ForEach-Object { `
			Write-Output "Info - Signing exported artifact `"$($_.FullName)`"";
			Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${Cert_CodeSigning}) -IncludeChain All -TimestampServer ("http://tsa.starfieldtech.com") | Out-Null;
		};
	}

}


<# Teamcity Only - Run a Background job and delay it by 60s, then attempt to sign the artifacts being exported from the current compilation job #>
If (("%system.teamcity.build.workingDir%") -NE (("%")+(@("system","teamcity","build","workingDir") -join ".")+("%"))) {
	Write-Output "`nCreating background/sleeper process then continuing-on without waiting for its completion";
	Write-Output "Background job will awaken in 60s (at $(Get-Date -Date ((Get-Date).AddSeconds(60)) -UFormat ('%H : %M : %S')))";
	Write-Ouytput "Background job, once awake, will sign all artifacts exported to this build's artifacts directory ('%env.TEAMCITY_DATA_PATH%\system\artifacts\%teamcity.project.id%\%system.teamcity.buildConfName%\%teamcity.build.id%\**\*')";
	Start-Process -NoNewWindow -Filepath ("C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe") -ArgumentList (@("-Command","`"Start-Sleep -Seconds 60; Get-Item '%env.TEAMCITY_DATA_PATH%\system\artifacts\%teamcity.project.id%\%system.teamcity.buildConfName%\%teamcity.build.id%\**\*' | Where-Object { (`$_.FullName -Like '*.dll') -Or (`$_.FullName -Like '*.exe') -Or (`$_.FullName -Like '*.msi') -Or (`$_.FullName -Like '*.sys') } | Where-Object { ((Get-AuthenticodeSignature -FilePath (`$_.FullName)).Status -NE 'Valid') } | ForEach-Object { Set-AuthenticodeSignature -FilePath (`$_.FullName) -Certificate (`${Cert_CodeSigning}) -IncludeChain All -TimestampServer ('http://tsa.starfieldtech.com') | Out-Null; }`""));
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Set-AuthenticodeSignature"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-authenticodesignature?view=powershell-5.1
#
#   docs.microsoft.com  |  "Test-Path - Determines whether all elements of a path exist"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-5.1
#
# ------------------------------------------------------------