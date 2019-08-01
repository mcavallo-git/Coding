#!/bin/bash

# Via guide @ https://help.ubnt.com/hc/en-us/articles/220066768-UniFi-How-to-Install-and-Update-via-APT-on-Debian-or-Ubuntu

apt-get update;
apt-get -y upgrade;
apt-get -y install oracle-java8-jdk;
apt-get -y autoremove;
apt-get clean;
reboot;

echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | sudo tee -a /etc/apt/sources.list.d/100-ubnt.list > /dev/null;

wget -O "/etc/apt/trusted.gpg.d/unifi-repo.gpg" "https://dl.ui.com/unifi/unifi-repo.gpg";

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
#  |--> HOTFIX 1-of-2:      NO_PUBKEY [KEY]   -->   [KEY] = 8B48AD6246925553
gpg --keyserver pgpkeys.mit.edu --recv-key 8B48AD6246925553; 
gpg -a --export 8B48AD6246925553 | sudo apt-key add -;
#  |--> HOTFIX 2-of-2:      NO_PUBKEY [KEY]   -->   [KEY] = 7638D0442B90D010
gpg --keyserver pgpkeys.mit.edu --recv-key 7638D0442B90D010; 
gpg -a --export 7638D0442B90D010 | sudo apt-key add -;

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
