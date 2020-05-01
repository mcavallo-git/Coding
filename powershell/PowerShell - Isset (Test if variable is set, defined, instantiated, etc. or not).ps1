
If (Test-Path -Path ("Env:WORKSPACE") -PathType ("Leaf")) { 
	<# Variable IS set (but may be empty) #>
	Write-Host "Environment Variable `"`${Env:WORKSPACE}`" is set with value `"${Env:WORKSPACE}`"" -ForegroundColor ("Green") -BackgroundColor ("Black");

} Else {
	<# Variable is NOT set #>
	Write-Host "Environment Variable `"`${Env:WORKSPACE}`" is set with value `"${Env:WORKSPACE}`"" -ForegroundColor ("Red") -BackgroundColor ("Black");

}

