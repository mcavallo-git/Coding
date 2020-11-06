#!/bin/bash


# Step 1: From your project repository, check out a new branch and test the changes.

# 1. Checkout local branch
git checkout -b TempBranchName master;

# 2. Pull target repo + branch OVER local branch
git pull https://github.com/SmartThingsCommunity/SmartThingsPublic.git master;

# 3. Resolve merge conflicts using Tortoise Git

# 4. Push branch to remote server/repository-host (GitHub, BitBucket etc.)

# 5. Create a pull request to merge the middleman branch ("TempBranchName" in this example) into the desired/target branch (master, usually)

# 6. Complete the merge request by merging the code, then delete the temporary middleman branch ("TempBranchName" in this example)


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.github.com  |  "Syncing a fork - GitHub Docs"  |  https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/syncing-a-fork
#
# ------------------------------------------------------------