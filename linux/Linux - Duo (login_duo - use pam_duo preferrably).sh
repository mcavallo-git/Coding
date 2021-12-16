# ------------------------------------------------------------ #
#                                                              #
#                      !!! DEPRECATED !!!                      #
#                                                              #
#             !!! USE "pam_duo" GUIDE, INSTEAD !!!             #
#                                                              #
#                      !!! DEPRECATED !!!                      #
#                                                              #
# ------------------------------------------------------------ #



# # Follwing Guide:  https://duo.com/docs/loginduo

# apt-get update -y && apt-get install -y gcc libpam-dev libssl-dev make zlib1g-dev

# wget https://dl.duosecurity.com/duo_unix-latest.tar.gz
# tar zxf duo_unix-latest.tar.gz
# cd duo_unix-1.11.1
# ./configure --with-pam --prefix=/usr && make && sudo make install

# vi /etc/duo/pam_duo.conf
# #
# #   [duo]
# #   ; Duo integration key
# #   ikey = [INTEGRATION-KEY-HERE]
# #   ; Duo secret key
# #   skey = [SECRET-KEY-HERE]
# #   ; Duo API host
# #   host = [HOST-API-HERE]
# #   ; `failmode = safe` In the event of errors with this configuration file or connection to the Duo service
# #   ; this mode will allow login without 2FA.
# #   ; `failmode = secure` This mode will deny access in the above cases. Misconfigurations with this setting
# #   ; enabled may result in you being locked out of your system.
# #   failmode = safe
# #   ; Send command for Duo Push authentication
# #   ;pushinfo = yes
# #
# ### Additional options - See Duo's PAM Config-options:
# ###			https://duo.com/docs/duounix#duo-configuration-options



# # As a regular user, test login_duo manually by running

# chmod 0755 "/usr/sbin/login_duo";
# /usr/sbin/login_duo;

# # Spit back link:
# Please enroll at https://api-....duosecurity.com/....
# # ^-- emailed this link to myself and opened it on my phone
# #     signed up for duo account on phone, received ending green fireworks



# # Now we're trying:

# /usr/sbin/login_duo echo 'YOU ROCK!'

# # Duo two-factor login for cavalol

# # Enter a passcode or select one of the following options:

# #  1. Duo Push to XXX-XXX-4508
# #  2. Phone call to XXX-XXX-4508
# #  3. SMS passcodes to XXX-XXX-4508 (next code starts with: 1)

# # Passcode or option (1-3): 1
# #
# # Pushed a login request to your device...
# # Success. Logging you in...
# # YOU ROCK!
# #

# # Add this to all SSH-Key-verifications by using adding the following lines to "/etc/ssh/sshd_config":

# ForceCommand /usr/sbin/login_duo
# PermitTunnel no
# AllowTcpForwarding no

# sudo service ssh restart



# ### Setup login_duo (via login_duo.conf) to automatically send push-notifications w/o user having to choose each time
# vi "/etc/duo/login_duo.conf";

# ##  Before:
# ;pushinfo = yes

# ##  After:
# pushinfo = yes
# autopush = yes
# prompts = 1


