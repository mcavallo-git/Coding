#!/bin/bash
exit 1;
#
# Manual log of actions-performed while upgrading Raspi from Debian-8 (jessie) to Debian-9 (stretch)
#
#	Following guide @ http://baddotrobot.com/blog/2017/10/26/upgrade-raspian-jessie-to-stretch/
#

sudo -i;

apt-get -y update; apt-get -y upgrade; apt-get -y dist-upgrade;

dpkg -C; # Nothing returned (no errors)

apt-mark showhold; # Nothing returned (no errors)

rpi-update; #... hit 'y' to agree that drivers may not match current drivers

reboot;

sed -i 's/jessie/stretch/g' /etc/apt/sources.list;

sed -i 's/jessie/stretch/g' /etc/apt/sources.list.d/raspi.list;

grep -lnr jessie /etc/apt; # First time around, returned 4 files w/ old release 'jessie' still found in them - replace all with 'stretch'
# /etc/apt/apt.conf
# /etc/apt/trusted.gpg~
# /etc/apt/apt.conf.d/50unattended-upgrades
# /etc/apt/trusted.gpg

sed -i 's/jessie/stretch/g' /etc/apt/apt.conf;
sed -i 's/jessie/stretch/g' /etc/apt/trusted.gpg~;
sed -i 's/jessie/stretch/g' /etc/apt/apt.conf.d/50unattended-upgrades;
sed -i 's/jessie/stretch/g' /etc/apt/trusted.gpg;

grep -lnr jessie /etc/apt; # Second time around. nothing returned (good to proceed)

apt-get remove apt-listchanges;

cat /etc/os-release;
# PRETTY_NAME="Raspbian GNU/Linux 8 (jessie)"
# NAME="Raspbian GNU/Linux"
# VERSION_ID="8"
# VERSION="8 (jessie)"
# ...

# Perform the upgrade
apt-get -y update && apt-get upgrade -y; # LONG WAIT HERE - 600+ package upgrades

apt-get -y dist-upgrade; # LONG WAIT HERE, AS WELL - 450+ package upgrades

apt-get -y autoremove && apt-get -y autoclean;

# Verify with
cat /etc/os-release;
