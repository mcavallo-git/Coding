# ------------------------------------------------------------


# Azure CLI (Az CLI) - Check if a Service Principal matching a given name exists & create it if it doesn't already exist

$SERVICE_PRINCIPAL_NAME="SERVICE_PRINCIPAL_NAME";
If (([Int32](az ad sp list --display-name "${SERVICE_PRINCIPAL_NAME}" --query "[].displayName | length(@)" --output "tsv")) -Eq 0) {
	# Service Principal not found - Create it
	az ad sp create-for-rbac --name "${SERVICE_PRINCIPAL_NAME}" --skip-assignment "true";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "json - Count the numer of instance in an array using JMESPath - Stack Overflow"  |  https://stackoverflow.com/a/39162262
#
# ------------------------------------------------------------