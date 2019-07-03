#!/bin/bash

configure

set system static-host-mapping host-name HOSTNAME inet 192.168.1.10

commit
save
