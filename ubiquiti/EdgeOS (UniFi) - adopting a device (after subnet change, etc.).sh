#!/bin/bash

### UniFi - Adopting a Device


#### !!! NOTE: Before running any of the following commands, replace the values with your relative values
######  IPv4 of UniFi Controller (performing-adoption):  192.168.1.27
######  IPv4 of UniFi Device (to-be-adopted):  192.168.1.2
######  Admin-User on UniFi Device (to-be-adopted):  ADMIN
######  Admin-Password on UniFi Device (to-be-adopted):  PASSWORD


#### SSH into your the Unifi device which you wish to adopt
ssh 192.168.0.1

# login using admin-user/admin-passwd credentials (google for default UniFi device SSH credentials if you can't get it, otherwise, you may need to factory reset the device (worst-case), then get in after it resets)
ADMIN
PASSWORD

# BusyBox v1.19.4 (2016-05-29 23:56:59 PDT) built-in shell (ash)
# Enter 'help' for a list of built-in commands.

# BZ.v3.7.5#
syswrapper.sh restore-default; \
UNIFI_CONTROLLER_IP="192.168.1.27"; \
set-inform "http://${UNIFI_CONTROLLER_IP}:8080/inform";

# Adoption request sent to 'http://192.168.1.27:8080//inform'.

# !!! LOG INTO UNIFI CONTROLLER VIA WEB GUI
#  > 1. Adopt it on the controller
#  > 2. Once you've hit "Adopt" on the controller, go back to the SSH terminal, hit up (to repeat last command), and Re-issue the "set-inform http://..." command
#  > 3. The <inform_url> will be saved after device is successfully managed

# *** MANUALLY ADOPTED DEVICE VIA CONTROLLER GUI (Step #1)


# *** ISSUE SET-INFORM COMMAND (Step #2)
UNIFI_CONTROLLER_IP="192.168.1.27"; \
set-inform "http://${UNIFI_CONTROLLER_IP}:8080/inform";


# *** Inform URL saved automatically (Step #3)
```
