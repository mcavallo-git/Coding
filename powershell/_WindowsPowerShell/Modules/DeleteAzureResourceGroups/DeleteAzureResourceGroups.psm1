#
#	Example use:
#
#		DeleteAzureResourceGroups -StartingWith "bis-20190326"
#
function DeleteAzureResourceGroups {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$StartingWith,
		
		[Switch]$Quiet

	)
	
	## Mass-delete Resource Groups which share a common string in their name (to target resource groups created en-masse during testing/development)
	Write-Host "`n";
	if ($StartingWith.length -gt 4) {

		$GroupsToDelete=@();

		# Walk through the list of resource groups
		$az_group_list = az group list | ConvertFrom-Json;
		For ($i=0; $i -lt $az_group_list.Count; $i++) {

			# Determine if the current Resource Group's name contains the user-defined string
			$Each_ResourceGroupName = (($az_group_list[$i]).name).ToLower();

			$DoNotDelete_ResourceGroupNames=@();
			$DoNotDelete_ResourceGroupNames += "bis-azurebus-sandbox".ToLower();
			$DoNotDelete_ResourceGroupNames += "bis-static-resourcegroup".ToLower();
			$DoNotDelete_ResourceGroupNames += "bnet-uat".ToLower();
			$DoNotDelete_ResourceGroupNames += "bonedge-qa-gateway".ToLower();
			$DoNotDelete_ResourceGroupNames += "bonedge-qa-rg".ToLower();
			$DoNotDelete_ResourceGroupNames += "bonedge-uat-rg".ToLower();
			$DoNotDelete_ResourceGroupNames += "DefaultResourceGroup-EUS".ToLower();
			$DoNotDelete_ResourceGroupNames += "NetworkWatcherRG".ToLower();

			# Current item must be a match and must not be on the blacklist

			If (($DoNotDelete_ResourceGroupNames.Contains($Each_ResourceGroupName)) -eq $true) {
				# Current item IS a match and IS restricted
				Write-Host (("Skipping Resource Group (Permanent) '")+($Each_ResourceGroupName)+("'"));

			} ElseIf (($Each_ResourceGroupName.StartsWith($StartingWith)) -eq $true) {
				# Current item IS a match and is NOT restricted
				$GroupsToDelete += ($Each_ResourceGroupName);

			} Else {
				# Current item is NOT a match
				If (!($PSBoundParameters.ContainsKey("Quiet"))) { Write-Host (("Skipping Resource Group (name doesn't start with given string) '")+($Each_ResourceGroupName)+("'")); }

			}

		}

		# If any Matches were found
		If ($GroupsToDelete.Length -gt 0) {
			If (!($PSBoundParameters.ContainsKey("Quiet"))) { Write-Host "`n"; }

			ForEach ($EachRgToDelete In $GroupsToDelete) {
				Write-Host (("DELETE Resource Group  `"")+($EachRgToDelete)+("`""));
			}
			If (!($PSBoundParameters.ContainsKey("Quiet"))) { Write-Host "`n"; }

			# First Confirmation step
			$ConfirmKeyList = "abcdefghijklmopqrstuvwxyz"; # removed 'n'
			$FirstConfirmKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList));
			Write-Host -NoNewLine ("Are you sure you want to delete the resource group(s)?") -BackgroundColor Black -ForegroundColor Yellow;
			Write-Host -NoNewLine ("  To confirm, type the letter [ ") -ForegroundColor Yellow;
			Write-Host -NoNewLine ($FirstConfirmKey) -ForegroundColor Green;
			Write-Host -NoNewLine (" ]:  ") -ForegroundColor Yellow;
			$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); Write-Host (($UserKeyPress.Character)+("`n"));
			If (($UserKeyPress.Character) -eq ($FirstConfirmKey)) {

				# Second Confirmation step (since we're deleting credentials)
				$SecondConfirmKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList.Replace([string]$FirstConfirmKey,"")));
				Write-Host -NoNewLine ("Really really sure?") -BackgroundColor Black -ForegroundColor Yellow;
				Write-Host -NoNewLine ("  To confirm, type the letter [ ") -ForegroundColor Yellow;
				Write-Host -NoNewLine ($SecondConfirmKey) -ForegroundColor Green;
				Write-Host -NoNewLine (" ]:  ") -ForegroundColor Yellow;
				$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
				Write-Host (($UserKeyPress.Character)+("`n"));
				If (($UserKeyPress.Character) -eq ($SecondConfirmKey)) {
				ForEach ($EachRgToDelete In $GroupsToDelete) {
					If (!($PSBoundParameters.ContainsKey("Quiet"))) { Write-Host (("Deleting resource group '")+($EachRgToDelete)+("'...")) -BackgroundColor Black -ForegroundColor Red; }
					az group delete --name ($EachRgToDelete) --yes --no-wait; # Delete the Resource Groups
				}

				} Else {
					If (!($PSBoundParameters.ContainsKey("Quiet"))) { Write-Host "No Action Taken" -BackgroundColor Black -ForegroundColor Green; }
				}
			} Else {
				If (!($PSBoundParameters.ContainsKey("Quiet"))) { Write-Host "No Action Taken" -BackgroundColor Black -ForegroundColor Green; }
			}
		}
		If (!($PSBoundParameters.ContainsKey("Quiet"))) {
			Write-Host "`n";
		}

	}

}

Export-ModuleMember -Function "DeleteAzureResourceGroups";
