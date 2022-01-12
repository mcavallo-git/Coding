#!/bin/bash
#
# ------------------------------------------------------------
#
# Folowing guide @ https://help.ubnt.com/hc/en-us/articles/220066768-UniFi-How-to-Install-and-Update-via-APT-on-Debian-or-Ubuntu
#
# ------------------------------------------------------------

# apt-get -y upgrade;
# apt-get -y autoremove;
# apt-get clean;
# reboot;

if [  1 -eq 1 ]; then

# Install pre-requisite package(s)
apt-get -y update; apt-get -y install apt-transport-https ca-certificates openjdk-8-jre-headless wget;

# Add the Unifi package repository
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee "/etc/apt/sources.list.d/100-ubnt-unifi.list";

# Import Unifi's official GPG Key
wget -O "/etc/apt/trusted.gpg.d/unifi-repo.gpg" "https://dl.ui.com/unifi/unifi-repo.gpg";

# Install Unifi for Debian, Ubuntu, etc.
apt-get -y update; apt-get -y install unifi;

echo -e "\n""   Open a browser to  [ https://$(hostname):8443 ]  to continue""\n";

fi;

#### 

# ------------------------------------------------------------
apt-get update;
#  ^
#  |
#  |--> THREW ERROR:
#  |     {
#  |        ...
#  |        Reading package lists... Done
#  |        W: GPG error: http://ftp.debian.org jessie-backports InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 8B48AD6246925553 NO_PUBKEY 7638D0442B90D010
#  |        ...
#  |     }
#  |--> HOTFIX 1 - Unifi Fingerprint Issue:
HOTFIX_FINGERPRINT="8B48AD6246925553"; gpg --keyserver pgpkeys.mit.edu --recv-key ${HOTFIX_FINGERPRINT}; gpg -a --export ${HOTFIX_FINGERPRINT} | sudo apt-key add -;
#  |--> HOTFIX 2 - Unifi Fingerprint Issue:
HOTFIX_FINGERPRINT="7638D0442B90D010"; gpg --keyserver pgpkeys.mit.edu --recv-key ${HOTFIX_FINGERPRINT}; gpg -a --export ${HOTFIX_FINGERPRINT} | sudo apt-key add -;
#  |--> HOTFIX 3 (2019-08-01_07-53-58) - Unifi Fingerprint Issue:
apt-get install -y debian-keyring;
apt-get install -y debian-archive-keyring;
HOTFIX_FINGERPRINT="06E85760C0A52C50"; gpg --keyserver "keyserver.ubuntu.com" --recv-key ${HOTFIX_FINGERPRINT}; gpg -a --export ${HOTFIX_FINGERPRINT} | sudo apt-key add -;
sudo apt-key adv --keyserver "keyserver.ubuntu.com" --recv "0C49F3730359A14518585931BC711F9BA15703C6";
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee "/etc/apt/sources.list.d/mongodb-org-3.4.list";
apt-get update -y;
#  |--> HOTFIX 4 (2019-08-01_08-27-52) - Note: Not a Unifi Fingeprint, but rather the "Raspberry Pi Archive Signing Key" - errors were still shown when trying to update Unifi
HOTFIX_FINGERPRINT="82B129927FA3303E"; gpg --keyserver "hkps://hkps.pool.sks-keyservers.net:443" --recv-key ${HOTFIX_FINGERPRINT}; gpg -a --export ${HOTFIX_FINGERPRINT} | sudo apt-key add -;

# REPEAT
apt-get -y update;

# Install Unifi
apt-get -y install unifi;

# Stop & Disable default mongodb service
systemctl stop mongodb; systemctl disable mongodb;

## On the Raspberry Pi 1 and Raspberry Pi Zero (W), which are both older ARMv6-based devices, UniFi Cloud Library support must be removed using the following command:
## sudo rm "/usr/lib/unifi/lib/native/Linux/armhf/libubnt_webrtc_jni.so";

reboot;

## On Reboot, follow setup Wizard:   http://www.technologist.site/2016/06/02/how-to-install-ubiquiti-unifi-controller-5-on-the-raspberry-pi/3/#setup-wizard

## UPDATING UNIFI SERVER:
#      apt-get update;
#      apt-get -y upgrade;

## DISABLING RASPBERRY PI'S WIFI
# sudo -i
# crontab -e
#  ^--> ADD: {   @reboot ifdown wlan0   }
