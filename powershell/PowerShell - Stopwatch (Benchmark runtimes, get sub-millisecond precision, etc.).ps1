# ------------------------------------------------------------
#
# Single Benchmark
#

If ($True) {
  $Benchmark = New-Object System.Diagnostics.Stopwatch;
  $Benchmark.Restart(); <# [Re-]Start the stopwatch #>
  # -------------------------------- #
  # v v v   START CODE BLOCK   v v v #

  Start-Sleep -Seconds (1);

  # ^ ^ ^    END CODE BLOCK    ^ ^ ^ #
  # -------------------------------- #
  $Benchmark.Stop();
  Write-Output "`$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
}


# ------------------------------------------------------------
#
# Double Benchmark (Comparisons)
#
If ($True) {
  $LoopIterations = 1000;
  $Benchmark = New-Object System.Diagnostics.Stopwatch;
  $DecimalTimestampShort = $Null;
  $Benchmark.Restart(); <# [Re-]Start the stopwatch #>
  For ($i = 0; $i -LT ${LoopIterations}; $i++) {
    # ----------------------------------- #
    # v v v   START CODE BLOCK #1   v v v #

    $ResolvedPath = (Resolve-Path -Path ("${env:USERPROFILE}") | Select-Object -ExpandProperty "Path");

    # ^ ^ ^    END CODE BLOCK #1    ^ ^ ^ #
    # ----------------------------------- #
  }
  $BenchTicks_1 = (${Benchmark}.ElapsedTicks);
  Write-Host "";
  Write-Host "[ Method #1 ]  `$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
  $Benchmark.Stop();
  $DecimalTimestampShort = $Null;
  $Benchmark.Restart(); <# [Re-]Start the stopwatch #>
  For ($i = 0; $i -LT ${LoopIterations}; $i++) {
    # ----------------------------------- #
    # v v v   START CODE BLOCK #2   v v v #


    $GetItemPath = (Get-Item -Path ("${env:USERPROFILE}") | Select-Object -ExpandProperty "FullName");


    # ^ ^ ^    END CODE BLOCK #2    ^ ^ ^ #
    # ----------------------------------- #
  }
  $BenchTicks_2 = (${Benchmark}.ElapsedTicks);
  Write-Host "";
  Write-Host "[ Method #2 ]  `$Benchmark.Elapsed = $(${Benchmark}.Elapsed)";
  $Benchmark.Stop();
  # Show comparable results
  Write-Host "";
  Write-Host "[Results]  Method #1 runs at [ $(([String]([Math]::Round(((${BenchTicks_1}/${BenchTicks_2})*100),2))).PadLeft(6,' ')) % ] the speed of Method #2";
  Write-Host "";
  Write-Host "[Results]  Method #2 runs at [ $(([String]([Math]::Round(((${BenchTicks_2}/${BenchTicks_1})*100),2))).PadLeft(6,' ')) % ] the speed of Method #1";
  Write-Host "";
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