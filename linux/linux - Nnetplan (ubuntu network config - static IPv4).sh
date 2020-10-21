#
# CFG="/etc/netplan/99-netplan-config.yaml"; echo "" > "${CFG}"; vi "${CFG}"; netplan apply;
#

network:
  version: 2
  ethernets:
    eth0:
      addresses: [192.168.1.25/24]  # Static IPv4 192.168.1.25
      dhcp4: no  # Do not attempt to pull a DHCP lease
      gateway4: 192.168.1.1  # Network Gateway IPv4 192.168.1.1
      nameservers:
        addresses: [192.168.1.1,8.8.8.8]  # Primary DNSv4 192.168.1.1, Secondary DNSv4 8.8.8.8


# ------------------------------------------------------------
#
# Citation(s)
#
#   netplan.io  |  "Netplan | Backend-agnostic network configuration in YAML"  |  https://netplan.io/reference/
#
# ------------------------------------------------------------