#!/bin/sh
#
# Linux - dig
# 	|--> use dig to identify DNS info regarding a given host/domain
#


# Get all readily-available DNS Information
dig google.com ANY


# Get one, single IPv4
dig google.com +short


# Get A-Record(s) (IPv4)
dig google.com A


# Get MX Record(s) (Email)
dig google.com MX



# Get TXT Record(s)
dig google.com TXT



# ------------------------------------------------------------
#
# Citation(s)
#
# 	linux.die.net, "dig(1) - Linux man page", https://linux.die.net/man/1/dig
#
# ------------------------------------------------------------