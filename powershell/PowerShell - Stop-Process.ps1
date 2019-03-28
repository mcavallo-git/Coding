

# $NamePartialMatch = "ApplicationFrameHost";
# $NamePartialMatch = "Chrome";
$NamePartialMatch = "chrome";

$ProcessMatches = Get-WmiObject Win32_Process -Filter (("Name like '%")+($NamePartialMatch)+("%'"));

# $ParentProcesses = @();

$ParentProcesses = @{};

ForEach ($EachItem In $ProcessMatches) {

	$EachProcess = $EachItem;

	If (($EachProcess.Name).contains($NamePartialMatch) -eq $true) {

		If ($EachProcess.ProcessId -ne 0) {

			# While (($EachProcess.ParentProcessId -ne 0) -And ($EachProcess.Description -inotmatch "System Idle Process")) {
			While ($EachProcess.Path -eq $null) {
				
				If ($EachProcess.ParentProcessId -eq 0) {

					Break;
					
				} Else {
					
					$EachProcess = Get-WmiObject Win32_Process -Filter (("ProcessId = '")+($ProcessId.ParentProcessId)+("'"));

				}

			}


			If ($EachProcess.ProcessId -ne 0) {

				$ProcessIsUnique = $true;

				ForEach ($EachUniqueProcess In ($ParentProcesses.GetEnumerator())) {

					If (($EachProcess.Value).ProcessId -eq ($EachUniqueProcess.Value).ProcessId) {

						$ProcessIsUnique = $false;

					}
					
				}

				if ($ProcessIsUnique -eq $true) {
					
					# $EachProcess

					$ParentProcesses[([String]$EachProcess.ProcessId)] = $EachProcess;

				}
				
				$EachProcess;
				
				# $EachProcess.Vaue.CommandLine;

			}

		}

	}
}

ForEach ($EachProcess In $ParentProcesses.GetEnumerator()) {
	# $CommandExists = EnsureCommandExists -Name ($RequiredCommand.Name) -OnErrorShowUrl ($RequiredCommand.Value);

	# Write-Host "`nShowing Matched Process: ";
	$EachProc = @{};

	$EachProc.NDX = $EachProcess.Name;

	$EachProc.PID = $EachProcess.Value.ProcessId;

	$EachProc.CommandLine = $EachProcess.Vaue.CommandLine;

	$EachProc.Name = $EachProcess.Value.Name;

	$EachProc.Path = $EachProcess.Value.Path;

	$EachProc.Fullpath = $EachProcess.Vaue.ExecutablePath;

	# $EachProc | Format-Table;
	$EachProcess.Vaue.CommandLine

}

Write-Host (("`n`n--- Matched ")+($ParentProcesses.Count)+(" Processes ---`n`n"));



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
