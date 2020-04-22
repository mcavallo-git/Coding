#!/bin/bash

# UniFi Controller 5.10.23 auto installation script.
# OS       | Cosmic
# Version  | 3.8.8
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
RED='\033[1;31m' # Light Red.
GREEN='\033[1;32m' # Light Green.

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                           Start Checks                                                                                          #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

# Check for root (SUDO).
if [ "$EUID" -ne 0 ]
then
  clear
  echo -e "${RED}#######################################${RESET}"
  echo -e "${RED}#                                     #${RESET}"
  echo -e "${RED}#   ${RESET}Please run this script as root.   ${RED}#${RESET}"
  echo -e "${RED}#                                     #${RESET}"
  echo -e "${RED}#######################################${RESET}"
  exit 1
fi

abort()
{
  echo -e "\n${RED}###############################################################\n\n          An error occurred. Aborting script..\nPlease contact Glenn R. (AmazedMender16) on the Community Forums!\n\n${RESET}"
  exit 1
}

if [ $(cat /root/.bashrc | grep "^export PATH=" | grep -c "/sbin") -eq 0 ]
then
  if [[ $(cat /root/.bashrc | grep "^export PATH=") ]]
  then
    sed -i 's/^export PATH=/#export PATH=/' /root/.bashrc
  fi
  echo export PATH=/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/bin >> /root/.bashrc || abort
  source /root/.bashrc || abort
fi

