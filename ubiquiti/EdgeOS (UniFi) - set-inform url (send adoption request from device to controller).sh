#!/bin/sh
#
# Linux - UniFi - Send Adoption request to target-URL (from devices being adopted)
#
# ------------------------------------------------------------

# GET INFORM URL

info


# ------------------------------------------------------------

# SET INFORM URL

UNIFI_CONTROLLER_IPv4="192.168.1.15"; sudo set-inform "http://${UNIFI_CONTROLLER_IPv4}:8080/inform";

# Note: if performing this action on a USG-3P, you must first run "mca-cli" to enter edit mode for the USG-3P's UniFi config
# 
# mca-cli
# set-inform http://192.168.1.15:8080/inform
# exit
# reboot


###
### Adoption request sent to 'http://192.168.1.15:8080/inform'.
### 
### 1. please adopt it on the controller
### 2. issue the set-inform command again
### 3. <inform_url> will be saved after device is successfully managed
### 

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