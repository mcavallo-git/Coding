#
# Example Call:
#
# 	Az_KeyVault `
# 		-SubscriptionID ($az.subscription) `
# 		-ResourceGroup ($az.group.name) `
# 		-AppServicePlanName ($az.appservice.plan.name) `
# 		-Name ($az.epithet) `
# 	;
#
function Az_KeyVault {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$SubscriptionID,

		[Parameter(Mandatory=$true)]
		[String]$ResourceGroup,

		[Parameter(Mandatory=$true)]
		[String]$Name,

		[Parameter(Mandatory=$true)]
		[ValidateSet("Create","Delete")]
		[String]$Action,

		[Parameter(Mandatory=$true)]
		[ValidateSet("Vault","Secret")]
		[String]$ResourceType,
		
		[String]$Location = "eastus",

		[ValidateSet("premium","standard")]
		[String]$Sku = "standard",
			
		[Switch]$Quiet
	)

	$ReturnValue = $false;



	$az = @{};
	$az.keyvault = @{};

	# Fail-out if any required modules are not found within the current scope
	$RequireModule="BombOut";
	if (!(Get-Module ($RequireModule))) {
		Write-Host (("`n`nRequired Module not found: `"")+($RequireModule)+("`"`n`n"));
		Start-Sleep -Seconds 60;
		Exit 1;
	}
	
	#
	#		az keyvault		--> https://docs.microsoft.com/en-us/cli/azure/keyvault
	#
	Switch ($Action.ToUpper()) {

		"CREATE" {

			$Name = (($Name) + ("-keyvault"));
			if ($Name.length -gt 24) {
				$Name = $Name.Substring(0, 24);
			}
			$CommandDescription = (("Creating Azure Key vault: `"")+($Name)+("`""));
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("`n ")+($CommandDescription)+("...`n")); }
			#
			# Create Keyvault
			#
			$ReturnValue = `
				az keyvault create `
				--subscription ($SubscriptionID) `
				--resource-group ($ResourceGroup) `
				--name ($Name) `
				--location ($Location) `
				--sku ($Sku) `
				| ConvertFrom-Json;
			$last_exit_code = If($?){0}Else{1};
			BombOut `
				-ExitCode ($last_exit_code) `
				-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
				-MessageOnSuccessJSON ($ReturnValue);
			break;
		}

		"DELETE" {
			$CommandDescription = (("Deleting Azure Key vault: `"")+($Name)+("`""));
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("`n ")+($CommandDescription)+("...`n")); }
			#
			#	Delete Keyvault
			#
			$ReturnValue = `
				az keyvault delete `
				--subscription ($SubscriptionID) `
				--resource-group ($ResourceGroup) `
				--name ($Name) `
				| ConvertFrom-Json;
			$last_exit_code = If($?){0}Else{1};
			BombOut `
				-ExitCode ($last_exit_code) `
				-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
				-MessageOnSuccessJSON ($ReturnValue);
			break;
		}
	}

	Return $ReturnValue;

	# ------------------------------------------------------------- #
}

Export-ModuleMember -Function "Az_KeyVault";
