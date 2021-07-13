#!/bin/bash
# ------------------------------------------------------------
#
# Linux - shuf - generate random permutations
#
# ------------------------------------------------------------
#
# shuf - general syntax
#    -i, --input-range=LO-HI   treat each number LO through HI as an input line
#    -n, --head-count=COUNT    output at most COUNT lines
#

# shuf - (example) generate a random value between 1 and 10, inclusively (e.g. a integer from the set [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] )
shuf -i 1-10 -n 1;


# shuf - (example) specify min/max with variables & output random value to a variable
MIN_VALUE=40000;
MAX_VALUE=42500;
RANDOM_INTEGER=$(shuf -i ${MIN_VALUE}-${MAX_VALUE} -n 1);
echo "\${RANDOM_INTEGER} = [ ${RANDOM_INTEGER} ]";


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "shell - Generate random numbers in specific range - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/140756
#
# ------------------------------------------------------------