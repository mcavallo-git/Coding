#!/bin/sh
# ------------------------------------------------------------
# Cloning a Git Repository & keeping Git-Logs & Large-File-Storage
# ------------------------------------------------------------

SOURCE_REPO="https://github.com/OWNER_SOURCE/REPO_SOURCE";

DESTINATION_REPO="https://github.com/OWNER_DEST/REPO_DEST.git";

mkdir "${HOME}/temp_mirror_dir";

cd "${HOME}/temp_mirror_dir";

git clone --bare ${SOURCE_REPO};

cd "./$(basename "${REPO_SOURCE}";).git";

git lfs fetch --all;

git push --mirror ${DESTINATION_REPO};

git lfs push --all ${DESTINATION_REPO};

cd ..;

rm -rf "$(basename "${REPO_SOURCE}";).git";

## End GitHub Tutorial;

cd ..;

rm -rf "${HOME}/temp_mirror_dir";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.github.com  |  "Duplicating a repository - GitHub Docs"  |  https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository#mirroring-a-repository-that-contains-git-large-file-storage-objects
#
# ------------------------------------------------------------