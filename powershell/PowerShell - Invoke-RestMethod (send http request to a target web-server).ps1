# ------------------------------------------------------------
#
# PowerShell - HTTP GET/POST Requests
#
# ------------------------------------------------------------

$HTTP_Methods = @("Default", "Delete", "Get", "Head", "Merge", "Options", "Patch", "Post", "Put", "Trace");

# ------------------------------------------------------------
#
# PowerShell - HTTP POST Request
#  |--> Required the name="..."'s property-values for the username & password fields
#  |--> Required the value="..."'s property-value for the form-submit button/action
#
$HttpRequest = @{};
$HttpRequest.Uri = "https://example-login.com";
$HttpRequest.Method = "POST";
$HttpRequest.Body = @{
	"dat_username" = "USERNAME";  <# Login username-field has html property [ name="dat_username" ] #>
	"dat_password" = "PLAINTEXT_PASSWORD"; <# login password-field for username has html property  [ name="dat_password" ] #>
	"@type" = "do_login";  <# Form which contains aforementioned usename & password has a [ type="submit" ] element with [ value="do_login" ] #>
}
$ProgressPreference='SilentlyContinue'; 
Invoke-WebRequest -UseBasicParsing `
-Uri ($HttpRequest.Uri) `
-Method ($HttpRequest.Method) `
-Body ($HttpRequest.Body);


# ------------------------------------------------------------


If ($True) {

	$HttpRequest = @{};

	#
	# Request URL
	#
	$HttpRequest.Url = "https://download.microsoft.com/download/7/1/D/71D86715-5596-4529-9B13-DA13A5DE5B63/ServiceTags_Public_$(Get-Date (Get-Date 0:00).AddDays(-([int](Get-date).DayOfWeek)+1) -UFormat '%Y%m%d').json";  # Microsoft Azure Datacenter IP Ranges

	#
	# Request Headers
	#
	$HttpRequest.HttpHeaders = (New-Object "System.Collections.Generic.Dictionary[[String],[String]]");
	# $HttpRequest.HttpHeaders.Add("X-DATE", 'mm/dd/yyyy');
	# $HttpRequest.HttpHeaders.Add("X-SIGNATURE", 'some_token');
	# $HttpRequest.HttpHeaders.Add("X-API-KEY", 'some_user');
	# $HttpRequest.HttpHeaders.Add("USER_AGENT", 'some_user');

	#
	# Call the HTTP Request
	#
	$HttpRequest.Response = (`
		Invoke-RestMethod `
			-Uri ($HttpRequest.Url) `
			-Headers ($HttpRequest.HttpHeaders) `
	);


	$Region_MatchAnyOf = @();
	# $Region_MatchAnyOf += "_"; # Items with a blank 'region'
	# $Region_MatchAnyOf += "australiacentral";
	# $Region_MatchAnyOf += "australiacentral2";
	# $Region_MatchAnyOf += "australiaeast";
	# $Region_MatchAnyOf += "australiasoutheast";
	# $Region_MatchAnyOf += "brazilne";
	# $Region_MatchAnyOf += "brazilse";
	# $Region_MatchAnyOf += "brazilsouth";
	# $Region_MatchAnyOf += "canadacentral";
	# $Region_MatchAnyOf += "canadaeast";
	# $Region_MatchAnyOf += "centralfrance";
	# $Region_MatchAnyOf += "centralindia";
	# $Region_MatchAnyOf += "centralus";
	# $Region_MatchAnyOf += "centraluseuap";
	# $Region_MatchAnyOf += "chilec";
	# $Region_MatchAnyOf += "eastasia";
	# $Region_MatchAnyOf += "easteurope";
	$Region_MatchAnyOf += "eastus";
	$Region_MatchAnyOf += "eastus2";
	# $Region_MatchAnyOf += "eastus2euap";
	# $Region_MatchAnyOf += "japaneast";
	# $Region_MatchAnyOf += "japanwest";
	# $Region_MatchAnyOf += "koreacentral";
	# $Region_MatchAnyOf += "koreas2";
	# $Region_MatchAnyOf += "koreasouth";
	# $Region_MatchAnyOf += "northcentralus";
	# $Region_MatchAnyOf += "northeurope";
	# $Region_MatchAnyOf += "northeurope2";
	# $Region_MatchAnyOf += "southafricanorth";
	# $Region_MatchAnyOf += "southafricawest";
	# $Region_MatchAnyOf += "southcentralus";
	# $Region_MatchAnyOf += "southeastasia";
	# $Region_MatchAnyOf += "southfrance";
	# $Region_MatchAnyOf += "southindia";
	# $Region_MatchAnyOf += "uaecentral";
	# $Region_MatchAnyOf += "uaenorth";
	# $Region_MatchAnyOf += "uknorth";
	# $Region_MatchAnyOf += "uksouth";
	# $Region_MatchAnyOf += "uksouth2";
	# $Region_MatchAnyOf += "ukwest";
	# $Region_MatchAnyOf += "westcentralus";
	# $Region_MatchAnyOf += "westeurope";
	# $Region_MatchAnyOf += "westindia";
	# $Region_MatchAnyOf += "westus";
	# $Region_MatchAnyOf += "westus2";

	$Service_MatchAnyOf = @();
	# $Service_MatchAnyOf += "_"; # Items with a blank 'systemService'
	# $Service_MatchAnyOf += "AzureApiManagement";
	$Service_MatchAnyOf += "AzureAppService";
	# $Service_MatchAnyOf += "AzureAppServiceManagement";
	# $Service_MatchAnyOf += "AzureBackup";
	$Service_MatchAnyOf += "AzureConnectors";
	# $Service_MatchAnyOf += "AzureContainerRegistry";
	# $Service_MatchAnyOf += "AzureCosmosDB";
	# $Service_MatchAnyOf += "AzureDataLake";
	# $Service_MatchAnyOf += "AzureEventHub";
	# $Service_MatchAnyOf += "AzureKeyVault";
	# $Service_MatchAnyOf += "AzureMachineLearning";
	# $Service_MatchAnyOf += "AzureMonitor";
	$Service_MatchAnyOf += "AzureServiceBus";
	# $Service_MatchAnyOf += "AzureSQL";
	# $Service_MatchAnyOf += "AzureStorage";
	# $Service_MatchAnyOf += "BatchNodeManagement";
	# $Service_MatchAnyOf += "GatewayManager";             # ?? possibly ??
	# $Service_MatchAnyOf += "MicrosoftContainerRegistry";
	# $Service_MatchAnyOf += "ServiceFabric";              # ?? possibly ??

	$RegionCIDR = @{};

	ForEach ($EachAzItem In ($HttpRequest.Response.values.properties)) {

		# Regions
		$EachRegion = $EachAzItem.region;
		If ($EachRegion.Length -eq 0) { # Items with a blank "region"
			$EachRegion = '_';
			# Continue; # Skip blank regions
		}

		# East-US Servers, Only
		If ($Region_MatchAnyOf.Contains($EachRegion)) {
			

			If ($null -eq $RegionCIDR[$EachRegion]) {
				$RegionCIDR[$EachRegion] = @{};
			}

			# Regions -> Services
			$EachSystemService = $EachAzItem.systemService;
			If ($EachSystemService.Length -eq 0) { # Items with a blank "systemService"
				$EachSystemService = '_';
				# Continue; # Skip blank services
			}

			If ($Service_MatchAnyOf.Contains($EachSystemService)) {

				If ($null -eq $RegionCIDR[$EachRegion][$EachSystemService]) {
					$RegionCIDR[$EachRegion][$EachSystemService] = @();
				}
				If ($null -eq $RegionCIDR[$EachRegion]['_AllServices']) {
					$RegionCIDR[$EachRegion]['_AllServices'] = @();
				}
				
				# Regions -> Services -> CIDRs
				ForEach ($EachCIDR In $EachAzItem.addressPrefixes) {
					if (!($RegionCIDR[$EachRegion][$EachSystemService].Contains($EachCIDR))) {
						$RegionCIDR[$EachRegion][$EachSystemService] += $EachCIDR;
					}
					if (!($RegionCIDR[$EachRegion]['_AllServices'].Contains($EachCIDR))) {
						$RegionCIDR[$EachRegion]['_AllServices'] += $EachCIDR;
					}

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
		Write-Host (("`n")+($EachRegion.Name));
		ForEach ($EachService In ($EachRegion.Value.GetEnumerator())) {
			$OutputFile = (
				("${OutputDir}/azure") +
				(".") +
				($EachRegion.Name) +
				(".") +
				($EachService.Name) +
				(".") +
				("conf")
			);
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

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Azure Public IP address prefix | Microsoft Docs"  |  https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-address-prefix
#
#   docs.microsoft.com  |  "Download [Deprecating] Microsoft Azure Datacenter IP Ranges from Official Microsoft Download Center"  |  https://www.microsoft.com/en-us/download/details.aspx?id=41653
#
#   docs.microsoft.com  |  "Microsoft Azure Datacenter IP Ranges (2020-05-11)"  |  https://download.microsoft.com/download/7/1/D/71D86715-5596-4529-9B13-DA13A5DE5B63/ServiceTags_Public_20200511.json
#
# ------------------------------------------------------------