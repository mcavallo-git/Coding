#!/bin/bash
# ------------------------------------------------------------
#
#  Restarting iDRAC via SSH
#


# iDRAC v8
racadm racreset soft
racadm racreset hard -f


# iDRAC v_?
racadm reset -h


# ------------------------------------------------------------
#
#  Disabling functionality for PCI devices which jack up the fan speed on PowerEdge Servers 
#   |--> To resolve this, I ended up having to:
#
#         > Browse to iDRAC
#          > Launch remote Java IPMI connection
#
#         > Browse to ESXI (host OS)
#          > Shut down all VMs
#           > Enter Maintenance mode
#            > Reboot server
#
#         > Enter "System Setup" (BIOS) during bootup (F2) 
#          > System Settings
#           > System Profile
#            > Set to "Performance per Watt (OS)"
#             > Save and Exit (Reboot Server)
#
#         > Browse to iDRAC
#          > On the left navigation within iDRAC, dropdown the Hardware section (hit the + next to it)
#           > Select "Fans" under the Hardware dropdown
#            > At the top of the window, select "Fan Configuration" or "Fan Setup" (or similar sounding option)
#             > Modify EVERY value to anything other than what they're currently set-to (just to trigger ANY change on each value) - I speculate that a BIOS update may have corrupted these values
#              > When popup appears to reboot server, select "Reboot now"
#             > Repeat these steps except in Fan settings, set to "Minimum Power", and select "Default" option for every other field
#              > When popup appears to reboot server, select "Reboot now"
#
#         > SSH into iDRAC
#          > Run command "racadm racreset soft" to restart iDRAC and fully apply new configuration
#


#
# Get the current thermal settings
#

racadm get system.thermalsettings

racadm get system.thermalsettings.ThirdPartyPCIFanResponse
#  ^ Returns Enabled (1) or Disabled (0)


racadm set system.thermalsettings.ThirdPartyPCIFanResponse 0
#  ^ Disable PCI fan response


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.dell.com  |  "Integrated Dell Remote Access Controller 8 (iDRAC8) and iDRAC7 v2.20.20.20 User's Guide"  |  https://www.dell.com/support/manuals/us/en/04/idrac7-8-with-lc-v2.20.20.20/idrac8_2.10.10.10_ug-v2/modifying-thermal-settings-using-racadm?guid=guid-476e0462-fb31-4dac-be4a-3af3801ae556&lang=en-us
#
#   www.dell.com  |  "PowerEdge R730xd cooling / fan noise issue - Dell Community"  |  https://www.dell.com/community/PowerEdge-Hardware-General/PowerEdge-R730xd-cooling-fan-noise-issue/td-p/7187458
#
#   www.dell.com  |  "Solved: Re: racadm racreset vs Reset idrac - Dell Community"  |  https://www.dell.com/community/Systems-Management-General/racadm-racreset-vs-Reset-idrac/m-p/7315091#M27654
#
# ------------------------------------------------------------