# ------------------------------------------------------------
#
# az repos policy list
#

$ORGANIZATION = (Read-Host -Prompt 'Enter the [ Azure DevOps Organization Name (not URL) ] to query');
$PROJECT = (Read-Host -Prompt 'Enter the [ Project within the Organization ] to query');

# Get a list of all repositories in a project, sorted by name
az repos list --organization https://dev.azure.com/${ORGANIZATION} --project "${PROJECT}" --query "[] | sort_by(@, &name) | [].name" --output "tsv";


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "az repos policy"  |  https://learn.microsoft.com/en-us/cli/azure/repos/policy
#
# ------------------------------------------------------------