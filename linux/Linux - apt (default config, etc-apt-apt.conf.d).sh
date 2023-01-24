#!/bin/bash
# ----------------------------------------------------------------------
#
# apt - Wait for background apt command(s) to complete (and show running background apt commands)
#
for i in {1..60}; do
  while [[ "$(ps aux | grep -v grep | grep apt | wc -l;)" -gt 0 ]]; do
    echo "------------------------------";
    echo "Calling [ ps aux | grep -v grep | grep apt; ]...";
    ps aux | grep -v grep | grep apt;
    echo "Calling [ sleep 1; ]...";
    sleep 1;
  done;
  echo "Calling [ sleep 1; ]...";
  sleep 1;
done;


# ----------------------------------------------------------------------
#
# [INSECURE] - apt - Always accept package signature's public key
#

# [INSECURE] - One-time auto-skip/accept package signature verification (for signatures not on keyring)
apt-get --yes --force-yes install $something

# [INSECURE] - Always auto-skip/accept package signature verification (for signatures not on keyring)
echo "APT::Get::Assume-Yes \"true\"" > "/etc/apt/apt.conf.d/01-apt-get-assume-yes";
echo "APT::Get::force-yes \"true\"" > "/etc/apt/apt.conf.d/01-apt-get-force-yes";


# ------------------------------------------------------------
#
# Citation(s)
#
#   superuser.com  |  "linux - Automatically answer 'Yes' when using apt-get install - Super User"  |  https://superuser.com/a/164580
#
# ------------------------------------------------------------