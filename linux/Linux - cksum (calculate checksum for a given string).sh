#!/bin/sh
# ------------------------------------------------------------
# Linux - cksum (calculate checksum for a given string)
# ------------------------------------------------------------

# Get the checksum for a given string
echo -n "tester" | cksum  | awk '{print $1}';


# ------------------------------------------------------------