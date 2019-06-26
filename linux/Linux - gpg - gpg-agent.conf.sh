#!/bin/bash

# GPG remembers a cached password
mkdir -p "${HOME}/.gnupg"; echo "default-cache-ttl 3600" >> "${HOME}/.gnupg/gpg-agent.conf";
