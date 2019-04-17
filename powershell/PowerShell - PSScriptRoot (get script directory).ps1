
$ReversePathLookups = @();

# Running Script - Fullpath
$ReversePathLookups += @{
	Description = "Fullpath of the PowerShell script currently being executed";
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

# Running Script - Parent directort
$ReversePathLookups += @{
	Description = "Dirname (parent directory) of the PowerShell script currently being executed";
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
	Description = "Working-Path / Working-Directory (directory of the current PowerShell session)";
	Commands = @(
		@{
			Command = "(Get-Item -Path `".\`").FullName;";
			CurrentValue = (Get-Item -Path ".\").FullName;
			MinimumPowerShellVersion = '??';
		}
	)
};

ForEach ($EachLookup In $ReversePathLookups) {
	Write-Host (("`n")+("-"*60)+("`n"));
	Write-Host (("  Description: ")+($EachLookup.Description));
	ForEach ($EachCommand In $EachLookup.Commands) {
		Write-Host "";
		ForEach ($EachProperty In $EachCommand.GetEnumerator()) {
			Write-Host (("    ")+($EachProperty.Name)+(": ")+($EachProperty.Value));
		}
	}
}
Write-Host (("`n")+("-"*60)+("`n"));


#
#	Citation(s)
#
#		Thanks to StackOverflow user [ Roman Kuzmin ] on forum [ https://stackoverflow.com/questions/3667238/how-can-i-get-the-file-system-location-of-a-powershell-script ]
#