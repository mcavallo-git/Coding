# ------------------------------------------------------------
#
#	PowerShell - Generate-Manuals
#		|
#		|--> Description:  Generates "Get-Help -Full ..." manuals for existing local commands
#		|
#		|--> Example(s):  Generate-Manuals
#
# ------------------------------------------------------------

function Generate-Manuals {
	Param(
	)
	Process {
		# ------------------------------------------------------------
		$Commands=@();
		$Commands+="ForEach";
		$Commands+="ForEach-Object";
		$Commands+="Get-Command";
		$Commands+="Get-Help";
		$Commands+="Get-ItemProperty";
		$Commands+="Get-WmiObject";
		$Commands+="Out-File";
		$Commands | ForEach-Object {
			If (Get-Command "$_") {
				$OutFile=("${Env:USERPROFILE}\Documents\GitHub\Coding\man\$((Get-Command "${_}").Name).ps-$(((Get-Command "${_}").CommandType).ToLower()).man");
				Get-Help "${_}" -Full | Out-File "${OutFile}";
			} Else {
				Write-Host "";
			}
		}

		# ------------------------------------------------------------

		Return;
	}
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Generate-Manuals" -ErrorAction "SilentlyContinue";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   ridicurious.com  |  "Deep Dive: PowerShell Loops and Iterations | RidiCurious.com  |  https://ridicurious.com/2019/10/10/powershell-loops-and-iterations/
#
# ------------------------------------------------------------