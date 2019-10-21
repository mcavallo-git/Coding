#
# PowerShell - EnsureProcessIsRunning
#   |
#   |--> Given a Process-Name, this module ensures that said process is running, and starts it if it isn't
#   |
#   |--> Returns:
#         |
#         |--> PID(s) of Running Process(es) which match input name/path
#         |
#         |--> $Null  (If Process is NOT running and could not be started)
#
function EnsureProcessIsRunning {
	Param(

		[String]$Name,

		[String]$Path,

		[Switch]$Quiet

	)

	$Returned_PID = $Null;

	If (($PSBoundParameters.ContainsKey('Name') -Eq $False) -And ($PSBoundParameters.ContainsKey('Path') -Eq $False)) {
		Write-Host "EnsureProcessIsRunning:  Error - Must specify a Process-Name (using EnsureProcessIsRunning -Name ...) or Process-Path (using EnsureProcessIsRunning -Path ...)" -ForegroundColor "Yellow";

	} Else {
		
		$ValidQuery_Name = $False;
		If (($PSBoundParameters.ContainsKey('Name') -Eq $True) -And (([String]::IsNullOrEmpty("${Name}")) -Eq $False)) {
			$ValidQuery_Name = $True;
		}

		$ValidQuery_Path = $False;
		If (($PSBoundParameters.ContainsKey('Path') -Eq $True) -And (([String]::IsNullOrEmpty("${Path}")) -Eq $False)) {
			$ValidQuery_Path = $True;
		}

		If ((${ValidQuery_Name} -Eq $False) -And (${ValidQuery_Path} -Eq $False)) {
			Write-Host "EnsureProcessIsRunning:  Error - Must specify a process to ensure is-running using either [ EnsureProcessIsRunning -Name ... ] or [ EnsureProcessIsRunning -Path ... ]" -ForegroundColor "Yellow";

		} ElseIf ((${ValidQuery_Name} -Eq $True) -And (${ValidQuery_Path} -Eq $False)) {
			# Find processes matching given [ Name ]
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "EnsureProcessIsRunning:  Info - Checking for Local Process w/ Name `"${Name}`"";
			}
			$Returned_PID = (Get-Process | Where-Object { $_.Name -eq "${Name}"; } | Select-Object -ExpandProperty "Id");
		

		} ElseIf ((${ValidQuery_Name} -Eq $False) -And (${ValidQuery_Path} -Eq $True)) {
			# Find processes matching given [ Path ]
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "EnsureProcessIsRunning:  Info - Checking for Local Process w/ Path `"${Path}`"";
			}
			$Returned_PID = (Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Select-Object -ExpandProperty "Id");
		
		} ElseIf ((${ValidQuery_Name} -Eq $True) -And (${ValidQuery_Path} -Eq $True)) {
			# Find processes matching given [ Name ] and given [ Path ]
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "EnsureProcessIsRunning:  Info - Checking for Local Process w/ Path `"${Path}`"";
			}
			$Returned_PID = (Get-Process | Where-Object { $_.Name -eq "${Name}"; } | Where-Object { $_.Path -eq "${Path}"; } | Select-Object -ExpandProperty "Id");
		
		}

	}

	Return $Returned_PID;
}

Export-ModuleMember -Function "EnsureProcessIsRunning";


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "About Functions Advanced Parameters"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-5.1&redirectedfrom=MSDN
#
# ------------------------------------------------------------