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


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/CodeSign/Code-Signing.ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}

<# Update the Powershell console's max characters-per-line by increasing the output buffer size #>
If (($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) {
  $rawUI = $Host.UI.RawUI;
  $oldSize = $rawUI.BufferSize;
  $typeName = $oldSize.GetType( ).FullName;
  $newSize = New-Object $typeName (16384, $oldSize.Height);
  $rawUI.BufferSize = $newSize;
}

<# Show environment variables #>
Get-ChildItem Env:;

<# Determine working directory #>
$WorkingDir = $Null;
If (Test-Path -Path ("Env:WORKSPACE") -PathType ("Leaf")) {
	$WorkingDir = "${Env:WORKSPACE}";
}

<# Determine artifacts' export-directory (if any) #>
$ArtifactsDir = $Null;
If (Test-Path -Path ("Env:ArtifactsExportDir") -PathType ("Leaf")) {
	$ArtifactsDir = "${Env:ArtifactsExportDir}";
}

<# Get the first non-expired code signing certificate found in the windows certificate store which has been imported onto the current Local Machine #>
$Cert_CodeSigning = (Get-ChildItem "Cert:\LocalMachine\My" -CodeSigningCert | Where-Object { ($_ -NE $Null) } | Where-Object { ($_.NotAfter) -GT (Get-Date) }); If ($Cert_CodeSigning -NE $Null) { $Cert_CodeSigning = (${Cert_CodeSigning}[0]); };

If ($Cert_CodeSigning -Eq $Null) {
	Write-Output "`nError:  No code signing certificate(s) found in the Local Machine certificate store.`n`nInfo:  Please retry after installing a code-signing (.pfx) certificate onto the Local Machine certificate store`n";
	Start-Sleep 10;

} Else {
	Write-Output "`nInfo - Using code signing certificate from the Local Machine certificate store:`n";
	$Cert_CodeSigning | Format-List;

	<# Sign files within the working directory #>
	If ($WorkingDir -Eq $Null) {
		Write-Output "`nError - Unable to detetermine working directory. You may manually define the working directory by setting it as the value of environment variable `${Env:WORKSPACE}`n";
		Start-Sleep 10;
	} Else {
		<# Use the code signing certificate to sign all unsigned { .dll, .exe, .msi, & .sys } files found under the directory specified by "${Env:WORKSPACE}" #>
		Get-ChildItem -Path ("${WorkingDir}") -Recurse -Force -File `
		| Where-Object { ($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.sys") } `
		| Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } `
		| ForEach-Object { `
			Write-Output "Info - Signing working-dir file `"$($_.FullName)`"";
			Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${Cert_CodeSigning}) -IncludeChain All -TimestampServer ("http://tsa.starfieldtech.com") | Out-Null;
		};
	}

	<# Sign files within the artifacts directory #>
	If ($ArtifactsDir -NE $Null) {
		Get-ChildItem -Path ("${ArtifactsDir}") -Recurse -Force -File `
		| Where-Object { ($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.sys") } `
		| Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } `
		| ForEach-Object { `
			Write-Output "Info - Signing exported artifact `"$($_.FullName)`"";
			Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${Cert_CodeSigning}) -IncludeChain All -TimestampServer ("http://tsa.starfieldtech.com") | Out-Null;
		};
	}

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