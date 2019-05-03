
# Folliwng Guide:  https://duo.com/docs/duounix

# TO INSTALL:  pam_duo

# ------------------------------------------------------------

apt-get update -y && apt-get install -y gcc libpam-dev libssl-dev make zlib1g-dev

# Install duo_unix
mkdir -p "${HOME}/pam_duo_install" && cd "${HOME}/pam_duo_install";
wget "https://dl.duosecurity.com/duo_unix-latest.tar.gz";
tar zxf "duo_unix-latest.tar.gz" && cd "duo_unix-1.11.1";
./configure --with-pam --prefix=/usr && make && sudo make install;

# ------------------------------------------------------------


vi "/etc/duo/pam_duo.conf";

### At the top of pam_duo.conf, set:

[duo]
; Duo integration key
ikey = [INTEGRATION-KEY-HERE]
; Duo secret key
skey = [SECRET-KEY-HERE]
; Duo API host
host = [HOST-API-HERE]

## At the bottom of pam_duo.conf, set:
pushinfo = yes
autopush = yes
prompts = 1
## ^-- This sets up automatic push-notifications whenever user attempts to BASH-into the environment


# ------------------------------------------------------------

# Configure "/etc/ssh/sshd_config" with the following settings (for public-key based authentication):

vi "/etc/ssh/sshd_config"

# Public Key Authentication
PubkeyAuthentication yes
PasswordAuthentication no
AuthenticationMethods publickey
ChallengeResponseAuthentication yes
UseDNS no
PermitTunnel no
AllowTcpForwarding no

# ------------------------------------------------------------

### Ubuntu 18.04
### SSH Public Key Authentication via PAM

## Prep
find / -name 'pam_duo.so'
find / -name 'pam_deny.so'
find / -name 'pam_permit.so'
find / -name 'pam_cap.so'
vi "/etc/pam.d/sshd";

##  Before:
@include common-auth

##  After:
#@include common-auth
auth [success=1 default=ignore] /usr/lib64/security/pam_duo.so
auth requisite /usr/lib/x86_64-linux-gnu/security/pam_deny.so
auth required /usr/lib/x86_64-linux-gnu/security/pam_permit.so

# ------------------------------------------------------------

### System-wide Authentication

## Prep
find / -name 'common-auth'
vi "/etc/pam.d/common-auth";

##  Before:
auth [success=1 default=ignore] pam_unix.so nullok_secure
auth requisite pam_deny.so
auth required pam_permit.so

##  After:
# auth  [success=1 default=ignore] pam_unix.so nullok_secure
auth requisite pam_unix.so nullok_secure
auth [success=1 default=ignore] /usr/lib64/security/pam_duo.so
auth requisite /usr/lib/x86_64-linux-gnu/security/pam_deny.so
auth required /usr/lib/x86_64-linux-gnu/security/pam_permit.so
auth optional /usr/lib/x86_64-linux-gnu/security/am_cap.so

# ------------------------------------------------------------

# Finally, connect the application to your duo

# NOTE: This command will return a URL hyperlink
# ^^^>>> on your MOBILE, browse to this url (not desktop)

cat "/etc/duo/pam_duo.conf" > "/etc/duo/login_duo.conf";

chmod 4755 "/usr/sbin/login_duo" && "/usr/sbin/login_duo";

# ------------------------------------------------------------