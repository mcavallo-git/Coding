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
		
		[Parameter(Mandatory=$True,
		ParameterSetName="WithPath")]
		[String]$Name,

		[Parameter(Mandatory=$True,
		ParameterSetName="WithName")]
		[String]$Path,

		[Switch]$Quiet
		
	)

	$ValidParam_Name = $False;
	If (($PSBoundParameters.ContainsKey('Name')) -And (([String]::IsNullOrEmpty("${Name}")) -Eq $False)) {

		Write-Host "Parameter [ -Name ] IS set w/ value [ ${Name} ]" -ForegroundColor "Green";
		$ValidParam_Name = $True;
	} Else {
		Write-Host "Parameter [ -Name ] is UNSET/EMPTY" -ForegroundColor "Yellow";
	}

	$ValidParam_Path = $False;
	If (($PSBoundParameters.ContainsKey('Path')) -And (([String]::IsNullOrEmpty("${Path}")) -Eq $False)) {
		$ValidParam_Path = $True;
		Write-Host "Parameter [ -Path ] IS set w/ value [ ${Path} ]" -ForegroundColor "Green";
	} Else {
		Write-Host "Parameter [ -Path ] is UNSET/EMPTY" -ForegroundColor "Yellow";
	}


	# If (!($PSBoundParameters.ContainsKey('Quiet'))) {
	# 	Write-Host (("Task - Checking for Local Process w/ Name: ") + ($Name));
	# }

	# $Returned_PID = $False;
	
	# $GetProcess = (Get-Process -Name "${Name}" -ErrorAction "SilentlyContinue");

	# If ((Get-Process -Name "Greenshot" -ErrorAction "SilentlyContinue") -Ne $Null) {
	# 	If (([String]::IsNullOrEmpty("${Path}")) -Eq $True) {
	# 		# Do not require matching on the program's path

	# 	}
	# 	Get-Process | Where-Object { $_.Name -eq "${Name}"; } | Where-Object { $_.Path -eq "${Path}"; } | Select-Object -ExpandProperty "Path"
	# 	Get-Process | Where-Object { $_.Name -eq "Greenshot"; } | Select-Object -ExpandProperty Path
	# 	Get-Process | Where-Object { $_.Path -eq "${Path}"; } | Select-Object -ExpandProperty Path
	# 	# Get-Process | Select-Object -ExpandProperty Path
	# 	$ProcessExists = $True
	# }

	# Return $ProcessExists;
}

Export-ModuleMember -Function "EnsureProcessIsRunning";
