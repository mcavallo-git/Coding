#!/bin/bash

# Ubnt (ERLite-3) - Force DHCP Lease-Renewal

sudo /opt/vyatta/bin/sudo-users/vyatta-clear-dhcp-lease.pl --lip=all
