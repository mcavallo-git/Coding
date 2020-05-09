#!/bin/sh
# ------------------------------------------------------------
#
# Backend command for selecting VM setting: "Video Card" > "Specify custom settings" > "Total video memory" >  [ 8 ] MB
#
vi "/vmfs/volumes'datastore1/VMDIR/VMNAME.vmx";
svga.autodetect = "FALSE"
svga.minVRAMSize = "8388608"
# vmotion.checkpointSVGAPrimarySize = "8388608"



# ------------------------------------------------------------
#
# Shutdown the VM, then manually SSH into the ESXi server and edit said VM's ".vmx" config file
#  > Add the following lines
#
### Note: svga.vramSize is calculated by multiplying the max width by the max height you wish to grant to target vm - e.g. If a 1920x1080 resolution should be the cap for a VM's resolution, then set svga.vramSize=2073600, as 1920 * 1080 = 2073600
vi "/vmfs/volumes'datastore1/VMDIR/VMNAME.vmx";
# ... (Add the following lines to the bottom of the ".vmx" file)
svga.vramSize = "2073600"
svga.present = "TRUE"
svga.guestBackedPrimaryAware = "TRUE"



# ------------------------------------------------------------
#
# VMware ESXi VMs --> Disable VM Display-Resizing
#  > Step 1: Shut down the VM
#   > Step 2: SSH into the ESXi host & locate target VM's ".vmx" configuration file
#    > Step 3: Add the following configuration lines to the end of aforementioned ".vmx" configuration file
#     > Step 4: Power VM on and test
#
vi "/vmfs/volumes'datastore1/VMDIR/VMNAME.vmx";
guestInfo.svga.wddm.modeset = "FALSE"
guestInfo.svga.wddm.modesetCCD = "FALSE"
guestInfo.svga.wddm.modesetLegacySingle = "FALSE"
guestInfo.svga.wddm.modesetLegacyMulti = "FALSE"



# ------------------------------------------------------------
#
# Force a resolution onto a VM which is powered-on and has VMware Tools currently running
#
ESXI_VM_NAME="YOUR_VM_NAME_HERE";
SCREEN_WIDTH="1366";
SCREEN_HEIGHT="768";
ID_VM=$(vim-cmd vmsvc/getallvms | sed -e '1d' -e 's/ \[.*$//' | awk '$1 ~ /^[0-9]+$/ {print $1":"substr($0,8,80)}' | sed -rne "s/^([0-9]+):(${ESXI_VM_NAME}\s*)$/\1/p";); echo "ID_VM: ${ID_VM}";
vim-cmd vmsvc/setscreenres ${ID_VM} ${SCREEN_WIDTH} ${SCREEN_HEIGHT};



# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Adding video resolution modes to Windows guest operating systems (1003)"  |  https://kb.vmware.com/s/article/1003
#
#   www.vgemba.net  |  "VM Console Display Resolution Change - vGemba.net"  |  https://www.vgemba.net/vmware/powercli/VMConsole-Resolution-Change/
#
# ------------------------------------------------------------