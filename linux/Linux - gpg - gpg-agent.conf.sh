#!/bin/bash


GPG_DIR="${HOME}/.gnupg/gpg-agent.conf";

GPG_AGENT_CONF="${HOME}/.gnupg/gpg-agent.conf";

# How long GPG remembers a cached password
mkdir -p "${HOME}/.gnupg"; echo "default-cache-ttl 3600" >> "${HOME}/.gnupg/gpg-agent.conf";
