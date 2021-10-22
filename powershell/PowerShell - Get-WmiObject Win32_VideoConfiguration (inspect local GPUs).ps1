# ------------------------------------------------------------

$ExternalGpuNames = @();

Get-WmiObject Win32_VideoConfiguration | ForEach-Object {
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
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-WmiObject"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject
#
#   docs.microsoft.com  |  "Win32_VideoConfiguration class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videoconfiguration
#
# ------------------------------------------------------------