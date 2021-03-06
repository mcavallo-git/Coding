
$ExternalGpuNames = @();

Get-WmiObject Win32_VideoConfiguration

Get-WmiObject Win32_VideoController | ForEach-Object {
	If (($_.AdapterDACType -Ne $Null) -And ($_.AdapterDACType -Ne "Internal")) {
		$ExternalGpuNames += ($_.Name);
	}
}

If ($ExternalGpuNames.Count -Gt 0) {
	$ExternalGpuNames;
} Else {
	Write-Host "No External GPU(s) found";
}

# ------------------------------------------------------------

Get-WmiObject Win32_PnPSignedDriver| select devicename, driverversion | where {$_.devicename -like "*nvidia*"}



# ------------------------------------------------------------
#
# Citation(s)
#
#		docs.microsoft.com  |  "Win32_VideoController class"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videocontroller
#
#		docs.microsoft.com  |  "Win32_VideoConfiguration class"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videoconfiguration
#
#		itprotoday.com  |  "Check Installed Driver Versions Using PowerShell"  |  https://www.itprotoday.com/powershell/check-installed-driver-versions-using-powershell
#
# ------------------------------------------------------------
