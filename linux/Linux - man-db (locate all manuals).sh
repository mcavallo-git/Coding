#!/bin/bash

# Output the location of all manuals in the current environment

cat /etc/manpath.config | grep MAN | grep -v '#';
