#!/bin/bash
# ------------------------------------------------------------
#
# Example function

#
#   concat_vars  -  funtion which concats two inputs together and returns the result
#
concat_vars() {
  local VARIABLE_1="${1}";
  local VARIABLE_2="${2}";
  local RETURNED_VAL="${VARIABLE_1}-${VARIABLE_2}";
  echo -n "${RETURNED_VAL}"; # If returning a value via echo, make sure to remove the newline via "-n"
}

# Call the function
concat_vars "a" "b";

# Store the output of the function as a variable then echo it later
STORED_RESULT="$(concat_vars "a" "b";)";
echo "STORED_RESULT=[${STORED_RESULT}]";


# ------------------------------------------------------------