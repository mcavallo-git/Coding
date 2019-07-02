#!/bin/bash

# Bash SSH using username & private-key 
ssh -o "StrictHostKeyChecking=no" -i "/path/to/private_key.pem" "remote_username@1.2.3.4";

# Same as above, but with variables
REMOTE_IP="1.2.3.4";
REMOTE_USER="remote_username";
PRIVATE_KEY="/path/to/private_key.pem";
SSH_OPT="StrictHostKeyChecking=no";
ssh-keygen -R "${REMOTE_IP}";
ssh -o "${SSH_OPT}" -i "${PRIVATE_KEY}" "${REMOTE_USER}@${REMOTE_IP}";


# ------------------------------------------------------------
#
# Citation(s)
#
# 	www.ssh.com  |  "SSH Command"  |  https://www.ssh.com/ssh/command
#
# 	linux.die.net  |  "ssh(1) - Linux man page"  |  https://linux.die.net/man/1/ssh
#
#