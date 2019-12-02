# Windows Update - Force-pull from Windows Update server (instead of using local WSUS server)
$RegEdit = @{
	Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU";
	Props=@(
		@{
			Description="Set this value to [ 1 ] to configure Automatic Updates to use a server that is running Software Update Services instead of Windows Update ( from https://docs.microsoft.com/en-us/windows/deployment/update/waas-wu-settings )";
			Name="UseWUServer";
			Type="DWord";
			Value=0;
			Delete=$False;
		}
	)
};

If ((Test-Path -Path ($RegEdit.Path)) -Eq $False) {
	# Create Key/Property
	New-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value) -Force;

} Else {
	# Check value of property
	$CurrentRegistryVal = ((Get-ItemProperty -Path ($RegEdit.Path) -Name ($RegEdit.Name)).($RegEdit.Name));
	Write-Output "Info: Currently, Registry property `"$($RegEdit.Name)`" within key `"$($RegEdit.Path)`" contains a value of `"$CurrentRegistryVal`" (desired value: `"$($RegEdit.Value)`")";
	If (($CurrentRegistryVal) -Ne ($RegEdit.Value)) {
		# Wrong Value found - Update it and alert user of update
		Write-Output "Info: Updating Registry property `"$($RegEdit.Name)`" within key `"$($RegEdit.Path)`" to now contain value `"$($RegEdit.Value)`", instead";
	} Else {
		# Value found and is set as-intended
		Write-Output "Info: Skipping Update (no action required)";
	}
}




Start-Sleep -Seconds 60;