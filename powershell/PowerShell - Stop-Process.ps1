$NamePartialMatch = "chrome";

$LiveProcs = (Get-Process -Name $NamePartialMatch | Select * | Where { $_.Id -ne 0 });

$UniqueProcs = @();

ForEach ($EachProc In $LiveProcs) {

	If (($EachProc.Name).contains($NamePartialMatch)) {

		If (($EachProc.Id) -eq 0) {

			# Ignore processes which have Id=0

		} Else {

			$ProcessIsUnique = $true;

			ForEach ($UniqProc In $UniqueProcs) {

				If (($EachProc.Id) -eq ($UniqProc.Id)) {

					$ProcessIsUnique = $false;

					Break;
					
				}

			}

			If ($ProcessIsUnique -eq $true) {

				$UniqueProcs += $EachProc;

			}
		}
	}
}

If ($UniqueProcs.Count -gt 0) {

	$UniqueProcs | Format-Table -Autosize -Property Id, Name, Description;

	Write-Host "`n   !!  WARNING  !!  " -ForegroundColor Red -NoNewline;
	Write-Host "This action will end all processes listed above" -ForegroundColor Yellow;

	Write-Host "`n   --  CONFIRM  --  " -ForegroundColor Red -NoNewline;
	Write-Host "Are you sure? ( y / n ): " -ForegroundColor Yellow -NoNewline;

	$confirmation = Read-Host;

	If ($confirmation -eq 'y') {

		ForEach ($UniqProc In $UniqueProcs) {
			$EachUniqPID = ($UniqProc.Id);

			Write-Host "   Stopping PID $EachUniqPID" -ForegroundColor Yellow;

			Stop-Process -Id ($EachUniqPID);

		}

	} Else {

		Write-Host "`n   No Action Taken" -ForegroundColor Yellow;

	}

	Write-Host "`n`n";

}


# Batch Script:
# @ECHO OFF
# SETLOCAL ENABLEDELAYEDEXPANSION
# REM Step 1/3 - Kill Notification Area QuickNote(s)
# SET QUICKNOTE_NOTIFICATION_AREA_EXE="ONENOTEM.EXE"
# TASKLIST /FI "IMAGENAME eq %QUICKNOTE_NOTIFICATION_AREA_EXE%"
# IF "!ERRORLEVEL!"=="0" ( REM PROGRAM CURRENTLY RUNNING
# 	TASKKILL /IM %QUICKNOTE_NOTIFICATION_AREA_EXE% /F
# )
# REM Step 2/3 - Kill App-Data QuickNote(s)
# DEL "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Send to OneNote*"
# REM Step 3/3 - Kill Startup-Directory QuickNote(s)
# DEL "%USERPROFILE%\Documents\OneNote Notebooks\Quick Notes*.one"


# ------------------------------------------------------------
# Citation(s)
#
#		docs.microsoft.com, "Stop-Process"
#			https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-process
#
# ------------------------------------------------------------