#!/bin/bash
# ------------------------------------------------------------
#
# EdgeOS (UniFi) - show configuration commands (outputs/reverse-engineers the cli config commands needed to recreate the current device's config)
#
# ------------------------------------------------------------

# Step 1 - SSH into your Unifi device (USG, for example)


# Step 2 - Export the config as a set of CLI commands
OUTFILE="$(getent passwd ${SUDO_USER:-${USER}} | cut -d":" -f6;)/show-configuration-commands.$(date +'%Y%m%d_%H%M%S').$(hostname).sh"; show configuration commands > "${OUTFILE}"; echo "OUTFILE=[ ${OUTFILE} ]";


# Step 3 - Download the exported file via your SFTP tool of choice (it will have been placed in user's home directory)


# ------------------------------------------------------------