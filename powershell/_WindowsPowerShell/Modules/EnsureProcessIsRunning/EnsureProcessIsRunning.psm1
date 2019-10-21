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

		[Alias("AsAdmin")]
		[Switch]$RunAsAdmin,

		[Switch]$Quiet

	)

	$Returned_PID = $Null;

	If (($PSBoundParameters.ContainsKey('Name') -Eq $False) -And ($PSBoundParameters.ContainsKey('Path') -Eq $False)) {
		Write-Host "EnsureProcessIsRunning:  Error - Must specify a Process-Name (using EnsureProcessIsRunning -Name ...) or Process-Path (using EnsureProcessIsRunning -Path ...)" -ForegroundColor "Yellow";

	} Else {

		If ([String]::IsNullOrEmpty("${Path}") -Eq $True) {
			Write-Host "EnsureProcessIsRunning:  Error - Must specify a process path to be ensured is-running" -ForegroundColor "Yellow";
			Write-Host "  |--> Syntax:    EnsureProcessIsRunning -Path ..." -ForegroundColor "Yellow";

		} Else {
		
			If ([String]::IsNullOrEmpty("${Name}") -Eq $True) {
				# Find processes matching given [ Name ] and given [ Path ]
				If (!($PSBoundParameters.ContainsKey('Quiet'))) {
					Write-Host "EnsureProcessIsRunning:  Info - Checking for Local Process w/ Path `"${Path}`"";
				}
				$Returned_PID = (Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Where-Object { $_.Name -eq "${Name}"; } | Select-Object -ExpandProperty "Id");
			} Else {
				# Find processes only matching given [ Path ]
				If (!($PSBoundParameters.ContainsKey('Quiet'))) {
					Write-Host "EnsureProcessIsRunning:  Info - Checking for Local Process w/ Path `"${Path}`"";
				}
				$Returned_PID = (Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Select-Object -ExpandProperty "Id");
			}

			If (${Returned_PID} -Eq $Null) {
				If (($PSBoundParameters.ContainsKey('RunAsAdmin') -Eq $True) -Or ($PSBoundParameters.ContainsKey('AsAdmin') -Eq $True)) {
					If ([String]::IsNullOrEmpty("${Args}") -Eq $True) {
						# Start Process [ NON-ADMIN ] & [ WITH ARGS ]
						If (!($PSBoundParameters.ContainsKey('Quiet'))) {
							Write-Host "EnsureProcessIsRunning:  Info - Calling [ Start-Process `"${Path}`" (`"${Args}`"); ]";
						}
						Start-Process "${Path}" ("${Args}");
					} Else {
						# Start Process [ NON-ADMIN ] & [ NO ARGS ]
						If (!($PSBoundParameters.ContainsKey('Quiet'))) {
							Write-Host "EnsureProcessIsRunning:  Info - Calling [ Start-Process `"${Path}`"; ]";
						}
						Start-Process "${Path}";
					}
				} Else {
					If ([String]::IsNullOrEmpty("${Args}") -Eq $True) {
						# Start Process [ AS-ADMIN ] & [ WITH ARGS ]
						If (!($PSBoundParameters.ContainsKey('Quiet'))) {
							Write-Host "EnsureProcessIsRunning:  Info - Calling [ Start-Process `"${Path}`" (`"${Args}`") -Verb `"RunAs`"; ]";
						}
						Start-Process "${Path}" ("${Args}") -Verb "RunAs";
					} Else {
						# Start Process [ AS-ADMIN ] & [ NO ARGS ]
						If (!($PSBoundParameters.ContainsKey('Quiet'))) {
							Write-Host "EnsureProcessIsRunning:  Info - Calling [ Start-Process `"${Path}`" -Verb `"RunAs`"; ]";
						}
						Start-Process "${Path}" -Verb "RunAs";
					}
				}
			}

			If ($Returned_PID -Eq $Null) {
				Write-Host "EnsureProcessIsRunning:  Failed to start Process" -ForegroundColor "Red";
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