# Install needed packages if not installed
clear
clear
echo -e "${GREEN}######################################################${RESET}"
echo -e "${GREEN}#                                                    #${RESET}"
echo -e "${GREEN}#  ${RESET}Checking if all required packages are installed!  ${GREEN}#"
echo -e "${GREEN}#                                                    #${RESET}"
echo -e "${GREEN}######################################################${RESET}"
echo ""
echo ""
if [ $(dpkg-query -W -f='${Status}' sudo 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install sudo -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -P -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main") -eq 0 ]]
    then
      echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      apt-get update
      apt-get install sudo -y || abort
    fi
  fi
fi
if [ $(dpkg-query -W -f='${Status}' lsb-release 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install lsb-release -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -P -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main") -eq 0 ]]
    then
      echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      apt-get update
      apt-get install lsb-release -y || abort
    fi
  fi
fi
if [ $(dpkg-query -W -f='${Status}' net-tools 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install net-tools -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -P -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main") -eq 0 ]]
    then
      echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      apt-get update
      apt-get install net-tools -y || abort
    fi
  fi
fi
if [ $(dpkg-query -W -f='${Status}' apt-transport-https 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install apt-transport-https -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu cosmic-security main") -eq 0 ]]
	then
	  echo deb http://security.ubuntu.com/ubuntu cosmic-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      apt-get update
      apt-get install apt-transport-https -y || abort
    fi
  fi
fi
if [ $(dpkg-query -W -f='${Status}' software-properties-common 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install software-properties-common -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -P -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main") -eq 0 ]]
	then
	  echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
	  apt-get update
	  apt-get install software-properties-common -y || abort
	fi
  fi
fi
if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install curl -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu cosmic-security main") -eq 0 ]]
	then
	  echo deb http://security.ubuntu.com/ubuntu cosmic-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
	  apt-get update
	  apt-get install curl -y || abort
	fi
  fi
fi
if [ $(dpkg-query -W -f='${Status}' dirmngr 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install dirmngr -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu cosmic-security main") -eq 0 ]]
	then
	  echo deb http://security.ubuntu.com/ubuntu cosmic-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
	  apt-get update
	  apt-get install dirmngr -y || abort
	fi
  fi
fi
if [ $(dpkg-query -W -f='${Status}' wget 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install wget -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu cosmic-security main") -eq 0 ]]
	then
	  echo deb http://security.ubuntu.com/ubuntu cosmic-security main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
      apt-get update
      apt-get install wget -y || abort
    fi
  fi
fi
if [ $(dpkg-query -W -f='${Status}' netcat 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get install netcat -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -P -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main universe") -eq 0 ]]
	then
	  echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
	  apt-get update
	  apt-get install netcat -y || abort
	fi
  fi
fi

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                             Values                                                                                              #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

MONGODB_ORG_SERVER=$(dpkg -l | grep ^ii | grep "mongodb-org-server" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
MONGODB_ORG_MONGOS=$(dpkg -l | grep ^ii | grep "mongodb-org-mongos" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
MONGODB_ORG_SHELL=$(dpkg -l | grep ^ii | grep "mongodb-org-shell" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
MONGODB_ORG_TOOLS=$(dpkg -l | grep ^ii | grep "mongodb-org-tools" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
MONGODB_ORGN=$(dpkg -l | grep ^ii | grep "mongodb-org" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
MONGODB_SERVER=$(dpkg -l | grep ^ii | grep "mongodb-server" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
MONGODB_CLIENTS=$(dpkg -l | grep ^ii | grep "mongodb-clients" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
MONGODB_SERVER_CORE=$(dpkg -l | grep ^ii | grep "mongodb-server-core" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
MONGO_TOOLS=$(dpkg -l | grep ^ii | grep "mongo-tools" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//g')
#
SYSTEM_MEMORY=$(awk '/MemTotal/ {printf( "%.0f\n", $2 / 1024 / 1024)}' /proc/meminfo)
SYSTEM_SWAP=$(awk '/SwapTotal/ {printf( "%.0f\n", $2 / 1024 / 1024)}' /proc/meminfo)
#SYSTEM_FREE_DISK=$(df -h / | grep "/" | awk '{print $4}' | sed 's/G//')
SYSTEM_FREE_DISK=$(df -k / | awk '{print $4}' | tail -n1)
#
#SERVER_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1)
SERVER_IP=$(/sbin/ifconfig | grep 'inet ' | grep -v '127.0.0.1' | head -n1 | awk '{print $2}' | head -1 | sed 's/.*://')
PUBLIC_SERVER_IP=$(curl https://ip.glennr.nl/ -s)
ARCHITECTURE=$(uname -m)
OS_NAME=$(lsb_release -cs)
OS_RELEASE=$(lsb_release -rs)
OS_DESC=$(lsb_release -ds)
#
#JAVA8=$(dpkg -l | grep -c "openjdk-8-jre-headless\|oracle-java8-installer")
MONGODB_SERVER_INSTALLED=$(dpkg -l | grep -c "mongodb-server\|mongodb-org-server")
MONGODB_VERSION=$(dpkg -l | grep "mongodb-server\|mongodb-org-server" | awk '{print $3}' | sed 's/.*://' | sed 's/-.*//' | sed 's/\.//g')
# JAVA Check
JAVA8=$(dpkg -l | grep ^ii | grep -c "openjdk-8\|oracle-java8")
JAVA9=$(dpkg -l | grep ^ii | grep -c "openjdk-9\|oracle-java9")
JAVA10=$(dpkg -l | grep ^ii | grep -c "openjdk-10\|oracle-java10")
JAVA11=$(dpkg -l | grep ^ii | grep -c "openjdk-11\|oracle-java11")
JAVA12=$(dpkg -l | grep ^ii | grep -c "openjdk-12\|oracle-java12")

UNSUPPORTED_JAVA_INSTALLED=''
JAVA8_INSTALLED=''
REMOTE_CONTROLLER=''

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                             Checks                                                                                              #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

# Check for Ubuntu Release
if [ $OS_RELEASE != "18.10" ]
then
  echo -e "${RED}################################################################################################################${RESET}"
  echo ""
  echo "                                    You seem to have ${OS_DESC}"
  echo "                                   This script is made for Ubuntu 18.10"
  echo ""
  echo "                               Please download the correct script for your OS."
  echo "                                            Cancelling script"
  echo ""
  rm $0
  exit 1
fi

# Check for 64/32 bit
if [[ $ARCHITECTURE != 'x86_64' && $ARCHITECTURE != 'armv8'* && $ARCHITECTURE != 'aarch64' && $ARCHITECTURE != 'arm64' ]]
then
  clear
  echo -e "${RED}########################################################${RESET}"
  echo -e "${RED}#                                                      #${RESET}"
  echo -e "${RED}#               ${RESET}32 bit system detected!                ${RED}#${RESET}"
  echo -e "${RED}#    ${RESET}32 bit MongoDB isn't supported on Ubuntu 18.10    ${RED}#${RESET}"
  echo -e "${RED}#        ${RESET}I recommend using Ubuntu 18.10 64 bit!        ${RED}#${RESET}"
  echo -e "${RED}#                                                      #${RESET}"
  echo -e "${RED}#                ${RESET}Cancelling the script!                ${RED}#${RESET}"
  echo -e "${RED}#                                                      #${RESET}"
  echo -e "${RED}########################################################${RESET}"
  echo ""
  sleep 10
  exit 0
fi

if [ $SYSTEM_FREE_DISK -lt "5242880" ]
then
  clear
  echo -e "${RED}################################################################################################################${RESET}"
  echo ""
  echo "                           Free disk space is below 5GB.. Please expand the disk size!"
  echo "                                      I recommend expanding to atleast 10GB"
  echo ""
  echo "                                            Cancelling script"
  exit 1
fi

# Check if dpkg is locked
if [ $(dpkg-query -W -f='${Status}' psmisc 2>/dev/null | grep -c "ok installed") -eq 0 ]
then
  apt-get update; apt-get upgrade -y || abort
  apt-get install psmisc -y
  if [[ $? > 0 ]]
  then
    if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -P -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main") -eq 0 ]]
    then
	  echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main >>/etc/apt/sources.list.d/glennr-install-script.list || abort
	  apt-get update
      apt-get install psmisc -y || abort
	fi
  fi
fi
while 
fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1
do
  clear
  echo -e "${RED}################################################################################################################${RESET}"
  echo ""
  echo "                        dpkg is locked.. Waiting for other software managers to finish!"
  echo "             If this is everlasting please contact Glenn R. (AmazedMender16) on the Community Forums!"
  sleep 10
done

# Check if UniFi is already installed.
if [ $(dpkg-query -W -f='${Status}' unifi 2>/dev/null | grep -c "ok installed") -eq 1 ]
then
  clear
  if (whiptail --title "GlennR Installation Script" --yesno "\n               UniFi is already installed on your system!\n     Would you like to download and execute My Easy Update Script?" 9 78)
  then
    clear
	echo -e "${GREEN}#####################################################${RESET}"
	echo -e "${GREEN}#                                                   #${RESET}"
	echo -e "${GREEN}#  ${RESET}Thanks for choosing GlennR's Easy Update Script  ${GREEN}#${RESET}"
	echo -e "${GREEN}#     ${RESET}Now downloading and executing the script      ${GREEN}#${RESET}"
	echo -e "${GREEN}#                                                   #${RESET}"
	echo -e "${GREEN}#####################################################${RESET}"
	sleep 3
    wget https://get.glennr.nl/unifi/update/unifi-update.sh; chmod +x unifi-update.sh; ./unifi-update.sh
	exit 0
  else
    clear
	echo -e "${RED}#####################################################${RESET}"
	echo -e "${RED}#                                                   #${RESET}"
	echo -e "${RED}#             ${RESET}You chose not to upgrade.             ${RED}#${RESET}"
	echo -e "${RED}#              ${RESET}Cancelling the script!               ${RED}#${RESET}"
	echo -e "${RED}#                                                   #${RESET}"
	echo -e "${RED}#####################################################${RESET}"
	exit 0
  fi
fi

# MongoDB version check.
if [[ $MONGODB_ORG_SERVER > "3.4.999" || $MONGODB_ORG_MONGOS > "3.4.999" || $MONGODB_ORG_SHELL > "3.4.999" || $MONGODB_ORG_TOOLS > "3.4.999" || $MONGODB_ORG > "3.4.999" || $MONGODB_SERVER > "3.4.999" || $MONGODB_CLIENTS > "3.4.999" || $MONGODB_SERVER_CORE > "3.4.999" || $MONGO_TOOLS > "3.4.999" ]]
then
  clear
  if ! (whiptail --title "GlennR Installation Script" --yesno "\n An unsupported MongoDB package was detected on your system!\n     UniFi will not work without the correct packages\n          Can we proceed to uninstall MongoDB?" 13 65)
  then
    clear
    echo -e "${RED}#####################################################${RESET}"
	echo -e "${RED}#                                                   #${RESET}"
	echo -e "${RED}#  ${RESET}You chose to keep your current MongoDB version!  ${RED}#${RESET}"
	echo -e "${RED}#              ${RESET}Cancelling the script!               ${RED}#${RESET}"
	echo -e "${RED}#                                                   #${RESET}"
	echo -e "${RED}#####################################################${RESET}"
    exit 0
  else
    clear
	echo -e "${RED}################################################################################################################${RESET}"
    echo ""
	if [ $(dpkg -l | awk '{print $2}' | grep -c "unifi") -eq 1 ]
	then
	  echo -e "                            ${RED}Doing this may damage your UniFi installation!${RESET}"
    fi
	if [ $(dpkg -l | awk '{print $2}' | grep -c "unifi-video") -eq 1 ]
	then
	  echo -e "                         ${RED}Doing this may damage your UniFi-Video installation!${RESET}"
    fi
	echo "                      This is required in order for UniFi to work on your system!"
    echo "              Make sure you have a backup of your UniFi Controller settings on your desktop!"
    echo ""
    echo "                   ! This will also uninstall any other package depending on MongoDB !"
	echo ""
	echo ""
	read -p "Do you want to proceed with uninstalling MongoDB? (Y/n)" yes_no
	case "${yes_no}" in
	    [Yy]*|"")
		  clear
          echo -e "${GREEN}#####################################################${RESET}"
          echo -e "${GREEN}#                                                   #${RESET}"
          echo -e "${GREEN}#               ${RESET}Uninstalling MongoDB!               ${GREEN}#${RESET}"
		  if [ $(dpkg -l | awk '{print $2}' | grep -c "unifi") -eq 1 ]
		  then
            echo -e "${GREEN}#       ${RESET}Removing UniFi to keep system files!        ${GREEN}#${RESET}"
          fi
		  if [ $(dpkg -l | awk '{print $2}' | grep -c "unifi-video") -eq 1 ]
		  then
            echo -e "${GREEN}#    ${RESET}Removing UniFi-Video to keep system files!     ${GREEN}#${RESET}"
          fi
		  echo -e "${GREEN}#                                                   #${RESET}"
          echo -e "${GREEN}#####################################################${RESET}"
          echo ""
          sleep 3
          rm /etc/apt/sources.list.d/mongo*.list
          if [ $(dpkg-query -W -f='${Status}' unifi 2>/dev/null | grep -c "ok installed") -eq 1 ]
          then
            dpkg --remove --force-remove-reinstreq unifi || abort
          fi
          if [ $(dpkg-query -W -f='${Status}' unifi-video 2>/dev/null | grep -c "ok installed") -eq 1 ]
          then
            dpkg --remove --force-remove-reinstreq unifi-video || abort
          fi
          apt-get purge mongo* -y
          if [[ $? > 0 ]]
          then
            clear
            echo -e "${RED}#####################################################${RESET}"
	        echo -e "${RED}#                                                   #${RESET}"
	        echo -e "${RED}#           ${RESET}Failed to uninstall MongoDB!            ${RED}#${RESET}"
	        echo -e "${RED}#   ${RESET}Uninstalling MongoDB with different actions!    ${RED}#${RESET}"
	        echo -e "${RED}#                                                   #${RESET}"
	        echo -e "${RED}#####################################################${RESET}"
            echo ""
            sleep 2
			apt-get --fix-broken install -y || apt-get install -f -y
			apt-get autoremove -y
		    if [ $(dpkg-query -W -f='${Status}' mongodb-org 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongodb-org || abort
			fi
		    if [ $(dpkg-query -W -f='${Status}' mongodb-org-tools 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongodb-org-tools || abort
			fi
			if [ $(dpkg-query -W -f='${Status}' mongodb-org-server 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongodb-org-server || abort
			fi
		    if [ $(dpkg-query -W -f='${Status}' mongodb-org-mongos 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongodb-org-mongos || abort
			fi
		    if [ $(dpkg-query -W -f='${Status}' mongodb-org-shell 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongodb-org-shell || abort
			fi
		    if [ $(dpkg-query -W -f='${Status}' mongodb-server 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongodb-server || abort
			fi
		    if [ $(dpkg-query -W -f='${Status}' mongodb-clients 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongodb-clients || abort
			fi
		    if [ $(dpkg-query -W -f='${Status}' mongodb-server-core 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongodb-server-core || abort
			fi
		    if [ $(dpkg-query -W -f='${Status}' mongo-tools 2>/dev/null | grep -c "ok installed") -eq 1 ]
			then
			  dpkg --remove --force-remove-reinstreq mongo-tools || abort
			fi
		  fi
	      apt-get autoremove -y || abort
		  apt-get clean -y || abort
		  apt-get update;;
	    [Nn]*)
		    clear
            echo -e "${RED}#####################################################${RESET}"
            echo -e "${RED}#                                                   #${RESET}"
            echo -e "${RED}#              ${RESET}Cancelling the script!               ${RED}#${RESET}"
            echo -e "${RED}#                                                   #${RESET}"
            echo -e "${RED}#####################################################${RESET}"
            exit 1;;
	esac
  fi
fi

# Memory and Swap file.
if [ $SYSTEM_MEMORY -lt "2" ]
then
  clear
  echo -e "${GREEN}########################################################${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}#       ${RESET}SYSTEM MEMORY is lower than recommended!       ${GREEN}#${RESET}"
  echo -e "${GREEN}#               ${RESET}Checking for swap file!                ${GREEN}#${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}########################################################${RESET}"
  echo ""
  sleep 2
  if [ $SYSTEM_FREE_DISK -gt "4194304" ]
  then
    if [ $SYSTEM_SWAP == "0" ]
	then
      clear
      echo -e "${GREEN}########################################################${RESET}"
      echo -e "${GREEN}#                                                      #${RESET}"
      echo -e "${GREEN}#                  ${RESET}Creating swap file!                 ${GREEN}#${RESET}"
      echo -e "${GREEN}#                                                      #${RESET}"
      echo -e "${GREEN}########################################################${RESET}"
	  echo ""
	  sleep 2
      dd if=/dev/zero of=/swapfile bs=2048 count=1048576
      chmod 600 /swapfile
      mkswap /swapfile
      swapon /swapfile
      echo "/swapfile swap swap defaults 0 0" | tee -a /etc/fstab
    else
      clear
      echo -e "${GREEN}########################################################${RESET}"
      echo -e "${GREEN}#                                                      #${RESET}"
      echo -e "${GREEN}#              ${RESET}Swap file already exists!               ${GREEN}#${RESET}"
      echo -e "${GREEN}#                                                      #${RESET}"
      echo -e "${GREEN}########################################################${RESET}"
	  echo ""
	  sleep 2
    fi
  else
    clear
    echo -e "${RED}########################################################${RESET}"
	echo -e "${RED}#                                                      #${RESET}"
    echo -e "${RED}#    ${RESET}Not enough free disk space for the swap file!     ${RED}#${RESET}"
    echo -e "${RED}#             ${RESET}Skipping swap file creation!             ${RED}#${RESET}"
	echo -e "${RED}#                                                      #${RESET}"
    echo -e "${RED}#    ${RESET}I highly recommend upgrading the system memory    ${RED}#${RESET}"
    echo -e "${RED}#     ${RESET}to atleast 2GB and expanding the disk space!     ${RED}#${RESET}"
    echo -e "${RED}#                                                      #${RESET}"
    echo -e "${RED}########################################################${RESET}"
	echo ""
	sleep 8
  fi
fi

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                 Installation Script starts here                                                                                 #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################

clear
echo -e "${GREEN}######################################################${RESET}"
echo -e "${GREEN}#                                                    #${RESET}"
echo -e "${GREEN}#    ${RESET}Getting the latest patches for your machine!    ${GREEN}#"
echo -e "${GREEN}#           ${RESET}Installing required packages!            ${GREEN}#"
echo -e "${GREEN}#                                                    #${RESET}"
echo -e "${GREEN}######################################################${RESET}"
echo ""
sleep 2
apt-get update
apt-get -o Dpkg::Options::="--force-confnew" -y upgrade || abort
apt-get dist-upgrade -y || abort
apt-get autoremove -y || abort
apt-get autoclean -y || abort

# MongoDB check
MONGODB_SERVER_INSTALLED=$(dpkg -l | grep -c "mongodb-server\|mongodb-org-server")

clear
echo -e "${GREEN}########################################################${RESET}"
echo -e "${GREEN}#                                                      #${RESET}"
echo -e "${GREEN}#  ${RESET}Updates/Requires packages successfully installed!   ${GREEN}#${RESET}"
echo -e "${GREEN}#       ${RESET}Installing MongoDB for 64 bit systems!         ${GREEN}#${RESET}"
echo -e "${GREEN}#                                                      #${RESET}"
echo -e "${GREEN}########################################################${RESET}"
echo ""
echo ""
sleep 2
if [ $MONGODB_SERVER_INSTALLED -eq 1 ]
then
  echo -e "${GREEN}########################################################${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}#            ${RESET}MongoDB is already installed!             ${GREEN}#${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}########################################################${RESET}"
  echo ""
  echo ""
  sleep 2
else
  sed -i '/mongodb/d' /etc/apt/sources.list
  if [ -f /etc/apt/sources.list.d/mongodb*.list ]
  then
    rm /etc/apt/sources.list.d/mongodb*
  fi
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
  if [[ $? > 0 ]]
  then
    curl -LO https://www.mongodb.org/static/pgp/server-3.4.asc || abort
	gpg --import server-3.4.asc || abort
	rm server-3.4.asc
  fi
  echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list || abort
  apt-get update
  apt-get install mongodb-org -y || abort
fi

clear
echo -e "${GREEN}########################################################${RESET}"
echo -e "${GREEN}#                                                      #${RESET}"
echo -e "${GREEN}#      ${RESET}MongoDB has been installed successfully!        ${GREEN}#${RESET}"
echo -e "${GREEN}#                ${RESET}Installing OpenJDK 8!                 ${GREEN}#${RESET}"
echo -e "${GREEN}#                                                      #${RESET}"
echo -e "${GREEN}########################################################${RESET}"
echo ""
echo ""
sleep 2
if [[ $(cat /etc/environment | grep "JAVA_HOME") ]]
then
  sed -i 's/^JAVA_HOME/#JAVA_HOME/' /etc/environment
fi
if [ $JAVA8 -eq 1 ]
then
  echo -e "${GREEN}########################################################${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}#            ${RESET}JAVA 8 is already installed!              ${GREEN}#${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}########################################################${RESET}"
  echo ""
  echo ""
  sleep 2
else
  if [ $(dpkg-query -W -f='${Status}' openjdk-8-jre-headless 2>/dev/null | grep -c "ok installed") -eq 0 ]
  then
	apt-get install openjdk-8-jre-headless -y
	if [[ $? > 0 ]]
	then
	  if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://security.ubuntu.com/ubuntu bionic-security main universe") -eq 0 ]]
	  then
		echo deb http://security.ubuntu.com/ubuntu bionic-security main universe >> /etc/apt/sources.list.d/glennr-install-script.list || abort
		apt-get update
		apt-get install openjdk-8-jre-headless -y
	  fi
	fi
	if [[ $? > 0 ]]
	then
	  if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -c "^deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu cosmic main") -eq 0 ]]
	  then
		echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu cosmic main >> /etc/apt/sources.list.d/glennr-install-script.list || abort
		apt-get update
		apt-get install openjdk-8-jre-headless -y || abort
	  fi
	fi
  fi
fi

if [[ $JAVA8 -eq 1 ]]
then
  JAVA8_INSTALLED=true
fi
if [[ $JAVA9 -eq 1 || $JAVA10 -eq 1 || $JAVA11 -eq 1 || $JAVA12 -eq 1 ]]
then
  UNSUPPORTED_JAVA_INSTALLED=true
fi

if [[ ( $JAVA8_INSTALLED = 'true' && $UNSUPPORTED_JAVA_INSTALLED = 'true' ) ]]
then
  clear
  echo -e "${RED}################################################################################################################${RESET}"
  echo ""
  echo "                   Unsupported JAVA versions are detected, do you want to uninstall them?"
  echo ""
  echo ""
  read -p $' \033[1;37m#\033[0m Do you want to proceed with uninstalling the unsupported JAVA versions? (Y/n) ' yes_no
  case "$yes_no" in
	  [Yy]*|"")
		clear
        echo -e "${GREEN}#####################################################${RESET}"
        echo -e "${GREEN}#                                                   #${RESET}"
        echo -e "${GREEN}#      ${RESET}Uninstalling unsupported JAVA versions!      ${GREEN}#${RESET}"
        echo -e "${GREEN}#                                                   #${RESET}"
        echo -e "${GREEN}#####################################################${RESET}"
		sleep 3
        if [[ $JAVA9 -eq 1 ]]
		then
		  apt-get purge openjdk-9-* -y || apt-get purge oracle-java9-* -y
		elif [[ $JAVA10 -eq 1 ]]
		then
		  apt-get purge openjdk-10-* -y || apt-get purge oracle-java10-* -y
		elif [[ $JAVA11 -eq 1 ]]
		then
		  apt-get purge openjdk-11-* -y || apt-get purge oracle-java11-* -y
		elif [[ $JAVA12 -eq 1 ]]
		then
		  apt-get purge openjdk-12-* -y || apt-get purge oracle-java12-* -y
		fi;;
	  [Nn]*)
		clear
        echo -e "${RED}#####################################################${RESET}"
        echo -e "${RED}#                                                   #${RESET}"
        echo -e "${RED}#             ${RESET}Continueing on own risk!              ${RED}#${RESET}"
        echo -e "${RED}#                                                   #${RESET}"
        echo -e "${RED}#####################################################${RESET}"
		sleep 3;;
  esac
fi

# Check what java got installed.
if [[ $(dpkg-query -W -f='${Status}' oracle-java8-installer 2>/dev/null | grep -c "ok installed") -eq 1 ]] || [[ $(dpkg-query -W -f='${Status}' openjdk-8-jre-headless 2>/dev/null | grep -c "ok installed") -eq 1 ]]
then
  if [ -f /etc/default/unifi ]
  then
    if [[ $(cat /etc/default/unifi | grep "^JAVA_HOME") ]]
    then
      sed -i 's/^JAVA_HOME/#JAVA_HOME/' /etc/default/unifi
    fi
      echo "JAVA_HOME="$( readlink -f "$( which java )" | sed "s:bin/.*$::" )"" >> /etc/default/unifi
    else
	  echo "JAVA_HOME="$( readlink -f "$( which java )" | sed "s:bin/.*$::" )"" >> /etc/environment
	  source /etc/environment
  fi
fi

clear
echo -e "${GREEN}########################################################${RESET}"
echo -e "${GREEN}#                                                      #${RESET}"
echo -e "${GREEN}#       ${RESET}JAVA 8 has been installed successfully!        ${GREEN}#${RESET}"
echo -e "${GREEN}#            ${RESET}Installing UniFi Dependencies!            ${GREEN}#${RESET}"
echo -e "${GREEN}#                                                      #${RESET}"
echo -e "${GREEN}########################################################${RESET}"
echo ""
sleep 2
apt-get update
apt-get install binutils ca-certificates-java java-common -y
apt-get install jsvc libcommons-daemon-java -y
if [[ $? > 0 ]]
then
  clear
  echo -e "${RED}########################################################${RESET}"
  echo -e "${RED}#                                                      #${RESET}"
  echo -e "${RED}#        ${RESET}Failed to install UniFi dependencies!         ${RED}#${RESET}"
  echo -e "${RED}#       ${RESET}Creating a backup of your sources.list!        ${RED}#${RESET}"
  echo -e "${RED}#   ${RESET}Adding required repository to the sources.list!    ${RED}#${RESET}"
  echo -e "${RED}#                                                      #${RESET}"
  echo -e "${RED}#            ${RESET}Installing UniFi Dependencies!            ${RED}#${RESET}"
  echo -e "${RED}#                                                      #${RESET}"
  echo -e "${RED}########################################################${RESET}"
  echo ""
  sleep 2
  if [[ $(find /etc/apt/* -name *.list | xargs cat | grep -P -c "^deb http://[A-Za-z0-9]*.archive.ubuntu.com/ubuntu cosmic main universe") -eq 0 ]]
  then
    echo deb http://nl.archive.ubuntu.com/ubuntu cosmic main universe >>/etc/apt/sources.list.d/glennr-install-script.list || abort
	apt-get update
  fi
  apt-get install binutils ca-certificates-java java-common -y || abort
  apt-get install jsvc libcommons-daemon-java -y || abort
fi

clear
echo -e "${GREEN}########################################################${RESET}"
echo -e "${GREEN}#                                                      #${RESET}"
echo -e "${GREEN}#  ${RESET}UniFi dependencies has been installed successfully! ${GREEN}#${RESET}"
echo -e "${GREEN}#         ${RESET}Installing UniFi Controller 5.10.23!         ${GREEN}#${RESET}"
echo -e "${GREEN}#                                                      #${RESET}"
echo -e "${GREEN}########################################################${RESET}"
echo ""
sleep 2
if [ -f unifi_sysvinit_all.deb ]
then
  rm unifi_sysvinit_all.deb
fi
wget https://dl.ui.com/unifi/5.10.23/unifi_sysvinit_all.deb || abort
dpkg -i unifi_sysvinit_all.deb || abort
rm unifi_sysvinit_all.deb || abort
service unifi start || abort

# Check if MongoDB service is enabled
if [ ${MONGODB_VERSION::2} -ge '26' ]
then
  SERVICE_MONGODB=$(systemctl is-enabled mongod)
  if [ $SERVICE_MONGODB = 'disabled' ]
  then
    systemctl enable mongod 2>/dev/null || { echo -e "${RED}#${RESET} Failed to enable service | MongoDB"; sleep 3; }
  fi
else
  SERVICE_MONGODB=$(systemctl is-enabled mongodb)
  if [ $SERVICE_MONGODB = 'disabled' ]
  then
    systemctl enable mongodb 2>/dev/null || { echo -e "${RED}#${RESET} Failed to enable service | MongoDB"; sleep 3; }
  fi
fi

# Check if UniFi service is enabled
SERVICE_UNIFI=$(systemctl is-enabled unifi)
if [ $SERVICE_UNIFI = 'disabled' ]
then
  systemctl enable unifi 2>/dev/null || { echo -e "${RED}#${RESET} Failed to enable service | UniFi"; sleep 3; }
fi

clear
if (whiptail --title "GlennR Installation Script" --yesno "Would you like to update the controller version when running the following command?\napt-get update && apt-get upgrade\n\nNOTE: This only included updates for controller version 5.10" 11 90)
then
  clear
  echo -e "${GREEN}########################################################${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}#          ${RESET}Adding new source list for UniFi!           ${GREEN}#${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}########################################################${RESET}"
  echo ""
  sleep 2
  sed -i '/unifi/d' /etc/apt/sources.list
  if [ -f /etc/apt/sources.list.d/100-ubnt-unifi.list ]
  then
    rm /etc/apt/sources.list.d/100-ubnt-unifi.list
  fi
  apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50
  if [[ $? > 0 ]]
  then
    wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
  fi
  echo 'deb http://www.ubnt.com/downloads/unifi/debian unifi-5.10 ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
  apt-get update
else
  clear
  echo -e "${GREEN}########################################################${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}#        ${RESET}Finishing up the installation script!         ${GREEN}#${RESET}"
  echo -e "${GREEN}#                                                      #${RESET}"
  echo -e "${GREEN}########################################################${RESET}"
  echo ""
  sleep 2
fi

# Check if controller is reachable via public IP.
timeout 1 nc -zv ${PUBLIC_SERVER_IP} 8443 &> /dev/null && REMOTE_CONTROLLER=true

if [[ $(dpkg -l | grep "unifi " | grep -c "ii") -eq 1 ]]
then
  clear
  clear
  echo -e "${GREEN}###############################################################${RESET}"
  echo ""
  echo ""
  echo -e "${GREEN}#${RESET} UniFi SDN Controller 5.10.23 has been installed successfully"
  if [[ ${REMOTE_CONTROLLER} = 'true' ]]
  then
    echo -e "${GREEN}#${RESET} Your controller address: ${WHITE}https://$PUBLIC_SERVER_IP:8443${RESET}"
  else
    echo -e "${GREEN}#${RESET} Your controller address: ${WHITE}https://$SERVER_IP:8443${RESET}"
  fi
  echo ""
  echo ""
  systemctl is-active -q unifi && echo -e "${GREEN}#${RESET} UniFi is active ( running )" || echo -e "${RED}#${RESET} UniFi failed to start... Please contact Glenn R. (AmazedMender16) on the Community Forums!"
  echo -e "${GREEN}#${RESET} CTRL + C to exit UniFi Status"
  echo ""
  echo ""
  echo -e "${WHITE}#${RESET} ${GRAY}Author   |  ${WHITE}Glenn R.${RESET}"
  echo -e "${WHITE}#${RESET} ${GRAY}Email    |  ${WHITE}glennrietveld8@hotmail.nl${RESET}"
  echo -e "${WHITE}#${RESET} ${GRAY}Website  |  ${WHITE}https://GlennR.nl${RESET}"
  echo ""
  echo ""
  echo ""
  rm $0
  service unifi status
else
  clear
  clear
  echo -e "${RED}###############################################################${RESET}"
  echo ""
  echo ""
  echo " Failed to successfully install UniFi SDN Controller 5.10.23"
  echo ""
  echo -e " ${RED}Please contact Glenn R. (AmazedMender16) on the Community Forums!${RESET}"
  echo ""
  echo ""
  rm $0
fi