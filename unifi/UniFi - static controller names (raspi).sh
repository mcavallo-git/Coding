#!/bin/bash

configure set system static-host-mapping host-name HOSTNAME inet IPADDRESS commit save

configure edit system static-host-mapping set host-name HOSTNAME inet IPADDRESS commit save
