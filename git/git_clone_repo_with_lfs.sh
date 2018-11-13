
# Cloning a Git Repository & keeping Git-Logs & Large-File-Storage
#     --> MCavallo, 2018-11-13_17-51-25

## Start by Git Bash'ing at your base GitHub Repository directory
##   --> AKA: Open windows explorer to "%USERPROFILE%\Documents\GitHub" then right click the folder & select "Git Bash Here"

mkdir clonefolder

cd clonefolder/

# Following Guide "Mirroring a repository that contains Git Large File Storage objects"
#   from: https://help.github.com/articles/duplicating-a-repository/#mirroring-a-repository-that-contains-git-large-file-storage-objects

git clone --bare https://github.com/bonealnet/boneal_github

cd boneal_github.git

git lfs fetch --all

git push --mirror https://github.com/bonealnet/supplier_gateway.git

git lfs push --all https://github.com/bonealnet/supplier_gateway.git

cd ..
rm -rf boneal_github.git

## End GitHub Tutorial

cd ..

rm -rf clonefolder
