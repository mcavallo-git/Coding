# Copy this command into an admin powershell terminal:
Set-ExecutionPolicy -ExecutionPolicy "RemoteSigned";

Exit;



# Inspect all configured PowerShell execution policies
# Note: -List will display execution-policies for the current [ session ], [ local ], & [ domain ] environments

Get-ExecutionPolicy -List;



# Setting PowerShell execution-policy defaults
#   To see the list of parameter & possible-values, refer to: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy#parameters

Set-ExecutionPolicy -ExecutionPolicy "Default" -Scope "LocalMachine" -Force; # Default policies: "Restricted" for Windows clients, "RemoteSigned" for Windows servers
Set-ExecutionPolicy -ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; # Allow Powershell (.ps1) Scripts to run for the current-user



# Disallow Powershell (.ps1) Scripts from running locally

Set-ExecutionPolicy -ExecutionPolicy "Restricted" -Force;



#
#	Citation(s)
#
#		docs.microsoft.com
#			"Set-ExecutionPolicy   Sets the PowerShell execution policies for Windows computers."
#			 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy
#
