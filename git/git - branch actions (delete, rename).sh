# ------------------------------------------------------------

# Rename branch, local repository
git branch -m "branch-name" "branch-name-new";

# Rename branch, remote repository
git push -u "branch-name" "branch-name-new";

# Delete branch, local repository
git branch -D "branch-name";

# Delete branch, remote repository
git push "repo-name" -v --delete "branch-name";

# Delete branch, remote repository (method 2)
#  |--> by pushing the branch as ":branch-name" (instead of "repository-name:branch-name"), git pushes a branch referring to a nonexistent source repository
#  |--> pushing a branch from a nonexistent source repository causes the branch in the pushed-to repository (if it exists) to be deleted
git push "repo-name" ":branch-name";

# Delete branch, local & remote repository (both)
git branch -D "branch-name" && git push "repo-name" -v --delete "branch-name";

# ------------------------------------------------------------

# Test git commands (rename, delete, etc.) safely @ https://try.github.io

# ------------------------------------------------------------