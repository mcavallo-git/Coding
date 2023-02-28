#!/bin/sh

# Check ESXi's current hostname configuration
esxcfg-advcfg -g "/Misc/hostname";


# Set ESXi host's FQDN (Host/Domain Names) & Restart the [ ESXi host daemon ] service (should be accessible again within ~15-30 seconds) - Note: Doesn't affect ESXi's hosting of any VMs or their associated network connection(s)
if [[ 1 -eq 1 ]]; then
  read -p "Enter hostname for this ESXi host (domain optionally included):  " -t ${READ_TIMEOUT:-60} <'/dev/tty'; EXIT_CODE=${?};
  if [[ -n "${REPLY}" ]]; then
    echo -e "\n""INFO:  Calling [ esxcfg-advcfg -s \"${REPLY}\" \"/Misc/hostname\"; /etc/init.d/hostd restart; ]...";
    esxcfg-advcfg -s "${REPLY}" "/Misc/hostname"; /etc/init.d/hostd restart;
  else
    echo "Error:  Empty response received";
  fi;
  echo "";
fi;


# Manual Network Config
if [ 1 -eq 1 ]; then
LAN_IPv4="";
if [ -z "${LAN_IPv4}" ]; then
echo "No IPv4 address defined - Please set \$LAN_IPV4 with desired static IPv4 address";
else
echo "# Do not remove the following line, or various programs" > "/etc/hosts";
echo "# that require network functionality will fail." >> "/etc/hosts";
echo "127.0.0.1       localhost.localdomain localhost" >> "/etc/hosts";
echo "::1             localhost.localdomain localhost" >> "/etc/hosts";
if [ -n "$(hostname -d)" ] && [ "$(hostname -f)" != "$(hostname -s)" ]; then
echo "${LAN_IPv4}     $(hostname -f) $(hostname -s)" >> "/etc/hosts";
else
echo "${LAN_IPv4}     $(hostname)" >> "/etc/hosts";
fi;
/etc/init.d/hostd restart; # Restart the [ ESXi host daemon ] service (should be accessible again within ~15-30 seconds) Note: Doesn't affect ESXi's hosting of any VMs or their associated network connection(s)
fi;
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Changing the name of an ESX or ESXi host (1010821)"  |  https://kb.vmware.com/s/article/1010821
#
# ------------------------------------------------------------