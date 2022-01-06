# ------------------------------
# JMESPath - get multiple properties at once
# ------------------------------


# JMESPath - Get 3 properties from output JSON at once (ID, Name & URL) - Approach 1 (outputs an object)
$DEVOPS_ORG_URL="https://dev.azure.com/COMPANY_NAME";
$DEVOPS_PROJECT="PROJECT_NAME";
az devops project show --project "${DEVOPS_PROJECT}" --organization "${DEVOPS_ORG_URL}" --query "{id:id,name:name,url:url}";


# JMESPath - Get 3 properties from output JSON at once (ID, Name & URL) - Approach A (outputs an array)
$DEVOPS_ORG_URL="https://dev.azure.com/COMPANY_NAME";
$DEVOPS_PROJECT="PROJECT_NAME";
az devops project show --project "${DEVOPS_PROJECT}" --organization "${DEVOPS_ORG_URL}" --query "[id,name,url]";


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
#   stackoverflow.com  |  "azure cli - AZ CLI query filter on multiple properties using && - Stack Overflow"  |  https://stackoverflow.com/questions/61237873/az-cli-query-filter-on-multiple-properties-using
#
# ------------------------------------------------------------