#!/bin/sh
#
# EdgeOS (UniFi) - get inform url (from client device for connected UniFi controller)
#
# ------------------------------------------------------------
#
# Get a UniFi device's outgoing inform URL:
#

info | grep inform;

# ^
# |-- Output is similar to: --|
#                             v
#   Status:      Connected (http://unifi:8080/inform)
#

# ------------------------------------------------------------
#
# Citation(s)
#
#   community.ui.com  |  "What is mca-cli (SSH) | Ubiquiti Community"  |  https://community.ui.com/questions/What-is-mca-cli-SSH/9dad411a-21b7-49d7-b07a-682e4f4f61c8
#
#   community.ui.com  |  "Where do I find current inform URL? | Ubiquiti Community"  |  https://community.ui.com/questions/Where-do-I-find-current-inform-URL/627dfeb7-7ffd-4975-b709-c947296438f4
#
#   help.ui.com  |  "UniFi - Layer 3 Adoption for Remote UniFi Network Applications – Ubiquiti Support and Help Center"  |  https://help.ui.com/hc/en-us/articles/204909754-UniFi-Device-Adoption-Methods-for-Remote-UniFi-Controllers
#
# ------------------------------------------------------------