#
# PowerShell - ManualGenerator
#   Generates Runtime Manuals
#
function ManualGenerator {
	Param(

		[String]$OutputDir = "${Env:USERPROFILE}\man",

		[Switch]$Quiet

	)

	If ((Test-Path "${OutputDir}") -eq $False) {
		New-Item -ItemType "Directory" -Path "${OutputDirectory}" | Out-Null;
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
			cmd /c "${Command} /? > `"${OutputDir}\${Command}.${Compiler}.man`"";
		}
	}



	Return;

}

Export-ModuleMember -Function "ManualGenerator";


# MCavallo, 2019-06-20_15-05-42
