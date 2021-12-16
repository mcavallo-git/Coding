#!/bin/bash
# ------------------------------------------------------------
#
# Following Guide:  https://duo.com/docs/duounix
#
# TO INSTALL:  pam_duo
#
# ------------------------------------------------------------

if [ 1 -eq 1 ]; then

# Install PAM & Duo prerequisite packages
apt-get -y update; apt-get -y install gcc libpam-dev libssl-dev make zlib1g-dev;

# Setup duo_unix variables - working directory / source url / local install path
WORKING_DIR="${HOME}/pam_duo_install";
DUO_UNIX_LATEST_REMOTE="https://dl.duosecurity.com/duo_unix-latest.tar.gz";
DUO_UNIX_LATEST_LOCAL="${WORKING_DIR}/$(basename "${DUO_UNIX_LATEST_REMOTE}";)";

# Create working dir
mkdir -pv "${WORKING_DIR}";

# Download duo_unix
curl -H 'Cache-Control:no-cache' -sL "${DUO_UNIX_LATEST_REMOTE}" -o "${DUO_UNIX_LATEST_LOCAL}";

# Unpack duo_unix
cd "${WORKING_DIR}"; tar zxf "${DUO_UNIX_LATEST_LOCAL}";

# Set the directory which was just unpacked (from the latest duo_unix tarball) as the current working directory
UNPACKED_DIR="$(find "${WORKING_DIR}/" -maxdepth "1" -mindepth "1" -type "d" -iname "duo_unix-*" -not -path "${DUO_UNIX_LATEST_LOCAL}" | head -n 1;)";

if [[ -d "${UNPACKED_DIR}" ]] && [[ "${UNPACKED_DIR}" != "${WORKING_DIR}" ]]; then
cd "${UNPACKED_DIR}"; pwd;
# Install duo_unix
echo "Calling [ ./configure --with-pam --prefix=/usr && make && sudo make install; ] from working directory [ $(pwd;) ]...";
./configure --with-pam --prefix=/usr && make && sudo make install;
fi;

fi;


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
find / -name 'pam_duo.so'; find / -name 'pam_deny.so'; find / -name 'pam_permit.so'; find / -name 'pam_cap.so';

vi "/etc/pam.d/sshd";

##  Before:
@include common-auth

##  After:
#@include common-auth
auth [success=1 default=ignore] /lib64/security/pam_duo.so
auth requisite /lib/x86_64-linux-gnu/security/pam_deny.so
auth required /lib/x86_64-linux-gnu/security/pam_permit.so

# ------------------------------------------------------------

### System-wide Authentication

## Prep
find / -name 'common-auth'
vi "/etc/pam.d/common-auth";

##  Before:
auth [success=1 default=ignore] /lib/x86_64-linux-gnu/security/pam_unix.so nullok_secure
auth requisite pam_deny.so
auth required pam_permit.so

##  After:
# auth  [success=1 default=ignore] pam_unix.so nullok_secure
auth requisite /lib/x86_64-linux-gnu/security/pam_unix.so nullok_secure
auth [success=1 default=ignore] /lib64/security/pam_duo.so
auth requisite /lib/x86_64-linux-gnu/security/pam_deny.so
auth required /lib/x86_64-linux-gnu/security/pam_permit.so

# ------------------------------------------------------------

# Finally, connect the application to your duo

# NOTE: This command will return a URL hyperlink
# ^^^>>> on your MOBILE, browse to this url (not desktop)

# cat "/etc/duo/pam_duo.conf" > "/etc/duo/login_duo.conf";
ln -sf "/etc/duo/pam_duo.conf" "/etc/duo/login_duo.conf";

chmod 4755 "/usr/sbin/login_duo" && "/usr/sbin/login_duo";

# ------------------------------------------------------------