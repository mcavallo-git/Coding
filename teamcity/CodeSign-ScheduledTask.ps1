$Cert_CodeSigning = (Get-ChildItem "Cert:\LocalMachine\My" -CodeSigningCert | Where-Object { ($_ -NE $Null) } | Where-Object { ($_.NotAfter) -GT (Get-Date) }); If ($Cert_CodeSigning -NE $Null) { $Cert_CodeSigning = (${Cert_CodeSigning}[0]); }; `
Get-ChildItem -Path ("${Env:TEAMCITY_DATA_PATH}\system\artifacts\") -Recurse -Force -File `
| Where-Object { (($_.FullName -Like "*.dll") -Or ($_.FullName -Like "*.exe") -Or ($_.FullName -Like "*.msi") -Or ($_.FullName -Like "*.sys")) } `
| Where-Object { (($_.LastWriteTime).AddMinutes(2) -lt (Get-Date)) } `
| Where-Object { ((Get-AuthenticodeSignature -FilePath ("$($_.FullName)")).Status -NE "Valid") } `
| Sort-Object -Property @{Expression={$_.LastWriteTime}; Ascending=$False} `
| Select-Object -First 20 `
| ForEach-Object { Write-Output "$(Get-Date -UFormat '%Y%m%d-%H%M%S') | Info:   Signing file `"$($_.FullName)`"..." | Out-File -FilePath ("${Env:TEAMCITY_DATA_PATH}\codesign_taskscheduler_$(Get-Date -UFormat '%Y%m%d').log") -Append; `
Set-AuthenticodeSignature -FilePath ("$($_.FullName)") -Certificate (${Cert_CodeSigning}) -IncludeChain All -TimestampServer ("http://timestamp.digicert.com") | Out-Null; `
};
