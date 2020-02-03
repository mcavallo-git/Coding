#!/bin/bash

# Basic syntax for running tasks in background

nohup seq 1234568 > ~/tester.txt 2>&1 &

# ------------------------------------------------------------

echo "$(date +'%D %r')";

TEST_OUTPUT="${HOME}/tester_$(date +'%s')";

(sleep 5; echo "$(date +'%D %r')">"${TEST_OUTPUT}"; echo "whoami: $(whoami);">>"${TEST_OUTPUT}"; ) & echo "">/dev/null;

# (sleep 5; echo "$(date +'%D %r')">"${TEST_OUTPUT}"; echo "whoami: $(whoami);">>"${TEST_OUTPUT}"; ) & 

sleep 2 && cat "${TEST_OUTPUT}"; \
sleep 2 && cat "${TEST_OUTPUT}"; \
sleep 2 && cat "${TEST_OUTPUT}";

# ------------------------------------------------------------
#
# DELAYED REBOOT
#

## Reboot @ 11:59 PM
sudo shutdown -r 23:59 &

## Reboot in 1 minute
sudo shutdown --reboot "+1" &


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.golinuxhub.com  |  "How to keep a process running after putty or terminal is closed - GoLinuxHub"  |  https://www.golinuxhub.com/2014/11/how-to-keep-process-running-after-putty.html
#
# ------------------------------------------------------------