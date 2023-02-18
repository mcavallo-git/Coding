#!/bin/sh
# ------------------------------------------------------------
# VMware ESXi - .vib file info and installation from V-Front package repo
# ------------------------------------------------------------

# Open firewall for outgoing http/s requests:
esxcli network firewall ruleset set -e true -r httpClient;

# List packages available in the V-Front depot:
esxcli software sources vib list -d http://vibsdepot.v-front.de;

# Get information about a package in the V-Front depot
esxcli software sources vib get -d http://vibsdepot.v-front.de -n sata-xahci;

# ------------------------------
#
# Install community supported package(s) from the V-Front depot
#

# Lower the system's acceptance level to match the package
esxcli software acceptance set --level=CommunitySupported;

# Install a package from the V-Front depot
esxcli software vib install -d http://vibsdepot.v-front.de -n sata-xahci;

# Install a package at a specific version
esxcli software vib install -d http://vibsdepot.v-front.de -n "cpu-microcode:7.0.0-1";

# Install an unsigned package from the V-Front depot
esxcli software vib install -d http://vibsdepot.v-front.de --no-sig-check -n cpu-microcode;

# Update installed packages from the V-Front depot
esxcli software vib update -d http://vibsdepot.v-front.de;


# ------------------------------------------------------------
#
#	Citation(s)
#
#   www.v-front.de  |  "VMware Front Experience: Announcing the V-Front Online Depot for ESXi software"  |  https://www.v-front.de/2013/12/announcing-v-front-online-depot-for.html
#
# ------------------------------------------------------------