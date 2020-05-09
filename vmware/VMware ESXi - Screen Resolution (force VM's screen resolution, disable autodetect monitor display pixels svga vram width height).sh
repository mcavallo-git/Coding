#!/bin/sh
# ------------------------------------------------------------
#
# Backend command for selecting VM setting: "Video Card" > "Specify custom settings" > "Total video memory" >  [ 8 ] MB
#
vi "/vmfs/volumes'datastore1/VMDIR/VMNAME.vmx";
svga.autodetect = "FALSE"
svga.minVRAMSize = "8388608"

# Reload the VM's config (applies any changes made to the VM's ".vmx" config-file)
ESXI_VM_NAME="VM_NAME"; ID_VM=$(vim-cmd vmsvc/getallvms | sed -e '1d' -e 's/ \[.*$//' | awk '$1 ~ /^[0-9]+$/ {print $1":"substr($0,8,80)}' | sed -rne "s/^([0-9]+):(${ESXI_VM_NAME}\s*)$/\1/p";); echo "ID_VM: ${ID_VM}"; vim-cmd vmsvc/reload ${ID_VM};



# ------------------------------------------------------------
#
# Increase total video memory allocated to a target VM (to allow for larger resolution outputs)
#  > Step 1: Shutdown the VM, then manually SSH into the ESXi server and edit said VM's ".vmx" config file
#   > Step 2: Add the following lines to said ".vmx" config-file
#    > Note: The [ svga.vramSize ] config-value can be quickly calculated by multiplying desired-max-width by desired-max-height you wish to grant to target VM (regarding display resolution)
#             - e.g. If a 1920x1080 resolution is desired to be the maximum resolution allocated for a given VM, then one would set [ svga.vramSize=2073600 ] in the target VM's ".vmx" config-file, since 1920 * 1080 = 2073600
#
vi "/vmfs/volumes'datastore1/VMDIR/VMNAME.vmx";
# ... (Add the following lines to the bottom of the ".vmx" file)
svga.vramSize = "2073600"
svga.present = "TRUE"
svga.guestBackedPrimaryAware = "TRUE"

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