#
#	Example Call:
#		Az_Extension -Name "extension_name" -Add
#
function Az_Extension {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$Name,

		[Switch]$Add, # Call with "-Add" to require that the extension be installed, locally (otherwise function will just look to see if extension exists)

		[Switch]$Quiet
 
	)

	$AddExtension = If ($PSBoundParameters.ContainsKey('Add') -eq $true) { $true } Else { $false };

	$az = @{};
	$az.extension = @{};
	$az.extension.name = $Name;

	#
	# Azure CLI Extension-Management
	#			To quickly view all available AZ Cli extensions (by-name), use the command:   (JsonDecoder -InputObject (az extension list-available)).name;
	#
	# az extension
	#		--> "Manage and update CLI extensions"  :::  https://docs.microsoft.com/en-us/cli/azure/extension?view=azure-cli-latest
	#
	#	az extension list-available
	# 	--> "List all publicly available extensions"  :::  https://docs.microsoft.com/en-us/cli/azure/extension#az-extension-list-available
	#
	$CommandDescription = "Obtaining list of available Azure CLI extensions";
	
	$az.extension.available = `
		JsonDecoder -InputObject ( `
			az extension list-available --output json `
		);
	$last_exit_code = If($?){0}Else{1};

	BombOut `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']'));

	$az.extension.validname = 0;

	ForEach ($EachAvailableExt In $az.extension.available) {
		If (($az.extension.name) -eq ($EachAvailableExt.name)) {
			$az.extension.validname = 1;
			If ($EachAvailableExt.installed -eq $true) {
				If ($PSBoundParameters.ContainsKey('Quiet') -eq $false) { Write-Host (("Skip - AZ Cli extension already installed: `"")+($az.extension.name)+("`"")); }
			} Else {
				If ($AddExtension -eq $true) {
					$CommandDescription = (("Adding Azure CLI extension: ")+($az.extension.name)+(" ..."));
					If ($PSBoundParameters.ContainsKey('Quiet') -eq $false) { Write-Host (("Info: ")+($CommandDescription)+("...")); }
					#
					# Add an Azure-CLI extension
					#		--> https://docs.microsoft.com/en-us/cli/azure/extension#az-extension-add
					#
					$az.extension.add = `
						JsonDecoder -InputObject ( `
							az extension add --name ($az.extension.name) `
						);
					$last_exit_code = If($?){0}Else{1};
					BombOut `
						-ExitCode ($last_exit_code) `
						-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
						-MessageOnSuccessJSON ($az.extension.add);
				} Else {
					$CommandDescription = (("Checking for Azure CLI extension: ")+($az.extension.name)+(" ..."));
					If ($PSBoundParameters.ContainsKey('Quiet') -eq $false) { Write-Host (("Pass - ")+($CommandDescription)+("...")); }
				}
			}
		}
	}

	If (($az.extension.validname) -eq 0) {
		$CommandDescription = (("Checking for Azure CLI extension: ")+($az.extension.name)+(" ..."));
		BombOut `
			-ExitCode ($az.extension.validname) `
			-MessageOnError (('Error thrown while [')+($CommandDescription)+(']'));
	}

	# https://docs.microsoft.com/en-us/cli/azure/extension?view=azure-cli-latest

	# Azure DevOps Extension for Azure CLI --> https://docs.microsoft.com/en-us/cli/azure/ext/azure-devops
	# URL: https://github.com/Microsoft/azure-devops-cli-extension/blob/master/README.md
	# Method(s): az { artifacts, boards, devops, pipelines, repos }  https://docs.microsoft.com/en-us/cli/azure/ext/azure-devops/devops?view=azure-cli-latest

	Return $az.extension;

}

Export-ModuleMember -Function "Az_Extension";
