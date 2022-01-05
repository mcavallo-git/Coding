#!/bin/bash
# ------------------------------------------------------------
#
# Linux - Background jobs
#

# Background: When you enter an ampersand (&) symbol at the end of a command line, the command runs without occupying the terminal window. The shell prompt is displayed immediately after you press Return. This is an example of a background job.

# General Syntax
command &

# General Syntax (using nohup)
nohup command &


# ------------------------------------------------------------

# Example - Background job in Linux
if [[ 1 -eq 1 ]]; then
  echo "$(date +'%D %r')";
  LOGFILE="${HOME}/tester_$(date +'%s';)";
  ( sleep 3; echo "$(date +'%D %r')">"${LOGFILE}"; echo "whoami: $(whoami);">>"${LOGFILE}"; ) & echo "";
  for i in {1..5}; do
    if [ -f "${LOGFILE}" ] && [ -n "$(cat "${LOGFILE}" 2>'/dev/null';)" ]; then
      echo "------------------------------";
      cat "${LOGFILE}";
      echo "------------------------------";
      break;
    fi;
    sleep 1;
  done;
fi;

# Example - Background job in Linux (using nohup)
nohup seq 1234568 > ~/tester.txt 2>&1 &


# ------------------------------------------------------------
#
# DELAYED REBOOT
#

# Reboot @ 11:59 PM
sudo shutdown -r 23:59 &

# Reboot in 1 minute
sudo shutdown --reboot "+1" &


# ------------------------------------------------------------
#
# Citation(s)
#
#   linuxize.com  |  "How to Run Linux Commands in Background | Linuxize"  |  https://linuxize.com/post/how-to-run-linux-commands-in-background/
#
#   www.golinuxhub.com  |  "How to keep a process running after putty or terminal is closed - GoLinuxHub"  |  https://www.golinuxhub.com/2014/11/how-to-keep-process-running-after-putty.html
#
#   www.thegeekdiary.com  |  "Understanding the job control commands in Linux – bg, fg and CTRL+Z – The Geek Diary"  |  https://www.thegeekdiary.com/understanding-the-job-control-commands-in-linux-bg-fg-and-ctrlz/
#
# ------------------------------------------------------------