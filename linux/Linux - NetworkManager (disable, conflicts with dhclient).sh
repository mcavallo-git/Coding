#!/bin/bash

# systemctl error while attempting to restart the network service: "Failed to start LSB: Bring up/down networking."

systemctl stop NetworkManager; systemctl disable NetworkManager;

# ------------------------------------------------------------
# Citation(s)
#
#   unix.stackexchange.com |  "Centos 7: failed to bring up/down networking: configure interface for a trunk interface"  |  https://unix.stackexchange.com/a/220961
#
# ------------------------------------------------------------