# ------------------------------------------------------------
# JMESPath - equals (==) comparisons
# ------------------------------------------------------------


#
# Match objects within an array using:
#    1 equals "==" conditional
#
az extension list --query "[? name=='${EXTENSION_NAME}' ].version" --output "tsv";  # Match local extensions by name


#
# Match objects within an array using:
#    1 equals "==" conditional
#  + 1 ends_width(...) conditional
#
az aks pod-identity list --cluster-name "${AKS_NAME}" --resource-group "${RESOURCE_GROUP}" --query "podIdentityProfile.userAssignedIdentities[? namespace=='${NAMESPACE}' && ends_with(identity.resourceId, '/${MANAGED_IDENTITY_NAME}')].identity.resourceId" --output "tsv";  # Match AKS Pod Identities by Namespace & Identity Name (ends with)


#
# Match objects within an array using:
#    1 equals "==" conditional
#
az identity list --subscription "${SUBSCRIPTION_ID}" --query "[? name=='${IDENTITY_NAME}'].id" --output "tsv";  # Match Managed Identities by name


#
# Match objects within an array using:
#    1 equals "==" conditional
#
# Then with the matched items:
#    Get the first item matched
#
az resource show --name "${AKS_NAME}" --resource-group "${RESOURCE_GROUP}" --resource-type "${AKS_RESOURCE_TYPE}" --query "properties.agentPoolProfiles[?mode=='System'] | [0].name" --output "tsv";  # Match AKS Nodepools in "System" mode


#
# Match objects within an array using:
#    3 equals "==" conditionals
#
az role assignment list --all --query "[?principalId=='${IDENTITY_ID}' && roleDefinitionName=='${EACH_ROLE}' && scope=='${SCOPE}'].id" --output "tsv";  # Match RBAC assignments against Identity, Role & Scope


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