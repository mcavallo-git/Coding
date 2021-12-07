# ------------------------------------------------------------
#
# PowerShell - Get if assembly type (e.g. a Microsoft .NET class) exists locally & adds it, if not
#
# ------------------------------------------------------------

If ($True) {

	$Assembly=@{ Class="System.Net.WebUtility"; Namespace="System.Web"; Method="HtmlEncode"; };
	$Assembly=@{ Class="System.IO.Compression.ZipFile"; Namespace="System.IO.Compression.FileSystem"; Method="ExtractToDirectory"; };

	# ------------------------------
	# SKIP USER CONFIRMATION & JUST ADD THE ASSEMBLY:
	$Assembly=@{ Class="System.Net.WebUtility"; Namespace="System.Web"; Method="HtmlEncode"; };
	$Local_Assemblies=([System.AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object { ${_}.GetTypes(); });
	$Class_ExistsLocally=(${Local_Assemblies} | Where-Object { ${_}.FullName -Eq "$(${Assembly}.Class)"; });
	# Check if we need to add a prerequisite assembly (e.g. a Microsoft .NET class) to this PowerShell session
	If (-Not (${Class_ExistsLocally})) {
		Add-Type -AssemblyName ("$(${Assembly}.Namespace)");
	}


	# ------------------------------
	# REQUIRE USER CONFIRMATION BEFORE ADDING THE ASSEMBLY:
	$Local_Assemblies=([System.AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object { ${_}.GetTypes(); });
	$Class_ExistsLocally=(${Local_Assemblies} | Where-Object { ${_}.FullName -Eq "$(${Assembly}.Class)"; });
	# Check if we need to add an assembly (e.g. a Microsoft .NET class) into this PowerShell session
	If (${Class_ExistsLocally}) {
		Write-Host "Info:  Skipped [ Add-Type `"$(${Assembly}.Namespace)`" ]  ( required to use method [$(${Assembly}.Class)]::$(${Assembly}.Method)(...) ) - (assembly already exists locally)";
	} Else {
		Write-Host "`n"; Write-Host -NoNewline "CONFIRMATION REQUIRED:  Add-Type `"$(${Assembly}.Namespace)`" ( required to use method [$(${Assembly}.Class)]::$(${Assembly}.Method)(...) )?  (press 'y' to confirm)" -BackgroundColor "Black" -ForegroundColor "Yellow";
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		If ($KeyPress.Character -Eq "y") {
			Write-Host "Info:  Confirmed (received `"y`" keypress)";
			Write-Host "Info:  Calling [ Add-Type `"$(${Assembly}.Namespace)`" ]  ( required to use method [$(${Assembly}.Class)]::$(${Assembly}.Method)(...) )...";
			Add-Type -AssemblyName ("$(${Assembly}.Namespace)");
		} Else {
			Write-Host "Info:  Skipped [ Add-Type `"$(${Assembly}.Namespace)`" ]  (did not receive `"y`" keypress)";
		}
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