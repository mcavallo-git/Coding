#!/bin/bash
# ------------------------------------------------------------
# 

# Note: [ <'/dev/tty' ]  is required for read to function with curl'ed scripts
# Note: [ -r ] argument breaks curl'ed scripts (avoid using it)
# ------------------------------------------------------------
#
# Single character entry
#

if [ 1 -eq 1 ]; then
  ACTION_DESCRIPTION="Sleep for 2 seconds";
  READ_TIMEOUT=3;
  USER_RESPONSE="";
  read -p "Perform action [ ${ACTION_DESCRIPTION} ], now?  (press 'y' to confirm)  " -a USER_RESPONSE -n 1 -t ${READ_TIMEOUT} <'/dev/tty'; EXIT_CODE=${?};
  echo "";
  if [[ "${EXIT_CODE}" -gt 128 ]]; then
    # DENIED - USER INPUT TIMED OUT
    echo "  |--> Error:  Response timed out after ${READ_TIMEOUT}s";
  elif [[ -z "${USER_RESPONSE}" ]]; then
    # DENIED - USER INPUT IS EMPTY
    echo "  |--> Warning:  DENIED  (empty response received)";
  elif [[ ! "${USER_RESPONSE}" =~ ^[Yy]$ ]]; then
    # DENIED - USER INPUT FAILED REGEX TEST
    echo "  |--> Warning:  DENIED  (response '${USER_RESPONSE}' received)";
  else
    # CONFIRMED - DO THE ACTION
    echo "  |--> Info:  CONFIRMED  (response '${USER_RESPONSE}' received)";
    echo "  |--> Info:  Performing action [ ${ACTION_DESCRIPTION} ]...";
    sleep 2;
  fi;
fi;


# Note: [ <'/dev/tty' ]  is required for read to function with curl'ed scripts
# Note: [ -r ] argument breaks curl'ed scripts (avoid using it)

read -p "Press any key to continue...  " -a KEY_PRESSED -n 1 -t 60 <'/dev/tty';
echo -e "\nKEY_PRESSED=[ ${KEY_PRESSED} ]";

# AVOID USING [ -r ] --> USE ABOVE METHODOLOGY OF [ <'/dev/tty' ], INSTEAD
# read -p "Press any key to continue...  " -n 1 -t 60 -r;  # !!! Note: [ -r ] breaks on curl commands (fails read immediately, returning exit code 1)

# ------------------------------------------------------------
#
# Multiple character entry (general terminal string entry)
#


if [ 1 -eq 1 ]; then
  READ_TIMEOUT=60;
  read -p "Enter a string:  " -a USER_RESPONSE -t ${READ_TIMEOUT} <'/dev/tty'; EXIT_CODE=${?};
  echo "";
  if [ ${EXIT_CODE} -gt 128 ]; then
    echo "  |--> Error:  Response timed out after ${READ_TIMEOUT}s";
  elif [ ${#USER_RESPONSE} -eq 0 ]; then
    echo "  |--> Error:  Response's string length is zero (empty)";
  else
    echo "  |--> Info:  Response received:  \"${USER_RESPONSE}\"";
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
# Hide typed text (for a more secure string entry, password entry, etc.)
#

if [ 1 -eq 1 ]; then
  read -p "Enter certificate password for file \"FULLPATH_PFX_CERT\" (or hit enter for no password):  " -s -a CERT_PASS -t 60 <'/dev/tty'; echo "";
  echo "Password is [ ${#CERT_PASS} ] characters long";
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   superuser.com  |  "command line - Possible to get a bash script to accept input from terminal if its stdin has been redirected? - Super User"  |  https://superuser.com/a/834508
#
# ------------------------------------------------------------