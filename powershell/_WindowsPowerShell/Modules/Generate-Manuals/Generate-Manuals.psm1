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
		[String]$OutDirname = "${Env:USERPROFILE}\Documents\GitHub\Coding\man"
	)
	Process {
		# ------------------------------------------------------------
		If ($False) { # RUN THIS SCRIPT:

			$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/Generate-Manuals/Generate-Manuals.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Generate-Manuals' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Generate-Manuals\Generate-Manuals.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; 
			Generate-Manuals;

		}
		# ------------------------------------------------------------
		
		$Commands=@();
		$Commands+="ForEach";
		$Commands+="ForEach-Object";
		$Commands+="Get-Command";
		$Commands+="Get-Help";
		$Commands+="Get-Item";
		$Commands+="Get-ItemProperty";
		$Commands+="Get-WmiObject";
		$Commands+="Out-File";
		$Commands+="Test-Path";
		$Commands+="Write-Host";

		$ValidCommands=0;

		Write-Host "------------------------------------------------------------";
		If (Test-Path "${OutDirname}" -PathType "Container") {

			Write-Host "------------------------------------------------------------";

			$Commands | ForEach-Object {
				If (Get-Command "$_") {
					$ValidCommands++;
					$OutFile=("${OutDirname}\$((Get-Command "${_}").Name).ps-$(([String]((Get-Command "${_}").CommandType)).ToLower()).man");
					Get-Help "${_}" -Full | Out-File "${OutFile}";
				} Else {
					Write-Host "Error: Command [ ${_} ] not found" -ForegroundColor "Yellow" -BackgroundColor "Black";
				}
			}

			Write-Host "------------------------------";
			Write-Host "Info: Generated [ ${ValidCommands} ] total manuals";
			Write-Host "Info: Output Directory:  [ ${OutDirname} ]";

		} Else {
			Write-Host "Error: Output directory [ ${OutDirname} ] doesn't exist" -ForegroundColor "Yellow" -BackgroundColor "Black";
		}
		Write-Host "------------------------------------------------------------";
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