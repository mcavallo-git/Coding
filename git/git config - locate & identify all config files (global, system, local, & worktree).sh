#!/bin/bash

# global
GIT_GLOBAL_CONFIG=$(git config --global --list --show-origin | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p'); \
GIT_GLOBAL_CONFIG_NO_DUPES=($(echo "${GIT_GLOBAL_CONFIG[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')); \
for EACH_CONFIG_FILE in "${GIT_GLOBAL_CONFIG_NO_DUPES[@]}"; do \
echo "${EACH_CONFIG_FILE}"; \
done;

# local
GIT_LOCAL_CONFIG=$(git config --local --list --show-origin | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p'); \
GIT_LOCAL_CONFIG_NO_DUPES=($(echo "${GIT_LOCAL_CONFIG[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')); \
for EACH_CONFIG_FILE in "${GIT_LOCAL_CONFIG_NO_DUPES[@]}"; do \
echo "${EACH_CONFIG_FILE}"; \
done;

# system
GIT_SYSTEM_CONFIG=$(git config --system --list --show-origin | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p'); \
GIT_SYSTEM_CONFIG_NO_DUPES=($(echo "${GIT_SYSTEM_CONFIG[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')); \
for EACH_CONFIG_FILE in "${GIT_SYSTEM_CONFIG_NO_DUPES[@]}"; do \
echo "${EACH_CONFIG_FILE}"; \
done;

# worktree
GIT_WORKTREE_CONFIG=$(git config --worktree --list --show-origin | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p'); \
GIT_WORKTREE_CONFIG_NO_DUPES=($(echo "${GIT_WORKTREE_CONFIG[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')); \
for EACH_CONFIG_FILE in "${GIT_WORKTREE_CONFIG_NO_DUPES[@]}"; do \
echo "${EACH_CONFIG_FILE}"; \
done;


