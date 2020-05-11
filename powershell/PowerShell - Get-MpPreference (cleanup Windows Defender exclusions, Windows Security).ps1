If ($True) {
$ProcessExclusions_All = ((Get-MpPreference).ExclusionProcess);
$ProcessExclusions_Removed = @();
$ProcessExclusions_All | ForEach-Object { If ((Test-Path -LiteralPath ("$_")) -NE $True) { Write-Output "INVALID:  $_"; $ProcessExclusions_Removed += $_; }; };
Write-Output "`n`n";
Write-Output "`$ProcessExclusions_All.Count: $($ProcessExclusions_All.Count) `n";
Write-Output "`$ProcessExclusions_Removed.Count: $($ProcessExclusions_Removed.Count) `n";
Write-Output "`n`n";
}
