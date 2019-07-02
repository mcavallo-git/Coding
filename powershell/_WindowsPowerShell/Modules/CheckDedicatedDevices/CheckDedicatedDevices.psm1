function CheckDedicatedDevices {
	Param(
	)

	$ExternalGpuNames = @();

	Get-WmiObject Win32_VideoController | ForEach-Object {
		If (($_.AdapterDACType -Ne $Null) -And ($_.AdapterDACType -Ne "Internal")) {
			$ExternalGpuNames += ($_.Name);
		}
	}

	If ($ExternalGpuNames.Count -Gt 0) {
		Write-Host "`n$($MyInvocation.MyCommand.Name) - Found $($ExternalGpuNames.Count) dedicated GPU(s):" -ForegroundColor "Gray";
		$ExternalGpuNames | ForEach-Object {
			Write-Host "  $($_)" -ForegroundColor Green;
		};
	} Else {
		Write-Host "`n$($MyInvocation.MyCommand.Name) - No dedicated GPU(s) found" -ForegroundColor Yellow;
		Get-WmiObject Win32_BaseBoard | Where-Object { $_.Manufacturer -Eq "LENOVO" -And $_.Product.Contains("20HR") } | ForEach-Object {
			TaskSnipe -Name "nv" -SkipConfirm;
			TaskSnipe -Name "razer" -SkipConfirm;
			TaskSnipe -Name "game" -SkipConfirm;
			Break;
		};
	}
	Write-Host "";
	Return;

}
Export-ModuleMember -Function "CheckDedicatedDevices";


# ---------------------------------------------------------------------------------------------------------------------- #
#
# Citation(s)
#
#		docs.microsoft.com  |  "Win32_VideoController class"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videocontroller
#