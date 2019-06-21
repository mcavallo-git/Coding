#
#	PowerShell - TaskSnipe
#		Kill all processes whose name contains a given substring
#
function TaskSnipe {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$SnipeTarget,

		[Switch]$CurrentUserMustOwn,
		[Switch]$Quiet

	)
	
	$Filters = "";

	If ($PSBoundParameters.ContainsKey('CurrentUserMustOwn') -eq $false) {
		$Filters += " /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`"";
	}

	(TaskList).Count
	(TaskList ${Filters}).Count
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
