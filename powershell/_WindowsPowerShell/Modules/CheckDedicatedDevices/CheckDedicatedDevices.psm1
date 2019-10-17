function CheckDedicatedDevices {
	Param(

		[Parameter(Mandatory=$True)]
		[ValidateLength(2,255)]
		[String]$Type,

		[Switch]$Quiet

	)

	$RunHidden = $False;
	If ($PSBoundParameters.ContainsKey('Quiet')) {
		$RunHidden = $True;
	}

	If ($Type.ToUpper() -Eq "GPU") {
		$ExternalGpuNames = @();

		Get-WmiObject Win32_VideoController | ForEach-Object {
			If (($_.AdapterDACType -Ne $Null) -And ($_.AdapterDACType -Ne "Internal")) {
				$ExternalGpuNames += ($_.Name);
			}
		}

		If ($ExternalGpuNames.Count -Gt 0) {
			#  ✔  Found 1+ dedicated GPU(s)
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "`n$($MyInvocation.MyCommand.Name) - Found $($ExternalGpuNames.Count) dedicated GPU(s):" -ForegroundColor "Gray";
				$ExternalGpuNames | ForEach-Object {
					Write-Host "  $($_)" -ForegroundColor Green;
				};
			}
		} Else {
			#  ✕  No dedicated GPU found
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "`n$($MyInvocation.MyCommand.Name) - No dedicated GPU(s) found" -ForegroundColor Yellow;
			}
			Get-WmiObject Win32_BaseBoard | Where-Object { $_.Manufacturer -Eq "LENOVO" -And $_.Product.Contains("20HR") } | ForEach-Object {
				TaskSnipe -Name "nv" -SkipConfirm;
				TaskSnipe -Name "razer" -SkipConfirm;
				TaskSnipe -Name "game" -SkipConfirm;
				TaskSnipe -Name "MSIAfterburner.exe" -SkipConfirm;
				Break;
			};
		}
		If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host ""; }


	} Else {
		Write-Host "Unhandled device type:  [ $Type ]";
		Write-Host " |";


	}

	Return;

}
Export-ModuleMember -Function "CheckDedicatedDevices";


# ---------------------------------------------------------------------------------------------------------------------- #
#
# Citation(s)
#
#		docs.microsoft.com  |  "Win32_VideoController class"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videocontroller
#