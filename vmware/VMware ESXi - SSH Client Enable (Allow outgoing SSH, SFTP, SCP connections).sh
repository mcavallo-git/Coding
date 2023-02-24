#!/bin/sh


# Linux - ESXi SSH Client Enable (Allow outgoing SSH, SFTP, SCP connections)


# Get the enabled/disabled status of ESXi's SSH client
esxcli network firewall ruleset list --ruleset-id sshClient;


# Enable ESXi's SSH client (e.g. enable outgoing SSH connections)
esxcli network firewall ruleset set --ruleset-id sshClient --enabled=true;


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