If ($True) {
$ProcessExclusions_All = ((Get-MpPreference).ExclusionProcess);
$ProcessExclusions_ToRemove = @();
$ProcessExclusions_All | ForEach-Object { If ((Test-Path -LiteralPath ("$_")) -NE $True) { Write-Output "INVALID:  $_"; $ProcessExclusions_ToRemove += $_; }; };
Write-Output "`n`n";
Write-Output "`$ProcessExclusions_All.Count: $($ProcessExclusions_All.Count) `n";
Write-Output "`$ProcessExclusions_Invalid.Count: $($ProcessExclusions_Invalid.Count) `n";
Write-Output "`n`n";
}
