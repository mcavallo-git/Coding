#!/bin/bash

THIS_IPv4=$(ip addr show | grep 'inet' | grep 'scope global' | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.' | head -n 1);
echo "${THIS_IPv4}";
