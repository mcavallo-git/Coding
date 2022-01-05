if [[ 1 -eq 1 ]]; then

MANFILE="${HOME}/man/flux.help.man";
NEWDOCS="\n------------------------------------------------------------\n";

flux --help > "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux bootstrap --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux bootstrap git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux bootstrap github --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux bootstrap gitlab --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux check --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux completion --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux completion bash --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux completion fish --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux completion powershell --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux completion zsh --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux create --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create alert --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create alert-provider --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create helmrelease --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux create image --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create image policy --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create image repository --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create image update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux create kustomization --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create receiver --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create secret --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create secret git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create secret helm --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create secret tls --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux create source --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create source bucket --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create source git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux create source helm --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux create tenant --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux delete --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete alert --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete alert-provider --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete helmrelease --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux delete image --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete image policy --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete image repository --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete image update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux delete kustomization --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete receiver --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux delete source --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete source bucket --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete source git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux delete source helm --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux export --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export alert --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export alert-provider --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export helmrelease --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux export image --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export image policy --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export image repository --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export image update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux export kustomization --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export receiver --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux export source --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export source bucket --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export source git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux export source helm --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux get --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get alert-providers --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get alerts --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get all --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get helmreleases --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux get images --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get images all --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get images policy --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get images repository --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get images update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux get kustomizations --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get receivers --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux get sources --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get sources all --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get sources bucket --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get sources chart --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get sources git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux get sources helm --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux help --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux install --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux logs --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile alert --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile alert-provider --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile helmrelease --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux reconcile image --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile image repository --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile image update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux reconcile kustomization --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile receiver --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux reconcile source --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile source bucket --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile source git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux reconcile source helm --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux resume --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume alert --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume helmrelease --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume image --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume kustomization --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume receiver --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume source --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume source bucket --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume source chart --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume source git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux resume source helm --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux suspend --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend alert --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend helmrelease --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux suspend image --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend image repository --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend image update --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux suspend kustomization --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend receiver --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend source --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend source bucket --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend source chart --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend source git --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux suspend source helm --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux trace --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux tree --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux tree kustomization --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

flux uninstall --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";
flux version --help >> "${MANFILE}";     echo -e "${NEWDOCS}" >> "${MANFILE}";

fi;