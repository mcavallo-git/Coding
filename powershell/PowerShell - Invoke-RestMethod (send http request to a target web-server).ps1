#
# Organize Azure's Public CIDR list by-region
#

$HttpRequest = @{};

$HttpRequest.HttpHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
# $HttpRequest.HttpHeaders.Add("X-DATE", 'mm/dd/yyyy')
# $HttpRequest.HttpHeaders.Add("X-SIGNATURE", 'some_token')
# $HttpRequest.HttpHeaders.Add("X-API-KEY", 'some_user')
# $HttpRequest.HttpHeaders.Add("USER_AGENT", 'some_user')

$HttpRequest.Url = "https://download.microsoft.com/download/7/1/D/71D86715-5596-4529-9B13-DA13A5DE5B63/ServiceTags_Public_20190415.json";

$HttpRequest.Response = (`
	Invoke-RestMethod `
		-Uri ($HttpRequest.Url) `
		-Headers ($HttpRequest.HttpHeaders) `
);

$RegionCIDR = @{};

ForEach ($EachAzItem In (($HttpResponse.Response).values.properties)) {
	$EachRegion = $EachAzItem.region;
	If ($RegionCIDR[$EachRegion] -eq $null) {
	# If (!($RegionCIDR.PSobject.Properties.name -match "$EachRegion")) {
		$RegionCIDR[$EachRegion] = @();
	}
	
	ForEach ($EachCIDR In $EachAzItem.addressPrefixes) {
		if (!($RegionCIDR[$EachRegion].Contains($EachCIDR))) {
			$RegionCIDR[$EachRegion] += $EachCIDR;
		}
	}
}

# $CurrentDirname = (Get-Item -Path ".\").FullName;

$OutputDir = (("${HOME}/Desktop/AzRegions_")+(Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S"));
New-Item -ItemType "Directory" -Path (($OutputDir)+("/")) | Out-Null;

ForEach ($EachRegion In (($RegionCIDR).GetEnumerator())) {
	If ($EachRegion.Name.Contains("eastus")) {
		$OutputFile = (("${OutputDir}/microsoft_azure_region_")+($EachRegion.Name)+(".conf"));
		
		Set-Content -Path ("${OutputFile}") -Value ("");
		ForEach ($EachCIDR In $EachRegion.Value) {
			Add-Content -Path ("${OutputFile}") -Value (("allow ")+($EachCIDR)+(";"));
			# Write-Host "Adding `"$EachCIDR`" to `"$OutputFile`"";
		}
		Write-Host (($EachRegion.Name)+(" - Found [ ")+($EachRegion.Value.Length)+(" ] unique IPv4 ranges (CIDR notation)"));
	}
}



Start "${OutputDir}";
