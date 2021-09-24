# ------------------------------------------------------------


# Get Azure Managed Identities who are in any Resource Group which contains a given string
#  |--> Intended to find Managed Identities within nested AKS Clusters' Resource Groups (which contain their parent resource group in their name)
(az group list --query "sort_by[], &name) | [].name" --output "tsv") `
| ForEach-Object {
	Write-Host "------------------------------------------------------------`nListing Managed Identities in Resource Group `"${_}`"...";
	az identity list --query "[? contains(resourceGroup,'${_}')] | sort_by([], &name) | [].name" --output "tsv";
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