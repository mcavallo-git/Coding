
$RegEdits = @();

# Explorer Settings
$RegEdits += @{
	Path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer";
	Props=@(
		@{
			Description="Enables (0) or Disables (1) `"Aero Shake`" in Windows 10.";
			Name="NoWindowMinimizingShortcuts"; 
			Type="DWord";
			Value=1;
		}
	)
};

# Search / Cortana Settings
$RegEdits += @{
	Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Search";
	Props=@(
		@{
			Description="Enables (1) or Disables (0) Cortana's ability to send search-resutls to Bing.com. Fix for KB4512941 bug: Set to value=1 to avoid Cortana from constantly eating 30-40% CPU (processing resources), even while idling.";
			Name="BingSearchEnabled";
			Type="DWord";
			Value=1;
		},
		@{
			Description=$Null;
			Name="AllowSearchToUseLocation";
			Type="DWord";
			Value=0;
		}
	)
};

# Search / Cortana Settings
$RegEdits += @{
	Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search";
	Props=@(
		@{
			Description=$Null;
			Name="AllowCortana";
			Type="DWord";
			Value=0;
		},
		@{
			Description=$Null;
			Name="ConnectedSearchUseWeb";
			Type="DWord";
			Value=0;
		},
		@{
			Description=$Null;
			Name="ConnectedSearchUseWebOverMeteredConnections";
			Type="DWord";
			Value=0;
		},
		@{
			Description=$Null;
			Name="DisableWebSearch";
			Type="DWord";
			Value=1;
		}
	)
};

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	#
	# Current session does not have Admin-Rights (required)
	#		--> Re-run this script as admin (if current user is not an admin, request admin credentials)
	#
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;
	Exit;

} Else {
	# 		New-Item --> Can be used to create new registry keys (assuming the current powershell session is running with elevated privileges)
	#			Set-ItemProperty --> Can be used to create new registry values (DWord 32-bit, etc.)
	#

	Foreach ($EachRegEdit In $RegEdits) {

		If ((Test-Path -Path ($EachRegEdit.Path)) -eq $true) {
			# Skip creating registry key if it already exists
			Write-Host (("`n`n  Found Key `"")+($EachRegEdit.Path)+("`" (Already up to date)"));
		} Else {
			# Create missing key in the registry
			Write-Host (("`n`n  Creating Key `"")+($EachRegEdit.Path)+("`" "));
			New-Item -Path ($EachRegEdit.Path);
		}

		Foreach ($EachProp In $EachRegEdit.Props) {

			# Check for each key-property
			# Write-Host (("`n`n  Checking for `"")+($EachRegEdit.Path)+("`" --> `"")+($EachProp.Name)+("`"...`n`n"));
			$Revertable_ErrorActionPreference = $ErrorActionPreference; $ErrorActionPreference = 'SilentlyContinue';
			$GetEachItemProp = Get-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name);
			$last_exit_code = If($?){0}Else{1};
			$ErrorActionPreference = $Revertable_ErrorActionPreference;

			If ($last_exit_code -eq 0) {

				$EachProp.LastValue = $GetEachItemProp.($EachProp.Name);

				If (($EachProp.LastValue) -eq ($EachProp.Value)) {
					# Existing key-property found with correct value
					Write-Host (("   |`n   |--> Found Property `"")+($EachProp.Name)+("`" with correct Value of [ ")+($EachProp.Value)+(" ] (Already up to date)"));

				} Else {
					# Modify the value of an existing property on an existing registry key
					Write-Host (("   |`n   |--> Updating Property `"")+($EachProp.Name)+("`" from Value [ ")+($EachProp.LastValue)+(" ] to Value [ ")+($EachProp.Value)+(" ]"));
					Set-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -Value ($EachProp.Value);

				}
			} Else {
				# Add the missing property to the Registry Key
				Write-Host (("   |`n   |--> Adding Property `"")+($EachProp.Name)+("`" with Value [ ")+($EachProp.Value)+(" ]"));
				New-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value);
				Write-Host " `n`n";

			}
			
			# If (($EachProp.Description) -Ne $Null) {
			# 	Write-Host (("        (")+($EachProp.Description)+(")"));
			# }
		}

	}

}

Write-Host -NoNewLine "`n`n  Press any key to exit...";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
