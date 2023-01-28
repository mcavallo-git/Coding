#!/bin/bash
# ------------------------------------------------------------
# git - branch actions (delete, rename)
# ------------------------------------------------------------

if [[ 1 -eq 1 ]]; then
  # Get current branch name
  CURRENT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)";
  echo "CURRENT_BRANCH=[${CURRENT_BRANCH}]";
fi;


# ------------------------------------------------------------
#
# Switch branches by cloning a branch from the source repo
#


# General Syntax:
git checkout -b remote_branch origin/remote_branch;


if [[ 1 -eq 1 ]]; then
  # If current branch is not the desired branch, switch to using the desired branch, instead
  CURRENT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)";
  DESIRED_BRANCH="main";
  echo "CURRENT_BRANCH=[${CURRENT_BRANCH}]";
  echo "DESIRED_BRANCH=[${DESIRED_BRANCH}]";
  if [[ -n "${CURRENT_BRANCH}" ]] && [[ "${CURRENT_BRANCH}" != "${DESIRED_BRANCH}" ]]; then
    echo "Calling [ git reset --hard \"origin/${LOCAL_BRANCH_TO_RESET}\"; ]...";
    git checkout -b "${DESIRED_BRANCH}" "origin/${DESIRED_BRANCH}";
  fi;
fi;


# ------------------------------------------------------------
#
# Reset current local branch to match remote (origin) branch  -->  Note that this is more effective than [ git reset --hard "HEAD"; ] as it resets the local to match the remote
#
if [[ 1 -eq 1 ]]; then
  LOCAL_BRANCH_TO_RESET="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)";
  echo "Calling [ git reset --hard \"origin/${LOCAL_BRANCH_TO_RESET}\"; ]...";
  git reset --hard "origin/${LOCAL_BRANCH_TO_RESET}";
fi;


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
#   stackoverflow.com  |  "git checkout - How do I check out a remote Git branch? - Stack Overflow"  |  https://stackoverflow.com/a/13770793
#
#   stackoverflow.com  |  "How to get the current branch name in Git? - Stack Overflow"  |  https://stackoverflow.com/a/12142066
#
# ------------------------------------------------------------