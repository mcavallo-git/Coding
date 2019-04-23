#
# Organize Azure's Public CIDR list by-region
#

$HttpRequest = @{};

$HttpRequest.HttpHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
# $HttpRequest.HttpHeaders.Add("X-DATE", 'mm/dd/yyyy')
# $HttpRequest.HttpHeaders.Add("X-SIGNATURE", 'some_token')
# $HttpRequest.HttpHeaders.Add("X-API-KEY", 'some_user')
# $HttpRequest.HttpHeaders.Add("USER_AGENT", 'some_user')

#
# "Public IP address prefix"
# https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-address-prefix
#			-match 'href="https://www.microsoft.com/download/details.aspx?id=56519"'
#			-match 'href="confirmation.aspx?id=56519"'
#				--> output_azure_ipv4.json

$LastMondaysDate = (Get-Date (Get-Date 0:00).AddDays(-([int](Get-date).DayOfWeek)+1) -UFormat "%Y%m%d");

# $HttpRequest.Url = (
# 	"https://download.microsoft.com/download/7/1/D/71D86715-5596-4529-9B13-DA13A5DE5B63/ServiceTags_Public_20190415.json"
# );

$HttpRequest.Url = (
	("https://download.microsoft.com/download/7/1/D/71D86715-5596-4529-9B13-DA13A5DE5B63/ServiceTags_Public_")+($LastMondaysDate)+(".json")
);

Write-Host $HttpRequest.Url;

$HttpRequest.Response = (`
	Invoke-RestMethod `
		-Uri ($HttpRequest.Url) `
		-Headers ($HttpRequest.HttpHeaders) `
);

# $HttpRequest.Response | Format-List;
# $HttpRequest.Response.values | Format-List;

$RegionCIDR = @{};

ForEach ($EachAzItem In ($HttpRequest.Response.values.properties)) {

	$EachRegion = $EachAzItem.region;

	# East-US Servers, Only
	If ($EachRegion.Contains("eastus")) {
		
		# Regions
		If ($RegionCIDR[$EachRegion] -eq $null) {
			$RegionCIDR[$EachRegion] = @{};
		}

		# Regions -> Services
		$EachSystemService = $EachAzItem.systemService;
		If ($EachSystemService.Length -eq 0) {
			$EachSystemService = '_';
		}

		If ($RegionCIDR[$EachRegion][$EachSystemService] -eq $null) {
			$RegionCIDR[$EachRegion][$EachSystemService] = @();
		}
		If ($RegionCIDR[$EachRegion]['_All_Azure_Services'] -eq $null) {
			$RegionCIDR[$EachRegion]['_All_Azure_Services'] = @();
		}
		
		# Regions -> Services -> CIDRs
		ForEach ($EachCIDR In $EachAzItem.addressPrefixes) {
			if (!($RegionCIDR[$EachRegion][$EachSystemService].Contains($EachCIDR))) {
				$RegionCIDR[$EachRegion][$EachSystemService] += $EachCIDR;
			}
			if (!($RegionCIDR[$EachRegion]['_All_Azure_Services'].Contains($EachCIDR))) {
				$RegionCIDR[$EachRegion]['_All_Azure_Services'] += $EachCIDR;
			}
		}
		
	}
	
}

# Create parent-directory on the Desktop
$OutputParentDir = ("${HOME}/Desktop/AzureCIDR");
If (!(Test-Path $OutputParentDir)) {
	New-Item -ItemType "Directory" -Path (($OutputParentDir)+("/")) | Out-Null;
}

# Create base-directory
$OutputDir = (($OutputParentDir)+("/")+(Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S"));
If (!(Test-Path $OutputDir)) {
	New-Item -ItemType "Directory" -Path (($OutputDir)+("/")) | Out-Null;
}

# Output the contents of the array into each file
ForEach ($EachRegion In (($RegionCIDR).GetEnumerator())) {
	ForEach ($EachService In ($EachRegion.Value.GetEnumerator())) {
		$OutputFile = (("${OutputDir}/azure")+(".")+($EachService.Name)+(".")+($EachRegion.Name)+(".")+("conf"));
		If (!(Test-Path $OutputFile)) {
			Set-Content -Path ("${OutputFile}") -Value ("");
		}
		ForEach ($EachCIDR In $EachService.Value) {
			Add-Content -Path ("${OutputFile}") -Value (("allow ")+($EachCIDR)+(";"));
			# Write-Host "Adding `"$EachCIDR`" to `"$OutputFile`"";
		}
		Write-Host (($EachRegion.Name)+(" - ")+($EachService.Name)+(" - Found [ ")+($EachService.Value.Length)+(" ] unique IPv4 ranges (CIDR notation)"));
		
	}
}



Start "${OutputDir}";

# $CurrentDirname = (Get-Item -Path ".\").FullName;
