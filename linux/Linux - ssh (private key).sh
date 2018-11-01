
# [ssh(1) - Linux man page](https://linux.die.net/man/1/ssh)

# [ssh-keygen(1) - Linux man page](https://linux.die.net/man/1/ssh-keygen)

# Bash SSH using username & private-key 
ssh -o StrictHostKeyChecking=no -i "/path/to/private_key.pem" "remote_username@10.10.10.10"


# Same as above, but with variables
REMOTE_IP="1.2.3.4";
REMOTE_USER="remote_username";
PRIVATE_KEY="/path/to/private_key.pem";
ssh-keygen -R "${REMOTE_IP}";
ssh -o StrictHostKeyChecking=no -i "${PRIVATE_KEY}" "${REMOTE_USER}@${REMOTE_IP}";
