#!/bin/sh
# ------------------------------------------------------------
# Linux - md5sum (calculate md5 checksum of a string, convert to a GUID)
# ------------------------------------------------------------

# Get the md5 checksum for a given string

echo -n "tester" | md5sum | awk '{print toupper($1)}';


# ------------------------------------------------------------

# Get the md5 checksum for a given string - convert to GUID format

echo -n "tester" | md5sum | awk '{print toupper($1)}' | sed -rne "s/^([0-9A-F]{8})([0-9A-F]{4})([0-9A-F]{4})([0-9A-F]{4})([0-9A-F]{12})$/\1-\2-\3-\4-\5/p";


# ------------------------------------------------------------