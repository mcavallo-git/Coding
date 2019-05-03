
# Folliwng Guide:  https://duo.com/docs/duounix

# TO INSTALL:  pam_duo

apt-get install -y zlib1g-dev
apt-get install -y gcc
apt-get install -y libssl-dev
apt-get install -y libpam-dev
apt-get install -y make


# Install duo_unix
wget https://dl.duosecurity.com/duo_unix-latest.tar.gz
tar zxf duo_unix-latest.tar.gz
cd duo_unix-1.11.1
./configure --with-pam --prefix=/usr && make && sudo make install


vi "/etc/duo/pam_duo.conf";


# [duo]
# ; Duo integration key
# ikey = ...
# ; Duo secret key
# skey = ...
# ; Duo API host
# host = api-....duosecurity.com
# ; `failmode = safe` In the event of errors with this configuration file or connection to the Duo service
# ; this mode will allow login without 2FA.
# ; `failmode = secure` This mode will deny access in the above cases. Misconfigurations with this setting
# ; enabled may result in you being locked out of your system.
# failmode = safe
# ; Send command for Duo Push authentication
# ;pushinfo = yes



# vvv Add this to "/etc/ssh/sshd_config" for public-key based authentication


# Public Key Authentication
PubkeyAuthentication yes
PasswordAuthentication no
AuthenticationMethods publickey,keyboard-interactive



# Meed to find the pam file, first

cd /lib64/security

find '/' -name 'pam_duo.so'

## Found:   /usr/lib64/security/pam_duo.so
##  -->  auth required /usr/lib64/security/pam_duo.so;

# Edit the PAM Configuration file
vi "/etc/pam.d/sshd";
vi "/etc/pam.d/common-auth";


# auth required "/usr/lib64/security/pam_duo.so";


### Ubuntu 18.04
### SSH Public Key Authentication via PAM
vi "/etc/pam.d/sshd";


## Prep
find / -name 'pam_duo.so'
find / -name 'pam_deny.so'
find / -name 'pam_permit.so'
find / -name 'pam_cap.so'

##  Before:
@include common-auth


##  After:
#@include common-auth
auth [success=1 default=ignore] /usr/lib64/security/pam_duo.so
auth requisite /usr/lib/x86_64-linux-gnu/security/pam_deny.so
auth required /usr/lib/x86_64-linux-gnu/security/pam_permit.so




### System-wide Authentication

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
auth required /usr/lib/x86_64-linux-gnu/security/am_cap.so


