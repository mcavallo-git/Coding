
$ExternalGpuNames = @();

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

# ---------------------------------------------------------------------------------------------------------------------- #
#
# Citation(s)
#
#		docs.microsoft.com  |  "Win32_VideoConfiguration class"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videoconfiguration
#
