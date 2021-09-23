# ------------------------------------------------------------


# Get all Azure RBAC custom role definitions
az role definition list --custom-role-only "true" --query "[] | sort_by(@, &roleName)";


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