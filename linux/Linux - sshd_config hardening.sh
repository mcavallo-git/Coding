#
# SSHD_CONF="/etc/ssh/sshd_config";
#
# See the sshd_config(5) manpage for details
#

AddressFamily inet

AllowTcpForwarding no

AuthenticationMethods publickey,keyboard-interactive

AuthorizedKeysFile /etc/ssh/authorized_keys/%u

ChallengeResponseAuthentication yes

ClientAliveCountMax 10

ClientAliveInterval 30

IgnoreRhosts yes

HostbasedAuthentication no

LoginGraceTime 60

LogLevel INFO

MaxAuthTries 1

MaxSessions 5

MaxStartups 5:30:10

PasswordAuthentication no

PermitEmptyPasswords no

PermitRootLogin no

PermitUserEnvironment no

PermitTunnel no

Port 22

PrintLastLog yes

PrintMotd no

Protocol 2

PubkeyAuthentication yes

StrictModes yes

TCPKeepAlive no

SyslogFacility AUTH

UseDNS no

UseLogin no

UsePAM yes

X11DisplayOffset 10

X11Forwarding yes

#####   SFTP-ONLY USERS (NO SSH)
#
Subsystem sftp internal-sftp -l INFO

Match Group sftp_jailed_users
	ForceCommand internal-sftp
	ChrootDirectory %h
	X11Forwarding no
	AllowAgentForwarding no
	AllowTcpForwarding no

# ------------------------------------------------------------
#
#  Citation(s)
#
#   access.redhat.com  |  "14.2. Configuring OpenSSH Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/s1-ssh-configuration
#
#   askubuntu.com  |  "security - How to harden an SSH server? - Ask Ubuntu"  |  https://askubuntu.com/questions/2271/how-to-harden-an-ssh-server
#
#   debian-administration.org  |  "Keeping SSH access secure"  |  https://debian-administration.org/article/87
#
#   freebsd.org  |  "sshd_config(5)"  |  https://freebsd.org/cgi/man.cgi?sshd_config(5)
#
#   linux.die.net  |  "sshd_config(5): OpenSSH SSH daemon config file - Linux man page"  |  https://linux.die.net/man/5/sshd_config
#
#   www.openssh.com  |  "OpenSSH: Manual Pages"  |  https://www.openssh.com/manual.html
#
# ------------------------------------------------------------