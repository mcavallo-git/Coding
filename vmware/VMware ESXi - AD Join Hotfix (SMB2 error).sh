#!/bin/sh
#
# VMware ESXi - AD Join Hotfix (SMB2 error)
#
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

/usr/lib/vmware/likewise/bin/lwregshell list_values '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' | grep Smb2Enabled;
###   "Smb2Enabled"      REG_DWORD       0x00000000 (0)

/usr/lib/vmware/likewise/bin/lwregshell list_values '[HKEY_THIS_MACHINE\Services\lwio\Parameters\Drivers\rdr]' | grep EchoInterval;
### +  "EchoInterval"     REG_DWORD       0x0000001e (300)


# ------------------------------------------------------------
### UPDATE CONFIG

/etc/init.d/lwsmd start;

chkconfig lwsmd on;

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
# service-control --start --all; service-control --stop --all
/etc/init.d/hostd restart; /etc/init.d/vpxa restart;


# ------------------------------------------------------------
#
#  Citation(s)
#
#   kb.vmware.com  |  "Slow logins to vCenter Server Appliance 6.7 with an Active Directory joined PSC (53698)"  |  https://kb.vmware.com/s/article/53698
#
#   www.jeffreykusters.nl  |  "Fixing "Errors in Active Directory operations" when adding an ESXi host to Active Directory - jeffreykusters.nl"  |  https://www.jeffreykusters.nl/2018/10/09/fixing-errors-in-active-directory-operations-when-adding-an-esxi-host-to-active-directory/
#
# ------------------------------------------------------------