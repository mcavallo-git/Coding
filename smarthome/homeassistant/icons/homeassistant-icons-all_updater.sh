#!/bin/bash
# ------------------------------------------------------------
#  Get an updated, exhaustive list of the latest material design icon classes
# ------------------------------------------------------------


#
# Update 'mdi-icons-all.txt'
#  |--> Open URL [ https://materialdesignicons.com/ ]
#   |--> Click "Cheatsheet" (top middle)
#    |--> Copy the URL to the variable [ CHEATSHEET_URL ], below:
#
if [[ 1 -eq 1 ]]; then
CHEATSHEET_URL="https://pictogrammers.github.io/@mdi/font/6.5.95/";
cd "$(if [[ -n "$(command -v "wslvar" 2>'/dev/null';)" ]]; then wslpath -u "$(wslvar --sys "USERPROFILE";)"; else echo "${HOME}"; fi;)/Documents/GitHub/Coding/smarthome/homeassistant/icons";
curl -sL "${CHEATSHEET_URL}" | grep 'var icons = ' | head -n 1 | tr "{" "\n" | sed -rne "s/name:\"([^\"]+)\".+$/mdi:\1/pi" | sort -u > "mdi-icons-all.txt";
echo -e -n "\n\n# ------------------------------------------------------------\n#\n# Citation(s)\n#\n#   materialdesignicons.com  |  \"Material Design Icons\"  |  https://materialdesignicons.com/\n#\n# ------------------------------------------------------------" >> "mdi-icons-all.txt";
fi;


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