
$ReversePathLookups = @();

# Session Working Path/Dir
$ReversePathLookups += @{
	Description = "Session Working Path/Dir";
	Commands = @(
		@{
			Command = "(Get-Item -Path `".\`").FullName;";
			CurrentValue = (Get-Item -Path ".\").FullName;
			MinimumPowerShellVersion = 3.0;
		}
	)
};


# Fullpath of Running Script
$ReversePathLookups += @{
	Description = "Fullpath of Running Script";
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



# Dirname of Running Script
$ReversePathLookups += @{
	Description = "Dirname of Running Script (e.g. the Fullpath of Parent-Dir)";
	Commands = @(
		@{
			Command = "Split-Path `$MyInvocation.MyCommand.Path -Parent";
			CurrentValue = (Split-Path $MyInvocation.MyCommand.Path -Parent);
			MinimumPowerShellVersion = 2.0;
		}
		,
		@{
			Command = "`$PSScriptRoot";
			CurrentValue = ($PSScriptRoot);
			MinimumPowerShellVersion = 3.0;
		}
	)
};


# Basename of Running Script
$ReversePathLookups += @{
	Description = "Basename of Running Script";
	Commands = @(
		@{
			Command = "`$MyInvocation.MyCommand.Name";
			CurrentValue = ($MyInvocation.MyCommand.Name);
			MinimumPowerShellVersion = 2.0;
		}
	)
};


Clear-Host;
ForEach ($EachLookup In $ReversePathLookups) {
	Write-Host (("`n")+("-"*60)+("`n"));
	Write-Host (("  ")+($EachLookup.Description)+("`n"));
	ForEach ($EachCommand In $EachLookup.Commands) {
		Write-Host (("    ")+($EachCommand.Command)) -ForegroundColor "Green";
		Write-Host (("      ")+($EachCommand.CurrentValue));
		Write-Host (("      (requires PowerShell ")+($EachCommand.MinimumPowerShellVersion)+("+)`n"));
		# Write-Host "";
		# ForEach ($EachProperty In $EachCommand.GetEnumerator()) {
		# 	Write-Host (("    ")+($EachProperty.Name)+(": ")+($EachProperty.Value));
		# }
	}
}
Write-Host (("`n")+("-"*60)+("`n"));


# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "About Automatic Variables"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables
#
#		ss64.com  |  "Automatic Variables"  |  https://ss64.com/ps/syntax-automatic-variables.html
#
#		stackoverflow.com  |  "How can I get the file system location of a PowerShell script?"  |  https://stackoverflow.com/a/3667376
#
# ------------------------------------------------------------