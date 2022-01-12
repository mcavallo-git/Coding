#!/bin/sh
#
# EdgeOS (UniFi) - poe opmode shutdown (cycle PoE port on UniFi switches via CLI)
#
# ------------------------------------------------------------
#
# UniFi Switch Lite 16 PoE
#  |--> SKU:  USW-LITE-16-PoE
#

POE_PORT="${POE_PORT:-2}";


# ----------
#
# Get the status of the target PoE port
#

cli -E -c "show interfaces GigabitEthernet ${POE_PORT:-2}";


# ----------
#
# Restart the PoE port
#

cli -E -c "configure" -c "interface GigabitEthernet ${POE_PORT:-2}" -c "shutdown" && sleep ${TIMEOUT_EACH_LOOP:-5} && cli -E -c "configure" -c "interface GigabitEthernet ${POE_PORT:-2}" -c "no shutdown";

# Verbosely
if [[ 1 -eq 1 ]]; then
  POE_PORT="${POE_PORT:-2}";
  LOOP_ITERATIONS=10;
  TIMEOUT_EACH_LOOP=5;
  echo "";
  for i in $(seq 2); do # i==1 denotes shutdown step. i==2 denotes re-enable step
    for j in $(seq ${LOOP_ITERATIONS}); do
      PORT_STATUS="$(cli -E -c "show interfaces GigabitEthernet ${POE_PORT:-2}" | grep "GigabitEthernet${POE_PORT:-2}";)";
      echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%z')] ${PORT_STATUS}  (i=${i}, j=${j})";
      if [[ "$(echo "${PORT_STATUS}" | cut -d' ' -f3;)" == "up" ]]; then
        if [[ "${i}" -eq 1 ]]; then # shutdown step
          echo -e "\n[$(date +'%Y-%m-%dT%H:%M:%S%z')] Shutting down port # ${POE_PORT:-2}...\n";
          cli -c "configure" -c "interface GigabitEthernet ${POE_PORT:-2}" -c "shutdown";
        else # re-enable step
          break;
        fi;
      elif [[ "$(echo "${PORT_STATUS}" | cut -d' ' -f3;)" == "down" ]]; then
        if [[ "${i}" -eq 1 ]]; then # shutdown step
          break;
        else # re-enable step
          echo -e "\n[$(date +'%Y-%m-%dT%H:%M:%S%z')] Starting/Re-Enabling port # ${POE_PORT:-2}...\n";
          cli -c "configure" -c "interface GigabitEthernet ${POE_PORT:-2}" -c "no shutdown";
        fi;
      fi;
      sleep ${TIMEOUT_EACH_LOOP:-5};
    done;
    sleep ${TIMEOUT_EACH_LOOP:-5};
  done;
fi;

# ----------
#
# Shutdown the PoE port (if it is up)
#

if [[ -n "$(cli -E -c "show interfaces GigabitEthernet ${POE_PORT:-2}" | grep "GigabitEthernet${POE_PORT:-2} is up";)" ]]; then echo -e "\n[$(date +'%Y-%m-%dT%H:%M:%S%z')] Port ${POE_PORT:-2} is up - Shutting it down, now...\n"; cli -E -c "configure" -c "interface GigabitEthernet ${POE_PORT:-2}" -c "shutdown"; sleep 5; fi;

# GigabitEthernet2 is down
#   Hardware is Gigabit Ethernet
#   Auto-duplex, Auto-speed, media type is Copper
#   flow-control is off
#   back-pressure is enabled


# ----------
#
# Start (re-enable) the PoE port (if it is down)
#

if [[ -n "$(cli -E -c "show interfaces GigabitEthernet ${POE_PORT:-2}" | grep "GigabitEthernet${POE_PORT:-2} is down";)" ]]; then echo -e "\n[$(date +'%Y-%m-%dT%H:%M:%S%z')] Port ${POE_PORT:-2} is down - Starting/Re-Enabling it, now...\n"; cli -E -c "configure" -c "interface GigabitEthernet ${POE_PORT:-2}" -c "no shutdown"; sleep 5; fi;



# GigabitEthernet2 is up
#   Hardware is Gigabit Ethernet
#   Auto-duplex, Auto-speed, media type is Copper
#   flow-control is off
#   back-pressure is enabled


# ------------------------------------------------------------
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