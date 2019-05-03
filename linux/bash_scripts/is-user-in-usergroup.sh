
# Script which checks if a given user is a member of a given usergroup

COMPARE_USER="boneal"; # Username to look

AGAINST_GROUP="docker"; # Usergroup to check against

echo "Checking if user \"${COMPARE_USER}\" is in usergroup \"${AGAINST_GROUP}\""
if getent group "docker" | grep &>/dev/null "\b${COMPARE_USER}\b"; then
	echo "User \"${COMPARE_USER}\" is a member of \"${AGAINST_GROUP}\"";
else
	echo "User \"${COMPARE_USER}\" STILL NEEDS docker access-privileges";
fi;
