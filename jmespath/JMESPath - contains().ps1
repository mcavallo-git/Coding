# ------------------------------------------------------------


# Get Azure Managed Identities who are in any Resource Group which contains a given string (used for finding identities within nested AKS Cluster Resource Groups, which contain the name of the AKS Cluster's Resource Group concatenated within their sub/node Resource Group name)
$ALL_RESOURCE_GROUPS=(az group list --query "sort_by[], &name) | [].name" --output "tsv");
$ALL_RESOURCE_GROUPS | ForEach-Object {
	Write-Host "------------------------------------------------------------";
	Write-Host "Listing Managed Identities in Resource Group `"${_}`"...";
	az identity list --query "[? contains(resourceGroup,'${_}')] | sort_by([], &name) | [].name" --output "tsv";
	Write-Host "";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   jmespath.org  |  "JMESPath Examples — JMESPath"  |  https://jmespath.org/examples.html
#
#   jmespath.org  |  "JMESPath Specification — JMESPath"  |  https://jmespath.org/specification.html
#
#   jmespath.org  |  "JMESPath Tester/Tutorial"  |  https://jmespath.org/tutorial.html
#
# ------------------------------------------------------------