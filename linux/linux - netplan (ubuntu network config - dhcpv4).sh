#
# CFG="/etc/netplan/99-netplan-config.yaml"; echo "" > "${CFG}"; vi "${CFG}"; netplan apply;
#

network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true  # Do not attempt to pull a DHCP lease


# ------------------------------------------------------------
#
# Citation(s)
#
#   netplan.io  |  "Netplan | Backend-agnostic network configuration in YAML"  |  https://netplan.io/reference/
#
# ------------------------------------------------------------