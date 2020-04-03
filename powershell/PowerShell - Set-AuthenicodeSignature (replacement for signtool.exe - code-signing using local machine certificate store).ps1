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


Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Set-AuthenicodeSignature%20(perform%20code-signing%20with%20local%20machine%20attached%20certificates).ps1'));


}
# ------------------------------------------------------------
$ExitCode = 1;

<# Determine Working Directory #>
$WorkingDir = $Null;
If (("%system.teamcity.build.workingDir%") -NE (("%")+(@("system","teamcity","build","workingDir") -join ".")+("%"))) {
	<# TeamCity build-environment #>
	$WorkingDir = "%system.teamcity.build.workingDir%";
} ElseIf (Test-Path -Path ("Env:WORKSPACE") -PathType ("Leaf")) {
	<# Jenkins build-environment #>
	$WorkingDir = "${Env:WORKSPACE}";
}
If ($WorkingDir -Eq $Null) {
	Write-Output "`nError - Unable to detetermine working directory. Exiting...`n";

} Else {

	<# Get the first non-expired code signing certificate found in the windows certificate store which has been imported onto the current Local Machine #>
	$Cert_CodeSigning = ((Get-ChildItem "Cert:\LocalMachine\My" -CodeSigningCert | Where-Object { ($_.NotAfter) -GT (Get-Date) })[0]);
	
	If ($Cert_CodeSigning -Eq $Null) {
		Write-Output "`nError - No code signing certificate(s) found in the Local Machine certificate store. Please retry after installing a code-signing (.pfx) certificate onto the Local Machine certificate store`n";

	} Else {

		Write-Output "`nInfo - Using code signing certificate (pulled from Local Machine certificate store) with specs:`n";
		$Cert_CodeSigning | Format-List;

		<# Use the code signing certificate to sign all unsigned { .dll, .exe, .msi, & .pdb } files found under the directory specified by "${Env:WORKSPACE}" #>
		Get-Item "${WorkingDir}\**\*" `
		| Where-Object { ($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.pdb") } `
		| Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } `
		| ForEach-Object { `
			Write-Output "Into - Signing file `"$_.FullName`"";
			Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${Cert_CodeSigning}) -IncludeChain All -TimestampServer ("http://tsa.starfieldtech.com") | Out-Null;
		};

		$ExitCode = 0;

	}
}

Exit $ExitCode;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Set-AuthenticodeSignature"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-authenticodesignature?view=powershell-5.1
#
#   docs.microsoft.com  |  "Test-Path - Determines whether all elements of a path exist"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-5.1
#
# ------------------------------------------------------------