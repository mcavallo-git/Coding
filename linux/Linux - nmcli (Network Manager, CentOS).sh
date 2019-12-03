#!/bin/bash

nmcli device show;

nmcli connection show $(nmcli connection show | grep -v "NAME" | head -n 1 | awk '{print $1}';);
