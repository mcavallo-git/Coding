#!/bin/bash

# ------------------------------------------------------------

GIT_USER_NAME="FirstName LastName";
git config --global user.name "${GIT_USER_NAME}";

# Repositories  :::  Personal
PERSONAL_GIT_SSH="ssh -i ~/.ssh/github.personal-login-username.timecreated.pem"; # Add -vvv for extra verbosity
PERSONAL_GIT_EMAIL="personal.email@gmail.com";
cd "${HOME}/Documents/GitHub/personal-repo-1"; git config core.sshcommand "${PERSONAL_GIT_SSH}"; git config user.email "${PERSONAL_GIT_EMAIL}";
cd "${HOME}/Documents/GitHub/personal-repo-2"; git config core.sshcommand "${PERSONAL_GIT_SSH}"; git config user.email "${PERSONAL_GIT_EMAIL}";

# Repositories  :::  Work
WORK_GIT_SSH="ssh -i ~/.ssh/git/github.work-login-username.timecreated.pem"; # Add -vvv for extra verbosity
WORK_GIT_EMAIL="work.email@gmail.com";
cd "${HOME}/Documents/GitHub/work-repo-1"; git config core.sshcommand "${WORK_GIT_SSH}"; git config user.email "${WORK_GIT_EMAIL}";
cd "${HOME}/Documents/GitHub/work-repo-2"; git config core.sshcommand "${WORK_GIT_SSH}"; git config user.email "${WORK_GIT_EMAIL}";

# ------------------------------------------------------------

git config "remote.origin.url"; # <-- make sure to use ssh-syntax'ed remote-urls, e.g. "git@github.com:owner-name/repo-name.git"

# Note: changing from https-urls to ssh-urls is simple - just replace the schema component at the start, e.g. replace "https://github.com/..." with "git@github.com:..."

# ------------------------------------------------------------

git config --list --show-origin; # Debugging/Troubleshooting - Show all git-configurations & what file they're being pulled-from

# ------------------------------------------------------------