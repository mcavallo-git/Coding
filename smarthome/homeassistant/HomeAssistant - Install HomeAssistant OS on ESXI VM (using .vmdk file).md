<!-- ------------------------------------------------------------ -->

# Installing HomeAssistant as an ESXi VM


<!-- ------------------------------------------------------------ -->

***
### Setup an ESXi 6.5+ host
  - Acquire an ESXi license (free)
    - Apply for a VMware license for your given version of ESXi (`6.x`, `7.x`, `8.x`, etc.) via the [My VMware portal](https://my.vmware.com/group/vmware/my-licenses)
  - Download an ESXi `.iso` bootable image
    - Reference: Powershell module [ESXI_BootMedia.psm1](https://github.com/mcavallo-git/Coding/blob/main/powershell/_WindowsPowerShell/Modules/ESXi_BootMedia/ESXi_BootMedia.psm1)
      - Call using command `ESXi_BootMedia -Create -ESXiVersion '6.5';` to create an ESXi v6.5 `.iso` file
    - Format ESXi .ISO file onto a USB flash drive using [Rufus.exe](https://rufus.ie/downloads/)
    - Plug USB flash drive into PC to format ESXi onto, boot to it, format PC, then connect via web-browser to ESXi host's IP address (using https://...) once it boots up


<!-- ------------------------------------------------------------ -->

***
### Download the latest HomeAssistant `.vmdk` file
  - [View GitHub Releases Page - home-assistant/operating-system](https://github.com/home-assistant/operating-system/releases/)
    - Locate the [latest release](https://github.com/home-assistant/operating-system/releases/latest) of the Home Assistant OS
      - Scroll down to `Assets`, search for text `.vmdk` (via `CTRL+F`), and click the file to download the latest Home Assistant OS `.vmdk` file
        - Example filename to download:  [`haos_ova-9.5.vmdk.zip`](https://github.com/home-assistant/operating-system/releases/download/9.5/haos_ova-9.5.vmdk.zip)   *(replace `9.5` with whatever the latest version is)*


<!-- ------------------------------------------------------------ -->

***
### Upload the HomeAssistant `.vmdk` file to ESXi datastore
  - In ESXi, browse to `Storage` > `Datastores` > `Datastore browser`
    - Create a directory named `iso`
      - Upload the `.vmdk` file downloaded from GitHub to this directory


<!-- ------------------------------------------------------------ -->

***
### Create the `HomeAssistant-OS` VM
  - [View YouTube Tutorial (Install Home Assistant OS in VMware ESXi)](https://www.youtube.com/watch?v=IxrF87VBTCg&t=110)
  - In ESXi, browse to `Virtual Machines` > `Create / Register VM`
    - `Create a new virtual machine`
      - &rarr; `Next`
    - `Name`:  `HomeAssistant-OS` (or anything other than `homeassistant`)
    - `Guest OS family`: `Linux`
    - `Guest OS version`: `Other 2.6.x Linux (64-bit)`
      - &rarr; `Next`
    - `Storage`: `(select datastore to run VM from)`
      - &rarr; `Next`
    - `CPU`: `2`
      - `Cores per Socket`: `1`
      - `Reservation`: `2061` `MHz`
      - `Limit`: `6184` `MHz`
    - `Memory`: `6144` `MB`
      - ✅ `Reserve all guest memory (all locked)`
      - `Limit`: `6144` `MB`
    - `Network Adapter 1`: `VM Network`
      - `Adapter Type`: `E1000e`
    - `Hard Disk`:  `DELETE`  (hit `X` on right side)
    - `SCSI Controller 0`: `DELETE`  (hit `X` on right side)
    - `CD/DVD Drive 1`:    `DELETE`  (hit `X` on right side)
    - `SATA Controller 0`: `DELETE`  (hit `X` on right side)
      - &rarr; `Next`


<!-- ------------------------------------------------------------ -->

***
### Copy `.vmdk` file to HomeAssistant VM's directory
  - In ESXi, browse to `Storage` > `Datastores` > `Datastore browser`
    - Copy the previously uploaded `.vmdk` file from its directory (`iso`) into the new VM's directory

<!-- ------------------------------------------------------------ -->

***
### Add `.vmdk` file to HomeAssistant VM
  - [View Docs (Install Home Assistant Operating System)](https://www.home-assistant.io/installation/linux)
  - On the HomeAssistant VM (to attach `.vmdk` disk to):
    - Edit settings
      - Add hard disk > Existing hard disk > (locate `.vmdk` file in new VM's datastore directory) > Set "Virtual Device Node"/"Controller location" to "IDE 0:0"/"IDE controller 0:Master"
      - VM Options > Boot Options > Firmware > Set to "EFI"


<!-- ------------------------------------------------------------ -->

***
### Perform initial HomeAssistant setup
  - In ESXi, start the HomeAssistant VM
  - Wait for console to show the URL of the HomeAssistant portal, or (alternatively)...
  - In your web browser, browse to the HomeAssistant portal @ the IPv4 address of the HomeAssistant VM, using port 8123 (http://VM_IPV4:8123)
  - The HomeAssistant portal should walk you through creation of initial admin user, then you should end up at the HomeAssistant home page / GUI


<!-- ------------------------------------------------------------ -->

***
### Quick Guide: Attaching a USB device(s) to ESXi VM from ESXi Host (pass-through USB)
  - [View YouTube Tutorial (How to Add Z-Wave to Home Assistant 2020)](https://www.youtube.com/watch?v=W0HD5mTqocA)
  - Physically plug-in USB device into ESXi host
  - In ESXi, on the HomeAssistant VM (to attach USB device to):
    - Shut down VM
    - Edit settings > Add other device > USB device > (Select USB device to attach to VM)
    - Start VM


<!-- ------------------------------------------------------------ -->

***
### Quick Guide: Using the shell terminal in HomeAssistant (direct or physical access to machine or VM running HA)
  - At the HomeAssistant terminal which shows a large ascii art "Home Assistant" logo, type the following command to login as the root user:
    `ha >   login`


<!-- ---------------------------------------------------------
#
# Citation(s)
#
#   docs.vmware.com  |  "Add USB Devices from an ESXi Host to a Virtual Machine"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.vm_admin.doc/GUID-68A08879-1744-4FF9-A856-D66C4AAB68AB.html
#
#   www.awesome-ha.com  |  "Awesome Home Assistant"  |  https://www.awesome-ha.com/
#
#   www.home-assistant.io  |  "Linux - Home Assistant"  |  https://www.home-assistant.io/installation/linux
#
#   www.youtube.com  |  "Install Home Assistant OS in VMware ESXi | Don't Miss These CRITICAL STEPS! - YouTube"  |  https://www.youtube.com/watch?v=IxrF87VBTCg
#
---------------------------------------------------------- -->