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


If ($True) {
  #
  # Benchmark 2 methods head-to-head  (ex 1)
  #
  $LoopIterations = 100000;
  $Benchmark = New-Object System.Diagnostics.Stopwatch;
  $DecimalTimestampShort = $Null;
  $Benchmark.Restart(); <# [Re-]Start the stopwatch #>
  For ($i = 0; $i -LT ${LoopIterations}; $i++) {
    # ------------------------------
    # v v v START METHOD #1 CODE BLOCK

    $ResolvedPath = (Resolve-Path -Path ("${env:USERPROFILE}") | Select-Object -ExpandProperty "Path");

    # ^ ^ ^ END METHOD #1 CODE BLOCK
    # ------------------------------
  }
  $BenchTicks_1 = (${Benchmark}.ElapsedTicks);
  Write-Host "";
  Write-Host "[ Method #1 ]  `$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
  Write-Host "[ Method #1 ]  `$Benchmark.ElapsedTicks = ${BenchTicks_1}";
  $Benchmark.Stop();
  $DecimalTimestampShort = $Null;
  $Benchmark.Restart(); <# [Re-]Start the stopwatch #>
  For ($i = 0; $i -LT ${LoopIterations}; $i++) {
    # ------------------------------
    # v v v START METHOD #2 CODE BLOCK

    $GetItemPath = (Get-Item -Path ("${env:USERPROFILE}") | Select-Object -ExpandProperty "FullName");

    # ^ ^ ^ END METHOD #2 CODE BLOCK
    # ------------------------------
  }
  $BenchTicks_2 = (${Benchmark}.ElapsedTicks);
  Write-Host "";
  Write-Host "[ Method #2 ]  `$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
  Write-Host "[ Method #2 ]  `$Benchmark.ElapsedTicks = ${BenchTicks_2}";
  $Benchmark.Stop();
  # Show comparable results
  Write-Host "";
  Write-Host "`$BenchTicks_1 / `$BenchTicks_2 = $(${BenchTicks_1}/${BenchTicks_2})";
  Write-Host "`$BenchTicks_2 / `$BenchTicks_1 = $(${BenchTicks_2}/${BenchTicks_1})";
  Write-Host "";
}


# ------------------------------------------------------------


If ($True) {
  #
  # Benchmark 2 methods head-to-head  (ex 2)
  #
  $LoopIterations = 10000;
  $Benchmark = New-Object System.Diagnostics.Stopwatch;
  $DecimalTimestampShort = $Null;
  $Benchmark.Restart(); <# [Re-]Start the stopwatch #>
  For ($i = 0; $i -LT ${LoopIterations}; $i++) {
    # ------------------------------
    # v v v START METHOD #1 CODE BLOCK

    $DecimalTimestampShort = $(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz')

    # ^ ^ ^ END METHOD #1 CODE BLOCK
    # ------------------------------
  }
  $BenchTicks_1 = (${Benchmark}.ElapsedTicks);
  Write-Host "";
  Write-Host "[ Method #1 ]  `$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
  Write-Host "[ Method #1 ]  `$Benchmark.ElapsedTicks = ${BenchTicks_1}";
  $Benchmark.Stop();
  $DecimalTimestampShort = $Null;
  $Benchmark.Restart(); <# [Re-]Start the stopwatch #>
  For ($i = 0; $i -LT ${LoopIterations}; $i++) {
    # ------------------------------
    # v v v START METHOD #2 CODE BLOCK

    $EpochDate = ([Decimal](Get-Date -UFormat ("%s")));
    $EpochToDateTime = (New-Object -Type DateTime -ArgumentList 1970,1,1,0,0,0,0).AddSeconds([Math]::Floor($EpochDate));
    $DecimalTimestampShort = ( ([String](Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y%m%d-%H%M%S"))) + (([String]((${EpochDate}%1))).Substring(1).PadRight(6,"0")) );

    # ^ ^ ^ END METHOD #2 CODE BLOCK
    # ------------------------------
  }
  $BenchTicks_2 = (${Benchmark}.ElapsedTicks);
  Write-Host "";
  Write-Host "[ Method #2 ]  `$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
  Write-Host "[ Method #2 ]  `$Benchmark.ElapsedTicks = ${BenchTicks_2}";
  $Benchmark.Stop();
  # Show comparable results
  Write-Host "";
  Write-Host "`$BenchTicks_1 / `$BenchTicks_2 = $(${BenchTicks_1}/${BenchTicks_2})";
  Write-Host "`$BenchTicks_2 / `$BenchTicks_1 = $(${BenchTicks_2}/${BenchTicks_1})";
  Write-Host "";
}


# ------------------------------------------------------------


If ($True) {
$LoopIterations = 100000;
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