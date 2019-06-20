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

$CurrentRelease = Get-ChildItem "Registry::${Registry_NET_Frameworks_v4}" | Get-ItemPropertyValue -Name "Release";
$CurrentVersion = Get-ChildItem "Registry::${Registry_NET_Frameworks_v4}" | Get-ItemPropertyValue -Name "Version";

$i=0;

Write-Host "`n";
Write-Host "  Compatibility Status: Microsoft .NET Framework";
Write-Host "`n";
Write-Host " |---------------|---------------|---------------|  ";
Write-Host " | Release       | Version       | Compatibility |  ";
Write-Host " |---------------|---------------|---------------|  ";
$VersionMap.Keys | Sort-Object | ForEach-Object {
	$Release = $_;
	$Version = $VersionMap.$Release;
	$Installed = (&{If($CurrentRelease -ge $Release) { "Compatible" } Else { "Incompatible" }});
	Write-Host (`
		(" | ") + `
		(([String]($Release)).PadRight(("Compatibility".Length)," ")) + `
		(" | ") + `
		(([String]($Version)).PadRight(("Compatibility".Length)," ")) + `
		(" | ") + `
		(([String]($Installed)).PadRight(("Compatibility".Length)," ")) + `
		(" | ") `
	);
}
Write-Host " |---------------|---------------|---------------|  ";
Write-Host "`n";

# Cited-Name: "How to: Determine which .NET Framework versions are installed"
# Cited-Host: docs.microsoft.com
# Cited-URL:  https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed#ps_a
