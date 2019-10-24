#!/bin/bash
wget -qO- https://get.docker.com/ | sh;
exit $?;



# ------------------------------------------------------------
# https://medium.com/faun/docker-running-seamlessly-in-windows-subsystem-linux-6ef8412377aa

if [ 0 -eq 1 ]; then 
# Update the source listing
apt-get -y update;

# Ensure that you have the binaries needed to fetch repo listing
apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common;

# Fetch the repository listing from docker's site & add it
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo apt-key add -;
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";

# Update source listing now that we've added Docker's repo
apt-get -y update;

# sudo apt-get install docker-ce=17.09.0~ce-0~ubuntu;
apt-get install -y docker-ce;

if [ -v SUDO_USER ]; then
sudo usermod -aG docker $SUDO_USER;
else
sudo usermod -aG docker $USER;
fi;

fi;
