#!/bin/sh
# ------------------------------------------------------------
#
# ESXi Embedded Host Client
# 
# ------------------------------------------------------------
#
# The ESXi Embedded Host Client is a native HTML and JavaScript application and is served directly from your ESXi host! It should perform much better than any of the existing solutions.
#
# In short, a VIB is a software package that gets installed on a vSphere ESXi host that contains things like drivers. They have become quite a bit more common in the last few years as the supported hardware base for vSphere has increased over time.
# 
# 
# ------------------------------------------------------------


### !!! MAKE SURE TO DOUBLE CHECK THAT YOU'VE BACKED UP THE ESXI INSTANCE'S CURRENT VIB BEFORE MAKING CHANGES/UPDATES TO IT !!! ###

# ------------------------------------------------------------
#
### List/Show installed ESXi drivers (.vib extensioned files)
#

esxcli software vib list;

esxcli software vib list | grep -i ahci

esxcli software vib list | grep -i net

esxcli software vib list | grep -i nic

esxcli software vib list | grep -i asmedia

esxcli software vib list | grep -i dell

esxcli software vib list | grep -i hp


# ------------------------------------------------------------
#
### Get drivers currently in-use by the ESXi host  (Note: replace "_" with "-" in driver names)
#

esxcli network nic list;  # Get [ network ] drivers currently in-use via the "Driver" column

esxcli storage core adapter list;  # Get [ disk ] drivers currently in-use via the "Driver" column


# ------------------------------------------------------------
#
### Install/Update target ESXi driver (.vib extensioned file)
#
esxcli software vib install -v "URL";

# ------------------------------------------------------------
#
### Remove target ESXi driver(s) (.vib extensioned files)
#
# software vib remove
#
# --dry-run            Performs a dry-run only. Report the VIB-level operations that would be performed, but do not change anything in the system.
#
# --force | -f         Bypasses checks for package dependencies, conflicts, obsolescence, and acceptance levels.
#                      Really not recommended unless you know what you are doing. Use of this option will result in a warning being displayed in the vSphere Client.
#
# --help | -h          Show the help message.
#
# --maintenance-mode   Pretends that maintenance mode is in effect. Otherwise, remove will stop for live removes that require maintenance mode.
#                      This flag has no effect for reboot required remediations.
#
# --no-live-install    Forces an remove to /altbootbank even if the VIBs are eligible for live removal. Will cause installation to be skipped on PXE-booted hosts.
#
# --vibname | -n       Specifies one or more VIBs on the host to remove. Must be one of the following forms: name, name:version, vendor:name, vendor:name:version.
#
esxcli software vib remove --vibname="NAME";


exit 0;

# ------------------------------------------------------------
#
### Ex) Update ESXi host with a file (.vib package) uploaded to either a local datastore, sftp directory, or other location directly accessible via the SSH on the ESXi host
#
esxcli software vib install -v "/vmfs/volumes/datastore0/.vib/EXAMPLE_VIB_NAME.vib";

# ------------------------------------------------------------
#
### Ex) Update ESXi's "Embedded Host Client"
###   |--> Download & install the latest HTTP & Javascript ".vib" file
#
esxcli software vib install -v "http://download3.vmware.com/software/vmw-tools/esxui/esxui-signed-latest.vib";


# ------------------------------------------------------------
#
### Ex) Update the ESXi driver for various hardware (to ESXi v6.5/v6.7 latest as-of Jan-2020)
#
esxcli software vib install -v "https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/esx/vmw/vib20/misc-drivers/VMW_bootbank_misc-drivers_6.7.0-2.48.13006603.vib";


# ------------------------------------------------------------
#
### Ex) Update the ESXi driver for NIC "net-r8168"
#
esxcli software vib install -v "https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/esx/vmw/vib20/net-r8168/VMware_bootbank_net-r8168_8.013.00-3vmw.510.0.0.799733.vib";


# ------------------------------------------------------------
#
### Ex) Remove specific driver(s) based on their "name"
#
# [root@esxi:~] > esxcli software vib list | grep -i net | grep sky;
# net51-sky2                     1.20-2vft.510.0.0.799733              VFrontDe  CommunitySupported  2020-05-25
#
esxcli software vib remove --vibname="net51-sky2";


# [root@esxi:~] esxcli software vib list | grep -i net | grep r8169
# net51-r8169                    6.011.00-2vft.510.0.0.799733          VFrontDe  CommunitySupported  2020-05-25
#
esxcli software vib remove --vibname="net51-r8169";


# ------------------------------------------------------------
#
# Backstory:  Tried to upgrade from ESXi 6.5-U2 to 6.7-U3, but received errors that two VIB files (which were already installed and live within the 6.5-U2 Image on the host) were incompatible with the 6.7-U3 Image, and that they needed to be removed before ESXi would perform the upgrade as-intended
#
### Ex) Remove specific driver(s) based on syntax their "name:version"
#

esxcli software vib remove --vibname="VFrontDe_bootbank_net51-sky2_1.20-2vft.510.0.0.799733"; esxcli software vib remove --vibname="VFrontDe_bootbank_net51-sr81696.011.00-2vft.510.0.0.799733";


#  [NoMatchError]
#  No VIB matching VIB search specification 'VFrontDe_bootbank_net51-sky2_1.20-2vft.510.0.0.799733'.
#  Please refer to the log file for more details.
#  [NoMatchError]
#  No VIB matching VIB search specification 'VFrontDe_bootbank_net51-sr81696.011.00-2vft.510.0.0.799733'.
#  Please refer to the log file for more details.


esxcli software vib remove --vibname="net51-sky2:1.20-2vft.510.0.0.799733"; esxcli software vib remove --vibname="net51-r8169:6.011.00-2vft.510.0.0.799733";
# Removal Result
#    Message: The update completed successfully, but the system needs to be rebooted for the changes to be effective.
#    Reboot Required: true
#    VIBs Installed:
#    VIBs Removed: VFrontDe_bootbank_net51-sky2_1.20-2vft.510.0.0.799733
#    VIBs Skipped:
# Removal Result
#    Message: The update completed successfully, but the system needs to be rebooted for the changes to be effective.
#    Reboot Required: true
#    VIBs Installed:
#    VIBs Removed: VFrontDe_bootbank_net51-r8169_6.011.00-2vft.510.0.0.799733
#    VIBs Skipped:


# ------------------------------------------------------------
#
# Citation(s)
#
#   flings.vmware.com  |  "ESXi Embedded Host Client"  |  https://flings.vmware.com/esxi-embedded-host-client#instructions
#
#   kb.vmware.com  |  "Determining Network/Storage firmware and driver version in ESXi (1027206)"  |  https://kb.vmware.com/s/article/1027206
#
#   www.v-front.de  |  "VMware Front Experience: vSphere 6 is GA: The ultimate guide to upgrade your white box to ESXi 6.0"  |  https://www.v-front.de/2015/03/vsphere-6-is-ga-ultimate-guide-to.html
#
# ------------------------------------------------------------