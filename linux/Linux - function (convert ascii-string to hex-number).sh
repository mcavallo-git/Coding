#!/bin/bash
# ------------------------------------------------------------
#
#   convert_branch_name_to_hex  -  funtion which converts a branch name (ascii string) to its hexadecimal equivalent (excluding refs)
#
convert_branch_name_to_hex() {
  local BRANCH_NAME="${1}";
  local BRANCH_HEX="";
  if [[ -n "${BRANCH_NAME}" ]]; then
    local HEX_CONCAT="";
    local EACH_HEX_SLASH_NAME="";
    local BRANCH_REF="$(echo -n "${BRANCH_NAME}" | sed -rne "s/^(refs\/[^\/]+\/)?(.+)?/\1/gp";)";
    local BRANCH_REMAINDER="$(echo -n "${BRANCH_NAME}" | sed -rne "s/^(refs\/[^\/]+\/)?(.+)?/\2/gp";)";
    for EACH_BRANCH_SLASH_NAME in $(echo ${BRANCH_REMAINDER} | sed "s/\// /g"); do
      if [[ -n "${HEX_CONCAT}" ]]; then
        HEX_CONCAT="${HEX_CONCAT}/";
      fi;
      EACH_HEX_SLASH_NAME="$(echo -n "${EACH_BRANCH_SLASH_NAME}" | od -A n -t x1 | sed -rne "s/\s*([a-f0-9]{2,})\s*/\100/gp";)";
      HEX_CONCAT="${HEX_CONCAT}${EACH_HEX_SLASH_NAME}";
    done;
    # Concatenate the ref-string and the hex-number values together
    if [[ -n "${HEX_CONCAT}" ]]; then
      # If no ref was given, assume that 'refs/heads/' was intended to be used
      if [[ -z "${BRANCH_REF}" ]]; then
        BRANCH_REF="refs/heads/";
      fi;
      BRANCH_HEX="${BRANCH_REF}${HEX_CONCAT}";
    fi;
  fi;
  echo -n "${BRANCH_HEX}";
}


#
#   get_repo_security_token  -  funtion which outputs an ADO repo security token (unique target/id) given a project id, repository id, and branch name (optional)
#
get_repo_security_token() {
  local PROJ_ID="${1}";
  local REPO_ID="${2}";
  local BRANCH_HEX="$(convert_branch_name_to_hex "${3}";)";
  # Concatenate the project+repo together to get the "Security Token" (repo/branch target to apply permissions onto)
  local RETURNED_SECURITY_TOKEN="repoV2/${PROJ_ID}/${REPO_ID}";
  if [[ -n "${BRANCH_HEX}" ]]; then
    # Append the branch hex onto the token (if not empty)
    RETURNED_SECURITY_TOKEN="${RETURNED_SECURITY_TOKEN}/${BRANCH_HEX}";
  fi;
  echo -n "${RETURNED_SECURITY_TOKEN}";
};


#
# Set ADO top-level info
#

DEVOPS_ORG="${DEVOPS_ORG}";
DEVOPS_PROJECT="${DEVOPS_PROJECT}";
REPOSITORY_NAME="${REPOSITORY_NAME}";
GROUP_NAME="${GROUP_NAME}";
GROUP_ALLOW_BIT=$((2+16384));  # https://learn.microsoft.com/en-us/azure/devops/organizations/security/namespace-reference


# Parse DevOps info
DEVOPS_ORG_URL="https://dev.azure.com/${DEVOPS_ORG}";

PROJECT_ID="$(az devops project show --project "${DEVOPS_PROJECT}" --organization "${DEVOPS_ORG_URL}" --query "id" --output "tsv";)";

REPOSITORY_ID="$(az repos show --organization "${DEVOPS_ORG_URL}" --project "${DEVOPS_PROJECT}" --repository "${REPOSITOY_NAME}" --query "id" --output "tsv";)";

GROUP_DESCRIPTOR="$(az devops security group list --organization "${DEVOPS_ORG_URL}" --project "${DEVOPS_PROJECT}" --scope "project" --query "graphGroups | [? principalName=='[${DEVOPS_PROJECT}]\\${GROUP_NAME}' ].descriptor" --output "tsv";)";

SECURITY_TOKEN="$(get_repo_security_token "${PROJECT_ID}" "${REPOSITORY_ID}")";

echo "SECURITY_TOKEN=[${SECURITY_TOKEN}]";

# Update permission group permissions on devops repo
ACL_NAMESPACE_GIT_REPOS="2e9eb7ed-3c0a-47d4-87c1-0ffdd275fd87";
az devops security permission update --organization "${DEVOPS_ORG_URL}" --id "${ACL_NAMESPACE_GIT_REPOS}" --subject "${GROUP_DESCRIPTOR}" --token "${SECURITY_TOKEN}" --allow-bit ${GROUP_ALLOW_BIT} --merge true;        


# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "[Feature Request] Support enable/disable inheritence for Security permissions · Issue #848 · Azure/azure-devops-cli-extension · GitHub"  |  https://github.com/Azure/azure-devops-cli-extension/issues/848
#
#   learn.microsoft.com  |  "az devops security group | Microsoft Learn"  |  https://learn.microsoft.com/en-us/cli/azure/devops/security/group
#
#   learn.microsoft.com  |  "az devops security permission | Microsoft Learn"  |  https://learn.microsoft.com/en-us/cli/azure/devops/security/permission?view=azure-cli-latest#az-devops-security-permission-update
#
#   learn.microsoft.com  |  "az repos | Microsoft Learn"  |  https://learn.microsoft.com/en-us/cli/azure/repos
#
#   learn.microsoft.com  |  "Namespace reference - Azure DevOps | Microsoft Learn"  |  https://learn.microsoft.com/en-us/azure/devops/organizations/security/namespace-reference
#
#   stackoverflow.com  |  "Repo-level security permissions using az devops CLI? - Stack Overflow"  |  https://stackoverflow.com/a/72402767
#
# ------------------------------------------------------------