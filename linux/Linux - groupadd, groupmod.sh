# ------------------------------------------------------------

# Get info regarding a group

INSPECT_GROUP_NAME="adm";
getent group ${INSPECT_GROUP_NAME};


INSPECT_GROUP_NAME="sudo";
getent group ${INSPECT_GROUP_NAME};


# ------------------------------------------------------------ #

# Create a new group with a given name

NEW_GROUP_NAME="foo";

groupadd ${NEW_GROUP_NAME};


# ------------------------------------------------------------ #
	
# Create a new group with a given name & group-id

NEW_GROUP_NAME="bar";

NEW_GROUP_ID=525;

groupadd ${NEW_GROUP_NAME} --gid ${NEW_GROUP_ID};


# ------------------------------------------------------------ #

# Update the name of a given group

GROUP_NAME_OLD="foo";

GROUP_NAME_UPDATED="bar";

groupmod -n ${GROUP_NAME_UPDATED} ${GROUP_NAME_OLD};


# ------------------------------------------------------------ #

# Add user to group - this grants the user the group-permissions read-write-execute 
# permission on any relevant files whose group-permission(s) are set accordingly

GROUP_NAME="foobar";

USER_NAME="example_username";

usermod -a -G ${GROUP_NAME} ${USER_NAME}


# ------------------------------------------------------------ #
	
# Update User's Primary/Default group (files created by user will now be associated to the given group)

usermod -g [GROUPNAME] [USERNAME]

GROUP_NAME="foobar";

USER_NAME="example_username";

usermod -g ${GROUP_NAME} ${USER_NAME}


# ------------------------------------------------------------ #

# Switch a groups identifier (gid) to a different value
# WARNING - YOU MUST MANUALLY CALL [ CHOWN [USER_ID]:[NEW_GID] ... ] ON ALL FILES WHICH WERE OWNED BY GROUP, ONCE CHANGED

GROUP_NAME="bar";

NEW_GID=625;

groupmod --gid ${NEW_GID} ${GROUP_NAME};

# Find and replace any items with the old user-group

OLDGID=1001 && NEWGID=625 && find / -gid ${OLDGID} ! -type l -exec chgrp ${NEWGID} {} \;


# ------------------------------------------------------------ #
