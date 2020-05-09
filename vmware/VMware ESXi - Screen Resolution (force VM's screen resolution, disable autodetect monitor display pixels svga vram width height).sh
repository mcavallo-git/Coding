#!/bin/sh
# ------------------------------------------------------------
#
# Backend command for selecting VM setting: "Video Card" > "Specify custom settings" > "Total video memory" > [ 8 ] MB
#  > Note: Increases total video memory allocated to a target VM (to allow for larger resolution outputs)
#  > Note: The minimum [ svga.vramSize ] required for a target resolution can be quickly calculated by multiplying desired-width by desired-height, both in pixels (regarding display resolution)
#             - e.g. If a 1920x1080 resolution is desired, one should set [ svga.vramSize=2073600 ] to a MINIMUM of 2073600 (which is in bytes), since 1920 * 1080 = 2073600
#
#  > Step 1: Shutdown the VM, then manually SSH into the ESXi server and edit said VM's ".vmx" config file
#   > Step 2: Add the following lines to said ".vmx" config-file
#

# Open the VM's ".vmx" config-file for editing
vi "/vmfs/volumes'datastore1/VMDIR/VMNAME.vmx";

# Modify (or add, if not found) the following config-name = config-value pairs to the VM's ".vmx" config-file
svga.vramSize = "8388608"
svga.autodetect = "FALSE"
svga.present = "TRUE"

# Reload the VM's config (applies any changes made to the VM's ".vmx" config-file)
ESXI_VM_NAME="VM_NAME"; ID_VM=$(vim-cmd vmsvc/getallvms | sed -e '1d' -e 's/ \[.*$//' | awk '$1 ~ /^[0-9]+$/ {print $1":"substr($0,8,80)}' | sed -rne "s/^([0-9]+):(${ESXI_VM_NAME}\s*)$/\1/p";); echo "ID_VM: ${ID_VM}"; vim-cmd vmsvc/reload ${ID_VM};



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
svga.ignoreSavedState = "TRUE"

# Reload the VM's config (applies any changes made to the VM's ".vmx" config-file)
ESXI_VM_NAME="VM_NAME"; ID_VM=$(vim-cmd vmsvc/getallvms | sed -e '1d' -e 's/ \[.*$//' | awk '$1 ~ /^[0-9]+$/ {print $1":"substr($0,8,80)}' | sed -rne "s/^([0-9]+):(${ESXI_VM_NAME}\s*)$/\1/p";); echo "ID_VM: ${ID_VM}"; vim-cmd vmsvc/reload ${ID_VM};



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
#   kb.vmware.com  |  "Reloading a vmx file without removing the virtual machine from inventory (1026043)"  |  https://kb.vmware.com/s/article/1026043
#
#   www.vgemba.net  |  "VM Console Display Resolution Change - vGemba.net"  |  https://www.vgemba.net/vmware/powercli/VMConsole-Resolution-Change/
#
# ------------------------------------------------------------