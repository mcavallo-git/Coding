#!/bin/sh

# Open firewall for outgoing http/s requests:
esxcli network firewall ruleset set -e true -r httpClient;

# List packages available in the V-Front depot:
esxcli software sources vib list -d http://vibsdepot.v-front.de;

# Get information about a package in the V-Front depot
esxcli software sources vib get -d http://vibsdepot.v-front.de -n sata-xahci;

# Install a community supported package from the V-Front depot:
# - Lower the system's acceptance level to match the package
esxcli software acceptance set --level=CommunitySupported;

# - Install the package
esxcli software vib install -d http://vibsdepot.v-front.de -n fw-ntpd;

# Install an unsigned package from the V-Front depot:
esxcli software vib install -d http://vibsdepot.v-front.de -n cpu-microcode --no-sig-check;

# Update installed packages from the V-Front depot:
esxcli software vib update -d http://vibsdepot.v-front.de;


# ------------------------------------------------------------
#
#	Citation(s)
#
#   www.v-front.de  |  "VMware Front Experience: Announcing the V-Front Online Depot for ESXi software"  |  https://www.v-front.de/2013/12/announcing-v-front-online-depot-for.html
#
# ------------------------------------------------------------