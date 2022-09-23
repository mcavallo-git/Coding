# ------------------------------------------------------------
# JMESPath - equals (==) comparisons
# ------------------------------------------------------------


#
# Ex) Get the version of local extension(s) matching a given name
#
az extension list --query "[? name=='${EXTENSION_NAME}' ].version" --output "tsv";


#
# Ex) Get AKS Pod Managed Identities matching a given namespace & ending with a given substring
#
az aks pod-identity list --cluster-name "${AKS_NAME}" --resource-group "${RESOURCE_GROUP}" --query "podIdentityProfile.userAssignedIdentities[? namespace=='${NAMESPACE}' && ends_with(identity.resourceId, '/${MANAGED_IDENTITY_NAME}')].identity.resourceId" --output "tsv";


#
# Ex) Get Managed Identities matching a given name
#
az identity list --subscription "${SUBSCRIPTION_ID}" --query "[? name=='${IDENTITY_NAME}'].id" --output "tsv";


#
# Ex) Get AKS nodepools matching a given mode ("System", in this case)
#
az resource show --name "${AKS_NAME}" --resource-group "${RESOURCE_GROUP}" --resource-type "${AKS_RESOURCE_TYPE}" --query "properties.agentPoolProfiles[?mode=='System'] | [0].name" --output "tsv";

#
# Ex) Get RBAC assignments matching a given Identity ID, Role Name, & Scope
#
az role assignment list --all --query "[?principalId=='${IDENTITY_ID}' && roleDefinitionName=='${EACH_ROLE}' && scope=='${SCOPE}'].id" --output "tsv";


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