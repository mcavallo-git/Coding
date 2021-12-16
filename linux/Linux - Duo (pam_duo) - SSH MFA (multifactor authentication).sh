#!/bin/bash
# ------------------------------------------------------------
#
# Following Guide:  https://duo.com/docs/duounix
#
# TO INSTALL:  pam_duo
#
# ------------------------------------------------------------

if [ 1 -eq 1 ]; then

# ------------------------------
#
# Start of [ install duo_unix ] code block
#

  # Verify that duo_unix is not already installed
  if [[ -z "$(command -v login_duo 2>'/dev/null';)" ]]; then

    # Install prerequisite packages for PAM & Duo
    apt-get -y update; apt-get -y install gcc libpam-dev libssl-dev make zlib1g-dev;

    # Setup runtime variables
    DUO_UNIX_LATEST_REMOTE="https://dl.duosecurity.com/duo_unix-latest.tar.gz"; # duo_unix source - https://duo.com/docs/duounix
    WORKING_DIR="${HOME}/pam_duo_install"; # Working directory
    DUO_UNIX_LATEST_LOCAL="${WORKING_DIR}/$(basename "${DUO_UNIX_LATEST_REMOTE}";)";  # Filepath to download duo_unix to

    # Create working dir
    mkdir -pv "${WORKING_DIR}";

    # Download duo_unix
    curl -H 'Cache-Control:no-cache' -sL "${DUO_UNIX_LATEST_REMOTE}" -o "${DUO_UNIX_LATEST_LOCAL}";

    # Unpack duo_unix
    cd "${WORKING_DIR}"; tar zxf "${DUO_UNIX_LATEST_LOCAL}";

    # Set the directory which was just unpacked (from the latest duo_unix tarball) as the current working directory
    UNPACKED_DIR="$(find "${WORKING_DIR}/" -maxdepth "1" -mindepth "1" -type "d" -iname "duo_unix-*" -not -path "${DUO_UNIX_LATEST_LOCAL}" | head -n 1;)";

    if [[ -d "${UNPACKED_DIR}" ]] && [[ "${UNPACKED_DIR}" != "${WORKING_DIR}" ]]; then

      cd "${UNPACKED_DIR}"; pwd;

      # Install duo_unix
      echo "Calling [ ./configure --with-pam --prefix=/usr && make && sudo make install; ] from working directory [ $(pwd;) ]...";
      ./configure --with-pam --prefix=/usr && make && sudo make install;

    fi;

  fi;

  #
  # End of [ install duo_unix ] code block
  #
  # ------------------------------
  #
  # Start of [ pam_duo.conf ] code block
  #

  # Verify that pam_duo's config exists before continuing
  PAM_DUO_CONF="/etc/duo/pam_duo.conf";
  if [[ -f "${PAM_DUO_CONF}" ]]; then

    # Setup options to apply to [ /etc/duo/pam_duo.conf ] as an array of key-value pairs

    unset PAM_DUO_OPTS; declare -A PAM_DUO_OPTS; # [Re-]Instantiate bash array

    PAM_DUO_OPTS+=(["ikey"]="SECRET");  # Duo integration key (required)  -  20 characters long

    PAM_DUO_OPTS+=(["skey"]="SECRET");  # Duo secret key (required)  -  40 characters long

    PAM_DUO_OPTS+=(["host"]="SECRET");  # Duo API host (required)  -  matches regex "api-[^\.\s]{8}\.duosecurity\.com"

    PAM_DUO_OPTS+=(["failmode"]="safe");  # On service or configuration errors that prevent Duo authentication, fail "safe" (allow access) or "secure" (deny access) - Default is "safe"

    PAM_DUO_OPTS+=(["pushinfo"]="yes");  # Send command to be approved via Duo Push authentication - Default is "no"

    PAM_DUO_OPTS+=(["autopush"]="yes");  # Automatically send a login request to the first factor (usually push), instead of prompting the user - Default is "no"

    PAM_DUO_OPTS+=(["prompts"]="1");  # Set the maxiumum number of prompts pam_duo will show before denying access - Default is 3

    # Walk through the array of config variables
    for EACH_OPTION_KEY in "${!PAM_DUO_OPTS[@]}"; do

      EACH_OPTION_VAL_INTENDED="${PAM_DUO_OPTS[${EACH_OPTION_KEY}]}";

      EACH_OPTION_COUNT_DEFINITIONS="$(sed -rne "s/^\s*(${EACH_OPTION_KEY//\//\\/})\s*=\s*(\S+)?\s*\$/\0/p" "${PAM_DUO_CONF}" | wc -l;)";

      echo "";
      echo -e "------------------------------------------------------------\n";
      echo "";
      echo "EACH_OPTION_KEY = [ ${EACH_OPTION_KEY} ]";
      echo "EACH_OPTION_VAL_INTENDED = [ ${EACH_OPTION_VAL_INTENDED} ]";
      echo "EACH_OPTION_COUNT_DEFINITIONS = [ ${EACH_OPTION_COUNT_DEFINITIONS} ]";
      # echo "PAM_DUO_OPTS[${EACH_OPTION_KEY}] = ${EACH_OPTION_VAL_INTENDED}";

      if [[ "${EACH_OPTION_COUNT_DEFINITIONS}" -eq 1 ]]; then

        echo "";
        echo "Exactly one (1) pre-existing definition exists for option \"${EACH_OPTION_KEY}\" in file \"${PAM_DUO_CONF}\"";
        echo " |";
        echo " |--> Compare the value defined in pam_duo.conf against the intended value";

        EACH_OPTION_VAL_CURRENT="$(sed -rne "s/^(\s*${EACH_OPTION_KEY//\//\\/}\s*=\s*)(\S+)\s*\$/\2/p" "${PAM_DUO_CONF}";)";
        echo "EACH_OPTION_VAL_CURRENT = [ ${EACH_OPTION_VAL_CURRENT} ]";

        if [[ "${EACH_OPTION_VAL_CURRENT}" == "${EACH_OPTION_VAL_INTENDED}" ]]; then

          echo " |";
          echo " |--> Values match (between intended value & currently defined value)";
          echo "       |";
          echo "       |--> Do not perform any action (continue on & parse next option (if any exist))";

        else

          echo " |";
          echo " |--> Values do NOT match";
          echo " |     |";
          echo " |     |--> EACH_OPTION_VAL_CURRENT = [ ${EACH_OPTION_VAL_CURRENT} ]";
          echo " |     |--> EACH_OPTION_VAL_INTENDED = [ ${EACH_OPTION_VAL_INTENDED} ]";
          echo " |";
          echo " |--> Updating option definition to use intended value";
          
          echo "       |--> Calling [ sed -rne \"s/^(\s*${EACH_OPTION_KEY//\//\\/}\s*=\s*)(\S+)\s*\$/\1${EACH_OPTION_VAL_INTENDED//\//\\/}/p\" -i \"${PAM_DUO_CONF}\"; ]...";
          sed -rne "s/^(\s*${EACH_OPTION_KEY//\//\\/}\s*=\s*)(\S+)\s*\$/\1${EACH_OPTION_VAL_INTENDED//\//\\/}/p" "${PAM_DUO_CONF}";
          # sed -rne "s/^(\s*${EACH_OPTION_KEY//\//\\/}\s*=\s*)(\S+)\s*\$/\1${EACH_OPTION_VAL_INTENDED//\//\\/}/p" -i "${PAM_DUO_CONF}";

        fi;

      else

        if [[ "${EACH_OPTION_COUNT_DEFINITIONS}" -gt 1 ]]; then

          echo "";
          echo "Multiple pre-existing definitions exist for option \"${EACH_OPTION_KEY}\" in file \"${PAM_DUO_CONF}\"";
          echo " |";
          echo " |--> Comment out all existing option definitions";
          echo "       |--> Calling [ sed -re \"/^\s*(${EACH_OPTION_KEY//\//\\/})\s*=\s*(\S+)?\s*\$/ s/^#*/# /\" -i \"${PAM_DUO_CONF}\"; ]...";
          sed -re "/^\s*(${EACH_OPTION_KEY//\//\\/})\s*=\s*(\S+)?\s*\$/ s/^#*/# /" "${PAM_DUO_CONF}";
          # sed -re "/^\s*(${EACH_OPTION_KEY//\//\\/})\s*=\s*(\S+)?\s*\$/ s/^#*/# /" -i "${PAM_DUO_CONF}";

        else

          echo "";
          echo "No pre-existing definitions exist for option \"${EACH_OPTION_KEY}\" in file \"${PAM_DUO_CONF}\"";

        fi;
        echo " |";
        echo " |--> Append intended option definition to the end of the file";
        echo "       |--> Calling [ echo -e \"\n${EACH_OPTION_KEY} = ${EACH_OPTION_VAL_INTENDED}\n\" >> \"${PAM_DUO_CONF}\"; ]...";
        # echo -e "\n${EACH_OPTION_KEY} = ${EACH_OPTION_VAL_INTENDED}\n" >> "${PAM_DUO_CONF}";

      fi;

    done;

    echo "";
    echo -e "------------------------------------------------------------\n";
    echo "";

  fi;

  #
  # End of [ pam_duo.conf ] code block
  #
  # ------------------------------

fi;



# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------



vi "/etc/duo/pam_duo.conf";

### At the top of pam_duo.conf, set:

[duo]
; Duo integration key
ikey = [INTEGRATION-KEY-HERE]
; Duo secret key
skey = [SECRET-KEY-HERE]
; Duo API host
host = [HOST-API-HERE]

## At the bottom of pam_duo.conf, set:
pushinfo = yes
autopush = yes
prompts = 1
## ^-- This sets up automatic push-notifications whenever user attempts to BASH-into the environment


# ------------------------------------------------------------

# Configure "/etc/ssh/sshd_config" with the following settings (for public-key based authentication):

vi "/etc/ssh/sshd_config"

# Public Key Authentication
PubkeyAuthentication yes
PasswordAuthentication no
AuthenticationMethods publickey
ChallengeResponseAuthentication yes
UseDNS no
PermitTunnel no
AllowTcpForwarding no

# ------------------------------------------------------------

### Ubuntu 18.04
### SSH Public Key Authentication via PAM

## Prep
find / -name 'pam_duo.so'; find / -name 'pam_deny.so'; find / -name 'pam_permit.so'; find / -name 'pam_cap.so';

vi "/etc/pam.d/sshd";

##  Before:
@include common-auth

##  After:
#@include common-auth
auth [success=1 default=ignore] /lib64/security/pam_duo.so
auth requisite /lib/x86_64-linux-gnu/security/pam_deny.so
auth required /lib/x86_64-linux-gnu/security/pam_permit.so

# ------------------------------------------------------------

### System-wide Authentication

## Prep
find / -name 'common-auth'
vi "/etc/pam.d/common-auth";

##  Before:
auth [success=1 default=ignore] /lib/x86_64-linux-gnu/security/pam_unix.so nullok_secure
auth requisite pam_deny.so
auth required pam_permit.so

##  After:
# auth  [success=1 default=ignore] pam_unix.so nullok_secure
auth requisite /lib/x86_64-linux-gnu/security/pam_unix.so nullok_secure
auth [success=1 default=ignore] /lib64/security/pam_duo.so
auth requisite /lib/x86_64-linux-gnu/security/pam_deny.so
auth required /lib/x86_64-linux-gnu/security/pam_permit.so

# ------------------------------------------------------------

# Finally, connect the application to your duo

# NOTE: This command will return a URL hyperlink
# ^^^>>> on your MOBILE, browse to this url (not desktop)

# cat "/etc/duo/pam_duo.conf" > "/etc/duo/login_duo.conf";
ln -sf "/etc/duo/pam_duo.conf" "/etc/duo/login_duo.conf";

chmod 4755 "/usr/sbin/login_duo" && "/usr/sbin/login_duo";


# ------------------------------------------------------------
#
# Citation(s)
#
#   manpages.debian.org  |  "pam_duo(8) — libpam-duo — Debian buster — Debian Manpages"  |  https://manpages.debian.org/buster/libpam-duo/pam_duo.8.en.html
#
# ------------------------------------------------------------