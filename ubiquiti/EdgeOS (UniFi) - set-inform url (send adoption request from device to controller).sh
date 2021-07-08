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
#   community.ui.com  |  "Where do I find current inform URL? | Ubiquiti Community"  |  https://community.ui.com/questions/Where-do-I-find-current-inform-URL/627dfeb7-7ffd-4975-b709-c947296438f4
#
# ------------------------------------------------------------