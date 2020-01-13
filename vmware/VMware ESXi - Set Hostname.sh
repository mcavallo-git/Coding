#!/bin/bash

### Set ESXi Host's FQDN (Host/Domain Names) & Restart the [ ESXi host daemon ] service (should be accessible again within ~15-30 seconds) Note: Doesn't affect any VMs
esxcfg-advcfg -s "HOSTNAME.DOMAIN.TLD" /Misc/hostname; /etc/init.d/hostd restart;


### Manual Network Config 
LAN_IPv4="";
echo "# Do not remove the following line, or various programs" > "/etc/hosts"; \
echo "# that require network functionality will fail." >> "/etc/hosts"; \
echo "127.0.0.1       localhost.localdomain localhost" >> "/etc/hosts"; \
echo "::1             localhost.localdomain localhost" >> "/etc/hosts"; \
if [ -n "${LAN_IPv4}" ]; then \
echo "${LAN_IPv4}       ${FQDN} ${HOSTNAME}" >> "/etc/hosts"; \
fi;
/etc/init.d/hostd restart; # Restart the [ ESXi host daemon ] service (should be accessible again within ~15-30 seconds) Note: Doesn't affect any VMs



# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Changing the name of an ESX or ESXi host (1010821)"  |  https://kb.vmware.com/s/article/1010821
#
# ------------------------------------------------------------