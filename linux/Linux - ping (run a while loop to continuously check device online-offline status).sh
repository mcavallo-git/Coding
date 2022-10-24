#!/bin/bash
# ------------------------------------------------------------

# Call method 'ping_loop'
curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -sL "https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/main/usr/local/bin/ping_loop?t=$(date +'%s.%N')" | bash;


# ------------------------------------------------------------