# ------------------------------------------------------------
#
#	PowerShell Module
#		|
#		|--> Name:
#		|      EnsureProcessIsRunning
#		|
#		|--> Description:
#		|      Given a Process Path (and optionally, Process Name), ensure that said process is running (start it if it isn't)
#		|
#		|--> Example Call(s):
#		       EnsureProcessIsRunning -Name 'kleopatra' -Path 'C:\Program Files (x86)\Gpg4win\bin\kleopatra.exe' -WindowStyle 'Hidden' -Quiet;
#		       EnsureProcessIsRunning -Name 'nginx' -Path 'C:\ISO\NGINX\nginx.exe' -WorkingDirectory 'C:\ISO\NGINX' -WindowStyle 'Hidden' -StopExisting -Quiet;
#
# ------------------------------------------------------------
function EnsureProcessIsRunning {
	Param(

		[String]$Name,

		[Parameter(Mandatory=$True)]
		[String]$Path,

		[String]$Args,

		[ValidateSet('Normal','Hidden','Minimized','Maximized')]
		[String]$WindowStyle="Normal",

		[String]$WorkingDirectory="",

		[Switch]$AsAdmin,
		[Switch]$Minimized,
		[Switch]$StopExisting,

		[Switch]$Quiet

	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'EnsureProcessIsRunning' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\EnsureProcessIsRunning\EnsureProcessIsRunning.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;

	}
	# ------------------------------------------------------------

	$Returned_PIDs = $Null;

	If ([String]::IsNullOrEmpty("${Path}") -Eq $True) {
		Write-Host "EnsureProcessIsRunning:  Error: Must specify a process path to be ensured is-running" -ForegroundColor "Yellow";
		Write-Host "  |--> Syntax:  EnsureProcessIsRunning -Path ..." -ForegroundColor "Yellow";

	} ElseIf ((Test-Path -Path (${Path})) -Eq $False) {
		Write-Host "EnsureProcessIsRunning:  Error: Path not found: `"${Path}`"" -ForegroundColor "Yellow";

	} Else {

		$GetProcess = $Null;

		If ([String]::IsNullOrEmpty("${Name}") -Eq $False) {
			# Find processes matching given [ Name ]  OR  [ Path ]
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "EnsureProcessIsRunning:  Info:  Checking for Local Process w/ Name `"${Name}`" OR Path `"${Path}`"";
			}
			If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
				Write-Host "EnsureProcessIsRunning:  Debug: Calling [ Get-Process | Where-Object { ((`$_.Path -Eq `"${Path}`") -Or (`$_.Name -Eq "${Name}")); } | Select-Object -ExpandProperty `"Id`" ]";
				(Get-Process | Where-Object { (($_.Path -Eq "${Path}") -Or ($_.Name -Eq "${Name}")); } | Select-Object -ExpandProperty "Id");
			}
			$GetProcess = (Get-Process | Where-Object { (($_.Path -Eq "${Path}") -Or ($_.Name -Eq "${Name}")); });
		} Else {
			# Find processes only matching given [ Path ]
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "EnsureProcessIsRunning:  Info:  Checking for Local Process w/ Path `"${Path}`"";
			}
			If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
				Write-Host "EnsureProcessIsRunning:  Debug: Calling [ Get-Process | Where-Object { (`$_.Path -Eq `"${Path}`"); } | Select-Object -ExpandProperty `"Id`" ]";
				(Get-Process | Where-Object { $_.Path -Eq "${Path}"; } | Select-Object -ExpandProperty "Id");
			}
			$GetProcess = (Get-Process | Where-Object { $_.Path -Eq "${Path}"; });
		}

		# If Process is already running
		If (${GetProcess} -NE $Null) {
			$Returned_PIDs = (${GetProcess} | Select-Object -ExpandProperty "Id");
			Get-Process | Where-Object { (($_.Name -Eq "chrome") -Or ($_.Path -Eq "${env:ProgramFiles}\Google\Chrome\Application\chrome.exe")); } | Stop-Process -Force;
			If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
				Write-Host "EnsureProcessIsRunning:  Debug: Returned_PIDs=[ ${Returned_PIDs} ]";
			}
			If ($PSBoundParameters.ContainsKey('StopExisting') -Eq $True) {
				# Stop existing process(es)
				Write-Host "EnsureProcessIsRunning:  Debug: Calling [ Stop-Process -Id (${Returned_PIDs}) -Force -ErrorAction SilentlyContinue; ]..";
				Stop-Process -Id (${Returned_PIDs}) -Force -ErrorAction SilentlyContinue;
				${GetProcess}=$Null;
			}
		}

		If ($null -eq ${GetProcess}) {

			# Need to start the process (as it was not found to already be running)

			# Build a hash table of parameters to splat into the "Start-Process" module
			$StartProcess_SplatParams = @{};
			$StartProcess_SplatParams.("Filepath")=("${Path}");
			$StartProcess_SplatParams.("WindowStyle")=("${WindowStyle}");
			If (($PSBoundParameters.ContainsKey('RunAsAdmin') -Eq $True) -Or ($PSBoundParameters.ContainsKey('AsAdmin') -Eq $True)) {
				$StartProcess_SplatParams.("Verb")=("RunAs");  # Run using:  [ RUN AS ADMIN ]
			}
			If ([String]::IsNullOrEmpty("${Args}") -Eq $False) {
				$StartProcess_SplatParams.("ArgumentList")=("${Args}"); # Run using:  [ COMMAND-SPECIFIC INLINE ARGUMENTS ]
			}
			If ([String]::IsNullOrEmpty("${WorkingDirectory}") -Eq $False) {
				$StartProcess_SplatParams.("WorkingDirectory")=("${WorkingDirectory}"); # Run using:  [ WORKING DIRECTORY ]
			}

			# Start the Process
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				$StartProcess_SplatParams_AsString = (($StartProcess_SplatParams.Keys | ForEach-Object { Write-Output "-$(${_})"; Write-Output "`"$(${StartProcess_SplatParams}[${_}])`""; }) -replace "`n","``n" -join " ");
				Write-Host "EnsureProcessIsRunning:  Info:  Calling [ Start-Process ${StartProcess_SplatParams_AsString}; ]...";
			}
			$EXIT_CODE=0;
			Start-Process @StartProcess_SplatParams;  $EXIT_CODE=([int]${EXIT_CODE}+([int](!${?})));

			If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
				Write-Host "EnsureProcessIsRunning:  Debug: EXIT_CODE=[ ${EXIT_CODE} ]";
			}

			# Re-check to ensure that process is now running (after just being started)
			If ([String]::IsNullOrEmpty("${Name}") -Eq $True) {
				# Find processes matching given [ Name ] and given [ Path ]
				If (($PSBoundParameters.ContainsKey('Debug'))) {
					Write-Host "EnsureProcessIsRunning:  Debug: Calling [ (Get-Process | Where-Object { `$_.Path -eq `"${Path}`"; } | Where-Object { `$_.Name -eq `"${Name}`"; } | Select-Object -ExpandProperty `"Id`"); ]..";
					(Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Where-Object { $_.Name -eq "${Name}"; } | Select-Object -ExpandProperty "Id");
				}
				$Returned_PIDs = (Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Where-Object { $_.Name -eq "${Name}"; } | Select-Object -ExpandProperty "Id");
			} Else {
				# Find processes only matching given [ Path ]
				If (($PSBoundParameters.ContainsKey('Debug'))) {
					Write-Host "EnsureProcessIsRunning:  Debug: Calling [ (Get-Process | Where-Object { `$_.Path -eq `"${Path}`"; } | Select-Object -ExpandProperty `"Id`"); ]..";
					(Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Select-Object -ExpandProperty "Id");
				}
				$Returned_PIDs = (Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Select-Object -ExpandProperty "Id");
			}

			If ($null -eq $Returned_PIDs) {
				Write-Host "EnsureProcessIsRunning:  Error: Failed to start Process `"${Path}`"" -ForegroundColor "Red";
			} Else {
				If (!($PSBoundParameters.ContainsKey('Quiet'))) {
					Write-Host "EnsureProcessIsRunning:  Info:  Successfully started Process";
				}
				If ($PSBoundParameters.ContainsKey('Debug') -Eq $True) {
					Write-Host "EnsureProcessIsRunning:  Debug: Returned_PIDs=[ ${Returned_PIDs} ]";
				}
			}

		}

	}

	If (!($PSBoundParameters.ContainsKey('Quiet'))) {
		Return ${Returned_PIDs};
	}

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "EnsureProcessIsRunning";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "About Functions Advanced Parameters"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-5.1&redirectedfrom=MSDN
#
#   docs.microsoft.com  |  "about Splatting - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting
#
#   docs.microsoft.com  |  "Start-Process - Starts one or more processes on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-5.1
#
# ------------------------------------------------------------