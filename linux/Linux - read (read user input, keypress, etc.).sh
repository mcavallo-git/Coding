#!/bin/bash

# ------------------------------------------------------------

read -p "Press any key to continue...  " -n 1 -t 60 -r; # Await single keypress

# ------------------------------------------------------------
# Await multiple keypresses (general keyboard string-entry)

if [ 1 -eq 1 ]; then
	READ_TIMEOUT=60;
	read -p "Enter a string:  " -t ${READ_TIMEOUT} -r; RETURN_CODE_READ=$?;
	echo "";
	if [ ${RETURN_CODE_READ} -le 128 ] && [ -n "${REPLY}" ]; then
		echo "Info:  Response received: \"${REPLY}\"";
	elif [ ${RETURN_CODE_READ} -gt 128 ]; then
		echo "Error:  Response timed out after ${READ_TIMEOUT}s";
	else
		echo "Info:  Response's string-length is zero (empty/unset)";
	fi;
fi;


# ------------------------------------------------------------
# Await single keypress & Listen for "y" (or "Y")


if [ 1 -eq 1 ]; then
  ACTION_DESCRIPTION="ACTION_DESCRIPTION_HERE";
  READ_TIMEOUT=3;
  read -p "Perform action [ ${ACTION_DESCRIPTION} ], now? (y/n)  " -n 1 -t ${READ_TIMEOUT} -r; RETURN_CODE_READ=$?;
  echo "";
  if [ ${RETURN_CODE_READ} -gt 128 ]; then
    echo "Error:  Response timed out after ${READ_TIMEOUT}s";
  elif [ -n "${REPLY}" ] && [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Info:  Confirmed - Performing Action [ ${ACTION_DESCRIPTION} ] ...";
  else
    echo "Info:  Denied - Skipping action [ ${ACTION_DESCRIPTION} ]";
  fi;
fi;


# ------------------------------------------------------------
# Double-confirmation
if [ 1 -eq 1 ]; then
  echo -e "";
  echo -e "! !        ! !                                         ! !        ! !";
  echo -e "! ! NOTICE ! !  THIS IS A DOUBLE CONFIRMATION MESSAGE  ! ! NOTICE ! !";
  echo -e "! !   |    ! !  PLEASE READ IT BEFORE HITTING Y (YES)  ! !        ! !";
  echo -e "      |";
  read -p "      |--> Are you sure you want to continue? (y/n)  " -n 1 -t 60 -r; # Await single keypress
  echo -e "";
  if [ -n "${REPLY}" ] && [ "$(echo ${REPLY} | tr '[:lower:]' '[:upper:]';)" == "Y" ]; then
    echo -e "      |";
    read -p "      |--> Are you completely positive you wish to continue? (y/n)  " -n 1 -t 60 -r; # Await single keypress
    echo -e "";
    if [ -n "${REPLY}" ] && [ "$(echo ${REPLY} | tr '[:lower:]' '[:upper:]';)" == "Y" ]; then
      echo "Confirmed twice!";
    fi;
  fi;
fi;


# ------------------------------------------------------------