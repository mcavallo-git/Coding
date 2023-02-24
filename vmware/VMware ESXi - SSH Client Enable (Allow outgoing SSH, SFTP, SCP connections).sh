#!/bin/sh


# Linux - ESXi SSH Client Enable (Allow outgoing SSH, SFTP, SCP connections)


esxcli network firewall ruleset list --ruleset-id sshClient;  # Check if SSH client service is enabled


esxcli network firewall ruleset set --ruleset-id sshClient --enabled=true;  # Enable SSH client (e.g. enable outgoing SSH connections)


# Setup public key on local device for incoming SSH authentication
SSH_AS_USERNAME="root";
# > Upload public key to the root directory as "/USERNAME.pub"
mkdir "/etc/ssh/keys-${SSH_AS_USERNAME}"; chmod 0755 "/etc/ssh/keys-${SSH_AS_USERNAME}"; mv "/${SSH_AS_USERNAME}.pub" "/etc/ssh/keys-${SSH_AS_USERNAME}/authorized_keys"; chmod 0600 "/etc/ssh/keys-${SSH_AS_USERNAME}/authorized_keys";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "SCP in ESXi not working"  |  https://stackoverflow.com/a/51668330
# 
# ------------------------------------------------------------