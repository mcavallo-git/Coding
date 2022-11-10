# ------------------------------------------------------------
# Helm - List chart versions in target helm chart repository
# ------------------------------------------------------------

if [[ 1 -eq 1 ]]; then

CHART_NAME="aad-pod-identity";
CHART_NAMESPACE="kube-system";

# helm - Add a helm repository
helm repo add "${CHART_NAME}" 'https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts';

# helm - Update information of available charts locally from chart repositories
helm repo update;  # https://helm.sh/docs/helm/helm_repo_update/

# helm - Get currently deployed version
CHART_VERSION_CURRENT="$(helm list --namespace="${CHART_NAMESPACE}" --filter="${CHART_NAME}" --output="json" | jq -r ".[0].chart" | grep -v '^null$' | sed -re "s/${CHART_NAME}-//g";)";
echo "CHART_VERSION_CURRENT=[ ${CHART_VERSION_CURRENT} ]";

# helm - Get all available version
helm search repo "${CHART_NAME}/${CHART_NAME}" --version "x" --versions;

# helm - Get latest available version
CHART_VERSION_LATEST="$(helm search repo "${CHART_NAME}/${CHART_NAME}" --version "x" --output "json" | jq -r ".[0].version" | grep -v '^null$';)";
echo "CHART_VERSION_LATEST=[ ${CHART_VERSION_LATEST} ]";

# helm - Get any newer versions greater than currently deployed version
NEWER_VERSION_EXISTS="$(helm search repo "${CHART_NAME}/${CHART_NAME}" --version ">${CHART_VERSION_CURRENT}" --output="json" | jq -r ".[0].version" | grep -v '^null$';)";
echo "NEWER_VERSION_EXISTS=[ ${NEWER_VERSION_EXISTS} ]";

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   helm.sh  |  "Helm | Helm Search Repo"  |  https://helm.sh/docs/helm/helm_search_repo/
#
#   stackoverflow.com  |  "kubernetes - For a helm chart, what versions are available? - Stack Overflow"  |  https://stackoverflow.com/a/51032442
#
# ------------------------------------------------------------