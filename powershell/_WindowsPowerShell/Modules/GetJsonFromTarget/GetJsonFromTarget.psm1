function GetJsonFromTarget {
	Param(

		[Parameter(Mandatory=$true)]
		[string]$target,

		[Parameter(Mandatory=$false)]
		[switch]$echo = $false

	)

	If ($PSBoundParameters.ContainsKey('echo')) {
		Write-Host (("`n`n`n"));
	}

	$json = @{};
	# $json.dirname = $PSScriptRoot;
	$json.dirname = $Env:UserProfile;
	$json.basename = "az_config.json";
	$json.fullpath = (($json.dirname) + ("\") + ($json.basename));

	$json.exists = Test-Path -Path ($json.fullpath);

	If ($json.exists -eq $false) {
		If ($PSBoundParameters.ContainsKey('echo')) {
			Write-Host (("`nFail - Target not found: `"") + ($json.fullpath) + ("`"`n"));
			Start-Sleep -Seconds 60;
		}
		Exit;

	} Else {
		If ($PSBoundParameters.ContainsKey('echo')) {
			Write-Host (("`nPass - Target exists: `"") + ($json.fullpath) + ("`"`n"));
		}
	}

	$json.data = Get-Content -Raw -Path ($json.fullpath) | ConvertFrom-Json;

	If ($PSBoundParameters.ContainsKey('echo')) {
		[PSCustomObject]$json;
		Write-Host (("`n`n`n"));
	}

	Return $json;
}

Export-ModuleMember -Function "GetJsonFromTarget";

# Import-Module ("...\GetJsonFromTarget.psm1");

# Get-Module "GetJsonFromTarget";

