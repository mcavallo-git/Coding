#!/bin/bash
# ------------------------------------------------------------
# Linux - groupdel (remove-delete target linux group, usergroup)
# ------------------------------------------------------------

# Remove/Delete target Linux Group
GROUP_TO_DELETE="ubuntu";
if [ -n "$(getent group "${GROUP_TO_DELETE}";)" ]; then
echo "  |--> Calling [ groupdel \"${GROUP_TO_DELETE}\"; ]...";
groupdel "${GROUP_TO_DELETE}";
else
echo -e "\n""No local groups found which match name \"${GROUP_TO_DELETE}\".";
fi;


# ------------------------------------------------------------