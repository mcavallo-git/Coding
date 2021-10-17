#!/bin/bash
# ------------------------------------------------------------

# ping (run a while loop to continuously check device online-offline status)
PING_HOST="8.8.8.8"; while [ 1 -eq 1 ]; do echo -n "Pinging \"${PING_HOST}\":   "; ping -w 1 -c 1 "${PING_HOST}" | grep ms | head -n 1; done;


# ------------------------------------------------------------