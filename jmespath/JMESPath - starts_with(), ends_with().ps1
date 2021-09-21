# ------------------------------------------------------------


<# Azure CLI (Az CLI) - Check if a Service Principal matching a given name exists & create it if it doesn't already exist #>

$RESOURCE_GROUP="___";

$FEATURE_NAME="EnablePodIdentityPreview";

$FEATURE_NAMESPACE="Microsoft.ContainerService";

$SUBSCRIPTION_ID = (((az group show --name "${RESOURCE_GROUP}" --query "id" --output "tsv") -split "/")[2]);

<# JMESPath - starts_with() && ends_with() #>
$POD_IDENTITY_PREVIEW_ENABLED=(az feature list --query "[? starts_with(id,'/subscriptions/${SUBSCRIPTION_ID}/') && ends_with(id,'/${FEATURE_NAME}')]");

$POD_IDENTITY_PREVIEW_ENABLED=(az feature list --subscription "${SUBSCRIPTION_ID}" --query "[? name=='${FEATURE_NAMESPACE}/${FEATURE_NAME}' ]");


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
