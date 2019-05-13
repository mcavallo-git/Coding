#
# Example Call:
#
# 	Az_StorageAccount `
# 		-SubscriptionID ($az.subscription) `
# 		-ResourceGroup ($az.group.name) `
# 	;
#
function Az_StorageAccount {
	Param(
		
		[Parameter(Mandatory=$true)]
		[String]$SubscriptionID,
		
		[Parameter(Mandatory=$true)]
		[String]$ResourceGroup,
		
		[ValidateSet("Create","Delete")]
		[String]$Action="Create",
		
		[String]$Location = "eastus",
		
		[ValidateSet("Standard_LRS", "Premium_LRS", "Standard_ZRS", "Premium_ZRS", "Standard_GRS", "Standard_RAGRS")] <# Azure-Defaults to "Standard_RAGRS" ### #>
		[String]$Sku = "Standard_LRS",
		
		# Note: $Name will be overwritten if $Action equals "Create"  (must force uniqueness across ALL of Azure)
		[String]$Name = "",
		
		[Switch]$Quiet
	)

	$az = @{};
	$az.storage = @{};
	$az.storage.account = @{};

	# Fail-out if any required modules are not found within the current scope
	$RequireModule="BombOut";
	if (!(Get-Module ($RequireModule))) {
		Write-Host (("`n`nRequired Module not found: `"")+($RequireModule)+("`"`n`n"));
		Start-Sleep -Seconds 60;
		Exit 1;
	}
		
	#
	#		az storage account		--> https://docs.microsoft.com/en-us/cli/azure/storage/account
	#
	Switch ($Action.ToUpper()) {

		"CREATE" {

			# Since storage-account names must be unique across ALL storage accounts on Azure,
			# the $Name variable must be forced to be unique --> make it a timestamp (including milliseconds)
			$Name = ((Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S")+(Get-Date -Format fff)+("storage"));
			if ($Name.length -gt 24) {
				$Name = $Name.Substring(0, 24);
			}

			$CommandDescription = (("Creating Azure Storage account: `"")+($Name)+("`""));
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("`n ")+($CommandDescription)+("...`n")); }
			#
			# Create Storage Account
			#
			$az.storage.account.create = `
			JsonDecoder -InputObject ( `
				az storage account create `
				--subscription ($SubscriptionID) `
				--resource-group ($ResourceGroup) `
				--name ($Name) `
				--location ($Location) `
				--sku ($Sku) `
			);
			$last_exit_code = If($?){0}Else{1};
			BombOut `
				-ExitCode ($last_exit_code) `
				-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
				-MessageOnSuccessJSON ($az.storage.account.create);

			$az.storage.account.connection_string = `
			(`
				JsonDecoder -InputObject (`
					az storage account show-connection-string `
						--subscription ($SubscriptionID) `
						--resource-group ($ResourceGroup) `
						--name ($Name) `
				) `
			).connectionString;

			break;
		}

		"DELETE" {
			$CommandDescription = (("Deleting Azure Storage account: `"")+($Name)+("`""));
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("`n ")+($CommandDescription)+("...`n")); }
			#
			#	Delete Storage Account
			#
			$az.storage.account.delete = `
			JsonDecoder -InputObject ( `
				az storage account delete `
				--subscription ($SubscriptionID) `
				--resource-group ($ResourceGroup) `
				--name ($Name) `
				--yes `
			);
			$last_exit_code = If($?){0}Else{1};
			BombOut `
				-ExitCode ($last_exit_code) `
				-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
				-MessageOnSuccessJSON ($az.storage.account.delete);

			break;
		}

	}

	Return ($az.storage.account);

	# ------------------------------------------------------------- #
}

Export-ModuleMember -Function "Az_StorageAccount";
