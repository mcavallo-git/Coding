
## Mass-delete Resource Groups (which were created iteratively during testing/development)
function Az_Group_BulkDelete {
	Param(

		[Parameter(Mandatory=$true)]
		[string]$StartingWith,
		
		[switch]$Silent

	)

	# Walk through the list of resource groups
	$az_group_list = az group list | ConvertFrom-Json;
	For ($i=0; $i -lt $az_group_list.Count; $i++) {
		
		If (!($PSBoundParameters.ContainsKey("Silent"))) {
			Write-Host (("`n`naz_group_list[")+($i)+("]")); 
		}

		# Determine if the current Resource Group's name contains the user-defined string
		$rg_name = (($az_group_list[$i]).name);
		If (($rg_name.StartsWith($StartingWith)) -eq $true) {

			If (!($PSBoundParameters.ContainsKey("Silent"))) {
				Write-Host (("Deleting resource group with name '")+($rg_name)+("'"));
			}

			# Remove matching resource groups
			az group delete --name ($rg_name) --yes --no-wait;

		} Else {

			If (!($PSBoundParameters.ContainsKey("Silent"))) {
				Write-Host (("Deleting resource group with name '")+($rg_name)+("'"));
			}

		}
	}

	If (!($PSBoundParameters.ContainsKey("Silent"))) {
		Write-Host "`n`n";
	}

}

Export-ModuleMember -Function "Az_Group_BulkDelete";
