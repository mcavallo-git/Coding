# ------------------------------------------------------------
# helm - List chart versions in target helm chart repository
# ------------------------------------------------------------

# Add a helm repository
helm repo add 'aad-pod-identity' 'https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts';

# helm - List all releases for a given helm chart
helm search repo "aad-pod-identity/aad-pod-identity" --versions --version "x";

# helm - Get the latest releases for a given helm chart
helm search repo "aad-pod-identity/aad-pod-identity" --version "x";

# helm - Get the version of the latest release for a given helm chart
helm search repo "aad-pod-identity/aad-pod-identity" --version "x" --output "json" | jq -r ".[].version";

# ------------------------------------------------------------
#
# Citation(s)
#
#   helm.sh  |  "Helm | Helm Search Repo"  |  https://helm.sh/docs/helm/helm_search_repo/
#
#   stackoverflow.com  |  "kubernetes - For a helm chart, what versions are available? - Stack Overflow"  |  https://stackoverflow.com/a/51032442
#
# ------------------------------------------------------------