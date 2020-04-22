#!/bin/bash

# UniFi Controller Updater auto installation script.
# Version  | 3.4.7
# Author   | Glenn Rietveld
# Email    | glennrietveld8@hotmail.nl
# Website  | https://GlennR.nl

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                           Color Codes                                                                                           #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

RESET='\033[0m'
GRAY='\033[0;37m'
WHITE='\033[1;37m'
GRAY_R='\033[39m'
WHITE_R='\033[39m'
RED='\033[1;31m' # Light Red.
GREEN='\033[1;32m' # Light Green.
BOLD='\e[1m'

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                           Start Checks                                                                                          #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

# Check for root (SUDO).
if [ "$EUID" -ne 0 ]; then
  clear
  clear
  echo -e "${RED}#########################################################################${RESET}"
  echo ""
  echo -e "${WHITE_R}#${RESET} The script need to be run as root..."
  echo ""
  echo ""
  echo -e "${WHITE_R}#${RESET} For Ubuntu based systems run the command below to login as root"
  echo -e "${GREEN}#${RESET} sudo -i"
  echo ""
  echo -e "${WHITE_R}#${RESET} For Debian based systems run the command below to login as root"
  echo -e "${GREEN}#${RESET} su"
  echo ""
  echo ""
  exit 1
fi

abort() {
  echo ""
  echo ""
  echo -e "${RED}#########################################################################${RESET}"
  echo ""
  echo -e "${WHITE_R}#${RESET} An error occurred. Aborting script..."
  echo -e "${WHITE_R}#${RESET} Please contact Glenn R. (AmazedMender16) on the Community Forums!"
  echo ""
  echo ""
  exit 1
}

header() {
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
}

header_red() {
  clear
  echo -e "${RED}#########################################################################${RESET}"
  echo ""
}

thank_you() {
  clear
  header
  echo -e "${WHITE_R}#${RESET} Starting the UniFi Network Controller update!"
  echo -e "${WHITE_R}#${RESET} Thank you for using my Easy Update Script!"
  echo ""
  echo ""
  sleep 2
}

