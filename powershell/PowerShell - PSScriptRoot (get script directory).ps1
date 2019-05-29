
$ReversePathLookups = @();

# Running Script - Parent Directory
$ReversePathLookups += @{
	Description = "Dirname / parent directory of the script currently being executed";
	Commands = @(
		@{
			Command = "`$PSScriptRoot";
			CurrentValue = ($PSScriptRoot);
			MinimumPowerShellVersion = 3.0;
		},
		@{
			Command = "Split-Path `$MyInvocation.MyCommand.Path -Parent";
			CurrentValue = (Split-Path $MyInvocation.MyCommand.Path -Parent);
			MinimumPowerShellVersion = 2.0;
		}
	)
};

# Working-Path / Working-Directory
$ReversePathLookups += @{
	Description = "Working-Path / Working-Directory of the current session";
	Commands = @(
		@{
			Command = "(Get-Item -Path `".\`").FullName;";
			CurrentValue = (Get-Item -Path ".\").FullName;
			MinimumPowerShellVersion = 3.0;
		}
	)
};

# Running Script - Fullpath
$ReversePathLookups += @{
	Description = "Fullpath of the script currently being executed";
	Commands = @(
		@{
			Command = "`$PSCommandPath";
			CurrentValue = ($PSCommandPath);
			MinimumPowerShellVersion = 3.0;
		},
		@{
			Command = "`$MyInvocation.MyCommand.Path";
			CurrentValue = ($MyInvocation.MyCommand.Path);
			MinimumPowerShellVersion = 2.0;
		}
	)
};

Clear-Host;
ForEach ($EachLookup In $ReversePathLookups) {
	Write-Host (("`n")+("-"*60)+("`n"));
	Write-Host ((" *** ")+($EachLookup.Description)+("`n"));
	ForEach ($EachCommand In $EachLookup.Commands) {
		Write-Host "    " -NoNewLine;
		Write-Host $EachCommand.Command -NoNewLine -ForegroundColor "Green";
		Write-Host (("   -->   ")+($EachCommand.CurrentValue)+("   (requires PowerShell ")+($EachCommand.MinimumPowerShellVersion)+("+)`n"));
		# Write-Host "";
		# ForEach ($EachProperty In $EachCommand.GetEnumerator()) {
		# 	Write-Host (("    ")+($EachProperty.Name)+(": ")+($EachProperty.Value));
		# }
	}
}
Write-Host (("`n")+("-"*60)+("`n"));


#
#	Citation(s)
#
#		Thanks to StackOverflow user [ Roman Kuzmin ] on forum [ https://stackoverflow.com/questions/3667238/how-can-i-get-the-file-system-location-of-a-powershell-script ]
#