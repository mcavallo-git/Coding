#!/bin/bash

GIT_URL="https://github.com/mcavallo-git/cloud-infrastructure.git";

# Ensure the (GitHub) Repos directory exists
DOCS_GITHUB="${HOME}/Documents/GitHub/";
if [ ! -d "${DOCS_GITHUB}" ]; then
	mkdir "${DOCS_GITHUB}";
fi;

# Clone the repo if it hasn't been synced, yet
GIT_WORKTREE="${DOCS_GITHUB}/cloud-infrastructure/";
if [ ! -d "${GIT_WORKTREE}" ]; then
	cd "${DOCS_GITHUB}" && \
	git clone "${GIT_URL}";
fi;

# Sync local workstation's commands with the repo's commands
cd "${GIT_WORKTREE}" && \
git fetch && \
git reset --hard "origin/master" && \
git pull && \
DO_UPD="${GIT_WORKTREE}/usr/local/sbin/update_from_git_repo" && \
sudo chmod 755 "${DO_UPD}" && \
sudo "${DO_UPD}";
