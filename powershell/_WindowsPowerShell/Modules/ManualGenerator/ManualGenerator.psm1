#
# PowerShell - ManualGenerator
#   Generates Runtime Manuals
#
function ManualGenerator {
	Param(

		[String]$OutputDirectory = "${Env:USERPROFILE}\man",

		[Switch]$Quiet,
		[Switch]$SkipOpenDirectory

	)

	If ((Test-Path "${OutputDirectory}") -eq $False) {
		New-Item -ItemType "Directory" -Path "${OutputDirectory}" | Out-Null;
	}

	$Manuals = @{};

	$Manuals.cmd = @();
	$Manuals.cmd += "assoc";
	$Manuals.cmd += "cmd";
	$Manuals.cmd += "ftype";
	$Manuals.cmd += "whoami";

	$Manuals.Keys | ForEach-Object {
		$Compiler = $_;
		If(Get-Command "${Compiler}" -ErrorAction "SilentlyContinue") {
			$Manuals.$Compiler | ForEach-Object {
				$Command = $_;
				If ($Compiler -Eq "cmd") {
					cmd /C "${Command} /? > `"${OutputDirectory}\${Command}.${Compiler}.man`"";
				}
			}
		}
	}

	If (!($PSBoundParameters.ContainsKey("SkipOpenDirectory"))) {
		If (Get-Command "Explorer" -ErrorAction "SilentlyContinue") {
			Explorer "${OutputDirectory}"; # Show the directory to the user
		} Else {
			If (!($PSBoundParameters.ContainsKey("Quiet"))) { Write-Host "ERROR | Command `"Explorer`" not found while trying to show directory `"${OutputDirectory}`""; }
		}
	}

	Return;
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "ManualGenerator";
}

