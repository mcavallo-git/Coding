

If ($True) { <# Start the benchmark, run some code, stop the benchmark, show the results #> 
$Benchmark = New-Object System.Diagnostics.Stopwatch;
$Benchmark.Reset(); <# Reuse same benchmark/stopwatch object by resetting it #>
$Benchmark.Start();
Start-Sleep -Seconds (1); <# REPLACE THIS LINE WITH COMMAND OR PROCESS TO-BENCHMARK #>
$Benchmark.Stop();
$Benchmark.Elapsed;
}



If ($True) {
# Start the benchmark, run some code, stop the benchmark, show the results
$Benchmark.Reset(); <# Reuse same benchmark/stopwatch object by resetting it #>
$Benchmark.Start();
Start-Sleep -Seconds (65);
$Benchmark.Stop();
$Benchmark | Format-List; <# Show detailed benchmark results #>
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