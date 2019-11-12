#!/bin/bash


esxcli network firewall ruleset list --ruleset-id sshClient;  # Check if SSH client service is enabled


esxcli network firewall ruleset set --ruleset-id sshClient --enabled=true;  # Enable SSH client


# ------------------------------------------------------------
# Citation(s)
#
#   stackoverflow.com  |  "SCP in ESXi not working"  |  https://stackoverflow.com/a/51668330
# 
# ------------------------------------------------------------