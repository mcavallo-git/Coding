 

## DO CODE SIGNING
If ($True) {
	$Cert_CodeSigning = (Get-ChildItem "Cert:\LocalMachine\My" -CodeSigningCert | Where-Object { ($_ -NE $Null) } | Where-Object { ($_.NotAfter) -GT (Get-Date) }); If ($Cert_CodeSigning -NE $Null) { $Cert_CodeSigning = (${Cert_CodeSigning}[0]); }; `
	([System.IO.Directory]::EnumerateFiles("${Env:TEAMCITY_DATA_PATH}\system\artifacts\","*.msi","AllDirectories")) `
	| Get-Item `
	| Where-Object { (($_.LastWriteTime).AddMinutes(2) -lt (Get-Date)) } `
	| Sort-Object -Property @{Expression={$_.LastWriteTime}; Ascending=$False} `
	| Select-Object -First 20 `
	| ForEach-Object {
		$CheckSig=(Get-AuthenticodeSignature -FilePath ("$($_.FullName)"));
		If (($CheckSig.Status -NE "Valid") -Or ($null -eq $CheckSig.TimeStamperCertificate)) {
			Write-Output "$(Get-Date -UFormat '%Y%m%d-%H%M%S') | Info:   Signing file `"$($_.FullName)`"..." | Out-File -FilePath ("${Env:TEAMCITY_DATA_PATH}\codesign_taskscheduler_$(Get-Date -UFormat '%Y%m%d').log") -Append; `
			Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${Cert_CodeSigning}) -IncludeChain All -TimestampServer ("http://timestamp.digicert.com") | Out-Null; `
		}
	};
}


## DEBUGGING - COUNT NUMBER OF ARTIFACTS TO-BE-SIGNED
If ($False) {
	$ToBeSigned=@(); ([System.IO.Directory]::EnumerateFiles("${Env:TEAMCITY_DATA_PATH}\system\artifacts\","*.msi","AllDirectories")) | Get-Item | Where-Object { (($_.LastWriteTime).AddMinutes(2) -lt (Get-Date)) } | Sort-Object -Property @{Expression={$_.LastWriteTime}; Ascending=$False} | ForEach-Object { $CheckSig=(Get-AuthenticodeSignature -FilePath ("$($_.FullName)")); If (($CheckSig.Status -NE "Valid") -Or ($null -eq $CheckSig.TimeStamperCertificate)) { $ToBeSigned += $_; Write-Output "`$ToBeSigned.Count :"; $ToBeSigned.Count; }; }; Write-Output "`n`nFinal Result:  `$ToBeSigned.Count :"; $ToBeSigned.Count; Write-Output "`n`n";
}

