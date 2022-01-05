if [[ 1 -eq 1 ]]; then

MANFILE="${HOME}/man/helm.help.man";
NEWDOCS="\n------------------------------------------------------------\n";

helm --help > "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm completion --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm completion bash --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm completion fish --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm completion powershell --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm completion zsh --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm create --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm dependency --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm dependency build --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm dependency list --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm dependency update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm env --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm get --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm get all --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm get hooks --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm get manifest --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm get notes --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm get values --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm help --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm history --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm install --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm lint --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm list --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm package --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm plugin --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm plugin install --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm plugin list --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm plugin uninstall --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm plugin update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm pull --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm repo --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm repo add --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm repo index --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm repo list --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm repo remove --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm repo update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm rollback --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm search --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm search hub --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm search repo --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm show --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm show all --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm show chart --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm show crds --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm show readme --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm show values --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

helm status --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm template --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm test --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm uninstall --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm upgrade --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm verify --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
helm version --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

fi;