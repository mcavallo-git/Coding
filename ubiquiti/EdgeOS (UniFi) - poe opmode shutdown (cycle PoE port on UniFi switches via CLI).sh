#!/bin/sh
#
# EdgeOS (UniFi) - poe opmode shutdown (cycle PoE port on UniFi switches via CLI)
#
# ------------------------------------------------------------
#
# UniFi Switch Lite 16 PoE
#  |--> SKU:  USW-LITE-16-PoE
#
echo "cli";
echo "?";
#  clear             Reset functions
#  clock             Manage the system clock
#  configure         Configuration Mode
#  copy              Copy from one file to another
#  debug             debug
#  delete            Delete a file from the flash file system
#  disable           Turn off privileged mode command
#  end               End current mode and change to enable mode
#  exit              Exit current mode and down to previous mode
#  no                Negate command
#  ping              Send ICMP ECHO_REQUEST to network hosts
#  reboot            Halt and perform a cold restart
#  renew             Renew functions
#  restore-defaults  Restore to default
#  save              Save running configuration to flash
#  show              Show running system information
#  ssl               Setup SSL host keys
#  terminal          Terminal configuration
#  traceroute        Trace route to network hosts

echo "configure";
echo "?";
#  aaa              Authentication, Authorization, Accounting
#  authentication   Auth Manager Global Configuration Commands
#  clock            Manage the system clock
#  custom           Custom Module configuration
#  dos              DoS information
#  dot1x            802.1x configuration
#  do               To run exec commands in current mode
#  enable           Local Enable Password
#  end              End current mode and change to enable mode
#  errdisable       Error Disable
#  exit             Exit current mode and down to previous mode
#  hostname         Set system's network name
#  interface        Select an interface to configure
#  ip               IP configuration
#  ipv6             IPV6 configuration
#  jumbo-frame      Jumbo Frame configuration
#  lacp             LACP Configuration
#  lag              Link Aggregation Group Configuration
#  line             To identify a specific line for configuration
#  lldp             Global LLDP configuration subcommands
#  logging          Log Configuration
#  mac              MAC configuration
#  management       IP management
#  management-vlan  Management VLAN configuration
#  mirror           Mirror configuration
#  mvr              MVR global enable
#  no               Negate command
#  port-security    Port Security
#  qos              QoS configuration
#  radius           RADIUS server information
#  snmp             SNMP information
#  spanning-tree    Spanning-tree configuration
#  storm-control    Storm control configuration
#  system           System information
#  tacacs           TACACS+ server information
#  username         Local User
#  vlan             VLAN configuration
#  voice-vlan       Voice VLAN configuration

echo "interface ?";
# GigabitEthernet  Gigabit ethernet interface to configure
# LAG              IEEE 802.3 Link Aggregateion interface
# range            interface range command

echo "interface LAG ?";
#  <1-8>  LAG

echo "interface GigabitEthernet ?";
#  <1-16>  GigabitEthernet

echo "interface GigabitEthernet 2";
echo "?";
#  authentication  Auth Manager Port Configuration Commands
#  back-pressure   Enable back-pressure
#  custom          Custom Module configuration
#  description     Interface specific description
#  dos             DoS information
#  dot1x           802.1x configuration
#  do              To run exec commands in current mode
#  duplex          Configure duplex operation
#  eee             EEE configuration
#  end             End current mode and change to enable mode
#  exit            Exit from current mode
#  flowcontrol     Configure flow-control mode
#  ip              Global IP configuration commands
#  ipv6            IPV6 configuration
#  lacp            LACP Configuration
#  lag             Link Aggregation Group Configuration
#  lldp            LLDP interface subcommands
#  mac             MAC configuration
#  mvr             MVR Configuration
#  no              Negate command
#  port-security   Port Security
#  protected       Configure an interface to be a protected port
#  qos             QoS configuration
#  rate-limit      Rate limit configuration of the specified incoming traffic
#  shutdown        Shutdown the selected interface
#  spanning-tree   Spanning-tree configuration
#  speed           Configure speed operation
#  storm-control   Storm control configuration
#  switchport      Set switching mode characteristics
#  vlan            VLAN configuration
#  voice-vlan      Voice VLAN configuration

echo "shutdown"; # Port shuts down

echo "no shutdown"; # Port is re-enabled and comes back on

echo "exit";
echo "exit";
echo "exit";
echo "exit";




# echo "poe opmode shutdown"; echo  "poe opmode auto"; echo "exit"; echo "exit"; echo "exit"  ) | telnet localhost 23; exit;

# ------------------------------
#
# Bash one-liner for cycling switch PoE power on a specific port (thanks to xsherlock on UniFi forums - see Citation(s), below)
#

UNIFI_SSH_USERNAME="${UNIFI_SSH_USERNAME:-admin}";
UNIFI_SSH_USERPASS="${UNIFI_SSH_USERPASS}";
UNIFI_CONTROLLER_IPV4="${UNIFI_CONTROLLER_IPV4:-192.168.1.15}";
sshpass -p ${UNIFI_SSH_USERPASS} ssh ${UNIFI_SSH_USERNAME}@${UNIFI_CONTROLLER_IPV4} '(echo "enable" ; echo "configure" ; echo "interface 0/38" ; echo "poe opmode shutdown" ; echo  "poe opmode auto" ; echo "exit" ; echo "exit"; echo "exit"  ) | telnet localhost 23 ; exit;';


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.ui.com  |  "Power Cycle POE port on UniFi Switch remotely. | Ubiquiti Community"  |  https://community.ui.com/questions/Power-Cycle-POE-port-on-UniFi-Switch-remotely-/f14675bd-85ae-41de-a524-5ffdfcdca7bf#answer/9a8ad92a-5520-478c-b886-f06f767d840c
#
#   forum.logicmachine.net  |  "Reset POE Port on Unifi Switch - Connecting to a device via SSH Key"  |  https://forum.logicmachine.net/showthread.php?tid=3139
#
#   github.com  |  "Tools/ubnt-unifi-switch-poe-on-off.sh at master · chenkaie/Tools · GitHub"  |  https://github.com/chenkaie/Tools/blob/master/ubnt-unifi-switch-poe-on-off.sh
#
#   ubntwiki.com  |  "products:software:unifi-controller:api [Ubiquiti Community Wiki]"  |  https://ubntwiki.com/products/software/unifi-controller/api
#
# ------------------------------------------------------------