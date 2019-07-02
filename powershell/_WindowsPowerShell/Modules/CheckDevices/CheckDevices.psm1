function CheckDevices {
	Param(
	)

	$ExternalGpuNames = @();

	Get-WmiObject Win32_VideoController | ForEach-Object {
		If (($_.AdapterDACType -Ne $Null) -And ($_.AdapterDACType -Ne "Internal")) {
			$ExternalGpuNames += ($_.Name);
		}
	}

	Write-Host "`n";
	If ($ExternalGpuNames.Count -Gt 0) {
		Write-Host "Found External GPU(s):";
		$ExternalGpuNames;
	} Else {
		Write-Host "No External GPU(s) found";
	}
	Write-Host "`n`n";

	Return;

}
Export-ModuleMember -Function "CheckDevices";


# ---------------------------------------------------------------------------------------------------------------------- #
#
# Citation(s)
#
#		docs.microsoft.com  |  "Win32_VideoController class"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videocontroller
#