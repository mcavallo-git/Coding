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

		[Parameter(Mandatory=$True)]
		[String]$Path,

		[String]$Args,

		[Switch]$AsAdmin,
		[Switch]$RunAsAdmin,

		[Switch]$Quiet

	)

	$Returned_PID = $Null;

	If ([String]::IsNullOrEmpty("${Path}") -Eq $True) {
		Write-Host "EnsureProcessIsRunning:  Error - Must specify a process path to be ensured is-running" -ForegroundColor "Yellow";
		Write-Host "  |--> Syntax:  EnsureProcessIsRunning -Path ..." -ForegroundColor "Yellow";

	} ElseIf ((Test-Path -Path (${Path})) -Eq $False) {
		Write-Host "EnsureProcessIsRunning:  Error - Path not found: `"${Path}`"" -ForegroundColor "Yellow";

	} Else {
	
		If ([String]::IsNullOrEmpty("${Name}") -Eq $True) {
			# Find processes matching given [ Name ]  OR  [ Path ]
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "EnsureProcessIsRunning:  Info - Checking for Local Process w/ Name `"${Name}`" OR Path `"${Path}`"";
			}
			$Returned_PID = (Get-Process | Where-Object { (($_.Path -Eq "${Path}") -Or ($_.Name -Eq "${Name}")); } | Select-Object -ExpandProperty "Id");

			If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
				Get-Process | Where-Object { (($_.Path -Eq "${Path}") -Or ($_.Name -Eq "${Name}")); } | Select-Object -ExpandProperty "Id";
			}

		} Else {
			# Find processes only matching given [ Path ]
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "EnsureProcessIsRunning:  Info - Checking for Local Process w/ Path `"${Path}`"";
			}
			$Returned_PID = (Get-Process | Where-Object { $_.Path -Eq "${Path}"; } | Select-Object -ExpandProperty "Id");

			If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
				Get-Process | Where-Object { $_.Path -Eq "${Path}"; } | Select-Object -ExpandProperty "Id";
			}
		}

		If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
			Write-Host "EnsureProcessIsRunning:  Debug - Returned_PID=[ ${Returned_PID} ]";
		}

		If (${Returned_PID} -Eq $Null) {

			If (($PSBoundParameters.ContainsKey('RunAsAdmin') -Eq $True) -Or ($PSBoundParameters.ContainsKey('AsAdmin') -Eq $True)) {
				If ([String]::IsNullOrEmpty("${Args}") -Eq $False) {
					# Start Process [ NON-ADMIN ] & [ WITH ARGS ]
					If (!($PSBoundParameters.ContainsKey('Quiet'))) {
						Write-Host "EnsureProcessIsRunning:  Info - Calling [ Start-Process -Filepath `"${Path}`" -ArgumentList (`"${Args}`"); ]";
					}
					Start-Process -Filepath ("${Path}") -ArgumentList ("${Args}");
				} Else {
					# Start Process [ NON-ADMIN ] & [ NO ARGS ]
					If (!($PSBoundParameters.ContainsKey('Quiet'))) {
						Write-Host "EnsureProcessIsRunning:  Info - Calling [ Start-Process -Filepath `"${Path}`"; ]";
					}
					Start-Process -Filepath ("${Path}");
				}
			} Else {
				If ([String]::IsNullOrEmpty("${Args}") -Eq $False) {
					# Start Process [ AS-ADMIN ] & [ WITH ARGS ]
					If (!($PSBoundParameters.ContainsKey('Quiet'))) {
						Write-Host "EnsureProcessIsRunning:  Info - Calling [ Start-Process -Filepath `"${Path}`" -ArgumentList (`"${Args}`") -Verb `"RunAs`"; ]";
					}
					Start-Process -Filepath ("${Path}") -ArgumentList ("${Args}") -Verb "RunAs";
				} Else {
					# Start Process [ AS-ADMIN ] & [ NO ARGS ]
					If (!($PSBoundParameters.ContainsKey('Quiet'))) {
						Write-Host "EnsureProcessIsRunning:  Info - Calling [ Start-Process -Filepath `"${Path}`" -Verb `"RunAs`"; ]";
					}
					Start-Process -Filepath ("${Path}") -Verb "RunAs";
				}
			}

			If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
				Write-Host "EnsureProcessIsRunning:  Debug - Returned_PID=[ ${Returned_PID} ]";
			}

			# Re-Check to ensure that process is now running (after just being started)
			If ([String]::IsNullOrEmpty("${Name}") -Eq $True) {
				# Find processes matching given [ Name ] and given [ Path ]
				$Returned_PID = (Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Where-Object { $_.Name -eq "${Name}"; } | Select-Object -ExpandProperty "Id");
			} Else {
				# Find processes only matching given [ Path ]
				$Returned_PID = (Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Select-Object -ExpandProperty "Id");
			}

			If ($Returned_PID -Eq $Null) {
				Write-Host "EnsureProcessIsRunning:  Error - Failed to start Process `"${Path}`"" -ForegroundColor "Red";
			}

		}

	}

	Return ${Returned_PID};

}

Export-ModuleMember -Function "EnsureProcessIsRunning";


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "About Functions Advanced Parameters"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-5.1&redirectedfrom=MSDN
#
# ------------------------------------------------------------