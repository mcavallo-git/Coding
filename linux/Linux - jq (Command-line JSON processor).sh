#!/bin/bash
# ------------------------------------------------------------
# Install jq
#
apt-get update -y; apt-get install -y "jq";


# ------------------------------------------------------------
# Get the first 2 items in the "items" property's array (which is within/just-under the main JSON object)
#
curl "https://ip-ranges.atlassian.com" | jq '.items[0:2]';


# ------------------------------------------------------------
# Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#
curl "https://ip-ranges.atlassian.com" | jq '.items[] | .cidr';

# ------------------------------------------------------------
# Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#   |----> Slice off all double-quotes (prepping for output)
#
curl "https://ip-ranges.atlassian.com" | jq '.items[] | .cidr' | tr -d '"';
# ------------------------------------------------------------
# Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#   |----> Slice off all double-quotes (prepping for output)
#   |-----> Wrap the jq call in a for-loop and add some string to the beginning/end of each line to prep it to-be-used-by as an NGINX IPv4 whitelist
#
for EACH_CIDR in $(curl -s "https://ip-ranges.atlassian.com" | jq '.items[] | .cidr' | tr -d '"' | sort); do echo "allow ${EACH_CIDR};"; done;


# ------------------------------------------------------------
# Citation(s)
#
#   github.io  |  "[jq] Tutorial"  |  https://stedolan.github.io/jq/tutorial/
#
# ------------------------------------------------------------