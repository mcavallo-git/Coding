#!/bin/sh
exit 1;
# ------------------------------------------------------------
#
#   Allowing SSH access to ESXi/ESX hosts with public/private key authentication
#
# ------------------------------------------------------------

### 1. Generate public/private keys. For more information, see the OpenBSD Reference Manual section in the OpenBSD.
###   Notes:
###     These instructions generate two files in ~/.ssh: id_rsa and id_rsa.pub.
/usr/lib/vmware/openssh/bin/ssh-keygen;


### 2. On the remote host, store the public key content, id_rsa.pubin ~/.ssh/authorized_keys.
###   Notes:
###     For ESXi 5.x, 6.0, 6.5 and 6.7, the authorized_keys is located at "$(cat /etc/ssh/sshd_config | grep '^AuthorizedKeysFile')"
###     More than one key can be stored in this file.


### 3. To allow root access, change PermitRootLogin no to PermitRootLogin yes in the /etc/ssh/sshd_config file.
vi "/etc/ssh/sshd_config";
### > Enter vim's "Insert Mode" by sending/typing "i" (should state "insert mode" at the bottom of the vim editor)
###  > ( make your changes )
###   > Enter vim's "Ex-mode" by sending/typing ":" (should brings up a cursor at the bottom of the screen to enter "Ex commands)
###    > Save + Quit via command "wq"
###    > Discard-Changes & Quit via command "!q"
###    > Clear-File-Contents via Ex-command "1,$d" (wipes all lines, doesn't save --> :w is still required for that)


### 4. To disable password login, ensure that the ChallengeResponseAuthentication and PasswordAuthentication are set to no.


### 5. Reload the service:
/etc/init.d/SSH restart;


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Allowing SSH access to ESXi/ESX hosts with public/private key authentication (1002866)"  |  https://kb.vmware.com/s/article/1002866
#
# ------------------------------------------------------------