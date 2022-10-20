
# Cloning a Git Repository & keeping Git-Logs & Large-File-Storage
#     --> MCavallo, 2018-11-13_17-51-25

## Start by Git Bash'ing at your base GitHub Repository directory
##   --> AKA: Open windows explorer to "%USERPROFILE%\Documents\GitHub" then right click the folder & select "Git Bash Here"

mkdir clonefolder

cd clonefolder/

# Following Guide "Mirroring a repository that contains Git Large File Storage objects"
#   from: https://help.github.com/articles/duplicating-a-repository/#mirroring-a-repository-that-contains-git-large-file-storage-objects

SOURCE_REPO="https://github.com/OWNER_SOURCE/REPO_SOURCE";

DESTINATION_REPO="https://github.com/OWNER_DEST/REPO_DEST.git";

git clone --bare ${SOURCE_REPO};

cd "./$(basename "${REPO_SOURCE}";).git";

git lfs fetch --all;

git push --mirror ${DESTINATION_REPO};

git lfs push --all ${DESTINATION_REPO};

cd ..;

rm -rf "$(basename "${REPO_SOURCE}";).git";

## End GitHub Tutorial;

cd ..;

rm -rf clonefolder;
