#!/bin/bash

# Ubnt (ERLite-3) - Force DHCP Lease-Renewal

sudo /opt/vyatta/bin/sudo-users/vyatta-clear-dhcp-lease.pl --lip=all


# UniFi (USG-3P) - Force DHCP Lease-Renewal

sudo /opt/vyatta/bin/sudo-users/vyatta-clear-dhcp-lease.pl --lip=all --ilfile=/config/dhcpd.leases --olfile=/config/dhcpd.leases --pidf=/run/dhcpd.pid

