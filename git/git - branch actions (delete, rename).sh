#!/bin/bash
# ------------------------------------------------------------


# Get current branch name
CHECKOUT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)";
echo "CHECKOUT_BRANCH=[ ${CHECKOUT_BRANCH} ]";


# ------------------------------------------------------------
#
# Reset current local branch to match remote (origin) branch  -->  Note that this is more effective than [ git reset --hard "HEAD"; ] as it resets the local to match the remote
#
CHECKOUT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)";
git reset --hard "origin/${CHECKOUT_BRANCH}";


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
#
# Citation(s)
#
#   stackoverflow.com  |  "How to get the current branch name in Git? - Stack Overflow"  |  https://stackoverflow.com/a/12142066
#
# ------------------------------------------------------------