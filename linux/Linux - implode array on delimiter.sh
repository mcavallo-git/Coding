#!/bin/bash

# ------------------------------------------------------------
#
# Sub-Function: Takes first argument ($1) as a SINGLE-CHARACTER delimiter, combines all remaining arguments ($2,$3,...,$n) into a string delimited by aforementioned delimiter ($1)
#
function implode { local IFS="$1"; shift; echo "$*"; }



# EXAMPLE USE:

unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=();
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-Two");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-B");
implode , "${DAT_ARRAY[@]}";  # Output:   Item-One,Item-One,Item-Two,Item-A,Item-A,Item-B


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How can I join elements of an array in Bash? - Stack Overflow"  |  https://stackoverflow.com/a/17841619
#
# ------------------------------------------------------------