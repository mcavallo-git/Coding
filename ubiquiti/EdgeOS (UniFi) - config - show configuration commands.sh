#!/bin/bash

show configuration commands > "${HOME}/show configuration commands.$(date +'%Y%m%d_%H%M%S').$(hostname).sh";
#  |
#  |--> Reverse-engineers the current config and outputs what it would take to rebuild it (as a set of shell-commands)
