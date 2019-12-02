#!/bin/bash

firewall-cmd --list-all;



# Ex) List all firewall-cmd rules, then allow traffic for SSH (22) & MongoDB (27017) Ports, restart the firewall service, then list all rules again
firewall-cmd --list-all; firewall-cmd --permanent --add-port=22/tcp --add-port=27017/tcp; firewall-cmd --reload; firewall-cmd --list-all;

