
#
#	Referring to guide:
#
# https://help.ubnt.com/hc/en-us/articles/360006634094-UniFi-Network-Controller-Repairing-Database-Issues-on-the-UniFi-Controller
#


# How to Repair a Database on Debian-based Linux

service unifi stop;

mongod --dbpath /usr/lib/unifi/data/db --smallfiles --logpath /usr/lib/unifi/logs/server.log --repair;

chown -R "unifi:unifi /usr/lib/unifi/data/db/";
chown -R "unifi:unifi /usr/lib/unifi/logs/server.log";

service unifi start;
