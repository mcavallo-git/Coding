# ------------------------------------------------------------
# JMESPath - contains()
# ------------------------------------------------------------

#
# Ex)  Get Azure Managed Identities who are in any Resource Group which contains a given string
#       |--> Managed Identities within nested AKS Cluster Resource Groups (which contain their parent Resource Group in their name)
#
(az group list --query "sort_by[], &name) | [].name" --output "tsv") `
| ForEach-Object {
	Write-Host "------------------------------------------------------------`nListing Managed Identities in Resource Group `"${_}`"...";
	az identity list --query "[? contains(resourceGroup,'${_}')] | sort_by([], &name) | [].name" --output "tsv";
}


#
# Ex)  Get Azure IPv4 Ranges
#
IPV4_ADDRESSES="$(az network list-service-tags --location "eastus2" --output "tsv" --query "values[? name=='AzureCloud.eastus2'].properties.addressPrefixes[] | [? ! contains(@,'::')]";)"; echo "${IPV4_ADDRESSES}";


#
# Ex)  Get Azure IPv6 Ranges
#
IPV6_ADDRESSES="$(az network list-service-tags --location "eastus2" --output "tsv" --query "values[? name=='AzureCloud.eastus2'].properties.addressPrefixes[] | [? contains(@,'::')]";)"; echo "${IPV6_ADDRESSES}";


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