
#
#	Get-ItemProperty
#		|
#		|--> Example: Check registry "HKEY_CURRENT_USER:\" for user-specific "Path" environment variables 
#		|--> Note: Powershell's built-in environment variable $Env:Path is a combination of system & user-specific environment-variables)
#

$RegEdit = @{
	Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Search";
	Name="BingSearchEnabled";
	Type="DWord";
	Description="Enables (1) or Disables (0) Cortana's ability to send search-resutls to Bing.com";
	Value="1";
};

Get-ItemProperty -Path ($RegEdit.Path) -Name ($RegEdit.Name)

If ((Test-Path -Path ($RegEdit.Path)) -Eq $True) {
	Set-ItemProperty -Path ($RegEdit.Path) -Name ($RegEdit.Name) -Value ($RegEdit.Value);
} Else {
	New-ItemProperty -Path ($RegEdit.Path) -Name ($RegEdit.Name) -PropertyType ($RegEdit.Type) -Value ($RegEdit.Value);
}

Get-ItemProperty -Path ($RegEdit.Path) -Name ($RegEdit.Name)

