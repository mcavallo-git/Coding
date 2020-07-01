
If ($True) {

	$Benchmark = New-Object System.Diagnostics.Stopwatch;

	# Start the benchmark, run some code, stop the benchmark, show the results
	$Benchmark.Start();
	Start-Sleep -Seconds (1);
	$Benchmark.Stop();
	$Benchmark | Format-List;

	# Reuse the same benchmark multiple times by resetting it (ideally to save on memory)
	$Benchmark.Reset();

	# Start the benchmark, run some code, stop the benchmark, show the results
	$Benchmark.Start();
	Start-Sleep -Seconds (65);
	$Benchmark.Stop();
	$Benchmark | Format-List;


	$Benchmark.IsRunning;            # Ex:  False
	$Benchmark.Elapsed;              # Ex:  00:00:02.1047087
	$Benchmark.ElapsedMilliseconds;  # Ex:  2104
	$Benchmark.ElapsedTicks;         # Ex:  5343986
	$Benchmark.Elapsed.TotalSeconds; # Ex:  90.5865709

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