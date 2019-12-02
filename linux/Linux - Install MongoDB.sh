#!/bin/bash


# CentOS / RHEL
echo -e "[mongodb-org-4.2]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/4.2/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc\n" > "/etc/yum.repos.d/mongodb-org-4.2.repo"; yum check-update; yum install -y mongodb-org;

mkdir -p "/var/lib/mongo"; chown -R "mongod:mongod" "/var/lib/mongo";
mkdir -p "/var/lib/mongodb"; chown -R "mongod:mongod" "/var/lib/mongodb";

# ------------------------------------------------------------
# Citation(s)
#
#   docs.mongodb.com  |  "Install MongoDB Community Edition on Debian"  |  https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/
#
#   docs.mongodb.com  |  "Install MongoDB Community Edition on Red Hat or CentOS"  |  https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
#
#   docs.mongodb.com  |  "Install MongoDB Community Edition on Ubuntu"  |  https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
#
#
# ------------------------------------------------------------