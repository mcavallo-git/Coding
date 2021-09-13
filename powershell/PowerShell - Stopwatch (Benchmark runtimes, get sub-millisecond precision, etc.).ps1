# ------------------------------------------------------------

If ($True) {
<# Start a benchmarking stopwatch > run command(s) to-be-benchmarked > stop the stopwatch > show the results #> 
$Benchmark = New-Object System.Diagnostics.Stopwatch;
$Benchmark.Restart(); <# [Re-]Start the stopwatch #>
Start-Sleep -Seconds (1); <# REPLACE THIS LINE WITH COMMAND OR PROCESS TO-BENCHMARK #>
$Benchmark.Stop();
Write-Output "`$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
}

# ------------------------------------------------------------

<# Example benchmark between two approaches of achieving a similar outcome to determine which method is faster #>

If ($True) {
$LoopIterations = 10000;
$Benchmark = New-Object System.Diagnostics.Stopwatch;
<# Test method 1 of getting timestamps w/ decimal-based seconds + timezone #>
$DecimalTimestampShort = $Null;
$Benchmark.Restart(); <# [Re-]Start the stopwatch #>
For ($i = 0; $i -LT ${LoopIterations}; $i++) {
$DecimalTimestampShort = $(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz')
}
$Benchmark.Stop();
Write-Output "`$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
<# Test method A of getting timestamps w/ decimal-based seconds + timezone #>
$DecimalTimestampShort = $Null;
$Benchmark.Restart(); <# [Re-]Start the stopwatch #>
For ($i = 0; $i -LT ${LoopIterations}; $i++) {
$EpochDate = ([Decimal](Get-Date -UFormat ("%s")));
$EpochToDateTime = (New-Object -Type DateTime -ArgumentList 1970,1,1,0,0,0,0).AddSeconds([Math]::Floor($EpochDate));
$DecimalTimestampShort = ( ([String](Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y%m%d-%H%M%S"))) + (([String]((${EpochDate}%1))).Substring(1).PadRight(6,"0")) );
}
$Benchmark.Stop();
Write-Output "`$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
}


# ------------------------------------------------------------

If ($True) {
$Benchmark.Restart(); <# [Re-]Start the stopwatch #>
Start-Sleep -Seconds (65);
$Benchmark.Stop();
# $Benchmark.Reset;
# $Benchmark.Start;
$Benchmark | Format-List; <# Show detailed benchmark results #>
# $Benchmark.IsRunning;            # Ex:  False
# $Benchmark.IsRunning;            # Ex:  False
# $Benchmark.Elapsed;              # Ex:  00:00:02.1047087
# $Benchmark.ElapsedMilliseconds;  # Ex:  2104
# $Benchmark.ElapsedTicks;         # Ex:  5343986
# $Benchmark.Elapsed.TotalSeconds; # Ex:  90.5865709
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Stopwatch Class (System.Diagnostics) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.stopwatch
#
#   stackoverflow.com  |  "timespan - Find time in milliseconds using PowerShell? - Stack Overflow"  |  https://stackoverflow.com/a/9066226
#
# ------------------------------------------------------------