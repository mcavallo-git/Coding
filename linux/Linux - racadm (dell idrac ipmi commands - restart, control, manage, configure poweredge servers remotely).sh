#!/bin/bash
#
#  Restarting iDRAC via SSH
#

# iDRAC v8
racadm racreset hard -f

# iDRAC v_?
racadm reset -h


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.dell.com  |  "Solved: Re: racadm racreset vs Reset idrac - Dell Community"  |  https://www.dell.com/community/Systems-Management-General/racadm-racreset-vs-Reset-idrac/m-p/7315091#M27654
#
# ------------------------------------------------------------