#!/bin/bash

# ------------------------------------------------------------
# CentOS / RHEL - Install MongoDB

# Setup & Downlaod the Package Repository & Package (itself)
echo -e "[mongodb-org-4.2]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/4.2/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc\n" > "/etc/yum.repos.d/mongodb-org-4.2.repo"; yum check-update; yum install -y mongodb-org;
mkdir -p "/var/lib/mongo"; chown -R "mongod:mongod" "/var/lib/mongo"; chmod 0755 "/var/lib/mongo";
mkdir -p "/var/lib/mongodb"; chown -R "mongod:mongod" "/var/lib/mongodb"; chmod 0755 "/var/lib/mongodb";
service mongod start;

# Setup IP Address as [ Loopback,LAN ] instead of [ Loopback ]
THIS_IPv4=$(ip addr show | grep 'inet' | grep 'scope global' | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.');
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^  bindIp: 127.0.0.1 /c\  bindIp: 127.0.0.1,${THIS_IPv4}" "/etc/mongod.conf";
cat "/etc/mongod.conf";

# Setup access security
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e '
/^#security:/ {
a\
  keyFile: /var/lib/mongo/keyfile
a\
  authorization: enabled
c\
security:
}' "/etc/mongod.conf"; \
cat "/etc/mongod.conf"; \
service mongod restart;



# ------------------------------------------------------------
# Citation(s)
#
#   docs.mongodb.com  |  "Install MongoDB Community Edition on Debian"  |  https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/
#
#   docs.mongodb.com  |  "Install MongoDB Community Edition on Red Hat or CentOS"  |  https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
#
#   docs.mongodb.com  |  "Install MongoDB Community Edition on Ubuntu"  |  https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
#
# ------------------------------------------------------------