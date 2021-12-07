#!/bin/bash
# ------------------------------------------------------------
#
# Benchmark Comparisons
#

if [ 1 -eq 1 ]; then

  # ------------------------------
  # Ensure command "bc" exists
  if [ -z "$(command -v bc 2>'/dev/null';)" ]; then
    apt-get update -y; apt-get install -y bc;
  fi;

  # ------------------------------------------------------------
  #
  # Setup/run benchmark #1
  #
  BENCHMARK_1_START=$(date +'%s.%N';);
  if [ 1 -eq 1 ]; then # --- START CODE BLOCK #1

    sleep 1;

  fi; # -------------------- END CODE BLOCK #1
  BENCHMARK_1_END=$(date +'%s.%N';)
  BENCHMARK_1_DELTA=$(echo "scale=4; (${BENCHMARK_1_END} - ${BENCHMARK_1_START})/1" | bc -l;);
  echo -e "\nRuntime Duration - Code Block #1:  ${BENCHMARK_1_DELTA}s";

  # ------------------------------------------------------------
  #
  # Setup/run benchmark #2
  #
  BENCHMARK_2_START=$(date +'%s.%N';);
  if [ 1 -eq 1 ]; then # --- START CODE BLOCK #1

    sleep 2;

  fi; # -------------------- END CODE BLOCK #1
  BENCHMARK_2_END=$(date +'%s.%N';)
  BENCHMARK_2_DELTA=$(echo "scale=4; (${BENCHMARK_2_END} - ${BENCHMARK_1_START})/1" | bc -l;);
  echo -e "\nRuntime Duration - Code Block #2:  ${BENCHMARK_2_DELTA}s";

  # ------------------------------------------------------------
  #
  # Calculate Results
  #

  echo -e "------------------------------------------------------------\n";
  echo -e "";
  echo -e "Results:";

  if [ $(echo "${BENCHMARK_1_DELTA} < ${BENCHMARK_2_DELTA}" | bc) -eq 1 ]; then
    BENCHMARK_2_MINUS_1_DELTA=$(perl -le "print(${BENCHMARK_2_DELTA} - ${BENCHMARK_1_DELTA})";);
    echo "Code Block #1 ran faster than Code Block #2 by ${BENCHMARK_2_MINUS_1_DELTA}s";
  else
    BENCHMARK_1_MINUS_2_DELTA=$(perl -le "print(${BENCHMARK_1_DELTA} - ${BENCHMARK_2_DELTA})";);
    echo "Code Block #2 ran faster than Code Block #1 by ${BENCHMARK_1_MINUS_2_DELTA}s";
  fi;
  echo -e "------------------------------------------------------------\n";

fi;


# -----------------------------------------------------------