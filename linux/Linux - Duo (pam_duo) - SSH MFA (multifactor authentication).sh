#!/bin/bash
# ------------------------------------------------------------
#
# Following Guide:  https://duo.com/docs/duounix
#
# TO INSTALL:  pam_duo
#
# ------------------------------------------------------------
if [[ 0 -eq 1 ]]; then # RUN THIS SCRIPT REMOTELY:

curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -sL "https://raw.githubusercontent.com/mcavallo-git/Coding/master/linux/Linux%20-%20Duo%20(pam_duo)%20-%20SSH%20MFA%20(multifactor%20authentication).sh?t=$(date +'%s.%N')" | bash;

curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -sL "https://raw.githubusercontent.com/mcavallo-git/Coding/master/linux/Linux%20-%20Duo%20(pam_duo)%20-%20SSH%20MFA%20(multifactor%20authentication).sh?t=$(date +'%s.%N')" | env duo_ikey="___" duo_host="___" duo_skey="___" bash;  # Call this script with env var arguments

fi;
if [[ 1 -eq 1 ]]; then

  # ------------------------------
  #
  # Start of [ install duo_unix ] code block
  #

  if [[ -z "$(command -v login_duo 2>'/dev/null';)" ]]; then
    # Duo is not installed --> Install it

    echo -e "\n------------------------------------------------------------\n";

    # Install prerequisite packages for PAM & Duo
    apt-get -y update; apt-get -y install gcc libpam-dev libssl-dev make zlib1g-dev;

    # Setup runtime variables
    DUO_UNIX_LATEST_REMOTE="https://dl.duosecurity.com/duo_unix-latest.tar.gz"; # duo_unix source - https://duo.com/docs/duounix
    WORKING_DIR="${HOME}/pam_duo_install"; # Working directory
    DUO_UNIX_LATEST_LOCAL="${WORKING_DIR}/$(basename "${DUO_UNIX_LATEST_REMOTE}";)";  # Filepath to download duo_unix to

    # Create working dir
    mkdir -pv "${WORKING_DIR}";

    # Download duo_unix
    curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -sL "${DUO_UNIX_LATEST_REMOTE}" -o "${DUO_UNIX_LATEST_LOCAL}";

    # Unpack duo_unix
    cd "${WORKING_DIR}"; tar zxf "${DUO_UNIX_LATEST_LOCAL}";

    # Set the directory which was just unpacked (from the latest duo_unix tarball) as the current working directory
    UNPACKED_DIR="$(find "${WORKING_DIR}/" -maxdepth "1" -mindepth "1" -type "d" -iname "duo_unix-*" -not -path "${DUO_UNIX_LATEST_LOCAL}" | head -n 1;)";

    if [[ -d "${UNPACKED_DIR}" ]] && [[ "${UNPACKED_DIR}" != "${WORKING_DIR}" ]]; then

      cd "${UNPACKED_DIR}"; pwd;

      # Install duo_unix
      echo "Calling [ ./configure --with-pam --prefix=/usr && make && sudo make install; ] from working directory [ $(pwd;) ]...";
      ./configure --with-pam --prefix=/usr && make && sudo make install;

      # Look into "Install from Linux Packages"  -  https://duo.com/docs/duounix#install-from-linux-packages
      # deb [arch=amd64] https://pkg.duosecurity.com/Ubuntu focal main;

    fi;

  fi;

  #
  # End of [ install duo_unix ] code block
  #
  # ------------------------------
  #
  # Start of [ integration-key/secret-key/api-host validation ] code block
  #

  echo -e "\n------------------------------------------------------------\n";
  echo -e "Info:  To protect a new application through Duo Security";
  echo -e " |      (e.g. to obtain a Integration key, Secret key, & API hostname):";
  echo -e " |";
  echo -e " |--> Login to your Duo Administrator portal (or create a new Duo Admin account, if you haven't already)";
  echo -e " |     |";
  echo -e " |     |--> Login URL: https://admin.duosecurity.com/login";
  echo -e " |";
  echo -e " |--> On the Admin Dashboard's leftmost column:";
  echo -e "       |--> Click 'Applications'";
  echo -e "        |--> Click 'Protect an Application'";
  echo -e "         |--> Locate (or filter by keyword) 'UNIX Application' and click 'Protect' to the right of 'UNIX Application'";
  echo -e "          |--> Set a name using syntax 'SSH (HOSTNAME) (pam_duo)', replacing 'HOSTNAME' with your server's hostname";
  echo -e "           |--> Copy the Integration key, Secret key, and API hostname down to your password manager of choice, then click 'Save'";
  echo -e "            |--> Done";
  echo -e "\n------------------------------------------------------------\n";

  # Verify that pam_duo's config exists before continuing
  PAM_DUO_CONF="/etc/duo/pam_duo.conf";
  if [[ -f "${PAM_DUO_CONF}" ]]; then

    MAX_LOOPS=5;
    READ_TIMEOUT=60;

    #
    # Duo integration key  -  Must be 20 characters long, consisting of only uppercase alphanumeric characters
    #
    echo -e "\nDuo integration key  -  Must be 20 characters long, consisting of only uppercase alphanumeric characters";
    duo_ikey="${duo_ikey}";
    for i in $(seq ${MAX_LOOPS}); do
      if [[ -z "${duo_ikey}" ]]; then
        # Get the value from user input
        read -p "  Type or paste your integration key (attempt ${i}/${MAX_LOOPS}):  " -s -a duo_ikey -t ${READ_TIMEOUT} <'/dev/tty';
      fi;
      # Trim leading/trailing whitespace off of string
      duo_ikey="$(echo -e "${duo_ikey}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';)";
      # Test string for validity
      if [[ -n "${duo_ikey}" ]] && [[ "${duo_ikey}" =~ ^[A-Z0-9]{20}$ ]]; then
        echo "   VALID syntax detected";
        break;
      else
        echo "   INVALID syntax detected";
        duo_ikey="";
      fi;
    done;

    #
    # Duo secret key  -  Must be 40 characters long, consisting of only alphanumeric characters (upper and lower)
    #
    echo -e "\nDuo secret key  -  Must be 40 characters long, consisting of only alphanumeric characters (upper and lower)";
    duo_skey="${duo_skey}";
    for i in $(seq ${MAX_LOOPS}); do
      if [[ -z "${duo_skey}" ]]; then
        # Get the value from user input
        read -p "  Type or paste your secret key (attempt ${i}/${MAX_LOOPS}):  " -s -a duo_skey -t ${READ_TIMEOUT} <'/dev/tty';
      fi;
      # Trim leading/trailing whitespace off of string
      duo_skey="$(echo -e "${duo_skey}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';)";
      # Test string for validity
      if [[ -n "${duo_skey}" ]] && [[ "${duo_skey}" =~ ^[a-zA-Z0-9]{40}$ ]]; then
        echo "   VALID syntax detected";
        break;
      else
        echo "   INVALID syntax detected";
        duo_skey="";
      fi;
    done;

    #
    # Duo API host  -  Must be 28 characters long & must match the regular expression 'api-[a-zA-Z0-9]{8}\.duosecurity\.com'
    #
    echo -e "\nDuo API host  -  Must be 28 characters long & must match the regular expression '^api-[a-zA-Z0-9]{8}\.duosecurity\.com\$'";
    duo_host="${duo_host}";
    for i in $(seq ${MAX_LOOPS}); do
      if [[ -z "${duo_host}" ]]; then
        # Get the value from user input
        read -p "  Type or paste your API host (attempt ${i}/${MAX_LOOPS}):  " -s -a duo_host -t ${READ_TIMEOUT} <'/dev/tty';
      fi;
      # Trim leading/trailing whitespace off of string
      duo_host="$(echo -e "${duo_host}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';)";
      # Test string for validity
      if [[ -n "${duo_host}" ]] && [[ "${duo_host}" =~ ^api-[a-zA-Z0-9]{8}\.duosecurity\.com$ ]]; then
        echo "   VALID syntax detected";
        break;
      else
        echo "   INVALID syntax detected";
        duo_host="";
      fi;
    done;

    #
    # End of [ integration-key/secret-key/api-host validation ] code block
    #
    # ------------------------------
    #
    # Start of [ Duo Configuration ] code block
    #

    echo -e "\n------------------------------------------------------------\n";

    #
    # Verify Duo integration key, secret key, & API host are set as-intended
    #
    if [[ -z "${duo_ikey}" ]] || [[ -z "${duo_skey}" ]] || [[ -z "${duo_host}" ]]; then

      #
      # Invalid Duo integration key, secret key, and/or API host
      #
      echo "Error:  One or more invalid values exist amongst the following:";
      echo " |";
      echo " |--> Duo integration key:  $(if [[ -n "${duo_ikey}" ]] && [[ "${duo_ikey}" =~ ^[A-Z0-9]{20}$ ]]; then echo "VALID - Passed"; else echo "INVALID - Failed"; fi;) regex test '^[A-Z0-9]{20}\$'";
      echo " |";
      echo " |--> Duo secret key:  $(if [[ -n "${duo_skey}" ]] && [[ "${duo_skey}" =~ ^[a-zA-Z0-9]{40}$ ]]; then echo "VALID - Passed"; else echo "INVALID - Failed"; fi;) regex test '^[a-zA-Z0-9]{40}\$'";
      echo " |";
      echo " |--> Duo API host:  $(if [[ -n "${duo_host}" ]] && [[ "${duo_host}" =~ ^api-[a-zA-Z0-9]{8}\.duosecurity\.com$ ]]; then echo "VALID - Passed"; else echo "INVALID - Failed"; fi;) regex test '^api-[a-zA-Z0-9]{8}\.duosecurity\.com\$'";
      #
      #  ^-- Help user to determine which value they gave contains invalid syntax
      #

    else
      #
      # VALID Duo integration key, secret key, & API host
      #

      # Setup options to apply to [ /etc/duo/pam_duo.conf ] as an array of key-value pairs

      unset PAM_DUO_OPTS; declare -A PAM_DUO_OPTS; # [Re-]Instantiate bash array

      PAM_DUO_OPTS+=(["ikey"]="${duo_ikey}");  # Duo integration key (required)  -  20 characters long

      PAM_DUO_OPTS+=(["skey"]="${duo_skey}");  # Duo secret key (required)  -  40 characters long

      PAM_DUO_OPTS+=(["host"]="${duo_host}");  # Duo API host (required)  -  matches regex "api-[a-zA-Z0-9]{8}\.duosecurity\.com"

      PAM_DUO_OPTS+=(["failmode"]="safe");  # On service or configuration errors that prevent Duo authentication, fail "safe" (allow access) or "secure" (deny access) - Default is "safe"

      PAM_DUO_OPTS+=(["pushinfo"]="yes");  # Send command to be approved via Duo Push authentication - Default is "no"

      PAM_DUO_OPTS+=(["autopush"]="yes");  # Automatically send a login request to the first factor (usually push), instead of prompting the user - Default is "no"

      PAM_DUO_OPTS+=(["prompts"]="1");  # Set the maxiumum number of prompts pam_duo will show before denying access - Default is 3

      # Walk through the array of config variables
      for EACH_OPTION_KEY in "${!PAM_DUO_OPTS[@]}"; do

        EACH_OPTION_VAL_INTENDED="${PAM_DUO_OPTS[${EACH_OPTION_KEY}]}";

        EACH_OPTION_COUNT_DEFINITIONS="$(sed -rne "s/^\s*(${EACH_OPTION_KEY//\//\\/})\s*=\s*(\S*)\s*\$/\0/p" "${PAM_DUO_CONF}" | wc -l;)";

        echo "";
        echo -e "------------------------------------------------------------\n";

        if [[ "${EACH_OPTION_COUNT_DEFINITIONS}" -eq 1 ]]; then

          echo "";
          echo "Exactly one (1) pre-existing definition exists for option \"${EACH_OPTION_KEY}\" in file \"${PAM_DUO_CONF}\"";
          echo " |";
          echo " |--> Compare the value defined in pam_duo.conf against the intended value";

          EACH_OPTION_VAL_CURRENT="$(sed -rne "s/^(\s*${EACH_OPTION_KEY//\//\\/}\s*=\s*)(\S*)\s*\$/\2/p" "${PAM_DUO_CONF}";)";

          # echo " |     |";
          # echo " |     |--> EACH_OPTION_KEY = [ ${EACH_OPTION_KEY} ]";
          # echo " |     |--> EACH_OPTION_VAL_INTENDED = [ ${EACH_OPTION_VAL_INTENDED} ]";
          # echo " |     |--> EACH_OPTION_VAL_CURRENT = [ ${EACH_OPTION_VAL_CURRENT} ]";

          if [[ "${EACH_OPTION_VAL_CURRENT}" == "${EACH_OPTION_VAL_INTENDED}" ]]; then

            echo " |";
            echo " |--> Values already up-to-date (between intended value & currently defined value)";

          else

            echo " |";
            echo " |--> Updating option definition to use intended value...";
            sed -re "s/^(\s*${EACH_OPTION_KEY//\//\\/}\s*=\s*)(\S*)\s*\$/\1${EACH_OPTION_VAL_INTENDED//\//\\/}\n/" -i "${PAM_DUO_CONF}";

          fi;

        else

          if [[ "${EACH_OPTION_COUNT_DEFINITIONS}" -gt 1 ]]; then

            echo "";
            echo "Multiple pre-existing definitions exist for option \"${EACH_OPTION_KEY}\" in file \"${PAM_DUO_CONF}\"";
            echo " |";
            echo " |--> Commenting out all existing option definitions...";
            sed -re "/^\s*(${EACH_OPTION_KEY//\//\\/})\s*=\s*(\S*)?\s*\$/ s/^#*/# /" -i "${PAM_DUO_CONF}";

          else

            echo "";
            echo "No pre-existing definitions exist for option \"${EACH_OPTION_KEY}\" in file \"${PAM_DUO_CONF}\"";

          fi;
          echo " |";
          echo " |--> Appending option definition onto the config file...";
          echo -e "\n${EACH_OPTION_KEY} = ${EACH_OPTION_VAL_INTENDED}" >> "${PAM_DUO_CONF}";

        fi;

      done;

      # Cleanup variables which may contain secrets before exiting (so that we don't leave said secrets lying around)
      unset PAM_DUO_OPTS; declare -A PAM_DUO_OPTS; # [Re-]Instantiate bash array
      duo_ikey="";
      duo_skey="";
      duo_host="";

      #
      # End of [ Duo Configuration ] code block
      #
      # ------------------------------
      #
      # Start of [ SSH/SSHD Configuration ] code block
      #

      if [[ 1 -eq 1 ]]; then

        echo -e "\n------------------------------------------------------------\n";

        SSHD_CONFIG_LOCAL="/etc/ssh/sshd_config";
        SSHD_CONFIG_REMOTE="https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master${SSHD_CONFIG_LOCAL}.mfa";

        # Backup the local config file
        cp -fv "${SSHD_CONFIG_LOCAL}" "${SSHD_CONFIG_LOCAL}.$(date +'%Y%m%d_%H%M%S').bak";
        
        # Overwrite the local config file with a verified Duo-compatible config file
        curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -sL "${SSHD_CONFIG_REMOTE}" -o "${SSHD_CONFIG_LOCAL}";
        
        # Apply file permissions as-intended
        chmod 0644 "${SSHD_CONFIG_LOCAL}";

        # Restart the associated service to apply changes
        SERVICE_NAME="sshd";
        SERVICE_RET_CODE=$(/bin/systemctl list-unit-files --no-legend --no-pager --full "${SERVICE_NAME}.service" | grep "^${SERVICE_NAME}.service" 1>'/dev/null' 2>&1; echo $?;);
        if [[ ${SERVICE_RET_CODE} -eq 0 ]]; then
          /usr/sbin/service "${SERVICE_NAME}" restart;
          /usr/sbin/service "${SERVICE_NAME}" status --no-pager --full;
        else
          echo "Skipped restart of the \"${SERVICE_NAME}\" service (not found as a local service)";
        fi;
        
      fi;

      #
      # End of [ SSH/SSHD Configuration ] code block
      #
      # ------------------------------
      #
      # Start of [ PAM Configuration ] code block
      #

      # Update Pam's "common-auth" config file
      if [[ 1 -eq 1 ]]; then

        echo -e "\n------------------------------------------------------------\n";

        COMMON_AUTH_LOCAL="/etc/pam.d/common-auth";
        COMMON_AUTH_REMOTE="https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master${COMMON_AUTH_LOCAL}";

        # Backup the local config file
        cp -fv "${COMMON_AUTH_LOCAL}" "${COMMON_AUTH_LOCAL}.$(date +'%Y%m%d_%H%M%S').bak";
        
        # Overwrite the local config file with a verified Duo-compatible config file
        curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -sL "${COMMON_AUTH_REMOTE}" -o "${COMMON_AUTH_LOCAL}";
        
        # Apply file permissions as-intended
        chmod 0644 "${COMMON_AUTH_LOCAL}";
        
      fi;

      # Update Pam's "sshd" config file
      if [[ 1 -eq 1 ]]; then

        echo -e "\n------------------------------------------------------------\n";

        PAM_D_SSHD_LOCAL="/etc/pam.d/sshd";
        PAM_D_SSHD_REMOTE="https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master${PAM_D_SSHD_LOCAL}";

        # Backup the local config file
        cp -fv "${PAM_D_SSHD_LOCAL}" "${PAM_D_SSHD_LOCAL}.$(date +'%Y%m%d_%H%M%S').bak";
        
        # Overwrite the local config file with a verified Duo-compatible config file
        curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -sL "${PAM_D_SSHD_REMOTE}" -o "${PAM_D_SSHD_LOCAL}";
        
        # Apply file permissions as-intended
        chmod 0644 "${PAM_D_SSHD_LOCAL}";
        
      fi;

      # Redirect "login_duo" to use the "pam_duo" configuration that was just applied
      if [[ 1 -eq 1 ]]; then

        # Backup the local config file
        mv -fv "/etc/duo/login_duo.conf" "/etc/duo/login_duo.conf.$(date +'%Y%m%d_%H%M%S').bak";

        # Redirect the original path of the local config file
        ln -sf "/etc/duo/pam_duo.conf" "/etc/duo/login_duo.conf";

      fi;

      # !!! DONE !!!

      # Keep the current terminal open, and open a side terminal to the same server to test Duo push requests to your mobile device for SSH authentication

      if [[ 0 -eq 1 ]]; then
        #
        # DEBUGGING ONLY
        #  |--> If you wish to test manual authentication/authorization requests to Duo's servers, run the following command:
        #
        chmod 4755 "/usr/sbin/login_duo" && "/usr/sbin/login_duo"; 
        #
        # ^-- This command will return a URL --> Open this URL on a mobile device with the Duo Authentication app installed (NOT on your desktop/workstation - Duo mobile app is required, here. Could possibly get away with a VM of a mobile OS (Android/iOS) running in Windows)
        #
      fi;

      #
      # End of [ PAM Configuration ] code block
      #
      # ------------------------------

    fi;

  fi;

  # Double-cleanup variables which may contain secrets before exiting (so that we don't leave said secrets lying around)
  unset PAM_DUO_OPTS; declare -A PAM_DUO_OPTS; # [Re-]Instantiate bash array
  duo_ikey="";
  duo_skey="";
  duo_host="";

  echo -e "\n------------------------------------------------------------\n";

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   duo.com  |  "Duo Unix - 2FA for SSH with PAM Support (pam_duo) | Duo Security"  |  https://duo.com/docs/duounix
#
#   manpages.debian.org  |  "pam_duo(8) — libpam-duo — Debian buster — Debian Manpages"  |  https://manpages.debian.org/buster/libpam-duo/pam_duo.8.en.html
#
# ------------------------------------------------------------