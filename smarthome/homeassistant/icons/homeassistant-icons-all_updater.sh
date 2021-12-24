#!/bin/bash
# ------------------------------------------------------------
#
# Get an updated, exhaustive list of the latest available material design icon classes
#


cd "$(wslpath -u "$(wslvar --sys "USERPROFILE";)\Documents\GitHub\Coding\smarthome\homeassistant\icons";)";

curl -sL "https://pictogrammers.github.io/@mdi/font/6.5.95/" | grep 'var icons = ' | head -n 1 | tr "{" "\n" | sed -rne "s/name:\"([^\"]+)\".+$/mdi:\1/pi" | sort -u > "mdi-icons-all.txt";


# ------------------------------------------------------------
# 
# Citation(s)
# 
#   community.home-assistant.io  |  "Documentation of built-in symbols / icons - Configuration - Home Assistant Community"  |  https://community.home-assistant.io/t/documentation-of-built-in-symbols-icons/225969
# 
#   materialdesignicons.com  |  "Material Design Icons"  |  https://materialdesignicons.com/
# 
#   pictogrammers.github.io  |  "Material Design Icons"  |  https://pictogrammers.github.io/@mdi/font/6.5.95/
# 
# ------------------------------------------------------------