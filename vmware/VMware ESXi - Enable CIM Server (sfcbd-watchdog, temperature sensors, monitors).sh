#!/bin/sh
# ------------------------------------------------------------
# VMware ESXi - Enable CIM Server (sfcbd-watchdog, temperature sensors, monitors)
# ------------------------------------------------------------

esxcli system wbem get | sed -rne "s/^\s*Enabled: (false)\s*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//" | while read CIM_ENABLED_SETTING; do
# Get service status:  CIM Server
echo -e "\n""INFO:  Calling [ /etc/init.d/sfcbd-watchdog status; /bin/sleep 2; ]..."; /etc/init.d/sfcbd-watchdog status; /bin/sleep 2;
# "Allow the 'sfcb-HTTPS-Daem' process to start - This process is the TCP Listener that takes CIM requests from probes and returns the health of the hardware." - http://www.squidworks.net/2017/02/vmware-esxi-6-5-cim-data-disabled-by-default/ 
echo -e "\n""INFO:  Calling [ esxcli system wbem set –-enable=\"true\"; /bin/sleep 5; ]..."; esxcli system wbem set –-enable="true"; /bin/sleep 5;
# Start service:  CIM Server
echo -e "\n""INFO:  Calling [ /etc/init.d/sfcbd-watchdog start; /bin/sleep 5; ]..."; /etc/init.d/sfcbd-watchdog start; /bin/sleep 5;
# Get service status:  CIM Server
echo -e "\n""INFO:  Calling [ /etc/init.d/sfcbd-watchdog status; /bin/sleep 2; ]..."; /etc/init.d/sfcbd-watchdog status; /bin/sleep 2;
# Test service:  CIM Server
echo -e "\n""INFO:  Calling [ /etc/init.d/sfcbd-watchdog test; /bin/sleep 2; ]..."; /etc/init.d/sfcbd-watchdog test; /bin/sleep 2;
done;


# ------------------------------------------------------------
#
# Citation(s)
#
#   communities.vmware.com  |  "Solved: vSphere ESXi 6.5.0 Hardware Sensors - VMware Technology Network VMTN"  |  https://communities.vmware.com/t5/ESXi-Discussions/vSphere-ESXi-6-5-0-Hardware-Sensors/td-p/1814719
#
#   kb.vmware.com  |  "How to disable or enable the SFCB service (CIM Server) on the ESX/ESXi host (1025757)"  |  https://kb.vmware.com/s/article/1025757
#
#   kb.vmware.com  |  "Installing and upgrading the latest version of VMware Tools on existing hosts (2129825)"  |  https://kb.vmware.com/s/article/2129825
#
#   sourceforge.net  |  "IPMItool - Browse /ipmitool at SourceForge.net"  |  https://sourceforge.net/projects/ipmitool/files/ipmitool/
#
#   vswitchzero.com  |  "ipmitool 1.8.11 vib for ESXi – vswitchzero"  |  https://vswitchzero.com/ipmitool-vib/
#
#   www.sentrysoftware.com  |  "KB1116: Enabling CIM Server on the ESXi System | Sentry Software"  |  https://www.sentrysoftware.com/bmc/kb/1116/index.html
#
#   www.squidworks.net  |  "VMWare ESXi 6.5 CIM Data Disabled by Default | Squid Works"  |  http://www.squidworks.net/2017/02/vmware-esxi-6-5-cim-data-disabled-by-default/
#
# ------------------------------------------------------------