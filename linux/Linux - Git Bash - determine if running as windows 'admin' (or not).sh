#!/bin/bash

# IS_ADMIN=1   will be set if running AS ADMIN
# IS_ADMIN=0   will be set if NOT running as admin
IS_ADMIN=$(net session > /dev/null 2>&1; if [ "$?" -ne "0" ]; then echo 0; else echo 1; fi;);

echo "IS_ADMIN ? ${IS_ADMIN}";
