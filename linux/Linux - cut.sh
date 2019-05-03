#!/bin/bash

#
# the command 'cut' separates fields by a given delimiter as well as which index they appear in (which can then be complemented, or flipped to get an inverse set)
#
#	Example:
#

USER_GROUPLIST=$(groups "$(whoami)" | cut --delimiter=" " --fields=1,2 --complement);

# ... which functions nearly the same as ...

USER_GROUPLIST=$(id --groups --name); echo ${USER_GROUPLIST};

