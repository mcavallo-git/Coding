
Write-Host (("`n")+("-"*60)+("`n")+ ("(PowerShell version 3)"))

$PSScript_Commands = @();

$PSScript_Commands += @{
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

$PSScript_Commands += @{
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

$PSScript_Commands

# (Get-Item -Path ".\").FullName

Write-Host (("`n")+("-"*60)+("`n"));


#
#	Citation(s)
#
#		Thanks to StackOverflow user [ Roman Kuzmin ] on forum [ https://stackoverflow.com/questions/3667238/how-can-i-get-the-file-system-location-of-a-powershell-script ]
#