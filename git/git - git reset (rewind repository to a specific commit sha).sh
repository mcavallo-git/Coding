#!/bin/bash
# ------------------------------------------------------------
#
#   git-reset
#

#
# Reset current local branch to match remote (origin) branch  -->  Note that this is more effective than [ git reset --hard "HEAD"; ] as it resets the local to match the remote
#
CHECKOUT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)";
git reset --hard "origin/${CHECKOUT_BRANCH}";


# ------------------------------------------------------------
#
#   Git - Reverting a Repository to a specific Commit SHA
#                               MCavallo, 2019-06-20_11-30-59


#
# Step 1
#  |--> Pull (copy) the remote branch to local workstation
#
git fetch;
git checkout "dev-releases"; # Using branch "dev-releases" (replace with desired target-branch name)
git log --oneline --max-count 10; # Show most-recent commits --> shows first 8-chars of the 40-char SHA
git pull;


#
# Step 2 (MANUAL)
#  |--> Browse to respository's origin (usually online, such as Github.com, etc.)
#  |--> Locate desired branch to-revert
#  |--> Delete the branch (from the repository origin, NOT local workstation)
#
#
### MANUALLY PERFORMED
#


#
# Step 3
#  |--> Reset to desired Commit SHA
#
git reset --hard "01234abc";
git log --oneline --max-count 10; # Show most-recent commits



#
# Step 4
#  |--> Push the final, reverted branch back to origin. Done.
#
git push;


# ------------------------------------------------------------