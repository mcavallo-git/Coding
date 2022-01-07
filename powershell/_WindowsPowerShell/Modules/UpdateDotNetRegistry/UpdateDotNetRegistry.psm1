# ------------------------------------------------------------
#
#	PowerShell - UpdateDotNetRegistry
#		|
#		|--> Description:  Updating Visual Studio, ASP.NET, & .NET default locations (for the current session)
#		|
#		|--> Example:     PowerShell -Command ("UpdateDotNetRegistry")
#
# ------------------------------------------------------------
Function UpdateDotNetRegistry() {
	Param(
		[String]$Dir_VSDefaultBuildInstance="C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional",
		[Switch]$Quiet,
		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:


	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/UpdateDotNetRegistry/UpdateDotNetRegistry.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'UpdateDotNetRegistry' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\UpdateDotNetRegistry\UpdateDotNetRegistry.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; UpdateDotNetRegistry;


	}
	# ------------------------------------------------------------

	If (Test-Path "${Dir_VSDefaultBuildInstance}") {

		Write-Host "";
		Write-Host "Updating Visual Studio defaults to reference `"${Dir_VSDefaultBuildInstance}`"";
		Write-Host "  |";
		Write-Host "  |--> Searching-for & executing `"VsMSBuildCmd.bat`", which performs (amongst other things) the following actions:";
		Write-Host "  |     - Adds MSBuild's directory to the PATH";
		Write-Host "  |     - Sets VS140COMNTOOLS environment variable (based on values held in the registry)";
		Write-Host "  |";
		Write-Host "  |--> Searching-for & executing `"VsDevCmd.bat`", which performs (amongst other things) the following actions:";
		Write-Host "  |     - Adds TypeScript Compiler's directory to the PATH";
		Write-Host "  |     - Adds additional directories to the PATH (dependent upon component selection)";
		Write-Host "  |     - Sets additional environment variables for use by the Visual C++ Compiler";
		Write-Host "  |     - Runs `"VsMSBuildCmd.bat`" doubleback";
		Write-Host "  |";
		Write-Host "  |--> Reference - `"VsDevCmd.bat`" CLI Usage";
		Write-Host "        - https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/ ";
		Write-Host "";

		<# Execute any `"VsMSBuildCmd.bat`" found (performs above list of actions) #>
		${Env:VSCMD_DEBUG}=1; Get-ChildItem -Path ("${Dir_VSDefaultBuildInstance}") -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "VsMSBuildCmd.bat" } | ForEach-Object { Write-Host "`nExecuting `"$($_.Name)`" from working directory `"$(Split-Path -Path ($($_.FullName)) -Parent)`"...`n" -ForegroundColor "Green"; Start-Process -Filepath ("$($_.Name)") -WorkingDirectory ("$(Split-Path -Path ($($_.FullName)) -Parent)") -Verb ("RunAs") -ErrorAction ("SilentlyContinue"); };
		<# Execute any `"VsDevCmd.bat`" found (performs above list of actions) #>
		${Env:VSCMD_DEBUG}=1; Get-ChildItem -Path ("${Dir_VSDefaultBuildInstance}") -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "VsDevCmd.bat" } | ForEach-Object { Write-Host "`nExecuting `"$($_.Name)`" from working directory `"$(Split-Path -Path ($($_.FullName)) -Parent)`"...`n" -ForegroundColor "Green"; Start-Process -Filepath ("$($_.Name)") -WorkingDirectory ("$(Split-Path -Path ($($_.FullName)) -Parent)") -Verb ("RunAs") -ErrorAction ("SilentlyContinue"); };

	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "UpdateDotNetRegistry";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "C# Compiler Options | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/
#
#   stackoverflow.com  |  "visual studio - VsDevCmd vs VsMSBuildCmd - Stack Overflow"  |  https://stackoverflow.com/a/30223278
#
# ------------------------------------------------------------