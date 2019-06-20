# Query the registry to check for installed versions of .NET Framework (4.5 and higher)

$Registry_NET_Frameworks_v4 = "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full";

$VersionMap = @{};
$VersionMap[378389] = '4.5.0';
$VersionMap[378675] = '4.5.1';
$VersionMap[379893] = '4.5.2';
$VersionMap[393295] = '4.6.0';
$VersionMap[394254] = '4.6.1';
$VersionMap[394802] = '4.6.2';
$VersionMap[460798] = '4.7.0';
$VersionMap[461308] = '4.7.1';
$VersionMap[461808] = '4.7.2';
$VersionMap[528040] = '4.8.0';

$i=0;

$OutputRows = @();
$OutputRows[$i++] = "";
$OutputRows[$i++] = " .NET Framework versions ";
Write-Host "`n";
Write-Host "  Installation Status: Microsoft .NET Framework";
Write-Host "`n";
Write-Host "  |-----------|-----------|--------------|  ";
Write-Host "  |  Release  |  Version  |  Installed?  |  ";
Write-Host "  |-----------|-----------|--------------|  ";
$VersionMap.Keys | Sort-Object | ForEach-Object {
	$Release = $_;
	$Version = $VersionMap.$Release;
	$RegistryInstalledVal = Get-ChildItem "Registry::${Registry_NET_Frameworks_v4}" | Get-ItemPropertyValue -Name "Release" | ForEach-Object { $_ -ge $Release };
	$Installed = (&{If($RegistryInstalledVal) { $True } Else { $False }});
	# $Version = $VersionMap[$Release];
	$OutputRows += @{
		Release = $Release;
		Version = $Version;
		Installed = $Installed;
	};
	Write-Host (`
		("  |  ") + `
		(([String]($Release)).PadLeft(("Release".Length)," ")) + `
		("  |  ") + `
		(([String]($Version)).PadLeft(("Version".Length)," ")) + `
		("  |  ") + `
		(([String]($Installed)).PadLeft(("Installed?".Length)," ")) + `
		("  |  ") `
	);
}
Write-Host "  |-----------|-----------|--------------|  ";
Write-Host "`n";

# $OutputRows[$i++] = "";

# ForEach($RowIndex In $($OutputRows.Keys | Sort-Object)) {
# 	$OutputRows[$RowIndex];
# }


# Cited-Name: "How to: Determine which .NET Framework versions are installed"
# Cited-Host: docs.microsoft.com
# Cited-URL:  https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed#ps_a
