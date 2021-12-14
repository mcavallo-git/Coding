#!/bin/bash

# ------------------------------------------------------------

read -p "Press any key to continue...  " -a KEY_PRESSED -n 1 -t 60 <'/dev/tty'; echo -e "\nKEY_PRESSED=[ ${KEY_PRESSED} ]";  # Await single keypress (works with curl'ed scripts)

# AVOID USING [ -r ] --> USE ABOVE METHODOLOGY OF [ <'/dev/tty' ], INSTEAD
# read -p "Press any key to continue...  " -n 1 -t 60 -r;  # !!! Note: [ -r ] breaks on curl commands (fails read immediately, returning exit code 1)

# ------------------------------------------------------------
# Await multiple keypresses (general keyboard string-entry)

if [ 1 -eq 1 ]; then
  READ_TIMEOUT=60;
  read -p "Enter a string:  " -a USER_RESPONSE -t ${READ_TIMEOUT} <'/dev/tty'; EXIT_CODE=${?};
  echo "";
  if [ ${EXIT_CODE} -gt 128 ]; then
    echo "Error:  Response timed out after ${READ_TIMEOUT}s";
  elif [ ${#USER_RESPONSE} -eq 0 ]; then
    echo "Error:  Response's string length is zero (empty)";
  else
    echo "Info:  Response received: \"${USER_RESPONSE}\"";
  fi;
fi;


# ------------------------------------------------------------
# Hide input string (for a more secure string entry, etc.)

if [ 1 -eq 1 ]; then
  read -p "Enter certificate password for file \"FULLPATH_PFX_CERT\" (or hit enter for no password):  " -s -a CERT_PASS -t 60 <'/dev/tty'; echo "";
  echo "Password is [ ${#CERT_PASS} ] characters long";
fi;


# ------------------------------------------------------------
# Await single keypress & Listen for "y" (or "Y")


if [ 1 -eq 1 ]; then
  ACTION_DESCRIPTION="ACTION_DESCRIPTION_HERE";
  READ_TIMEOUT=3;
  USER_RESPONSE="";
  read -p "Perform action [ ${ACTION_DESCRIPTION} ], now?  (press 'y' to confirm)  " -a USER_RESPONSE -n 1 -t ${READ_TIMEOUT} <'/dev/tty'; EXIT_CODE=${?};
  echo "";
  if [ ${EXIT_CODE} -gt 128 ]; then
    echo "Error:  Response timed out after ${READ_TIMEOUT}s";
  elif [ -n "${USER_RESPONSE}" ] && [[ ${USER_RESPONSE} =~ ^[Yy]$ ]]; then
    echo "Info:  Confirmed - Performing Action [ ${ACTION_DESCRIPTION} ] ...";
  else
    echo "Info:  Denied - Skipping action [ ${ACTION_DESCRIPTION} ]";
  fi;
  if [ ${EXIT_CODE} -le 128 ] && [ -n "${USER_RESPONSE}" ] && [[ ${USER_RESPONSE} =~ ^[Yy]$ ]]; then
    echo "Info:  Response received: \"${USER_RESPONSE}\"";
    if [[ ${USER_RESPONSE} =~ ^[Yy]$ ]]; then
      # DO THE ACTION
      echo "Info:  CONFIRMED  -  Performing Action [ ${ACTION_DESCRIPTION} ] ...";
    else
      # SKIP THE ACTION
      echo "Info:  DENIED  -  Skipping action [ ${ACTION_DESCRIPTION} ]";
    fi;
  else
    # ERROR + SKIP THE ACTION
    echo -n "Info:  DENIED  -  Skipping action [ ${ACTION_DESCRIPTION} ]";
    if [ ${EXIT_CODE} -gt 128 ]; then
      echo " (response timed out after ${READ_TIMEOUT}s)";
    elif [ -z "${USER_RESPONSE}" ]; then
      echo " (empty response received)";
    else
      echo " (response does not match confirmation format)";
    fi;
  fi;

fi;


# ------------------------------------------------------------
#
# Require two confirmation keypresses before proceeding
#
#   Note: If no "-a VARNAME" argument is passed to "read", then it will save the user's input to the variable "$REPLY"  (by default)
#


if [ 1 -eq 1 ]; then
  echo -e "";
  echo -e "! !        ! !                                         ! !        ! !";
  echo -e "! ! NOTICE ! !  THIS IS A DOUBLE CONFIRMATION MESSAGE  ! ! NOTICE ! !";
  echo -e "! !   |    ! !  PLEASE READ IT BEFORE HITTING Y (YES)  ! !        ! !";
  echo -e "      |";
  read -p "      |--> Are you sure you want to continue?  (press 'y' to confirm)" -n 1 -t 60 <'/dev/tty'; # Await single keypress
  echo -e "";
  if [ -n "${REPLY}" ] && [ "$(echo ${REPLY} | tr '[:lower:]' '[:upper:]';)" == "Y" ]; then
    echo -e "      |";
    read -p "      |--> Are you completely positive you wish to continue?  (press 'y' to confirm)" -n 1 -t 60 <'/dev/tty'; # Await single keypress
    echo -e "";
    if [ -n "${REPLY}" ] && [ "$(echo ${REPLY} | tr '[:lower:]' '[:upper:]';)" == "Y" ]; then
      echo "Confirmed twice!";
    fi;
  fi;
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   superuser.com  |  "command line - Possible to get a bash script to accept input from terminal if its stdin has been redirected? - Super User"  |  https://superuser.com/a/834508
#
# ------------------------------------------------------------