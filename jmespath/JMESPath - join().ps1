# ------------------------------------------------------------
# JMESPath - join()
# ------------------------------------------------------------

#
# Ex) Get all Git repos in a given DevOps project - filter & sort by Git repo name - output only the URL for each matching Git repo
#
$ORGANIZATION = (Read-Host -Prompt 'Enter the [ Azure DevOps Organization Name (not URL) ] to query');
$PROJECT = (Read-Host -Prompt 'Enter the [ Project within the Organization ] to query');
$STARTS_WITH = (Read-Host -Prompt 'Enter the [ required string which Git repos must start with (leave blank to get all repos) ]');

az repos list --organization https://dev.azure.com/${ORGANIZATION} --project "${PROJECT}" --query "[? starts_with(name,'${STARTS_WITH}') ] | sort_by([], &name) | [].{url:join('',['https://dev.azure.com/${ORGANIZATION}/${PROJECT}/_git/',name])} | [].url" --output "tsv";


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