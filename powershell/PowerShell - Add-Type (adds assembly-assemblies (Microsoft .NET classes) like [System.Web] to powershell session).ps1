# ------------------------------------------------------------
#
# PowerShell - Get if type exists, add it if not
#
# ------------------------------------------------------------

# Check if we need to add an assembly (Microsoft .NET class) into this PowerShell session

$Assembly=@{ Class="System.Net.WebUtility"; Namespace="System.Web"; };
# $Assembly=@{ Class="System.IO.Compression.ZipFile"; Namespace="System.IO.Compression.FileSystem"; };

$LocalAssemblies=([System.AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object { ${_}.GetTypes(); });
$Assembly_Exists=(${LocalAssemblies} | Where-Object { ${_}.FullName -Eq "$(${Assembly}.Class)"; });

If (${Assembly_Exists}) {
	Write-Host "Info:  Skipped [ Add-Type `"$(${Assembly}.Namespace)`" ]  (assembly already exists locally)";
} Else {
	Write-Host "Warning:  Microsoft .NET class not found:  `"$(${Assembly}.Namespace)`"";
	Write-Host "Confirm:  Add-Type `"$(${Assembly}.Namespace)`" (required to use class `"$(${Assembly}.Class)`")? (y/n)";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	If ($KeyPress.Character -Eq "y") {
		Write-Host "Info:  Confirmed (received `"y`" keypress)";
		Write-Host "Info:  Calling [ Add-Type `"$(${Assembly}.Namespace)`" ]...";
		Add-Type -AssemblyName ("$(${Assembly}.Namespace)");
	} Else {
		Write-Host "Info:  Skipped [ Add-Type `"$(${Assembly}.Namespace)`" ]  (did not receive `"y`" keypress)";
	}
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Add-Type (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type?view=powershell-5.1
#
#   docs.microsoft.com  |  "WebUtility Class (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.webutility?view=net-5.0
#
#   stackoverflow.com  |  "PowerShell - Check if .NET class exists - Stack Overflow"  |  https://stackoverflow.com/a/43648202
#
# ------------------------------------------------------------