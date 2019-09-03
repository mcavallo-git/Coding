#!/bin/bash
#
# tr - "translate or delete characters" (e.g. splits strings on a given character)
# ------------------------------------------------------------



for EACH_PATH in $(manpath | tr ":" "\n"); do echo -e "\nCalling:  ls -al \"${EACH_PATH}\"..."; ls -al "${EACH_PATH}"; done;



# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "How do I split a string on a delimiter in Bash?"  |  https://stackoverflow.com/a/918931
#
# ------------------------------------------------------------