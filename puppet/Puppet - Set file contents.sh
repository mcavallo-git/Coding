#!/bin/bash
exit 1;
# ------------------------------------------------------------

sudo -i

apt-get -y update; apt-get -y install puppet;

mkdir -p "/var/save/puppet_hello";

chmod 0770 "/var/save/puppet_hello";

echo -e "file {\n  \"/var/save/puppet_hello/hellopuppet.txt\":\n    ensure => file,\n    content => \"Hello Puppet\",\n}" >> "/var/save/puppet_hello/hellopuppet.pp";

puppet apply "/var/save/puppet_hello/hellopuppet.pp";

# File should be created at filepath [ /var/save/puppet_hello/hellopuppet.txt ] with contents [ Hello Puppet ]  (without a trailing newline)


# ------------------------------------------------------------
#
# Citation(s)
#
#   jussinotes.wordpress.com  |  "Learning Puppet 1: Hello World! | School Work and Other Notes"  |  https://jussinotes.wordpress.com/2013/04/01/learning-puppet-1-hello-world/
#
# ------------------------------------------------------------