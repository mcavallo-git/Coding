#!/bin/bash

configure

set system static-host-mapping host-name HOSTNAME inet IPADDRESS

edit system static-host-mapping set host-name HOSTNAME inet IPADDRESS

delete system static-host-mapping host-name HOSTNAME

commit
save
