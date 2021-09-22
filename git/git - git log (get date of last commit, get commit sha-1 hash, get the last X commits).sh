#!/bin/bash
# ------------------------------------------------------------

BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD;)";  echo "BRANCH_NAME=[${BRANCH_NAME}]";

COMMIT_HASH="$(git rev-parse HEAD;)";  echo "COMMIT_HASH=[${COMMIT_HASH}]";

COMMIT_TIMESTAMP="$(git log -1 --format="%h %ad" --date=format:'%Y-%m-%d %H:%M:%S';)";  echo "COMMIT_TIMESTAMP=[${COMMIT_TIMESTAMP}]";


# ------------------------------------------------------------

# Get the last 10 commits
git log --oneline --max-count 10;


# ------------------------------------------------------------
