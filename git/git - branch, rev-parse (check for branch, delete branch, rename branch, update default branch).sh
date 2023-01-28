#!/bin/bash
# ------------------------------------------------------------
# git - branch actions (delete, rename)
# ------------------------------------------------------------
#
# List all branches
#

git branch -v -a;

# ------------------------------------------------------------
#
# Check if a branch exists
#

TEST_BRANCH="main"; if [ `git rev-parse --verify ${TEST_BRANCH} 2>/dev/null` ]; then echo "Branch \"${TEST_BRANCH}\" exists!"; else echo "Branch \"${TEST_BRANCH}\" does NOT exist"; fi;


# ------------------------------------------------------------
#
# Get current branch name
#

if [[ 1 -eq 1 ]]; then
  # Show the name of the current branch in target Git repo
  CURRENT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)";
  echo "CURRENT_BRANCH=[${CURRENT_BRANCH}]";
fi;


# ------------------------------------------------------------
#
# Switch branches by cloning a branch from the source repo
#  |
#  |--> General Syntax:
#         git checkout -b remote_branch origin/remote_branch;
#

if [[ 1 -eq 1 ]]; then
  # If current branch is not the desired branch, switch to using the desired branch, instead
  CURRENT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)";
  DESIRED_BRANCH="main";
  echo "CURRENT_BRANCH=[${CURRENT_BRANCH}]";
  echo "DESIRED_BRANCH=[${DESIRED_BRANCH}]";
  if [[ -n "${CURRENT_BRANCH}" ]] && [[ "${CURRENT_BRANCH}" != "${DESIRED_BRANCH}" ]]; then
    echo "Calling [ git checkout -b \"${DESIRED_BRANCH}\" \"origin/${DESIRED_BRANCH}\"; ]...";
    git checkout -b "${DESIRED_BRANCH}" "origin/${DESIRED_BRANCH}";
  fi;
fi;


# ------------------------------------------------------------
#
# Rename branch
#

# Rename branch, local repository
git branch -m "branch-name" "branch-name-new";

# Rename branch, remote repository
git push -u "branch-name" "branch-name-new";


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
#
# Update default branch
#

if [[ 1 -eq 1 ]]; then
  # Update the local HEAD reference (remotes/origin/HEAD)
  CURRENT_DEFAULT_BRANCH="$(git symbolic-ref --short "refs/remotes/origin/HEAD" | sed -rne "s/^\s*origin\/(\S+)\s*$/\1/p";)";
  DESIRED_DEFAULT_BRANCH="main";
  if [[ -n "${CURRENT_DEFAULT_BRANCH}" ]] && [[ "${CURRENT_DEFAULT_BRANCH}" != "${DESIRED_DEFAULT_BRANCH}" ]]; then
    echo "Calling [ git symbolic-ref \"refs/remotes/origin/HEAD\" \"refs/remotes/origin/${DESIRED_DEFAULT_BRANCH}\"; ]...";
    git symbolic-ref "refs/remotes/origin/HEAD" "refs/remotes/origin/${DESIRED_DEFAULT_BRANCH}";
  fi;
fi;

# CURRENT_DEFAULT_BRANCH="$(git branch --all | sed -rne "s/^\s*remotes\/origin\/HEAD\s*->\s*origin\/(\S+)\s*$/\1/p";)";


# ------------------------------------------------------------
#
# Delete branch
#

# Delete LOCAL branch
git branch -D "branch-name";


# Delete LOCAL branch & refs (only if it exists)
if [[ 1 -eq 1 ]]; then
  DEPRECATED_BRANCH="master";
  # Check for branch to delete
  if [ `git rev-parse --verify ${DEPRECATED_BRANCH} 2>/dev/null` ]; then
    echo "Calling [ git branch --delete --force \"${DEPRECATED_BRANCH}\"; ]...";
    git branch --delete --force "${DEPRECATED_BRANCH}";
  fi;
  # Prune - Remove nonexistent remote trackers
  git fetch --all --prune;
fi;


# Delete REMOTE branch
git push "repo-name" -v --delete "branch-name";


# Delete REMOTE branch (method 2)
#  |--> by pushing the branch as ":branch-name" (instead of "repository-name:branch-name"), git pushes a branch referring to a nonexistent source repository
#  |--> pushing a branch from a nonexistent source repository causes the branch in the pushed-to repository (if it exists) to be deleted
git push "repo-name" ":branch-name";


# ------------------------------------------------------------
#
# Note:  Safely test git commands (rename, delete, etc.) via https://try.github.io
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.gitlab.com  |  "Default branch | GitLab"  |  https://docs.gitlab.com/ee/user/project/repository/branches/default.html#update-the-default-branch-name-in-your-repository
#
#   stackoverflow.com  |  "git - How do I delete a branch without an error message if the branch does not exist? - Stack Overflow"  |  https://stackoverflow.com/a/22402618
#
#   stackoverflow.com  |  "git checkout - How do I check out a remote Git branch? - Stack Overflow"  |  https://stackoverflow.com/a/13770793
#
#   stackoverflow.com  |  "Is there a better way to find out if a local git branch exists? - Stack Overflow"  |  https://stackoverflow.com/a/28776049
#
#   stackoverflow.com  |  "How to get the current branch name in Git? - Stack Overflow"  |  https://stackoverflow.com/a/12142066
#
# ------------------------------------------------------------