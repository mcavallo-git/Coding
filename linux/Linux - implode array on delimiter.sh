#!/bin/bash

# ------------------------------------------------------------
#
# Sub-Function: Takes first argument ($1) as a SINGLE-CHARACTER delimiter, combines all remaining arguments ($2,$3,...,$n) into a string delimited by aforementioned delimiter ($1)
#
function implode { local IFS="$1"; shift; echo "$*"; };

# ------------------------------

# Example 1.1:
implode ',' a b c;
# Output:
#a,b,c

# ------------------------------

# Example 1.2:
implode $'\n' a b c;
# Output:
#a
#b
#c

# ------------------------------

# Example 1.3:
unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=();
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-Two");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-B");

implode , "${DAT_ARRAY[@]}";
# ^ Outputs:  Item-One,Item-One,Item-Two,Item-A,Item-A,Item-B

implode $'\n' "${DAT_ARRAY[@]}";
# ^ Outputs:
# Item-One
# Item-One
# Item-Two
# Item-A
# Item-A
# Item-B



# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "Echo newline in Bash prints literal \n - Stack Overflow"  |  https://stackoverflow.com/a/8467448
#
#   stackoverflow.com  |  "How can I join elements of an array in Bash? - Stack Overflow"  |  https://stackoverflow.com/a/17841619
#
# ------------------------------------------------------------