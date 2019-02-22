function GitCloneRepo {
	Param(

		[Parameter(Mandatory=$true)]
		[string]$Target,

		[Parameter(Mandatory=$false)]
		[switch]$echo = $false

	)

	##  Resolve an HTTPS URI by querying it drirectly (over port 443),
	##  then detect it's response headers to dig deeper
	##   

	##\ Example showing... just all around the handheld repo

	$WebRequest = [System.Net.WebRequest]::Create("https://git.mcavallo.com");
	$Response = $WebRequest.GetResponse();
	$Response.StatusCode;
	$ResolvedUri = $Response.ResponseUri.AbsoluteUri;

	# rm .\Coding -Force -Recurse

	cd ($Env:Tmp);
	Write-Host "------";
	$git_clone = (git clone ($ResolvedUri));
	$ReurnVal = $?;
	Write-Host "------";

	Return $ReurnVal;
	
}

Export-ModuleMember -Function "GitCloneRepo";

# Import-Module ("...\GetJsonFromTarget.psm1");

# Get-Module "GetJsonFromTarget";
