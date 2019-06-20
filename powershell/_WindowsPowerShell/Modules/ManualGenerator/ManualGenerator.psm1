#
# PowerShell - ManualGenerator
#   Generates Runtime Manuals
#
function ManualGenerator {
	Param(
		[Switch]$Quiet
	)

	If ((Test-Path "${Env:USERPROFILE}\man") -eq $False) {
		New-Item -ItemType "Directory" -Path "${Env:USERPROFILE}\man" | Out-Null;
	}

	$Manuals = @{};

	$Manuals.cmd = @();
	$Manuals.cmd += "assoc";
	$Manuals.cmd += "ftype";
	$Manuals.cmd += "whoami";

	$Manuals.Keys | ForEach-Object {
		$Compiler = $_;
		$Manuals.$Compiler | ForEach-Object {
			$Command = $_;
			cmd /c "${Command} /? > ${Env:USERPROFILE}\man\${Command}.${Compiler}.man";
		}
	}



	Return;

}

Export-ModuleMember -Function "ManualGenerator";


# MCavallo, 2019-06-20_15-05-42
