#
#	PowerShell - TaskSnipe
#		Kill all processes whose name contains a given substring
#
function TaskSnipe {
	Param(

		[Parameter(Mandatory=$true)]
		[ValidateLength(4,255)]
		[String]$SnipeTarget,

		[Switch]$CurrentUserMustOwn,
		[Switch]$Quiet

	)
	
	$Filters = "";

	If ($PSBoundParameters.ContainsKey('CurrentUserMustOwn') -eq $false) {
		$Filters += " /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`"";
	}

	(Cmd /C "TaskList").Count
	(Cmd /C "TaskList ${Filters}").Count
	Return;
		# [Switch]$CurrentUserMustOwn,
	# TaskList | Select-Object -Unique | Sort-Object
	TaskList /FI "USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}" | Select-Object -Unique | ForEach-Object {
		$_;
		# TaskKill /FI "USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}" /FI "IMAGENAME eq %IMAGENAME_TO_KILL%"

	}






	Return;
}
Export-ModuleMember -Function "TaskSnipe";
