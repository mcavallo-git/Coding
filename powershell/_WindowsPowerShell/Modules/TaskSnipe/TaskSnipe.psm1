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
	
	$ProcessSnipeList = @();

	$TASKLIST_FILTERS = "";

	If ($PSBoundParameters.ContainsKey('CurrentUserMustOwn')) {
		$TASKLIST_FILTERS += " /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`"";
	}

	# TaskList | Select-Object -Unique | Sort-Object
	(CMD /C "TASKLIST${TASKLIST_FILTERS}") | Select-Object -Unique | ForEach-Object {
		$_;
		
		# TaskKill /FI "USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}" /FI "IMAGENAME eq %IMAGENAME_TO_KILL%"

	}






	Return;
}
Export-ModuleMember -Function "TaskSnipe";
