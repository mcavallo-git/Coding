#!/bin/bash
# ------------------------------------------------------------
# How to Repair a Database on Debian-based Linux

service unifi stop;

mongod --dbpath /usr/lib/unifi/data/db --smallfiles --logpath /usr/lib/unifi/logs/server.log --repair;

chown -R "unifi:unifi" "/usr/lib/unifi/data/db/";
chown -R "unifi:unifi" "/usr/lib/unifi/logs/server.log";

service unifi start;


# ------------------------------------------------------------

mongoexport --collection="startup_log" --db="local" --out="mongoexport.$(date +'%Y%m%d_%H%M%S').json";



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.mongodb.com  |  "mongoexport — MongoDB Manual"  |  https://docs.mongodb.com/manual/reference/program/mongoexport/#cmdoption-mongoexport-collection
#
#   docs.mongodb.com  |  "mongoimport — MongoDB Manual"  |  https://docs.mongodb.com/manual/reference/program/mongoimport/
#
#   help.ubnt.com  |  "UniFi - Network Controller: Repairing Database Issues on the UniFi Controller – Ubiquiti Networks Support and Help Center"  |  https://help.ubnt.com/hc/en-us/articles/360006634094-UniFi-Network-Controller-Repairing-Database-Issues-on-the-UniFi-Controller
#
#   stackoverflow.com  |  "Reducing MongoDB database file size - Stack Overflow"  |  https://stackoverflow.com/a/2975296
#
# ------------------------------------------------------------