# Get distro.
if [ -z "$(command -v lsb_release)" ]; then
  if [ -f "/etc/os-release" ]; then
    if [[ -n "$(grep VERSION_CODENAME /etc/os-release)" ]]; then
      os_codename=$(grep VERSION_CODENAME /etc/os-release | sed 's/VERSION_CODENAME//g' | tr -d '="')
    elif [[ -z "$(grep VERSION_CODENAME /etc/os-release)" ]]; then
      os_codename=$(grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//g' | tr -d '="' | awk '{print $4}' | sed 's/\((\|)\)//g')
    fi
  fi
else
  os_codename=$(lsb_release -cs)
fi

if [ $(grep "^export PATH=" /root/.bashrc | grep -c "/sbin") -eq 0 ]; then
  if [[ $(grep "^export PATH=" /root/.bashrc) ]]; then
    sed -i 's/^export PATH=/#export PATH=/' /root/.bashrc
  fi
  echo "export PATH=/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/bin" >> /root/.bashrc || abort
  source /root/.bashrc || abort
fi

if [ ! -d /etc/apt/sources.list.d ]; then
  mkdir -p /etc/apt/sources.list.d
fi

# Check if UniFi is already installed.
if [ $(dpkg-query -W -f='${Status}' unifi 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  clear
  header_red
  echo ""
  echo -e "${WHITE_R}#${RESET} UniFi is not installed on your system!${RESET}"
  echo ""
  echo ""
  echo -e "${WHITE_R}#${RESET} You can use GlennR's Installation Scripts to install UniFi on your system.${RESET}"
  echo -e "${WHITE_R}#${RESET} ${GRAY_R}Installation Scripts Community Forums  |  ${WHITE_R}https://community.ui.com/questions/ccbc7530-dd61-40a7-82ec-22b17f027776${RESET}"
  echo -e "${WHITE_R}#${RESET} ${GRAY_R}Installation Scripts Download Page     |  ${WHITE_R}https://glennr.nl/s/unifi-network-controller${RESET}"
  echo ""
  echo ""
  echo -e "${WHITE_R}#${RESET} ${GRAY_R}Author   |  ${WHITE_R}Glenn R.${RESET}"
  echo -e "${WHITE_R}#${RESET} ${GRAY_R}Email    |  ${WHITE_R}glennrietveld8@hotmail.nl${RESET}"
  echo -e "${WHITE_R}#${RESET} ${GRAY_R}Website  |  ${WHITE_R}https://GlennR.nl${RESET}"
  echo ""
  echo ""
  exit 0
fi

dpkg_locked_message() {
  clear
  header_red
  echo -e "${WHITE_R}#${RESET} dpkg is locked.. Waiting for other software managers to finish!"
  echo -e "${WHITE_R}#${RESET} If this is everlasting please contact Glenn R. (AmazedMender16) on the Community Forums!"
  echo ""
  echo ""
  sleep 5
  if [[ -z "$dpkg_wait" ]]; then
    echo "glennr_lock_active" >> /tmp/glennr_lock
  fi
}

dpkg_locked_60_message() {
  clear
  header
  echo -e "${WHITE_R}#${RESET} dpkg is already locked for 60 seconds..."
  echo -e "${WHITE_R}#${RESET} Would you like to force remove the lock?"
  echo ""
  echo ""
  echo ""
}

# Check if dpkg is locked
if [ $(dpkg-query -W -f='${Status}' psmisc 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
  while fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1; do
    dpkg_locked_message
    if [ $(grep glennr_lock_active /tmp/glennr_lock | wc -l) -ge 12 ]; then
      rm -rf /tmp/glennr_lock 2> /dev/null
      dpkg_locked_60_message
      read -p $'\033[39m#\033[0m Do you want to proceed with removing the lock? (Y/n) ' yes_no
      case "$yes_no" in
          [Yy]*|"")
            killall apt apt-get 2> /dev/null
            rm -rf /var/lib/apt/lists/lock 2> /dev/null
            rm -rf /var/cache/apt/archives/lock 2> /dev/null
            rm -rf /var/lib/dpkg/lock* 2> /dev/null
            dpkg --configure -a 2> /dev/null
            apt-get check >/dev/null 2>&1
            if [ "$?" -ne 0 ]; then
              apt-get install --fix-broken -y 2> /dev/null
            fi
            clear
            clear;;
          [Nn]*) dpkg_wait=true;;
      esac
    fi
  done;
else
  dpkg -i /dev/null 2> /tmp/glennr_dpkg_lock; if grep -q "locked.* another" /tmp/glennr_dpkg_lock; then dpkg_locked=true; rm -rf /tmp/glennr_dpkg_lock 2> /dev/null; fi
  while [[ $dpkg_locked == 'true'  ]]; do
    unset dpkg_locked
    dpkg_locked_message
    if [ $(grep glennr_lock_active /tmp/glennr_lock | wc -l) -ge 12 ]; then
      rm -rf /tmp/glennr_lock 2> /dev/null
      dpkg_locked_60_message
      read -p $'\033[39m#\033[0m Do you want to proceed with force removing the lock? (Y/n) ' yes_no
      case "$yes_no" in
          [Yy]*|"")
            ps aux | grep -i apt | awk '{print $2}' >> /tmp/glennr_apt
            glennr_apt_pid_list=$(tr '\r\n' ' ' < /tmp/glennr_apt)
            for glennr_apt in ${glennr_apt_pid_list[@]}; do
              kill -9 $glennr_apt 2> /dev/null
            done;
            rm -rf /tmp/glennr_apt 2> /dev/null
            rm -rf /var/lib/apt/lists/lock 2> /dev/null
            rm -rf /var/cache/apt/archives/lock 2> /dev/null
            rm -rf /var/lib/dpkg/lock* 2> /dev/null
            dpkg --configure -a 2> /dev/null
            apt-get check >/dev/null 2>&1
            if [ "$?" -ne 0 ]; then
              apt-get install --fix-broken -y 2> /dev/null
            fi
            clear
            clear;;
          [Nn]*) dpkg_wait=true;;
      esac
    fi
    dpkg -i /dev/null 2> /tmp/glennr_dpkg_lock; if grep -q "locked.* another" /tmp/glennr_dpkg_lock; then dpkg_locked=true; rm -rf /tmp/glennr_dpkg_lock 2> /dev/null; fi
  done;
  rm -rf /tmp/glennr_dpkg_lock 2> /dev/null
fi

# Install needed packages if not installed
clear
clear
echo -e "${GREEN}#########################################################################${RESET}"
echo ""
echo -e "${WHITE_R}#${RESET} Checking if all required packages are installed.."
echo ""
echo ""
sleep 2
if [ $(dpkg-query -W -f='${Status}' jq 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  apt-get install jq -y
  if [[ $? > 0 ]]; then
    if [[ $os_codename =~ (precise|maya) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu trusty-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu trusty-security main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (trusty|qiana|rebecca|rafaela|rosa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu trusty-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu trusty-security main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (xenial|sarah|serena|sonya|sylvia) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu xenial-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu xenial-security main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (bionic|tara|tessa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu bionic main universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu bionic main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "cosmic" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "disco" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu disco main universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu disco main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "jessie" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian jessie main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian jessie main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (stretch|continuum) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian stretch main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian stretch main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "buster" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian buster main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian buster main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    fi
    apt-get update
    apt-get install jq -y || abort
  fi
fi
if [ $(dpkg-query -W -f='${Status}' dirmngr 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  apt-get install dirmngr -y
  if [[ $? > 0 ]]; then
    if [[ $os_codename =~ (precise|maya) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ precise universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ precise universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ precise main restricted") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ precise main restricted >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (trusty|qiana|rebecca|rafaela|rosa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ trusty universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ trusty universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ trusty main restricted") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ trusty main restricted >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (xenial|sarah|serena|sonya|sylvia) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu xenial-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu xenial-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ xenial main restricted") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ xenial main restricted >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (bionic|tara|tessa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu bionic-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu bionic-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ bionic main restricted") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ bionic main restricted >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "cosmic" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu cosmic-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu cosmic-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ cosmic main restricted") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ cosmic main restricted >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "disco" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu disco-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu disco-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ disco main restricted") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ disco main restricted >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "jessie" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian/ jessie main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian/ jessie main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (stretch|continuum) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian/ stretch main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian/ stretch main >>/etc/apt/sources.list.d/glennr-install-script.list || abor
      fi
    elif [[ $os_codename == "buster" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian/ buster main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian/ buster main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    fi
    apt-get update
    apt-get install dirmngr -y || abort
  fi
fi
if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  apt-get install curl -y
  if [[ $? > 0 ]]; then
    if [[ $os_codename =~ (precise|maya) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu precise-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu precise-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (trusty|qiana|rebecca|rafaela|rosa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu trusty-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu trusty-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (xenial|sarah|serena|sonya|sylvia) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu xenial-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu xenial-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (bionic|tara|tessa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu bionic-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu bionic-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "cosmic" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu cosmic-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu cosmic-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "disco" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu disco main") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu disco main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "jessie" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.debian.org/debian-security jessie/updates main") -eq 0 ]]; then
        echo deb http://security.debian.org/debian-security jessie/updates main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (stretch|continuum) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian stretch main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian stretch main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "buster" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian buster main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian buster main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    fi
    apt-get update
    apt-get install curl -y || abort
  fi
fi
if [ $(dpkg-query -W -f='${Status}' apt-transport-https 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  apt-get install apt-transport-https -y
  if [[ $? > 0 ]]; then
    if [[ $os_codename =~ (precise|maya) ]]; then
       if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu precise-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu precise-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
       fi
    elif [[ $os_codename =~ (trusty|qiana|rebecca|rafaela|rosa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu trusty-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu trusty-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (xenial|sarah|serena|sonya|sylvia) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu xenial-security main") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu xenial-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (bionic|tara|tessa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu bionic-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu bionic-security main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "cosmic" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu cosmic-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu cosmic-security main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "disco" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu disco main universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu disco main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "jessie" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.debian.org/debian-security jessie/updates main") -eq 0 ]]; then
        echo deb http://security.debian.org/debian-security jessie/updates main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (stretch|continuum) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian stretch main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian stretch main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "buster" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian buster main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian buster main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    fi
    apt-get update
    apt-get install apt-transport-https -y || abort
  fi
fi
if [ $(dpkg-query -W -f='${Status}' psmisc 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  apt-get install psmisc -y
  if [[ $? > 0 ]]; then
    if [[ $os_codename =~ (precise|maya) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu/ precise-updates main restricted") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu/ precise-updates main restricted >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (trusty|qiana|rebecca|rafaela|rosa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu trusty main") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu trusty main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (xenial|sarah|serena|sonya|sylvia) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu xenial main") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu xenial main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (bionic|tara|tessa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu bionic main") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu bionic main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "cosmic" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "disco" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu disco main") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu disco main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "jessie" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian jessie main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian jessie main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (stretch|continuum) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian stretch main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian stretch main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "buster" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian buster main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian buster main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    fi
    apt-get update
    apt-get install psmisc -y || abort
  fi
fi
if [ $(dpkg-query -W -f='${Status}' lsb-release 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  apt-get install lsb-release -y
  if [[ $? > 0 ]]; then
    if [[ $os_codename =~ (precise|maya) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu precise main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu precise main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (trusty|qiana|rebecca|rafaela|rosa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu trusty main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu trusty main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (xenial|sarah|serena|sonya|sylvia) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu xenial main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu xenial main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (bionic|tara|tessa) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu bionic main universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu bionic main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
       fi
    elif [[ $os_codename == "cosmic" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "disco" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu disco main universe") -eq 0 ]]; then
        echo deb http://nl.archive.ubuntu.com/ubuntu disco main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "jessie" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian jessie main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian jessie main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename =~ (stretch|continuum) ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian stretch main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian stretch main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    elif [[ $os_codename == "buster" ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.[A-Za-z0-9]*.debian.org/debian buster main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian buster main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      fi
    fi
    apt-get update
    apt-get install lsb-release -y || abort
  fi
fi

mongodb_org_shell_cache=$(apt-cache policy mongodb-org-shell | grep Installed: | awk '{print $2}' | sed 's/\.//g' | sed 's/.*://' | sed 's/-.*//g')
mongodb_clients_cache=$(apt-cache policy mongodb-clients | grep Installed: | awk '{print $2}' | sed 's/\.//g' | sed 's/.*://' | sed 's/-.*//g')
install_mongodb_shell_clients=''
mongodb_fail=''

failed_mongodb_org_shell() {
  clear
  header_red
  if [[ $mongodb_fail == 'shell' ]]; then
    echo -e "${RED}#${RESET} Failed to install mongodb-org-shell, multiple options won't work with this package."
  elif [[ $mongodb_fail == 'clients' ]]; then
    echo -e "${RED}#${RESET} Failed to install mongodb-clients, multiple options won't work with this package."
  fi
  echo ""
  echo ""
  echo ""
  echo "${WHITE_R}#${RESET} Note: creating backup etc will not work ( via the script ), I do NOT recommend going forward with a backup "
  read -p $'\033[39m#\033[0m Do you want to continue the script? (y/N) ' yes_no
  case "$yes_no" in
      [Yy]*) ;;
      [Nn]*|"") abort;;
  esac
}

if [[ $mongodb_org_shell_cache == *'none'* && $(dpkg -l | grep "mongodb-org-server" | awk '{print $1}' | grep "^ii") ]]; then
  shell_v_to_install=$(dpkg -l | grep "mongodb-org" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g' | sort -V | tail -n 1)
  apt-get -y install mongodb-org-shell=${shell_v_to_install} || { mongodb_fail=shell; failed_mongodb_org_shell; }
elif [[ $mongodb_clients_cache == *'none'* && $(dpkg -l | grep "mongodb-server" | awk '{print $1}' | grep "^ii") ]]; then
  apt-get -y install mongodb-clients || { mongodb_fail=clients; failed_mongodb_org_shell; }
fi

SCRIPT_VERSION_ONLINE=$(curl https://get.glennr.nl/unifi/update/unifi-update.sh -s | grep "# Version" | awk '{print $4}' | sed 's/\.//g')
SCRIPT_VERSION=$(grep "# Version " $0 | awk '{print $4}' | sed 's/\.//g')

# Script version check.
if [ ${SCRIPT_VERSION_ONLINE::3} -gt ${SCRIPT_VERSION::3} ]; then
  clear
  header_red
  echo -e "${WHITE_R}#${RESET} You're not using the latest version of the Easy Update Script!"
  echo -e "${WHITE_R}#${RESET} Downloading and executing the latest script version.."
  echo ""
  echo ""
  sleep 3
  rm -rf $0 2> /dev/null
  rm -rf unifi-update.sh 2> /dev/null
  wget https://get.glennr.nl/unifi/update/unifi-update.sh; chmod +x unifi-update.sh; sudo ./unifi-update.sh; exit 0
fi

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                            Variables                                                                                            #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

UNIFI=$(dpkg -l | grep "unifi " | awk '{print $3}' | sed 's/-.*//')
UNIFI_RELEASE=$(dpkg -l | grep "unifi " | awk '{print $3}' | sed 's/-.*//' | sed 's/\.//g')
os_desc=$(lsb_release -ds)
ARCHITECTURE=$(uname -m)
JAVA7=$(dpkg -l | grep ^ii | grep -c "openjdk-7\|oracle-java7")
JAVA8=$(dpkg -l | grep ^ii | grep -c "openjdk-8\|oracle-java8")
JAVA_V=$(dpkg -l | grep ^ii | grep "openjdk\|oracle" | awk '{print $3}' | grep "^8u" | sed 's/-.*//g' | sed 's/8u//g' | sort -V | tail -n 1)
mongodb_org_v=$(dpkg -l | grep "mongodb-org" | awk '{print $3}' | sed 's/\.//g' | sed 's/.*://' | sed 's/-.*//g' | sort -V | tail -n 1)

JAVA7_INSTALLED=''
JAVA8_INSTALLED=''
OUTDATED_JAVA_V=''
UNIFI_VERSION=''

UNIFI_BACKUP_END=''
UNIFI_BACKUP_TIMED_OUT=''
GLENNR_UNIFI_BACKUP=''
UNIFI_DEVICE_UPGRADE=''
UNIFI_DEVICE_UPGRADE_TIMED_OUT=''
EXECUTED_UNIFI_CREDENTIALS=''
RUN_UNIFI_DEVICES_UPGRADE=''
ONLY_RUN_UNIFI_DEVICES_UPGRADE=''
UNIFI_FIRMWARE_AVAILABLE=''
UNIFI_FIRMWARE_TIMED_OUT=''
run_unifi_devices_upgrade_already=''
backup_location=''
debug_system_warn=''
debug_mgmt_warn=''
unifi_write_permission=''

user_name_exist=''
user_email_exist=''
admin_name_super=''
admin_email_super=''
ubic_2fa_token=''
two_factor=''
unifi_backup_cancel=''
controller_login=''

# UniFi API Variables
unifi_api_baseurl=https://localhost:8443
unifi_api_cookie=$(mktemp)
unifi_api_curl_cmd="curl --tlsv1 --silent --cookie ${unifi_api_cookie} --cookie-jar ${unifi_api_cookie} --insecure "

# UniFi Devices ( 3.7.58 )
UGW3=(UGW3) #USG3
UGW4=(UGW4) #USGP4
US24P250=(USW US8 US8P60 US8P150 US16P150 US24 US24P250 US24P500 US48 US48P500 US48P750) #USW
U7PG2=(U7LT U7LR U7PG2 U7EDU U7MSH U7MP U7IW U7IWP) #UAP-AC-Lite/LR/Pro/EDU/M/M-PRO/IW/IW-Pro
BZ2=(BZ2 BZ2LR U2O U5O) #UAP, UAP-LR, UAP-OD, UAP-OD5
U2Sv2=(U2Sv2 U2Lv2) #UAP-v2, UAP-LR-v2
U2IW=(U2IW) #UAP IW
U7P=(U7P) #UAP PRO
U2HSR=(U2HSR) #UAP OD+
U7HD=(U7HD) #UAP HD
USXG=(USXG) #USW 16 XG
U7E=(U7E U7Ev2 U7O) #UAP AC, UAP AC v2, UAP AC OD


###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                                                                                                                                 #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

migration_check() {
  clear
  header
  echo "                 Checking Database migration process."
  echo "            This can take up to 2 minutes before timing out!"
  echo ""
  echo ""
  read -t 120 < <(tail -n 0 -f /usr/lib/unifi/logs/server.log | grep --line-buffered 'DB migration to version (.*) is complete\|*** Factory Default ***') && UNIFI_UPDATE=true || TIMED_OUT=true
  if [[ $UNIFI_UPDATE = 'true' ]]; then
    clear
    unset UNIFI
    UNIFI=$(dpkg -l | grep "unifi " | awk '{print $3}' | sed 's/-.*//')
    header
    echo -e "${WHITE_R}#${RESET} UniFi Network Controller DB migration was successful"
    echo -e "${WHITE_R}#${RESET} Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
    echo ""
    echo ""
    echo -e "${WHITE_R}#${RESET} Continuing the UniFi Network Controller update!"
    echo ""
    echo ""
    unset UNIFI_UPDATE
    unset TIMED_OUT
    sleep 3
  elif [[ $TIMED_OUT = 'true' ]]; then
    clear
    header_red
    echo "                      DB migration check timed out!"
    echo ""
    echo "    Please contact Glenn R. (AmazedMender16) on the Community Forums!"
    echo ""
    echo ""
    exit 1
  fi
  echo ""
  echo ""
}

remove_yourself() {
  if [[ $delete_script == 'true' ]]; then
    if [[ -e $0 ]]; then
      rm -rf $0 2> /dev/null
    fi
  fi
}

unifi_update_start() {
  clear
  header
  echo -e "${WHITE_R}#${RESET} Starting the UniFi Network Controller update!"
  echo ""
  echo ""
  sleep 2
}

author() {
  echo -e "${WHITE_R}#${RESET} ${GRAY_R}Author   |  ${WHITE_R}Glenn R.${RESET}"
  echo -e "${WHITE_R}#${RESET} ${GRAY_R}Email    |  ${WHITE_R}glennrietveld8@hotmail.nl${RESET}"
  echo -e "${WHITE_R}#${RESET} ${GRAY_R}Website  |  ${WHITE_R}https://GlennR.nl${RESET}"
  echo ""
  echo ""
  echo ""
}

backup_save_location() {
  if [[ $backup_location == "custom" ]]; then
    if echo $auto_dir | grep -q '/$'; then
      echo -e "${WHITE_R}#${RESET} Your UniFi Network Controller backup is saved here: ${WHITE_R}${auto_dir}glennr-unifi-backups/${RESET}"
    else
      echo -e "${WHITE_R}#${RESET} Your UniFi Network Controller backup is saved here: ${WHITE_R}${auto_dir}/glennr-unifi-backups/${RESET}"
    fi
  elif [[ $backup_location == "sd_card" ]]; then
    echo -e "${WHITE_R}#${RESET} Your UniFi Network Controller backup is saved here: ${WHITE_R}/data/glennr-unifi-backups/${RESET}"
  elif [[ $backup_location == "unifi_dir" ]]; then
    echo -e "${WHITE_R}#${RESET} Your UniFi Network Controller backup is saved here: ${WHITE_R}/usr/lib/unifi/data/backup/glennr-unifi-backups/${RESET}"
  fi
}

auto_backup_write_warning() {
  if [[ $controller_login == 'success' ]]; then
    if mongo --quiet --port 27117 ace --eval "db.getCollection('setting').find({}).forEach(printjson);" | grep -q 'autobackup_enabled.* true' && [[ $unifi_write_permission == "false" ]]; then
      echo -e "${RED}#${RESET} Your autobackups path is set to '${WHITE_R}${auto_dir}${RESET}', user UniFi is not able to backup to that location.."
      echo -e "${RED}#${RESET} I recommend checking the path and make sure the user UniFi has permissions to that directory.. or use the default location."
    elif mongo --quiet --port 27117 ace --eval "db.getCollection('setting').find({}).forEach(printjson);" | grep -q 'autobackup_enabled.* false'; then
      echo -e "${RED}#${RESET} You currently don't have autobackups turned on.."
      echo -e "${RED}#${RESET} I highly recommend turning that on, let it run daily settings only backups..."
    fi
  fi
}

unifi_update_finish() {
  if [[ $controller_login == 'success' ]]; then
    clear
    controller_login_attempt
  fi
  unset UNIFI
  UNIFI=$(dpkg -l | grep "unifi " | awk '{print $3}' | sed 's/-.*//')
  login_cleanup
  clear
  header
  echo ""
  echo -e "${WHITE_R}#${RESET} Your UniFi Network Controller has been successfully updated to ${WHITE_R}$UNIFI${RESET}"
  backup_save_location
  echo ""
  auto_backup_write_warning
  echo ""
  echo ""
  author
  remove_yourself
  exit 0
}

unifi_update_latest() {
  login_cleanup
  clear
  header
  echo ""
  echo -e "${WHITE_R}#${RESET} Your UniFi Network Controller is already on the latest stable release! ( ${WHITE_R}5.10.27${RESET} )"
  backup_save_location
  echo ""
  auto_backup_write_warning
  echo ""
  echo ""
  author
  remove_yourself
  exit 0
}

os_update_finish() {
  clear
  header
  echo ""
  echo -e "${WHITE_R}#${RESET} The latest patches have been successfully installed on your system!"
  echo ""
  echo ""
  author
  remove_yourself
  exit 0
}

devices_update_finish() {
  clear
  header
  echo ""
  echo -e "${WHITE_R}#${RESET} Your UniFi devices have been successfully updated!"
  echo ""
  echo ""
  author
  remove_yourself
  exit 0
}

cancel_script() {
  clear
  header
  echo -e "${WHITE_R}#${RESET} Cancelling the script!"
  echo ""
  echo ""
  exit 0
}

controller_startup_message() {
  clear
  header
  echo -e "${WHITE_R}#${RESET} UniFi Network Controller is starting up..."
  echo -e "${WHITE_R}#${RESET} Please wait a moment."
  echo ""
  echo ""
}


###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                  UniFi API Login/Logout/Cleanup                                                                                 #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

username_text() {
  clear
  header
  echo ""
  echo -e "${RED}#${RESET} Use the Super Administrator credentials!"
  echo -e "${RED}#${RESET} The credentials are only used to login to the controller. ( username and password will NOT be saved )"
  echo ""
  echo ""
  echo -e "${GREEN}####${RESET}"
  echo ""
  echo -e "${WHITE_R}#${RESET} What is your UniFi Network Controller Username?"
  echo ""
  echo ""
}

password_text() {
  clear
  header
  echo -e "${WHITE_R}#${RESET} What is your UniFi Network Controller Password?"
  echo ""
  echo ""
}

two_factor_request() {
  echo -e "${WHITE_R}#${RESET} Insert your 2FA token ( 6 Digits Token )"
  echo ""
  echo ""
  read -p $' 2FA Token:\033[39m ' ubic_2fa_token
  if [ -z "$ubic_2fa_token" ]; then
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} 2FA Token can't be blank..."
    echo ""
    echo ""
    sleep 3
    unset ubic_2fa_token
    read -p $' 2FA Token:\033[39m ' ubic_2fa_token
  fi
}

unifi_credentials() {
  username_text
  read -p $' Username:\033[39m ' username
  if [ -z "$username" ]; then
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} Username can't be blank..."
    echo ""
    echo ""
    sleep 3
    unset username
    username_text
    read -p $' Username:\033[39m ' username
  fi
  password_text
  read -srp " Password: " password
  if [ -z "$password" ]; then
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} Password can't be blank..."
    echo ""
    echo ""
    sleep 3
    unset password
    password_text
    read -srp " Password: " password
  fi
  if mongo --quiet --port 27117 ace --eval "db.getCollection('setting').find({}).forEach(printjson);" | grep -q 'sso_login_enabled.* true'; then
    clear
    header
    echo ""
    read -p $'\033[39m#\033[0m Do you have 2FA enabled on your UBNT Account? (Y/n) ' yes_no
    case "$yes_no" in
        [Yy]*|"")
          two_factor=enabled
          unset ubic_2fa_token
          clear
          header
          two_factor_request;;
        [Nn]*) ;;
    esac
  fi
  clear
}

unifi_login() {
  if [[ $two_factor == 'enabled' ]]; then
    ${unifi_api_curl_cmd} --data "{\"username\":\"$username\", \"password\":\"$password\", \"ubic_2fa_token\":\"$ubic_2fa_token\"}" $unifi_api_baseurl/api/login >> /tmp/controller-login.log
  else
    ${unifi_api_curl_cmd} --data "{\"username\":\"$username\", \"password\":\"$password\"}" $unifi_api_baseurl/api/login >> /tmp/controller-login.log
  fi
}

unifi_logout() {
  ${unifi_api_curl_cmd} $unifi_api_baseurl/logout
}

super_user_check() {
  mongo --quiet --port 27117 ace --eval "db.getCollection('privilege').find({}).forEach(printjson);" >> /tmp/glennr_con_pri && sed -i 's/\(ObjectId(\|)\)//g' /tmp/glennr_con_pri
  mongo --quiet --port 27117 ace --eval "db.getCollection('site').find({}).forEach(printjson);" >> /tmp/glennr_con_sit && sed -i 's/\(ObjectId(\|)\)//g' /tmp/glennr_con_sit
  mongo --quiet --port 27117 ace --eval "db.getCollection('admin').find({}).forEach(printjson);" >> /tmp/glennr_con_adm && sed -i 's/\(ObjectId(\|)\|NumberLong(\)//g' /tmp/glennr_con_adm
  super_id=`cat /tmp/glennr_con_sit | jq -r '. | select(.name=="super" and .key=="super") | ._id' && rm -rf /tmp/glennr_con_sit 2> /dev/null`
  cat /tmp/glennr_con_pri | jq -r '. | select(.site_id=="'$super_id'" and .role=="admin") | .admin_id' >> /tmp/id_admin_list && rm -rf /tmp/glennr_con_pri 2> /dev/null
  admin_name=`cat /tmp/glennr_con_adm | jq -r '. | select(.name=="'$username'") | ._id'`
  admin_email=`cat /tmp/glennr_con_adm | jq -r '. | select(.email=="'$username'") | ._id'`
  if ! grep -Fxq "$admin_name" /tmp/id_admin_list; then admin_name_super=false; fi
  if ! grep -Fxq "$admin_email" /tmp/id_admin_list; then admin_email_super=false; fi
  if [[ ( $admin_name_super == 'false' && $admin_email_super == 'false' ) ]]; then
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} Account/User ${WHITE_R}${username}${RESET} is not a Super Administrator.."
    echo -e "${WHITE_R}#${RESET} Please use the Super Administrator credentials!"
    echo ""
    echo ""
    read -p $'\033[39m#\033[0m Would you like to try another account? (Y/n) ' yes_no
    case "$yes_no" in
        [Yy]*|"")
          unifi_login_cleanup
          unifi_logout
          unifi_credentials
          unifi_login
          super_user_check
          unifi_login_check;;
        [Nn]*) unifi_backup_cancel=true;;
    esac
  else
    rm -rf /tmp/id_admin_list 2> /dev/null
  fi
  rm -rf /tmp/glennr_con_adm 2> /dev/null
}

unifi_login_check () {
  mongo --quiet --port 27117 ace --eval "db.getCollection('admin').find({}).forEach(printjson);" >> /tmp/glennr_adm_acc && sed -i 's/\(ObjectId(\|)\|NumberLong(\)//g' /tmp/glennr_adm_acc
  cat /tmp/glennr_adm_acc | jq -r '. | ._id' >> /tmp/adm_id_list
  user_name=`cat /tmp/glennr_adm_acc | jq -r '. | select(.name=="'$username'") | ._id'`
  user_email=`cat /tmp/glennr_adm_acc | jq -r '. | select(.email=="'$username'") | ._id'`
  if ! grep -Fxq "$user_name" /tmp/adm_id_list; then user_name_exist=false; fi
  if ! grep -Fxq "$user_email" /tmp/adm_id_list; then user_email_exist=false; fi
  if [[ ( $user_name_exist == 'false' && $user_email_exist == 'false' ) ]]; then
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} Account/User ${WHITE_R}${username}${RESET} does not exist in the database"
    echo -e "${WHITE_R}#${RESET} Be aware... \e[1mCaSe SeNsItIvE${RESET}"
    echo ""
    echo ""
    read -p $'\033[39m#\033[0m Would you like to try another account? (Y/n) ' yes_no
    case "$yes_no" in
        [Yy]*|"")
          unifi_login_cleanup
          unifi_credentials
          unifi_login
          unifi_login_check
          super_user_check;;
        [Nn]*) 
          unifi_backup_cancel=true
          unifi_login_cleanup;;
    esac
  elif [[ $(grep "Ubic2faToken.*Required" /tmp/controller-login.log) ]]; then
    unifi_login_cleanup
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} You seem to have 2FA enabled on your UBNT account.."
    two_factor_request
  elif [[ $(grep "Invalid2FAToken" /tmp/controller-login.log) ]]; then
    unifi_login_cleanup
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} Login error... Invalid 2FA Token"
    two_factor_request
  elif [[ $(grep "error" /tmp/controller-login.log) ]]; then
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} UniFi Network Controller credentials are incorrect, login failed.."
    echo ""
    echo ""
    read -p $'\033[39m#\033[0m Would you like to try again? (Y/n) ' yes_no
    case "$yes_no" in
        [Yy]*|"")
          unifi_login_cleanup
          unifi_credentials
          unifi_login
          unifi_login_check
          if [[ $unifi_backup_cancel != 'true' ]]; then
            super_user_check
          fi;;
        [Nn]*)
          unifi_backup_cancel=true
          unifi_login_cleanup;;
    esac
  elif [[ $(grep "ok" /tmp/controller-login.log) ]]; then
    controller_login=success
    unifi_login_cleanup
  fi
  rm -rf /tmp/glennr_adm_acc 2> /dev/null
  rm -rf /tmp/glennr_use_acc 2> /dev/null
  rm -rf /tmp/adm_id_list 2> /dev/null
}

unifi_cleanup() {
  rm -rf /tmp/unifi_site* 2> /dev/null
  rm -rf /tmp/unifi_device* 2> /dev/null
  rm -rf /tmp/unifi_models 2> /dev/null
  rm -rf ${unifi_api_cookie} 2> /dev/null
  rm -rf /tmp/glennr_custom_upgrade_executed 2> /dev/null
}

login_cleanup() {
  unset username
  unset password
  unset ubic_2fa_token
  unifi_login_cleanup
}

unifi_login_cleanup() {
  rm -rf /tmp/controller-login.log 2> /dev/null
}

controller_login_attempt() {
  unifi_login
  while grep -q "error" /tmp/controller-login.log; do
    unifi_login;
    unifi_login_cleanup;
    controller_startup_message;
   sleep 5
  done;
  unifi_logout
}

controller_statup_message() {
  clear
  header
  echo -e "${WHITE_R}#${RESET} Controller started successfully!"
  echo ""
  echo ""
  sleep 2
}

debug_check () {
  if [[ $(grep "^debug.system=warn" /usr/lib/unifi/data/system.properties) ]]; then
    debug_system_warn=true
  fi
  if [[ $(grep "^debug.mgmt=warn" /usr/lib/unifi/data/system.properties) ]]; then
    debug_mgmt_warn=true
  fi
  if [[ $debug_system_warn == 'true' ]] && [[ $debug_mgmt_warn == 'true' ]]; then
    sed -i 's/^debug.system=warn/debug.system=info/' /usr/lib/unifi/data/system.properties
    debug_warn_info=true
    clear
    header
    echo -e "${WHITE_R}#${RESET} Restarting the UniFi Network Controller service.."
    echo -e "${WHITE_R}#${RESET} This is required so the script can get the information that it needs. ( from the logs )"
    echo ""
    echo ""
    service unifi restart && controller_login_attempt && controller_statup_message
  fi
}

debug_check_no_upgrade() {
  if [[ $debug_warn_info == 'true' ]]; then
    clear
    header
    echo -e "${WHITE_R}#${RESET} Reverting back the debug modifications that the script made earlier.."
    echo -e "${WHITE_R}#${RESET} Restarting the UniFi Network Controller service.."
    echo ""
    echo ""
    sleep 2
    sed -i 's/^debug.system=info/debug.system=warn/' /usr/lib/unifi/data/system.properties
    service unifi restart
  fi
}

alert_event_cleanup() {
  alert_find_m=$(mongo --port 27117 ace --eval 'db.alarm.find({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}})' | grep -c "log.* 127.0.0.1\|log.* 0:0:0:0:0:0:0:1")
  event_find_m=$(mongo --port 27117 ace --eval 'db.event.find({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}})' | grep -c "log.* 127.0.0.1\|log.* 0:0:0:0:0:0:0:1")
  m_org_s_ver=$(dpkg -l | grep ^ii | grep "mongodb-org-server" | awk '{print $3}' | sed 's/\.//g')
  if [[ $alert_find_m -ge 1 || $event_find_m -ge 1 ]]; then
    clear
    header
    echo -e "${WHITE_R}#${RESET} Localhost ( 127.0.0.1 ) controller logins detected in the database."
    echo -e "${WHITE_R}#${RESET} Would you like to archive/delete those Alerts/Events?"
    echo ""
    echo -e " [   ${WHITE_R}1${RESET}   ]  |  Delete the Events/Alerts ( default )"
    echo -e " [   ${WHITE_R}2${RESET}   ]  |  Archive the Alerts ( keeps the Alerts and deletes the Events )"
    echo -e " [   ${WHITE_R}3${RESET}   ]  |  Skip ( keep the Events/Alerts )"
    echo ""
    echo ""
    echo ""
    read -p $'Your choice | \033[39m' alert_event_cleanup_question
    case "$alert_event_cleanup_question" in
        1*|"")
          clear
          header
          echo -e "${WHITE_R}#${RESET} Deleting the Alerts/Events..."
          echo ""
          sleep 2
          if [[ ${m_org_s_ver::2} -gt "30" ]]; then
            mongo --quiet --port 27117 ace --eval 'db.alarm.deleteMany({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}})' | awk '{ deletedCount=$7 ; print "\033[39m#\033[0m Deleted " deletedCount " Alerts" }' # deletedCount
            mongo --quiet --port 27117 ace --eval 'db.event.deleteMany({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}})' | awk '{ deletedCount=$7 ; print "\033[39m#\033[0m Deleted " deletedCount " Events" }' # deletedCount
          else
            mongo --quiet --port 27117 ace --eval 'db.alarm.remove({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}},{multi: true})' | awk '{ nRemoved=$4 ; print "\033[39m#\033[0m Deleted " nRemoved " Alerts" }' # nRemoved
            mongo --quiet --port 27117 ace --eval 'db.event.remove({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}},{multi: true})' | awk '{ nRemoved=$4 ; print "\033[39m#\033[0m Deleted " nRemoved " Events" }' # nRemoved
          fi
          echo ""
          echo ""
          sleep 4;;
        2*)
          clear
          header
          echo -e "${WHITE_R}#${RESET} Archiving the Alerts..."
          echo ""
          if [[ ${m_org_s_ver::2} -gt "30" ]]; then
            mongo --quiet --port 27117 ace --eval 'db.alarm.updateMany({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}},{$set: {"archived": true}})' | awk '{ modifiedCount=$10 ; print "\033[39m#\033[0m Archived " modifiedCount " Alerts" }' # modifiedCount
            mongo --quiet --port 27117 ace --eval 'db.event.deleteMany({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}})' | awk '{ deletedCount=$7 ; print "\033[39m#\033[0m Deleted " deletedCount " Events" }' # deletedCount
          else
            mongo --quiet --port 27117 ace --eval 'db.alarm.update({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}},{$set: {"archived": true}},{multi: true})' | awk '{ nModified=$10 ; print "\033[39m#\033[0m Archived " nModified " Alerts" }' # nModified
            mongo --quiet --port 27117 ace --eval 'db.event.remove({"ip":{ $regex: "127.0.0.1|0:0:0:0:0:0:0:1"}},{multi: true})' | awk '{ nRemoved=$4 ; print "\033[39m#\033[0m Deleted " nRemoved " Alerts" }' # nRemoved
          fi
          echo ""
          echo ""
          sleep 4;;
        3*) ;;
    esac
  fi
}

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                      UniFi Devices Upgrade                                                                                      #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

unifi_list_sites() {
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo -e "${WHITE_R}#${RESET} Catching all the site names!"
  echo ""
  echo ""
  sleep 3
  ${unifi_api_curl_cmd} $unifi_api_baseurl/api/stat/sites | jq -r '.data[] .name' >> /tmp/unifi_sites
  cd /tmp; xargs -I {} mkdir -p "unifi_site_{}" < /tmp/unifi_sites; cd ~
}

unifi_upgrade_devices() {
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo -e "${WHITE_R}#${RESET} Upgrading all the UniFi Devices!!"
  echo ""
  echo ""
  sleep 3
  unifi_api_site=$(tr '\r\n' ' ' < /tmp/unifi_sites)
  for site in ${unifi_api_site[@]}; do
    ${unifi_api_curl_cmd} $unifi_api_baseurl/api/s/$site/stat/device | jq -r '.data[] | select((.version > "3.8") and (.version < .upgrade_to_firmware)) | .mac' >> /tmp/unifi_site_${site}/unifi_device_mac_addresses
    normal_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/unifi_device_mac_addresses)
    for mac_normal in ${normal_upgrade[@]}; do
      ${unifi_api_curl_cmd} --data "{\"mac\":\"${mac_normal}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade >> /tmp/unifi_device_normal
    done
    ${unifi_api_curl_cmd} $unifi_api_baseurl/api/s/$site/stat/device | jq -r '.data[] | select(.version < "3.8") | .model' >> /tmp/unifi_models
    unifi_api_models=$(tr '\r\n' ' ' < /tmp/unifi_models)
    for model in ${unifi_api_models[@]}; do
      ${unifi_api_curl_cmd} $unifi_api_baseurl/api/s/$site/stat/device | jq -r '.data[] | select((.version < "3.8") and (.model == "'$model'")) | .mac' >> /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses
      custom_upgrade_file=(/tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
      if [[ -s $custom_upgrade_file ]]; then
        touch /tmp/glennr_custom_upgrade_executed
        if [[ ${U7PG2[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/U7PG2/3.9.54.9373/BZ.qca956x.v3.9.54.9373.180914.0009.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${BZ2[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/BZ2/4.0.10.9653/BZ.ar7240.v4.0.10.9653.181205.1311.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${U2Sv2[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ubnt.com/unifi/firmware/U2Sv2/4.0.10.9653/BZ.qca9342.v4.0.10.9653.181205.1310.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${U2IW[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/U2IW/4.0.10.9653/BZ.qca933x.v4.0.10.9653.181205.1310.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${U7P[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/U7P/4.0.10.9653/BZ.ar934x.v4.0.10.9653.181205.1310.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${U2HSR[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/U2HSR/4.0.10.9653/BZ.ar7240.v4.0.10.9653.181205.1311.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${U7HD[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/U7HD/3.9.54.9373/BZ.ipq806x.v3.9.54.9373.180914.0028.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${USXG[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/USXG/3.9.54.9373/US.bcm5341x.v3.9.54.9373.180914.0002.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${U7E[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/U7E/3.8.17.6789/BZ.bcm4706.v3.8.17.6789.190110.0913.bin
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${US24P250[@]} =~ ${model} ]];then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=(http://dl.ui.com/unifi/firmware/US24P250/3.9.54.9373/US.bcm5334x.v3.9.54.9373.180914.0005.bin)
          for mac_custom in ${custom_upgrade[@]};do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/$site/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${UGW3[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/UGW3/4.4.22.5086045/UGW3.v4.4.22.5086045.tar
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        elif [[ ${UGW4[@]} =~ ${model} ]]; then
          custom_upgrade=$(tr '\r\n' ' ' < /tmp/unifi_site_${site}/${model}_unifi_device_mac_addresses)
          firmware_url=http://dl.ui.com/unifi/firmware/UGW4/4.4.22.5086057/UGW4.v4.4.22.5086057.tar
          for mac_custom in ${custom_upgrade[@]}; do
            ${unifi_api_curl_cmd}  --data "{\"url\":\"${firmware_url}\", \"mac\":\"${mac_custom}\"}" $unifi_api_baseurl/api/s/${site}/cmd/devmgr/upgrade-external >> /tmp/unifi_device_custom
          done
          unset firmware_url
        fi
      fi
    done
  done
  if [[ -f /tmp/unifi_device_normal ]]; then
    clear
    header
    echo -e "${WHITE_R}#${RESET} All the UniFi Devices are now upgrading!"
    echo ""
    echo ""
  else
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} Can't find any UniFi Devices to upgrade!"
    echo ""
    echo ""
  fi
  sleep 3
}

unifi_custom_upgrade_check () {
  clear
  header
  echo -e "${WHITE_R}#${RESET} A custom upgrade has been executed, the script will run one more"
  echo -e "${WHITE_R}#${RESET} time to upgrade everything to the latest available firmware"
  echo ""
  echo -e "${WHITE_R}#${RESET} Waiting for the first device to report back that it upgraded!"
  echo ""
  echo ""
  read -t 900 < <(tail -n 0 -f /usr/lib/unifi/logs/server.log | grep --line-buffered 'was upgraded from ".*" to ".*"') && UNIFI_DEVICE_UPGRADE=true || UNIFI_DEVICE_UPGRADE_TIMED_OUT=true
  if [[ $UNIFI_DEVICE_UPGRADE = 'true' ]]; then
    echo -e "${GREEN}#########################################################################${RESET}"
    echo ""
    echo -e "${WHITE_R}#${RESET} One of the first devices reported back and upgraded!"
    echo -e "${WHITE_R}#${RESET} The script will wait 10 minutes to make sure everything gets upgraded."
    echo ""
    sleep 600
    echo ""
    echo -e "${GREEN}#########################################################################${RESET}"
    echo ""
    echo -e "${WHITE_R}#${RESET} Starting the second upgrade!"
    echo ""
    echo ""
    sleep 3
    unifi_upgrade_devices
  elif [[ $UNIFI_DEVICE_UPGRADE_TIMED_OUT = 'true' ]]; then
    clear
    header_red
    echo "                    Device upgrade check timed out!"
    echo ""
    echo "      Please manually check the upgrade status in the controller or"
    echo "        contact Glenn R. (AmazedMender16) on the Community Forums!"
    echo ""
    echo ""
    exit 1
  fi
}

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                          UniFi Backup                                                                                           #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

unifi_backup () {
  backup_time=$(date +%Y%m%d_%H%M_%S%N)
  clear
  header
  echo -e "${WHITE_R}#${RESET} Creating the backup!"
  echo -e "${WHITE_R}#${RESET} This can take a while for big controllers!"
  echo ""
  echo ""
  sleep 2
  auto_dir=$(grep ^autobackup.dir /var/lib/unifi/system.properties 2> /dev/null | sed 's/autobackup.dir=//g')
  if grep -q "^unifi:" /etc/group && grep -q "^unifi:" /etc/passwd; then
    if sudo -u unifi [ -w $auto_dir ]; then touch /tmp/glennr_dir_writable; fi
    if [[ -f /tmp/glennr_dir_writable ]]; then
      unifi_write_permission=true
      rm -rf /tmp/glennr_dir_writable 2> /dev/null
    else
      unifi_write_permission=false
    fi
  fi
  if ! [[ $UNIFI =~ ^(5.6.0|5.6.1|5.6.2|5.6.3)$ || ${UNIFI_RELEASE::3} -lt "56" ]]; then
    unifi_write_permission=pass
  fi
  if [[ -n "$auto_dir" && $unifi_write_permission =~ (true|pass) || $(ls -ld $auto_dir | awk '{print $3":"$4}') == "unifi:unifi" ]]; then
    backup_location=custom
    if echo $auto_dir | grep -q '/$'; then
      if [[ ! -d ${auto_dir}glennr-unifi-backups/ ]]; then
        mkdir ${auto_dir}glennr-unifi-backups/
      fi
      output=${auto_dir}glennr-unifi-backups/unifi_backup_${UNIFI}_${backup_time}.unf
    else
      if [[ ! -d ${auto_dir}/glennr-unifi-backups/ ]]; then
        mkdir ${auto_dir}/glennr-unifi-backups/
      fi
      output=${auto_dir}/glennr-unifi-backups/unifi_backup_${UNIFI}_${backup_time}.unf
	fi
  elif [[ -d /data/autobackup/ ]]; then
    if [[ ! -d /data/glennr-unifi-backups/ ]]; then
      mkdir /data/glennr-unifi-backups/
    fi
    backup_location=sd_card
    output=/data/glennr-unifi-backups/unifi_backup_${UNIFI}_${backup_time}.unf
  else
    if [[ ! -d /usr/lib/unifi/data/backup/glennr-unifi-backups/ ]]; then
      mkdir /usr/lib/unifi/data/backup/glennr-unifi-backups/
    fi
    backup_location=unifi_dir
    output=/usr/lib/unifi/data/backup/glennr-unifi-backups/unifi_backup_${UNIFI}_${backup_time}.unf
  fi
  if [[ $UNIFI =~ ^(5.4.0|5.4.1)$ || ${UNIFI_RELEASE::3} -lt "54" ]]; then
    path=`$unifi_api_curl_cmd --data "{\"cmd\":\"backup\",\"days\":\"0\"}" $unifi_api_baseurl/api/s/default/cmd/system | sed -n 's/.*\(\/dl.*unf\).*/\1/p'`
  else
    path=`$unifi_api_curl_cmd --data "{\"cmd\":\"backup\",\"days\":\"0\"}" $unifi_api_baseurl/api/s/default/cmd/backup | sed -n 's/.*\(\/dl.*unf\).*/\1/p'`
  fi
  $unifi_api_curl_cmd $unifi_api_baseurl$path -o $output --create-dirs
}

unifi_backup_check () {
  clear
  header
  echo -e "${WHITE_R}#${RESET} Checking if the backup got created!"
  echo -e "${WHITE_R}#${RESET} This can take up to 10 minutes before timing out!"
  echo ""
  echo ""
  read -t 600 < <(tail -n 1000 -f /usr/lib/unifi/logs/server.log | grep --line-buffered 'BACKUP.* end\|backup.* end\|Backup has been created') && UNIFI_BACKUP_END=true || UNIFI_BACKUP_TIMED_OUT=true
  if [[ $UNIFI_BACKUP_END = 'true' ]]; then
    GLENNR_UNIFI_BACKUP=success
    clear
    clear
    echo -e "${GREEN}#########################################################################${RESET}"
    echo ""
    echo -e "${WHITE_R}#${RESET} UniFi Network Controller backup was successful!"
    if [[ $backup_location == 'custom' ]]; then
      if ! [[ $UNIFI =~ ^(5.6.0|5.6.1|5.6.2|5.6.3)$ || ${UNIFI_RELEASE::3} -lt "56" ]]; then
        if echo $auto_dir | grep -q '/$'; then
          chown -R unifi:unifi ${auto_dir}glennr-unifi-backups/
        else
          chown -R unifi:unifi ${auto_dir}/glennr-unifi-backups/
        fi
      fi
    elif [[ $backup_location == 'sd_card' ]]; then
      if ! [[ $UNIFI =~ ^(5.6.0|5.6.1|5.6.2|5.6.3)$ || ${UNIFI_RELEASE::3} -lt "56" ]]; then
        chown -R unifi:unifi /data/glennr-unifi-backups/
      fi
    elif [[ $backup_location == 'unifi_dir' ]]; then
      if ! [[ $UNIFI =~ ^(5.6.0|5.6.1|5.6.2|5.6.3)$ || ${UNIFI_RELEASE::3} -lt "56" ]]; then
        chown -R unifi:unifi /usr/lib/unifi/data/backup/glennr-unifi-backups/
      fi
    fi
    echo ""
    echo ""
    sleep 4
  elif [[ $UNIFI_BACKUP_TIMED_OUT = 'true' ]]; then
    clear
    header_red
    echo -e "${WHITE_R}#${RESET} UniFi Network Controller Backup check timed out!"
    echo ""
    echo ""
    sleep 2
  fi
}

unifi_backup_fail () {
  if [[ $GLENNR_UNIFI_BACKUP != 'success' ]]; then
    header_red
    echo -e "${WHITE_R}#${RESET} The backup failed, please manually create a settings only backup."
    echo ""
    echo -e "${WHITE_R}#${RESET} Script will execute itself again in 10 seconds."
    echo ""
    echo ""
    sleep 10
    ./$0 && exit 0
  fi
}

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                     Ask For Device Upgrade                                                                                      #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

run_unifi_devices_upgrade () {
  clear
  header
  echo -e "${WHITE_R}#${RESET} Starting the devices updates!"
  echo ""
  echo ""
  sleep 3
  #run_unifi_devices_upgrade_already=true
  if [[ $EXECUTED_UNIFI_CREDENTIALS != 'true' ]]; then
    unifi_credentials
    EXECUTED_UNIFI_CREDENTIALS=true
  fi
  unifi_login
  unifi_login_check
  unifi_list_sites
  unifi_upgrade_devices
  if [[ -f /tmp/glennr_custom_upgrade_executed ]]; then
    unifi_custom_upgrade_check
  fi
  unifi_logout
}

only_run_unifi_devices_upgrade () {
  clear
  header
  echo -e "${WHITE_R}#${RESET} Starting the devices updates!"
  echo ""
  echo ""
  sleep 3
  unifi_credentials
  unifi_login
  unifi_login_check
  unifi_list_sites
  unifi_upgrade_devices
  if [[ -f /tmp/glennr_custom_upgrade_executed ]]; then
    unifi_custom_upgrade_check
  fi
  unifi_logout
  unifi_cleanup
  devices_update_finish
  remove_yourself
  exit 0
}

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                   5.10.x Upgrades ( 5.6.42 )                                                                                    #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

unifi_firmware_requirement () {
  clear
  header
  echo -e "${WHITE_R}#${RESET} The script is about to upgrade the UniFi Network controller to 5.10.x ( or 5.6.42 )." 
  echo ""
  echo -e "${WHITE_R}#${RESET} The required minimum firmware for UAP/USW is 4.0.9 and 4.4.34 for the USG. ( 3.8.17 for EOL devices )"
  echo -e "${WHITE_R}#${RESET} Devices on earlier firmware will show in the controller and work as you've configured them,"
  echo -e "${WHITE_R}#${RESET} this update doesn't change any of the settings. However, please note you will not be able"
  echo -e "${WHITE_R}#${RESET} to modify the device configuration until you update the firmware."
  echo ""
  echo ""
  echo -e "${WHITE_R}#${RESET} Would you like the script to execute the upgrade commands?"
  echo ""
  echo ""
  read -p $'\033[39m#\033[0m Do you want to proceed with upgrading the devices? (Y/n) ' yes_no
  case "$yes_no" in
      [Yy]*|"")
        echo -e "${GREEN}#########################################################################${RESET}"
        echo ""
        echo -e "${WHITE_R}#${RESET} Checking if the firmware is available!"
        echo -e "${WHITE_R}#${RESET} This can take up to 5 minutes before timing out!"
        echo ""
        echo ""
        sleep 3
        read -t 300 < <(tail -n 0 -f /usr/lib/unifi/logs/server.log | grep --line-buffered 'firmware.* new version (.*) is available') && UNIFI_FIRMWARE_AVAILABLE=true || UNIFI_FIRMWARE_TIMED_OUT=true
        if [[ $UNIFI_FIRMWARE_AVAILABLE = 'true' ]]; then
          run_unifi_devices_upgrade
        elif [[ $UNIFI_FIRMWARE_TIMED_OUT = 'true' ]]; then
          echo -e "${RED}#########################################################################${RESET}"
          echo ""
          echo -e "${WHITE_R}#${RESET} UniFi Firmware Available check timed out!"
          echo -e "${WHITE_R}#${RESET} Running the devices upgrade without the check"
          echo ""
          echo ""
          sleep 3
          run_unifi_devices_upgrade
        fi;;
      [Nn]*) ;;
  esac
}

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                            OS Update                                                                                            #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

apt_mongodb_check() {
  apt-get update
  MONGODB_ORG_CACHE=$(apt-cache madison mongodb-org | awk '{print $3}' | sort -V | tail -n 1 | sed 's/\.//g')
  MONGODB_CACHE=$(apt-cache madison mongodb | awk '{print $3}' | sort -V | tail -n 1 | sed 's/-.*//' | sed 's/.*://' | sed 's/\.//g')
  MONGO_TOOLS_CACHE=$(apt-cache madison mongo-tools | awk '{print $3}' | sort -V | tail -n 1 | sed 's/-.*//' | sed 's/.*://' | sed 's/\.//g')
}

#HOLD_UNIFI=$(dpkg --get-selections | grep "unifi" | awk '{print $2}')
#HOLD_MONGODB_ORG=$(dpkg --get-selections | grep "mongodb-org" | awk '{print $2}')
set_hold_unifi=''
set_hold_unifi_video=''
set_hold_unifi_voip=''
set_hold_mongodb_org=''
set_hold_mongodb=''
set_hold_mongo_tools=''
mongodb_key_failed=''
mongodb_key=''

os_upgrade () {
  clear
  header
  echo -e "${WHITE_R}#${RESET} You're about to upgrade/update the OS with all it's packages, I recommend"
  echo -e "${WHITE_R}#${RESET} creating a backup/snapshot of the current state of the machine/VM."
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  Continue with the upgrade/update"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  Create a UniFi Network Controller backup before the upgrade/update"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""
  read -p $'Your choice | \033[39m' OS_EASY_UPDATE
  case "$OS_EASY_UPDATE" in
      1*) ;;
      2*)
        clear
        header
        echo -e "${WHITE_R}#${RESET} Starting the UniFi Network Controller backup."
        echo ""
        echo ""
        if [[ $EXECUTED_UNIFI_CREDENTIALS != 'true' ]]; then
          unifi_credentials
          EXECUTED_UNIFI_CREDENTIALS=true
        fi
        unifi_login
        unifi_login_check
        super_user_check
        debug_check
        unifi_backup
        unifi_logout
        unifi_backup_check
        unifi_backup_fail
        unifi_cleanup
        login_cleanup;;
       3|*) cancel_script;;
  esac
  clear
  header
  echo -e "${WHITE_R}#${RESET} Starting the OS update/upgrade."
  echo ""
  echo ""
  sleep 2
  if [ $(dpkg-query -W -f='${Status}' unifi 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    header
    echo -e "${WHITE_R}#${RESET} UniFi Network Controller is installed."
    if [ $(dpkg --get-selections | grep "unifi" | awk '{print $2}' | grep -c "install") -ne 0 ]; then
      echo -e "${WHITE_R}#${RESET} Making sure the UniFi Network Controller won't upgrade."
      echo "unifi hold" | sudo dpkg --set-selections || abort
      set_hold_unifi=true
    fi
    echo ""
    echo ""
    sleep 2
  fi
  if [ $(dpkg-query -W -f='${Status}' unifi-video 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    header
    echo -e "${WHITE_R}#${RESET} UniFi-Video is installed."
    echo -e "${WHITE_R}#${RESET} Making sure the UniFi-Video won't upgrade."
    echo "unifi-video hold" | sudo dpkg --set-selections || abort
    set_hold_unifi_video=true
    echo ""
    echo ""
    sleep 2
  fi
  if [ $(dpkg-query -W -f='${Status}' unifi-voip 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    header
    echo -e "${WHITE_R}#${RESET} UniFi-VoIP is installed."
    echo -e "${WHITE_R}#${RESET} Making sure the UniFi-VoIP won't upgrade."
    echo "unifi-voip hold" | sudo dpkg --set-selections || abort
    set_hold_unifi_voip=true
    echo ""
    echo ""
    sleep 2
  fi
  if [ $(dpkg-query -W -f='${Status}' mongodb-org 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    if [[ ${mongodb_org_v::2} == '34' ]]; then
      header
      echo -e "${WHITE_R}#${RESET} Creating a list file for MongoDB"
      echo ""
      echo ""
      sed -i '/mongodb/d' /etc/apt/sources.list
      if ls /etc/apt/sources.list.d/mongodb* > /dev/null 2>&1; then
        rm /etc/apt/sources.list.d/mongodb*  2> /dev/null
      fi
      if [[ $os_codename =~ (trusty|qiana|rebecca|rafaela|rosa) ]]; then
        echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
        mongodb_key=true
      elif [[ $os_codename =~ (xenial|sarah|serena|sonya|sylvia) ]]; then
        echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
        mongodb_key=true
      elif [[ $os_codename =~ (bionic|tara|tessa) ]]; then
        echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
        mongodb_key=true
      elif [[ $os_codename == "cosmic" ]]; then
        echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
        mongodb_key=true
      elif [[ $os_codename == "disco" ]]; then
        echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
        mongodb_key=true
      elif [[ $os_codename == "jessie" ]]; then
        echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
        mongodb_key=true
      elif [[ $os_codename =~ (stretch|continuum) ]]; then
        echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
        mongodb_key=true
      elif [[ $os_codename == "buster" ]]; then
        echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
        mongodb_key=true
      fi
      if [[ $mongodb_key == 'true' ]]; then
        if [ ! -z "$http_proxy" ]; then
          apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${http_proxy} --recv-keys 0C49F3730359A14518585931BC711F9BA15703C6 || mongodb_key_failed=true
        elif [ -f /etc/apt/apt.conf ]; then
          apt_http_proxy=$(grep http.*Proxy /etc/apt/apt.conf | awk '{print $2}' | sed 's/[";]//g')
          if [[ apt_http_proxy ]]; then
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${apt_http_proxy} --recv-keys 0C49F3730359A14518585931BC711F9BA15703C6 || mongodb_key_failed=true
          fi
        else
          apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 || mongodb_key_failed=true
        fi
      fi
      if [[ $mongodb_key_failed == 'true' ]]; then
        wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | sudo apt-key add - || abort
      fi
    fi
    apt_mongodb_check
    if [[ ${MONGODB_ORG_CACHE::2} -gt "34" ]]; then
      if [ $(dpkg --get-selections | grep "mongodb-org" | awk '{print $2}' | grep -c "install") -ne 0 ]; then
        echo "mongodb-org hold" | sudo dpkg --set-selections 2> /dev/null || abort
        echo "mongodb-org-mongos hold" | sudo dpkg --set-selections 2> /dev/null || abort
        echo "mongodb-org-server hold" | sudo dpkg --set-selections 2> /dev/null || abort
        echo "mongodb-org-shell hold" | sudo dpkg --set-selections 2> /dev/null || abort
        echo "mongodb-org-tools hold" | sudo dpkg --set-selections 2> /dev/null || abort
        set_hold_mongodb_org=true
      fi
    fi
    if [[ ${MONGODB_CACHE::2} -gt "34" ]]; then
      if [ $(dpkg --get-selections | grep "mongodb-server" | awk '{print $2}' | grep -c "install") -ne 0 ]; then
        echo "mongodb hold" | sudo dpkg --set-selections 2> /dev/null || abort
        echo "mongodb-server hold" | sudo dpkg --set-selections 2> /dev/null || abort
        echo "mongodb-server-core hold" | sudo dpkg --set-selections 2> /dev/null || abort
        echo "mongodb-clients hold" | sudo dpkg --set-selections 2> /dev/null || abort
        set_hold_mongodb=true
      fi
    fi
    if [[ ${MONGO_TOOLS_CACHE::2} -gt "34" ]]; then
      if [ $(dpkg --get-selections | grep "mongo-tools" | awk '{print $2}' | grep -c "install") -ne 0 ]; then
        echo "mongo-tools hold" | sudo dpkg --set-selections 2> /dev/null || abort
        set_hold_mongo_tools=true
      fi
    fi
  fi
  header
  echo -e "${WHITE_R}#${RESET} Updating/Upgrading the OS.."
  echo ""
  echo ""
  apt-get update
  DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade || abort
  DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade || abort
  apt-get autoremove -y || abort
  apt-get autoclean -y || abort
  if [[ $set_hold_unifi == 'true' ]]; then
     echo "unifi install" | sudo dpkg --set-selections 2> /dev/null || abort
  fi
  if [[ $set_hold_unifi_video == 'true' ]]; then
    echo "unifi-video install" | sudo dpkg --set-selections 2> /dev/null || abort
  fi
  if [[ $set_hold_unifi_voip == 'true' ]]; then
    echo "unifi-voip install" | sudo dpkg --set-selections 2> /dev/null || abort
  fi
  if [[ $set_hold_mongodb_org == 'true' ]]; then
    echo "mongodb-org install" | sudo dpkg --set-selections 2> /dev/null || abort
    echo "mongodb-org-mongos install" | sudo dpkg --set-selections 2> /dev/null || abort
    echo "mongodb-org-server install" | sudo dpkg --set-selections 2> /dev/null || abort
    echo "mongodb-org-shell install" | sudo dpkg --set-selections 2> /dev/null || abort
    echo "mongodb-org-tools install" | sudo dpkg --set-selections 2> /dev/null || abort
  fi
  if [[ $set_hold_mongodb == 'true' ]]; then
    echo "mongodb install" | sudo dpkg --set-selections 2> /dev/null || abort
    echo "mongodb-server install" | sudo dpkg --set-selections 2> /dev/null || abort
    echo "mongodb-server-core install" | sudo dpkg --set-selections 2> /dev/null || abort
    echo "mongodb-clients install" | sudo dpkg --set-selections 2> /dev/null || abort
  fi
  if [[ $set_hold_mongo_tools == 'true' ]]; then
    echo "mongo-tools install" | sudo dpkg --set-selections 2> /dev/null || abort
  fi
  sleep 2
  os_update_finish
  remove_yourself
  exit 0
}

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                  Ask to keep script or delete                                                                                   #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

script_removal() {
  header
  read -p $'\033[39m#\033[0m Do you want to keep the script on your system after completion? (Y/n) ' yes_no
  case "$yes_no" in
      [Yy]*|"") ;;
      [Nn]*) delete_script=true;;
  esac
}

script_removal

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                       What Should we run?                                                                                       #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

clear
clear
echo -e "${GREEN}#########################################################################${RESET}"
echo ""
echo "  What do you want to update?"
echo ""
echo ""
echo -e " [   ${WHITE_R}1${RESET}   ]  |  UniFi Network Controller"
echo -e " [   ${WHITE_R}2${RESET}   ]  |  UniFi Devices ( on all sites )"
echo -e " [   ${WHITE_R}3${RESET}   ]  |  OS ( Operating System )"
echo -e " [   ${WHITE_R}4${RESET}   ]  |  UniFi Network Controller and UniFi Devices"
echo -e " [   ${WHITE_R}5${RESET}   ]  |  Cancel"
echo ""
echo ""
echo ""
read -p $'Your choice | \033[39m' UNIFI_EASY_UPDATE
case "$UNIFI_EASY_UPDATE" in
    1*) ;;
    2*) only_run_unifi_devices_upgrade;;
    3*) os_upgrade;;
    4*) run_unifi_devices_upgrade;;
    5|*) cancel_script;;
esac

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                         Ask For Backup                                                                                          #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

clear
clear
echo -e "${GREEN}#########################################################################${RESET}"
echo ""
echo -e "${WHITE_R}#${RESET} Would you like to create a backup of your UniFi Network Controller?"
echo -e "${WHITE_R}#${RESET} I highly recommend creating a controller backup!${RESET}"
echo ""
echo ""
read -p $'\033[39m#\033[0m Do you want to proceed with creating a backup? (Y/n) ' yes_no
case "$yes_no" in
    [Yy]*|"")
      clear
      echo -e "${GREEN}#########################################################################${RESET}"
      echo ""
      echo -e "${WHITE_R}#${RESET} Starting the controller backup!"
      echo ""
      echo ""
      sleep 3
      if [[ $EXECUTED_UNIFI_CREDENTIALS != 'true' ]]; then
        unifi_credentials
        EXECUTED_UNIFI_CREDENTIALS=true
      fi
      unifi_login
      unifi_login_check
      if [[ $unifi_backup_cancel != 'true' ]]; then
        super_user_check
        debug_check
        unifi_backup
        unifi_logout
        unifi_backup_check
        unifi_cleanup
      fi;;
    [Nn]*)
      clear
      header_red
      echo -e "${WHITE_R}#${RESET} You choose not to create a backup!"
      echo ""
      echo ""
      sleep 2
      unifi_cleanup;;
esac

if [[ $GLENNR_UNIFI_BACKUP != 'success' ]]; then
  clear
  header_red
  echo -e "${WHITE_R}#${RESET} You didn't create a backup of your UniFi Network Controller!"
  echo ""
  echo ""
  read -p $'\033[39m#\033[0m Do you want to proceed with updating your UniFi Network Controller? (Y/n) ' yes_no
  case "$yes_no" in
      [Yy]*|"") ;;
      [Nn]*)
        clear
        header_red
        echo "                     You didn't download a backup!"
        echo "             Please download a backup and rerun the script.."
        echo ""
        echo "                        Cancelling the script!"
        echo ""
        echo ""
       exit 1;;
  esac
fi

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                             Checks                                                                                              #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

if [ -f /etc/apt/sources.list.d/100-ubnt-unifi.list ] || [[ $(grep -c "ubnt.com/download\|ui.com/download" /etc/apt/sources.list) -gt 0 ]]; then
  clear
  sed -i '/unifi/d' /etc/apt/sources.list
  rm -rf /etc/apt/sources.list.d/100-ubnt-unifi.list 2> /dev/null
  header_red
  echo -e "${WHITE_R}#${RESET} UniFi source files were detected on your system!"
  echo -e "${WHITE_R}#${RESET} Removing the source files to make sure your update will be successful..."
  echo ""
  echo ""
  sleep 3
  clear
fi

alert_event_cleanup

if [[ $backup_location == "custom" ]]; then
  if echo $auto_dir | grep -q '/$'; then
    glennr_backups_a=$(ls ${auto_dir}glennr-unifi-backups/*.unf | wc -l)
    glennr_backup_old_files=$(ls -t ${auto_dir}glennr-unifi-backups/*.unf | awk 'NR>5')
    glennr_backup_old_files_a=$(ls -t ${auto_dir}glennr-unifi-backups/*.unf | awk 'NR>5' | wc -l)
  else
    glennr_backups_a=$(ls ${auto_dir}/glennr-unifi-backups/*.unf | wc -l)
    glennr_backup_old_files=$(ls -t ${auto_dir}/glennr-unifi-backups/*.unf | awk 'NR>5')
    glennr_backup_old_files_a=$(ls -t ${auto_dir}/glennr-unifi-backups/*.unf | awk 'NR>5' | wc -l)
  fi
elif [[ $backup_location == "sd_card" ]]; then
  glennr_backups_a=$(ls /data/glennr-unifi-backups/*.unf | wc -l)
  glennr_backup_old_files=$(ls -t /data/glennr-unifi-backups/*.unf | awk 'NR>5')
  glennr_backup_old_files_a=$(ls -t /data/glennr-unifi-backups/*.unf | awk 'NR>5' | wc -l)
elif [[ $backup_location == "unifi_dir" ]]; then
  glennr_backups_a=$(ls /usr/lib/unifi/data/backup/glennr-unifi-backups/*.unf | wc -l)
  glennr_backup_old_files=$(ls -t /usr/lib/unifi/data/backup/glennr-unifi-backups/*.unf | awk 'NR>5')
  glennr_backup_old_files_a=$(ls -t /usr/lib/unifi/data/backup/glennr-unifi-backups/*.unf | awk 'NR>5' | wc -l)
fi
glennr_backup_free=$(du -sch $glennr_backup_old_files | grep total$ | awk '{print $1}')

if [ $glennr_backups_a -gt 5 ]; then
  clear
  header
  echo -e "${WHITE_R}#${RESET} Older backups are detected on your system. ( made by GlennR's Easy Update Script )"
  echo -e "${WHITE_R}#${RESET} Erasing the older backups ( ${glennr_backup_old_files_a} ) will free up ${WHITE_R}${glennr_backup_free}${RESET} on your disk."
  echo ""
  echo -e "${WHITE_R}#${RESET} The script will keep the 5 latest backups if you choose to erase the older backups."
  echo ""
  echo ""
  read -p $'\033[39m#\033[0m Do you want to delete/erase older backups? (y/N) ' yes_no
  case "$yes_no" in
      [Yy]*)
        header
        if [ ${glennr_backup_old_files_a} -gt 1 ]; then
          echo -e "${WHITE_R}#${RESET} Deleting ${glennr_backup_old_files_a} backup files..."
        else
          echo -e "${WHITE_R}#${RESET} Deleting ${glennr_backup_old_files_a} backup file..."
        fi
        echo ""
        echo ""
        sleep 2
        if [[ $backup_location == 'custom' ]]; then
          if echo $auto_dir | grep -q '/$'; then
            ls -t ${auto_dir}glennr-unifi-backups/*.unf | awk 'NR>5' | xargs rm -f 2> /dev/null
          else
            ls -t ${auto_dir}/glennr-unifi-backups/*.unf | awk 'NR>5' | xargs rm -f 2> /dev/null
          fi
        elif [[ $backup_location == 'sd_card' ]]; then
          ls -t /data/glennr-unifi-backups/*.unf | awk 'NR>5' | xargs rm -f 2> /dev/null
        elif [[ $backup_location == 'unifi_dir' ]]; then
          ls -t /usr/lib/unifi/data/backup/glennr-unifi-backups/*.unf | awk 'NR>5' | xargs rm -f 2> /dev/null
        fi;;
      [Nn]*|"")
        header
        echo -e "${WHITE_R}#${RESET} Keeping the older backups."
        echo ""
        echo ""
        sleep 2;;
  esac
fi

if [[ ${JAVA_V} -lt 131 ]]; then
    OUTDATED_JAVA_V=true
fi
  
if [[ $JAVA8 -eq 0 ]] || [[ $OUTDATED_JAVA_V == 'true' ]]; then
  clear
  header_red
  echo -e "${WHITE_R}#${RESET} JAVA 8 is not installed..." 
  echo -e "${WHITE_R}#${RESET} Installing OpenJDK 8!" 
  echo ""
  echo ""
  sleep 2
  if [[ $os_codename =~ (precise|maya) ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Ubuntu Precise Pangolin ( 12.04 )"
    echo ""
    echo ""
    sleep 2
    apt-get install openjdk-8-jre-headless -y
    if [[ $? > 0 ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu precise main") -eq 0 ]]; then
        echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu precise main >> /etc/apt/sources.list.d/glennr-install-script.list || abort
        if [ ! -z "$http_proxy" ]; then
          apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${http_proxy} --recv-keys EB9B1D8886F44E2A || abort
        elif [ -f /etc/apt/apt.conf ]; then
          apt_http_proxy=$(grep http.*Proxy /etc/apt/apt.conf | awk '{print $2}' | sed 's/[";]//g')
          if [[ apt_http_proxy ]]; then
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${apt_http_proxy} --recv-keys EB9B1D8886F44E2A || abort
          fi
        else
          apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EB9B1D8886F44E2A || abort
        fi
      apt-get update
      apt-get install openjdk-8-jre-headless -y || abort
      fi
    fi
  elif [[ $os_codename =~ (trusty|qiana|rebecca|rafaela|rosa) ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Ubuntu Trusty Tahr ( 14.04 )"
    echo ""
    echo ""
    sleep 2
    apt-get install openjdk-8-jre-headless -y
    if [[ $? > 0 ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main") -eq 0 ]]; then
        echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main >> /etc/apt/sources.list.d/glennr-install-script.list || abort
        if [ ! -z "$http_proxy" ]; then
          apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${http_proxy} --recv-keys EB9B1D8886F44E2A || abort
        elif [ -f /etc/apt/apt.conf ]; then
           apt_http_proxy=$(grep http.*Proxy /etc/apt/apt.conf | awk '{print $2}' | sed 's/[";]//g')
          if [[ apt_http_proxy ]]; then
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${apt_http_proxy} --recv-keys EB9B1D8886F44E2A || abort
          fi
        else
          apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EB9B1D8886F44E2A || abort
        fi
        apt-get update
        apt-get install openjdk-8-jre-headless -y || abort
      fi
    fi
  elif [[ $os_codename =~ (xenial|sarah|serena|sonya|sylvia) ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Ubuntu Xenial Xerus ( 16.04 )"
    echo ""
    echo ""
    sleep 2
    apt-get install openjdk-8-jre-headless -y
    if [[ $? > 0 ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu xenial-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu xenial-security main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
        apt-get update
        apt-get install openjdk-8-jre-headless -y
      fi
      if [[ $? > 0 ]]; then
        if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu xenial main") -eq 0 ]]; then
          echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu xenial main >> /etc/apt/sources.list.d/glennr-install-script.list || abort
          if [ ! -z "$http_proxy" ]; then
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${http_proxy} --recv-keys EB9B1D8886F44E2A || abort
          elif [ -f /etc/apt/apt.conf ]; then
            apt_http_proxy=$(grep http.*Proxy /etc/apt/apt.conf | awk '{print $2}' | sed 's/[";]//g')
            if [[ apt_http_proxy ]]; then
              apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${apt_http_proxy} --recv-keys EB9B1D8886F44E2A || abort
            fi
          else
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EB9B1D8886F44E2A || abort
          fi
          apt-get update
          apt-get install openjdk-8-jre-headless -y || abort
        fi
      fi
    fi
  elif [[ $os_codename =~ (bionic|tara|tessa) ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Ubuntu Bionic Beaver ( 18.04 )"
    echo ""
    echo ""
    sleep 2
    apt-get install openjdk-8-jre-headless -y
    if [[ $? > 0 ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu bionic-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu bionic-security main universe >> /etc/apt/sources.list.d/glennr-install-script.list || abort
        apt-get update
        apt-get install openjdk-8-jre-headless -y
      fi
      if [[ $? > 0 ]]; then
        if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu bionic main") -eq 0 ]]; then
          echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu bionic main >> /etc/apt/sources.list.d/glennr-install-script.list || abort
          if [ ! -z "$http_proxy" ]; then
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${http_proxy} --recv-keys EB9B1D8886F44E2A || abort
          elif [ -f /etc/apt/apt.conf ]; then
            apt_http_proxy=$(grep http.*Proxy /etc/apt/apt.conf | awk '{print $2}' | sed 's/[";]//g')
            if [[ apt_http_proxy ]]; then
              apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${apt_http_proxy} --recv-keys EB9B1D8886F44E2A || abort
            fi
          else
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EB9B1D8886F44E2A || abort
          fi
          apt-get update
          apt-get install openjdk-8-jre-headless -y || abort
        fi
      fi
    fi
  elif [[ $os_codename == "cosmic" ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Ubuntu Cosmic Cuttlefish ( 18.10 )"
    echo ""
    echo ""
    sleep 2
    apt-get install openjdk-8-jre-headless -y
    if [[ $? > 0 ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu bionic-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu bionic-security main universe >> /etc/apt/sources.list.d/glennr-install-script.list || abort
        apt-get update
        apt-get install openjdk-8-jre-headless -y
      fi
      if [[ $? > 0 ]]; then
        if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu cosmic main") -eq 0 ]]; then
          echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu cosmic main >> /etc/apt/sources.list.d/glennr-install-script.list || abort
          if [ ! -z "$http_proxy" ]; then
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${http_proxy} --recv-keys EB9B1D8886F44E2A || abort
          elif [ -f /etc/apt/apt.conf ]; then
            apt_http_proxy=$(grep http.*Proxy /etc/apt/apt.conf | awk '{print $2}' | sed 's/[";]//g')
            if [[ apt_http_proxy ]]; then
              apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${apt_http_proxy} --recv-keys EB9B1D8886F44E2A || abort
            fi
          else
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EB9B1D8886F44E2A || abort
          fi
          apt-get update
          apt-get install openjdk-8-jre-headless -y || abort
        fi
      fi
    fi
  elif [[ $os_codename == "disco" ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Ubuntu Disco Dingo ( 19.04 )"
    echo ""
    echo ""
    sleep 2
    apt-get install openjdk-8-jre-headless -y
    if [[ $? > 0 ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu bionic-security main universe") -eq 0 ]]; then
        echo deb http://security.ubuntu.com/ubuntu bionic-security main universe >> /etc/apt/sources.list.d/glennr-install-script.list || abort
        apt-get update
        apt-get install openjdk-8-jre-headless -y || abort
      fi
    fi
  elif [[ $os_codename == "jessie" ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Debian Jessie ( 8 )"
    echo ""
    echo ""
    sleep 2
    if [ $(dpkg-query -W -f='${Status}' openjdk-8-jre-headless 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
      apt-get install -t jessie-backports openjdk-8-jre-headless ca-certificates-java -y
      if [[ $? > 0 ]]; then
        if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -P -c "^deb http://archive.debian.org/debian jessie-backports main") -eq 0 ]]; then
          echo deb http://archive.debian.org/debian jessie-backports main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
          apt-get update -o Acquire::Check-Valid-Until=false
          apt-get install -t jessie-backports openjdk-8-jre-headless ca-certificates-java -y || abort
          sed -i '/jessie-backports/d' /etc/apt/sources.list.d/glennr-install-script.list
        fi
      fi
    fi
  elif [[ $os_codename =~ (stretch|continuum) ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Debian Stretch ( 9 )"
    echo ""
    echo ""
    sleep 2
    apt-get install openjdk-8-jre-headless -y
    if [[ $? > 0 ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.nl.debian.org/debian stretch main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian stretch main >> /etc/apt/sources.list.d/glennr-install-script.list || abort
        apt-get update
        apt-get install openjdk-8-jre-headless -y
      fi
      if [[ $? > 0 ]]; then
        if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu cosmic main") -eq 0 ]]; then
          echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu xenial main >> /etc/apt/sources.list.d/glennr-install-script.list || abort        
          if [ ! -z "$http_proxy" ]; then
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${http_proxy} --recv-keys EB9B1D8886F44E2A || abort
          elif [ -f /etc/apt/apt.conf ]; then
            apt_http_proxy=$(grep http.*Proxy /etc/apt/apt.conf | awk '{print $2}' | sed 's/[";]//g')
            if [[ apt_http_proxy ]]; then
              apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=${apt_http_proxy} --recv-keys EB9B1D8886F44E2A || abort
            fi
          else
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EB9B1D8886F44E2A || abort
          fi
          apt-get update
          apt-get install openjdk-8-jre-headless -y || abort
        fi
      fi
    fi
  elif [[ $os_codename == "buster" ]]; then
    header
    echo -e "${WHITE_R}#${RESET} Selected OS ${WHITE_R}Debian Buster ( 10 )"
    echo ""
    echo ""
    sleep 2
    apt-get install openjdk-8-jre-headless -y
    if [[ $? > 0 ]]; then
      if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ftp.nl.debian.org/debian stretch main") -eq 0 ]]; then
        echo deb http://ftp.nl.debian.org/debian stretch main >> /etc/apt/sources.list.d/glennr-install-script.list || abort
        apt-get update
        apt-get install openjdk-8-jre-headless -y
      fi
    fi
  else
    clear
    header_red
    echo ""
    echo -e "      ${RED}Please manually install JAVA 8 on your system!${RESET}"
    echo ""
    echo -e "      ${GRAY_R}OS Details:${RESET}"
    echo ""
    echo -e "      ${RED}${os_desc}${RESET}"
    echo ""
    exit 0
  fi
fi

# JAVA 7 Check
JAVA7=$(dpkg -l | grep ^ii | grep -c "openjdk-7\|oracle-java7")
JAVA8=$(dpkg -l | grep ^ii | grep -c "openjdk-8\|oracle-java8")

if [[ $JAVA8 -eq 1 ]]; then
  JAVA8_INSTALLED=true
fi
if [[ $JAVA7 -eq 1 ]]; then
  JAVA7_INSTALLED=true
fi

if [[ ( $JAVA8_INSTALLED = 'true' && $JAVA7_INSTALLED = 'true' ) ]]; then
  clear
  header_red
  echo -e "${WHITE_R}#${RESET} JAVA 8 was installed on your system!"
  echo -e "${WHITE_R}#${RESET} Do you want to uninstall JAVA 7?"
  echo ""
  echo -e "${WHITE_R}#${RESET} This will also uninstall any other package depending on JAVA 7!"
  echo ""
  echo ""
  read -p $'\033[39m#\033[0m Do you want to proceed with uninstalling JAVA 7? (Y/n) ' yes_no
  case "$yes_no" in
      [Yy]*|"")
        clear
        header
        echo -e "${WHITE_R}#${RESET} Uninstalling JAVA 7!"
        echo ""
        echo ""
        apt-get purge openjdk-7-* -y || apt-get purge oracle-java7-* -y;;
      [Nn]*) ;;
  esac
fi

# Check what java got installed.
if [[ $(dpkg-query -W -f='${Status}' oracle-java8-installer 2>/dev/null | grep -c "ok installed") -eq 1 ]] || [[ $(dpkg-query -W -f='${Status}' openjdk-8-jre-headless 2>/dev/null | grep -c "ok installed") -eq 1 ]]; then
  if [ -f /etc/default/unifi ]; then
    if [[ $(grep "^JAVA_HOME" /etc/default/unifi) ]]; then
      sed -i 's/^JAVA_HOME/#JAVA_HOME/' /etc/default/unifi
    fi
      echo "JAVA_HOME="$( readlink -f "$( which java )" | sed "s:bin/.*$::" )"" >> /etc/default/unifi
    else
      echo "JAVA_HOME="$( readlink -f "$( which java )" | sed "s:bin/.*$::" )"" >> /etc/environment
      source /etc/environment
  fi
fi

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.0.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

thank_you

if [[ $UNIFI = "5.0."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.6.40 ( UAP-AC, UAP-AC v2, UAP-AC-OD, PicoM2 )"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.6.42 ( UAP-AC, UAP-AC v2, UAP-AC-OD )"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  5.10.27"
  echo -e " [   ${WHITE_R}4${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}5${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|5640|5.6.40)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.40_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.40/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|5642|5.6.42)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.42_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      3|51027|5.10.27)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      4|51138|5.11.38)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      5|*) cancel_script;;
  esac

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.2.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.2."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.6.40 ( UAP-AC, UAP-AC v2, UAP-AC-OD, PicoM2 )"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.6.42 ( UAP-AC, UAP-AC v2, UAP-AC-OD )"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  5.10.27"
  echo -e " [   ${WHITE_R}4${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}5${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|5640|5.6.40)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.40_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.40/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|5642|5.6.42)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.42_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      3|51027|5.10.27)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      4|51138|5.11.38)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      5|*) cancel_script;;
  esac

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.3.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.3."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.6.40 ( UAP-AC, UAP-AC v2, UAP-AC-OD, PicoM2 )"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.6.42 ( UAP-AC, UAP-AC v2, UAP-AC-OD )"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  5.10.27"
  echo -e " [   ${WHITE_R}4${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}5${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|5640|5.6.40)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.40_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.40/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|5642|5.6.42)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.42_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      3|51027|5.10.27)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      4|51138|5.11.38)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      5|*) cancel_script;;
  esac

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.4.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.4."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.6.40 ( UAP-AC, UAP-AC v2, UAP-AC-OD, PicoM2 )"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.6.42 ( UAP-AC, UAP-AC v2, UAP-AC-OD )"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  5.10.27"
  echo -e " [   ${WHITE_R}4${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}5${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|5640|5.6.40)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.40_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.40/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|5642|5.6.42)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.42_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      3|51027|5.10.27)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      4|51138|5.11.38)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      5|*) cancel_script;;
  esac

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.5.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.5."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.6.40 ( UAP-AC, UAP-AC v2, UAP-AC-OD, PicoM2 )"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.6.42 ( UAP-AC, UAP-AC v2, UAP-AC-OD )"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  5.10.27"
  echo -e " [   ${WHITE_R}4${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}5${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|5640|5.6.40)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.40_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.40/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|5642|5.6.42)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.42_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      3|51027|5.10.27)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      4|51138|5.11.38)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      5|*) cancel_script;;
  esac

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.6.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.6."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  if [[ $UNIFI = "5.6.40" || $UNIFI = "5.6.41" ]]; then
    UNIFI_VERSION='5.6.40'
    echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.6.42 ( UAP-AC, UAP-AC v2, UAP-AC-OD )"
    echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.10.27"
    echo -e " [   ${WHITE_R}3${RESET}   ]  |  5.11.38"
    echo -e " [   ${WHITE_R}4${RESET}   ]  |  Cancel"
  elif [[ $UNIFI = "5.6.42" ]]; then
    UNIFI_VERSION='5.6.42'
    echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.10.27"
    echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.11.38"
    echo -e " [   ${WHITE_R}3${RESET}   ]  |  Cancel"
  else
    echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.6.40 ( UAP-AC, UAP-AC v2, UAP-AC-OD, PicoM2 )"
    echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.6.42 ( UAP-AC, UAP-AC v2, UAP-AC-OD )"
    echo -e " [   ${WHITE_R}3${RESET}   ]  |  5.10.27"
    echo -e " [   ${WHITE_R}4${RESET}   ]  |  5.11.38"
    echo -e " [   ${WHITE_R}5${RESET}   ]  |  Cancel"
  fi
  echo ""
  echo ""
  echo ""

  if [[ $UNIFI_VERSION = "5.6.40" ]]; then
    read -p $'Your choice | \033[39m' UPGRADE_VERSION
    case "$UPGRADE_VERSION" in
        1|5642|5.6.42)
          unifi_update_start
          unifi_firmware_requirement
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.40_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        2|51027|5.10.27)
          unifi_update_start
          unifi_firmware_requirement
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.42_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          migration_check
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        3|51138|5.11.38)
          unifi_update_start
          unifi_firmware_requirement
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.42_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          migration_check
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        4|*) cancel_script;;
    esac
  elif [[ $UNIFI_VERSION = "5.6.42" ]]; then
    read -p $'Your choice | \033[39m' UPGRADE_VERSION
    case "$UPGRADE_VERSION" in
        1|51027|5.10.27)
          unifi_update_start
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        2|51138|5.11.38)
          unifi_update_start
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        3|*) cancel_script;;
    esac
  else
    read -p $'Your choice | \033[39m' UPGRADE_VERSION
    case "$UPGRADE_VERSION" in
        1|5640|5.6.40)
          unifi_update_start
          unifi_firmware_requirement
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.40_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.40/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        2|5642|5.6.42)
          unifi_update_start
          unifi_firmware_requirement
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.6.42_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.6.42/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        3|51027|5.10.27)
          unifi_update_start
          unifi_firmware_requirement
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        4|51138|5.11.38)
          unifi_update_start
          unifi_firmware_requirement
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        5|*) cancel_script;;
    esac
  fi

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.7.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.7."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.10.27"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|51027|5.10.27)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|51138|5.11.38)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      3|*) cancel_script;;
  esac

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.8.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.8."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.10.27"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|51027|5.10.27)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|51138|5.11.38)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      3|*) cancel_script;;
  esac

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.9.x                                                                            #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.9."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.10.27"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}3${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|51027|5.10.27)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|51138|5.11.38)
        unifi_update_start
        unifi_firmware_requirement
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      3|*) cancel_script;;
  esac

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.10.x                                                                           #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.10."* ]]; then
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  if [[ $UNIFI = "5.10.27" ]]; then
    UNIFI_VERSION='5.10.27'
    echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.11.38"
    echo -e " [   ${WHITE_R}2${RESET}   ]  |  Cancel"
  else
    echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.10.27"
    echo -e " [   ${WHITE_R}2${RESET}   ]  |  5.11.38"
    echo -e " [   ${WHITE_R}3${RESET}   ]  |  Cancel"
  fi
  echo ""
  echo ""
  echo ""

  if [[ $UNIFI_VERSION = "5.10.27" ]]; then
    read -p $'Your choice | \033[39m' UPGRADE_VERSION
    case "$UPGRADE_VERSION" in
        1|51138|5.11.38)
          unifi_update_start
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        2|*) cancel_script;;
    esac
  else
    read -p $'Your choice | \033[39m' UPGRADE_VERSION
    case "$UPGRADE_VERSION" in
        1|51027|5.10.27)
          unifi_update_start
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.10.27_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27-2ad6590363/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.10.27/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        2|51138|5.11.38)
          unifi_update_start
          header
          unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
          wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
          DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
          rm -rf "$unifi_temp" 2> /dev/null
          unifi_update_finish;;
        3|*) cancel_script;;
    esac
  fi

##########################################################################################################################################################################
#                                                                                                                                                                        #
#                                                                                       5.11.x                                                                           #
#                                                                                                                                                                        #
##########################################################################################################################################################################

elif [[ $UNIFI = "5.11."* ]]; then
  if [ $UNIFI = "5.11.38" ]; then
    debug_check_no_upgrade
    unifi_update_latest
  fi
  clear
  echo -e "${GREEN}#########################################################################${RESET}"
  echo ""
  echo "  To what UniFi Network Controller version would you like to update?"
  echo -e "  Currently your UniFi Network Controller is on version ${WHITE_R}$UNIFI${RESET}"
  echo ""
  echo ""
  echo -e " [   ${WHITE_R}1${RESET}   ]  |  5.11.38"
  echo -e " [   ${WHITE_R}2${RESET}   ]  |  Cancel"
  echo ""
  echo ""
  echo ""

  read -p $'Your choice | \033[39m' UPGRADE_VERSION
  case "$UPGRADE_VERSION" in
      1|51138|5.11.38)
        unifi_update_start
        header
        unifi_temp="$(mktemp --tmpdir=/tmp unifi_sysvinit_all_5.11.38_XXXXX.deb)"
        wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38-65a83af88b/unifi_sysvinit_all.deb' || wget -O "$unifi_temp" 'https://dl.ui.com/unifi/5.11.38/unifi_sysvinit_all.deb' || abort
        DEBIAN_FRONTEND=noninteractive dpkg -i "$unifi_temp" || abort
        rm -rf "$unifi_temp" 2> /dev/null
        unifi_update_finish;;
      2|*) cancel_script;;
  esac
else
  debug_check_no_upgrade
  login_cleanup
  clear
  header
  echo -e "${WHITE_R}#${RESET} Your UniFi Network Controller is on a release that is not ( yet ) supported in this script."
  echo -e "${WHITE_R}#${RESET} Feel free to contact Glenn R. (AmazedMender16) on the Community Forums if you need help upgrading your controller."
  echo ""
  echo -e "${WHITE_R}#${RESET} Current version of your UniFi Network Controller | ${WHITE_R}$UNIFI${RESET}"
  backup_save_location
  echo ""
  echo ""
fi