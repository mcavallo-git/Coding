#!/bin/bash
# ------------------------------------------------------------
# Linux - userdel (remove-delete target linux user)
# ------------------------------------------------------------

# Remove/Delete target Linux User
USER_TO_DELETE="ubuntu";
if [ -n "$(getent passwd "${USER_TO_DELETE}";)" ]; then
echo -e "\n""Calling [ userdel \"${USER_TO_DELETE}\" --force --remove; ]...";
userdel "${USER_TO_DELETE}" --force --remove;
else
echo -e "\n""No local users found which match name \"${USER_TO_DELETE}\".";
fi;


# ------------------------------------------------------------