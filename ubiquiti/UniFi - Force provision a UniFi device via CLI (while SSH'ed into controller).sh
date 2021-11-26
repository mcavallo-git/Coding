#!/bin/bash
# ------------------------------------------------------------
#
#  UniFi - Force provision a UniFi device via CLI (while SSH'ed into controller)
#
# ------------------------------------------------------------


# Written by Nick Jeppson 08/01/2019
# Inspired by posts made from ubiquiti forums: https://community.ui.com/questions/API/82a3a9c7-60da-4ec2-a4d1-cac68e86b53c
# API interface functions taken from unifi_sh_api shipped with controller version 5.10.25, https://dl.ui.com/unifi/5.10.25/unifi_sh_api
#
# This bash script copies the specified config file to the Unifi controller via SCP
# It then uses curl to issue an API call to tell the controller to force a provision to the device with the supplied mac address. 

#### BEGIN VARIABLES ####
# Fill out to match your environment

gateway_mac="12:34:56:78:90:ab" # MAC address of the gateway you wish to manage
config_file="your_config_file.json"   # Path to config file
unifi_server="unifi_server_name"     # Name/IP of unifi controller server
unifi_gateway_path="/usr/lib/unifi/data/sites/default/config.gateway.json"  # Path to config.gateway.json on the controller
ssh_user="root"         # User to SSH to controller as
username="unifi_admin_username"       # Unifi username
password="unifi_admin_password" # Unifi password
baseurl="https://unifi_server_name:8443" # Unifi URL
site="default"          # Unifi site the gateway resides in

#### END VARIABLES ####

# Copy updated config to controller
scp $config_file $ssh_user@$unifi_server:$unifi_gateway_path

# API interface functions
cookie=$(mktemp)
curl_cmd="curl --tlsv1 --silent --cookie ${cookie} --cookie-jar ${cookie} --insecure "
unifi_login() {
  # Authenticate against unifi controller
  ${curl_cmd} --data "{\"username\":\"$username\", \"password\":\"$password\"}" $baseurl/api/login
}

unifi_logout() {
  # Logout
  ${curl_cmd} $baseurl/logout
}

unifi_api() {
  # Make an API call to the UniFi Controller
  if [ $# -lt 1 ] ; then
    echo "Usage: $0 <uri> [json]"
    echo "  uri example /stat/sta "
    return
  fi
  uri=$1
  shift
  [ "${uri:0:1}" != "/" ] && uri="/$uri"
  json="$@"
  [ "$json" = "" ] && json="{}"
  ${curl_cmd} --data "$json" $baseurl/api/s/$site$uri
}

# Trigger a provision
unifi_login 
unifi_api /cmd/devmgr {\"mac\": \"$gateway_mac\", \"cmd\": \"force-provision\"}
unifi_logout


# ------------------------------------------------------------
#
# Citation(s)
#
#   techblog.jeppson.org  |  "Automate USG config deploy with Ubiquiti API in Bash - Technicus"  |  https://techblog.jeppson.org/2019/08/automate-usg-config-deploy-with-ubiquiti-api-in-bash/
#
# ------------------------------------------------------------