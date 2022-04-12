#!/bin/sh
# ------------------------------------------------------------
#
# Linux - dig
# 	|--> use dig to identify DNS info regarding a given host/domain
#
# ------------------------------------------------------------

#
# Get all readily-available DNS Information
#
dig any google.com


#
# Quickly resolve an IPv4 address for target hostname/fqdn
#
dig +short google.com


# ------------------------------------------------------------
#
# Use a proxy-server for DNS resolution
#  |--> from [ man dig ]:
#    "If @server is also specified, it affects only the
#     initial query for the root zone name servers."
#

dig @8.8.8.8 google.com

dig @208.67.222.222 google.com




# ------------------------------------------------------------
#
# Get A-Record(s) (IPv4)
#
dig google.com A


#
# Get MX Record(s) (Email)
#
dig google.com MX


#
# Get TXT Record(s)
#
dig google.com TXT


# ------------------------------------------------------------
#
# Citation(s)
#
#   linux.die.net  |  "dig(1): DNS lookup utility - Linux man page"  |  https://linux.die.net/man/1/dig
#
# ------------------------------------------------------------