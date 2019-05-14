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

#
#	Citation(s)
#
# Documentation
#		--> https://linux.die.net/man/5/sshd_config
#		--> https://freebsd.org/cgi/man.cgi?sshd_config(5)
#
#
#	Discussion
#		--> https://askubuntu.com/questions/2271/how-to-harden-an-ssh-server
#
