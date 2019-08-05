### UniFi - Adopting a Device


#### !!! NOTE: Before running any of the following commands, replace the values with your relative values
* ######  IPv4 of UniFi Controller (performing-adoption):  192.168.1.27
* ######  IPv4 of UniFi Device (to-be-adopted):  192.168.1.2
* ######  Admin-User on UniFi Device (to-be-adopted):  ADMIN
* ######  Admin-Password on UniFi Device (to-be-adopted):  PASSWORD


#### Via SSH
```
ssh 192.168.1.2

# login as:
ADMIN

# admin@192.168.1.2's password:
PASSWORD

# BusyBox v1.19.4 (2016-05-29 23:56:59 PDT) built-in shell (ash)
# Enter 'help' for a list of built-in commands.

# BZ.v3.7.5#
syswrapper.sh restore-default; set-inform http://192.168.1.27:8080/inform;

# Adoption request sent to 'http://192.168.1.27:8080//inform'.

# 1. please adopt it on the controller
# 2. issue the set-inform command again
# 3. <inform_url> will be saved after device is successfully managed

# *** MANUALLY ADOPTED DEVICE VIA CONTROLLER GUI (Step #1)


# *** ISSUE SET-INFORM COMMAND (Step #2)
set-inform http://192.168.1.27:8080/inform;


# *** Inform URL saved automatically (Step #3)
```
