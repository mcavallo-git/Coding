#!/bin/bash
# ------------------------------------------------------------
# Linux - isset, unset (test if var is empty or unset)
# ------------------------------------------------------------

if [[ 1 -eq 1 ]]; then

  unset tester1;

  tester2="";

  tester3="hello world";

  for EACH_VAR in tester1 tester2 tester3; do

    if [[ ! -v ${EACH_VAR} ]]; then

      echo "Error:  Variable \$${EACH_VAR} is unset";

    elif [[ -z "${!EACH_VAR}" ]]; then

      echo "Error:  Variable \$${EACH_VAR} is set but empty";

    else

      echo "Info:  Variable \$${EACH_VAR} is set to \"${!EACH_VAR}\"";

    fi;

  done;

fi;

# ------------------------------------------------------------