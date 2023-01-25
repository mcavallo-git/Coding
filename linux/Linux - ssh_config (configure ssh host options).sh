# ------------------------------------------------------------
#
# SSH Config (all users):   /etc/ssh/ssh_config
#
# SSH Config (per user):    ~/.ssh/config
#
# ------------------------------------------------------------

# Example - Avoid using any cached keys for a given hostname
Host hostname
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null

# Example - github, all repos (git)
Match host *github.com
	User git
  IdentitiesOnly yes

# Example - fallthrough catch - target github.com instead of cli target & attempt to use either of two private keys
Host *
  HostName ssh.dev.azure.com
  IdentityFile /fullpath/to/ssh/private/key#1.pem
  IdentityFile /fullpath/to/ssh/private/key#2.pem
  IdentitiesOnly yes
  StrictHostKeyChecking no

# ------------------------------------------------------------
#
# Citation(s)
#
#   blog.tankywoo.com  |  "SSH PasswordAuthentication vs ChallengeResponseAuthentication | Blog·Tanky Woo"  |  https://blog.tankywoo.com/linux/2013/09/14/ssh-passwordauthentication-vs-challengeresponseauthentication.html
#
#   man7.org  |  "ssh_config(5) - Linux manual page"  |  http://man7.org/linux/man-pages/man5/ssh_config.5.html
#
#   manpages.ubuntu.com  |  "Ubuntu Manpage: ssh_config — OpenSSH client configuration file"  |  https://manpages.ubuntu.com/manpages/kinetic/en/man5/ssh_config.5.html
#
#   www.ssh.com  |  "SSH config file syntax and how-tos for configuring the OpenSSH client"  |  https://www.ssh.com/ssh/config/
#
# ------------------------------------------------------------