#!/bin/bash

# ------------------------------------------------------------
# Output stdout and stderr to a file (do not output to terminal)
exec 2>&1 1> "${LOGFILE}";

# ------------------------------------------------------------
# Output stdout and stderr to terminal AND file
exec > >(tee -a "${LOGFILE}" );
exec 2>&1;


# ------------------------------------------------------------
# Restore stdout to terminal (only)
exec &>/dev/tty

# ------------------------------------------------------------
# Citation(s)
#
#   unix.stackexchange.com  |  "Restoring output to the terminal after having issued “exec &>filename”"  |  https://unix.stackexchange.com/a/91716
#
# ------------------------------------------------------------