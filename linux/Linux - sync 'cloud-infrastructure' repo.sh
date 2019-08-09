#!/bin/bash

GIT_URL="https://github.com/mcavallo-git/cloud-infrastructure.git";

GIT_WORKINGTREE="${HOME}/Documents/GitHub/cloud-infrastructure/";

if [ ! -d "${GIT_WORKINGTREE}" ]; then
	cd $(dirname "${GIT_WORKINGTREE}");
	git clone "https://github.com/mcavallo-git/cloud-infrastructure.git";
fi;

cd "${GIT_WORKINGTREE}" && \
git fetch && \
git reset --hard "origin/master" && \
git pull && \
DO_UPD="${GIT_WORKINGTREE}/usr/local/sbin/update_bins_from_sftp" && \
sudo chmod 755 "${DO_UPD}" && \
sudo "${DO_UPD}";
