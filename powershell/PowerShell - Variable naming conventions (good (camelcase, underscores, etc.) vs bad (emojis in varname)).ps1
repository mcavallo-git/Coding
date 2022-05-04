Set-Location "Temp:\";
Clear-Host;
Set-Variable -Name "ThumbsUp" -Value "Good";
Set-Variable -Name "👎" -Value "Bad";
Write-Host -BackgroundColor "Black" -ForegroundColor "Green" -Object "`nVarname: [ThumbsUp]`nValue:   [${ThumbsUp}]`n";
Write-Host -BackgroundColor "Black" -ForegroundColor "Red" -Object "`nVarname: [👎]`nValue:   [${👎}]`n";
Write-Host -BackgroundColor "Black" -ForegroundColor "Yellow" -Object "`n`nTakeaway:`n   There are many ways to name a variable`n   Not all are 'Good'`n`n";
