#!/bin/bash

# --------------------------------------------------------------------------------------------------------- #


# Show Settings (Before Edits)
coproc bluetoothctl; echo -e 'show\nexit' >&${COPROC[1]};
status=$(cat <&${COPROC[0]}); echo "$status"; rfkill list;


# --------------------------------------------------------------------------------------------------------- #


# Disable Bluetooth via  [ bluetooth_ctl ]
bt_01="discoverable off";
bt_02="pairable off";
bt_03="scan off";
bt_04="power off";
BLUETOOTH_CTL_OFF="${bt_01}\n${bt_02}\n${bt_03}\n${bt_04}\nexit";
coproc bluetoothctl;
echo -e "${BLUETOOTH_CTL_OFF}" >&${COPROC[1]};
output=$(cat <&${COPROC[0]});
echo "$output";


# --------------------------------------------------------------------------------------------------------- #


#  Disable Bluetooth via  [ rfkill ]
rfkill block bluetooth;

#  ^^^ This is essentially the same as doing:
# 	DIR_RFKILL_BT="/sys/devices/platform/soc/3f201000.serial/tty/ttyAMA0/hci0/rfkill0";
# 	echo 1 > "${DIR_RFKILL_BT}/soft";


# --------------------------------------------------------------------------------------------------------- #


# Show Settings (After Edits)
coproc bluetoothctl; echo -e 'show\nexit' >&${COPROC[1]};
status=$(cat <&${COPROC[0]}); echo "$status"; rfkill list;


# --------------------------------------------------------------------------------------------------------- #
