# ------------------------------------------------------------
#
# SSH Config (all users):   /etc/ssh/ssh_config
#
# SSH Config (per user):    ~/.ssh/config
#
# ------------------------------------------------------------

# Example - Avoid using any cached keys for a given host
Host hostname
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null


# Example - fallthrough catch - target github.com instead of cli target & attempt to use either of two private keys
Host *
  HostName github.com
  IdentityFile /fullpath/to/ssh/private/key#1.pem
  IdentityFile /fullpath/to/ssh/private/key#2.pem
  IdentitiesOnly yes
  StrictHostKeyChecking no


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.ssh.com  |  "SSH config file syntax and how-tos for configuring the OpenSSH client"  |  https://www.ssh.com/academy/ssh/config#commonly-used-configuration-options
#
# ------------------------------------------------------------