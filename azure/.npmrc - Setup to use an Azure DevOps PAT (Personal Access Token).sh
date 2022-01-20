#!/bin/bash
# ------------------------------------------------------------
# .npmrc - Setup to use an Azure DevOps PAT (Personal Access Token)
# ------------------------------------------------------------

if [[ 1 -eq 1 ]]; then
READ_TIMEOUT=60;
echo ""; echo ""; read -p "Paste your PAT (Personal Access Token) which has Packaging read & write scopes, then press 'Enter':  " -s -a PAT_TOKEN_PLAINTEXT -t ${READ_TIMEOUT} <'/dev/tty'; EXIT_CODE=${?};
echo "";
if [[ "${EXIT_CODE}" -gt 128 ]]; then
echo "Error:  Response timed out after ${READ_TIMEOUT}s";
elif [[ -z "${PAT_TOKEN_PLAINTEXT}" ]]; then
echo "Error:  Empty response received";
else
ORGANIZATION_NAME="softprocorp";
PROJECT_NAME="SaaS";
ARTIFACT_FEED="SoftPro-SaaS-Private";
PAT_TOKEN_BASE64=$(echo -n ${PAT_TOKEN_PLAINTEXT} | base64 --wrap=0;);
OUTFILE="${HOME}/.npmrc";
if [[ -f "${OUTFILE}" ]]; then
mv -fv "${OUTFILE}" "${OUTFILE}.$(date +'%Y%m%dT%H%M%S';).bak";
fi;
unset NPMRC_ARR; declare -a NPMRC_ARR;
NPMRC_ARR=();
NPMRC_ARR+=("");
NPMRC_ARR+=("//pkgs.dev.azure.com/${ORGANIZATION_NAME}/${PROJECT_NAME}/_packaging/${ARTIFACT_FEED}/npm/registry/:username=VssSessionToken");
NPMRC_ARR+=("//${ORGANIZATION_NAME}.pkgs.visualstudio.com/${PROJECT_NAME}/_packaging/${ARTIFACT_FEED}/npm/registry/:username=VssSessionToken");
NPMRC_ARR+=("");
NPMRC_ARR+=("; This is an unencrypted authentication token. Treat it like a password. DO NOT share this value with anyone, including Microsoft support.");
NPMRC_ARR+=("//pkgs.dev.azure.com/${ORGANIZATION_NAME}/${PROJECT_NAME}/_packaging/${ARTIFACT_FEED}/npm/registry/:_password=${PAT_TOKEN_BASE64}");
NPMRC_ARR+=("//${ORGANIZATION_NAME}.pkgs.visualstudio.com/${PROJECT_NAME}/_packaging/${ARTIFACT_FEED}/npm/registry/:_password=${PAT_TOKEN_BASE64}");
NPMRC_ARR+=("");
NPMRC_ARR+=("; The npm client won't use username and _password without an email set, but the service doesn't use the email value. The following is an arbitrarily made-up address.");
NPMRC_ARR+=("//pkgs.dev.azure.com/${ORGANIZATION_NAME}/${PROJECT_NAME}/_packaging/${ARTIFACT_FEED}/npm/registry/:email=not-used@example.com");
NPMRC_ARR+=("//${ORGANIZATION_NAME}.pkgs.visualstudio.com/${PROJECT_NAME}/_packaging/${ARTIFACT_FEED}/npm/registry/:email=not-used@example.com");
NPMRC_ARR+=("");
for EACH_LINE in "${NPMRC_ARR[@]}"; do
echo "${EACH_LINE}" >> "${OUTFILE}";
done;
echo ""; echo "Created .npmrc file with PAT token at filepath \"${OUTFILE}\""; echo "";
fi;
PAT_TOKEN_PLAINTEXT="";
PAT_TOKEN_BASE64="";
fi;
