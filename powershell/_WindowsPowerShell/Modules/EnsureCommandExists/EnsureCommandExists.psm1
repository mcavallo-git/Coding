
# EnsureCommandExists -Name "git"

function EnsureCommandExists {
	Param(
		[Parameter(Mandatory=$true)]
		[String]$Name,

		[String]$OnErrorShowUrl="",

		[Boolean]$OnErrorHalt=$true
	)

	Write-Host (("`nTask - Checking for local command: ") + ($Name));
			# $ErrorActionPreference = 'SilentlyContinue';
	$Version = [System.String]::Join(".", ((Get-Command $Name).Version));
			# $ErrorActionPreference = 'Continue';
	$CommandExists = If($?){0}Else{1};
	
	if ($CommandExists -ne 0) {
		Write-Host (("Fail - Command not found: ") + ($Name));
		If ($PSBoundParameters.ContainsKey('OnErrorShowUrl')) {
			# Download/Install/Info URL
			Write-Host (("Info - For troubleshooting, download references, etc. please visit Url: ")+($OnErrorShowUrl));
			Start ($OnErrorShowUrl);
		}
		if ($OnErrorHalt -eq $true) {
			BombOut `
			-ExitCode 1 `
			-MessageOnError ("") `
			-MessageOnSuccess ("");
		}
	} else {
		Write-Host (("Pass - Local runtime exists:  ") + ($Name) + (" v")+($Version)+("`n"));
	}


	return $CommandExists;
}

Export-ModuleMember -Function "EnsureCommandExists";
