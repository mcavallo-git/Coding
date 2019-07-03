


#	>	man usermod
#
#	-g, --gid GROUP
#			The group name or number of the user's new initial login group. The group must exist.
#			Any file from the user's home directory owned by the previous primary group of the user will be owned by this new group.
#			The group ownership of files outside of the user's home directory must be fixed manually.

# Change user's primary group
USER_NAME="wordpress";
PRIMARY_GROUP_NAME="www-data";
usermod -g "${PRIMARY_GROUP_NAME}" "${USER_NAME}";



#	>	man usermod
#
#		-a, --append
#			Add the user to the supplementary group(s). Use only with the -G option.
#
#		-G, --groups GROUP1[,GROUP2,...[,GROUPN]]]
#			A list of supplementary groups which the user is also a member of.
#			Each group is separated from the next by a comma, with no intervening whitespace.
#			The groups are subject to the same restrictions as the group given with the -g option.

# Add user to multiple groups, simultaneously
USER_NAME="wordpress";
GROUPS_TO_JOIN="www-data,wordpress";
usermod -aG "${GROUPS_TO_JOIN}" "${USER_NAME}";

