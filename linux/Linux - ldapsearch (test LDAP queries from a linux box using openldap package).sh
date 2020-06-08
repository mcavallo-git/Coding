#!/bin/bash
# ------------------------------------------------------------
#
# Test AD connection in Linux
#

yum -y install openldap*;

ldapsearch \
-x \
-h "DC_FQDN_or_IPv4" \
-D "CN=LOGIN_USER_CN,AD-Auth,OU=Users,DC=example,DC=com" \
-W \
-b "dc=example,dc=com" \
-s sub "(cn=*)" cn mail sn;


# ------------------------------------------------------------
#
# Citation(s)
#
#   plugins.jenkins.io  |  "Active Directory | Jenkins plugin"  |  https://plugins.jenkins.io/active-directory/
#
#   stackoverflow.com  |  "hudson - How can I limit Jenkins LDAP access to users in a specific groupOfNames? - Stack Overflow"  |  https://stackoverflow.com/a/37191361
#
# ------------------------------------------------------------