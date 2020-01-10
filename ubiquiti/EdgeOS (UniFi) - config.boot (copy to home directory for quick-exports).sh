#!/bin/bash

# Copy the target UniFi device's "config.boot" config file to the current user's home-dir
# cat "/config/config.boot" > "${HOME}/config.$(date +'%Y%m%d_%H%M%S').$(hostname).boot";
show configuration > "${HOME}/config.$(date +'%Y%m%d_%H%M%S').$(hostname).boot";

# SFTP into the server and download the file, then delete the copy from the associated UniFi device's user-homedir
