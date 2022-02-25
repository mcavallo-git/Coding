#!/bin/bash
# ------------------------------------------------------------

# Debian,Ubuntu,Raspbian - Add 1 user to 1 group
USER_NAME="username";
GROUPS_TO_JOIN="group1";
usermod --append --groups "${GROUPS_TO_JOIN}" "${USER_NAME}";

# Alpine - Add 1 user to 1 group
USER_NAME="username";
GROUPS_TO_JOIN="group1";
addgroup -g "${GROUPS_TO_JOIN}" "${USER_NAME}";


# Debian,Ubuntu,Raspbian - Add 1 user to many groups
USER_NAME="username";
GROUPS_TO_JOIN="group1,group2,group3";
usermod --append --groups "${GROUPS_TO_JOIN}" "${USER_NAME}";


# ------------------------------------------------------------

# GENERAL USER DISABLE:
USER_NAME="ubuntu"; usermod --expiredate "1" --shell "$(which nologin)" "${USER_NAME}";

# (UNDO DISABLE) GENERAL USER RE-ENABLE:
USER_NAME="ubuntu"; usermod --expiredate "" --shell "$(which bash)" "${USER_NAME}";


# ------------------------------------------------------------

# Disable target user's shell access
USER_NAME="bar";
usermod --shell "$(which nologin)" "${USER_NAME}";

# (UNDO DISABLE) Restore target user's shell access
USER_NAME="bar";
usermod --shell "$(which bash)" "${USER_NAME}";


# ------------------------------------------------------------

# Expire target user (Disable target user by enforcing a 'user-expiration date' onto said user (using some date in the past))
USER_NAME="bar";
usermod --expiredate "1" "${USER_NAME}"; # date-format: [ YYYY-MM-DD ] or [ days since epoch (1970-01-01) ]

# (UNDO EXPIRATION) Remove Expiration from user
USER_NAME="bar";
usermod --expiredate "" "${USER_NAME}"; # date-format: [ "" (empty) ] removes/disables expiration


# ------------------------------------------------------------

# Change existent user's primary/default group
USER_NAME="bar";
PRIMARY_GROUP_NAME="foo";
usermod -g "${PRIMARY_GROUP_NAME}" "${USER_NAME}";


# ------------------------------------------------------------

# Change existent user's UID
USER_NAME="foo";
UPDATED_UID="500";
usermod --uid "${UPDATED_UID}" "${USER_NAME}";


# ------------------------------------------------------------

# Change existent group's GID
GROUP_NAME="foo";
UPDATED_GID="500";
groupmod --gid "${UPDATED_GID}" "${GROUP_NAME}";


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


# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "How to enable or disable a user? - Ask Ubuntu"  |  https://askubuntu.com/a/607108
#
# ------------------------------------------------------------