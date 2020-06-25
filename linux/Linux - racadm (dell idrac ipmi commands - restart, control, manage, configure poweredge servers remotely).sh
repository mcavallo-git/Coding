#!/bin/bash
# ------------------------------------------------------------
#
#  Restarting iDRAC via SSH
#


# iDRAC v8
racadm racreset hard -f


# iDRAC v_?
racadm reset -h


# ------------------------------------------------------------
#
#  Disabling functionality for PCI devices which jack up the fan speed on PowerEdge Servers 
#


#
# Get the current setting for the fan speed
#
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
#   www.dell.com  |  "Solved: Re: racadm racreset vs Reset idrac - Dell Community"  |  https://www.dell.com/community/Systems-Management-General/racadm-racreset-vs-Reset-idrac/m-p/7315091#M27654
#
# ------------------------------------------------------------