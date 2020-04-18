#!/bin/bash

TargetHost="localhost";
ssh -vG "${TargetHost}"; # Show both included config files as well as their contained values
ssh -vG "${TargetHost}" | grep 'Reading configuration data'; # Show only filepaths for included config files


# ------------------------------------------------------------
# Info regarding command(s) used above (info from 'man ssh'):
#
#     ssh -G      Causes ssh to print its configuration after evaluating Host and Match blocks and exit.
#     ssh -v      Verbose mode.  Causes ssh to print debugging messages about its progress.
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   serverfault.com  |  "How to show the host/configured/default ssh "configuration"? - Server Fault"  |  https://serverfault.com/a/717177
#
# ------------------------------------------------------------