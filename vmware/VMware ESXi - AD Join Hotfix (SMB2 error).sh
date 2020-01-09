#!/bin/sh
#
# VMware ESXi - AD Join Hotfix (SMB2 error)
#
# ------------------------------------------------------------
##
## Post by VMware @ https://kb.vmware.com/s/article/67033:
## "
##   Symptoms
##      An ESXi host may fail to join an Active Directory domain when the SMBv1 protocol is disabled on the domain controller or when a firewall is blocking SMB negotiate packets. 
##   Cause
##     SMB2 is supported on ESXi 6.5 Update 1 onward but the initial SMB packet negotiation request begins over SMB1 packet.
##     If SMB2 is enabled on both Active Directory controller and the ESXi host then the negotiation switches to SMB2 otherwise it negotiates through SMB1packets only.
##     If SMB1 is disabled on the domain controller then it would prevent the initial packet negotiation, thus causing packet drops and eventually failure with an error similar to ERROR_GEN_FAILURE.##
## "
# ------------------------------------------------------------

DOMAIN_NAME="YOUR_DOMAIN";
DOMAIN_AUTH_USER="YOUR_AUTH_USER";
/usr/lib/vmware/likewise/bin/domainjoin-cli join $DOMAIN_NAME $DOMAIN_AUTH_USER;
### Joining to AD Domain:   DOMAIN_NAME
### With Computer DNS Name: DNS_SERVER.DOMAIN_NAME
###
### DOMAIN_AUTH_USER@DOMAIN_NAME's password:  DOMAIN_AUTH_PASS
###
### Error: ERROR_GEN_FAILURE [code 0x0000001f]
###


# ------------------------------------------------------------
### CHECK CONFIG

/etc/init.d/lwsmd status;
### running

chkconfig lwsmd;
### lwsmd              on

/usr/lib/vmware/likewise/bin/lwregshell list_values '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' | grep ConnectTimeout;
### (BLANK/EMPTY RESPONSE)

/usr/lib/vmware/likewise/bin/lwregshell list_values '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' | grep Smb2Enabled;
###   "Smb2Enabled"      REG_DWORD       0x00000000 (0)

/usr/lib/vmware/likewise/bin/lwregshell list_values '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' | grep Smb2Enabled;
###   "Smb2Enabled"      REG_DWORD       0x00000000 (0)

/usr/lib/vmware/likewise/bin/lwregshell list_values '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' | grep EchoInterval;
### +  "EchoInterval"     REG_DWORD       0x0000001e (300)

/usr/lib/vmware/likewise/bin/lwsm status lwio
### running (sm: 18346253)

# ------------------------------------------------------------
### UPDATE CONFIG

/etc/init.d/lwsmd start;

chkconfig lwsmd on;

/usr/lib/vmware/likewise/bin/lwregshell add_value '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' ConnectTimeout REG_DWORD 5

/usr/lib/vmware/likewise/bin/lwregshell set_value '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' Smb2Enabled 1;

/usr/lib/vmware/likewise/bin/lwregshell set_value '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' EchoInterval 30;


# ------------------------------------------------------------
### VERIFY CONFIG

/etc/init.d/lwsmd status;
### running

chkconfig lwsmd;
### lwsmd              on

/usr/lib/vmware/likewise/bin/lwregshell list_values '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' | grep Smb2Enabled;
### +  "Smb2Enabled"      REG_DWORD       0x00000001 (1)

/usr/lib/vmware/likewise/bin/lwregshell list_values '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' | grep EchoInterval;
### +  "EchoInterval"     REG_DWORD       0x0000001e (300)


# ------------------------------------------------------------
### Restart vCenter Server Appliance services
# /etc/init.d/hostd restart; /etc/init.d/vpxa restart;

### Restart vCenter Server Appliance services
service-control --stop --all; service-control --start --all;

### Restart A..? (AD Services? Registry?)
# /usr/lib/vmware/likewise/bin/lwsm restart lwio


# ------------------------------------------------------------
#
#  Citation(s)
#
#   kb.vmware.com  |  "ESXi domain join fails when SMBv1 is disabled on the domain controller or a firewall is blocking SMB negotiate packets (67033)"  |  https://kb.vmware.com/s/article/67033
#
#   kb.vmware.com  |  "Slow logins to vCenter Server Appliance 6.7 with an Active Directory joined PSC (53698)"  |  https://kb.vmware.com/s/article/53698
#
#   kb.vmware.com  |  "Stopping, Starting or Restarting VMware vCenter Server Appliance 6.x services (2109887)"  |  https://kb.vmware.com/s/article/2109887
#
#   technet.microsoft.com  |  "Sc config"  |  http://technet.microsoft.com/en-us/library/cc990290.aspx
#
#   www.jeffreykusters.nl  |  "Fixing "Errors in Active Directory operations" when adding an ESXi host to Active Directory - jeffreykusters.nl"  |  https://www.jeffreykusters.nl/2018/10/09/fixing-errors-in-active-directory-operations-when-adding-an-esxi-host-to-active-directory/
#
# ------------------------------------------------------------