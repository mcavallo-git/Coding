#!/bin/bash
# ------------------------------------------------------------
#
# Benchmark Comparisons
#

if [ 1 -eq 1 ]; then
  BENCHMARK_1_START=$(date +'%s.%N';);
  # ------------------------------
  # START CODE BLOCK #1
  if [ 1 -eq 1 ]; then

    sleep 3;

  fi;
  # END CODE BLOCK #1
  # ------------------------------
  BENCHMARK_1_END=$(date +'%s.%N';)
  if [ -n "$(command -v bc 2>'/dev/null';)" ]; then
    BENCHMARK_1_DELTA=$(echo "scale=4; (${BENCHMARK_1_END} - ${BENCHMARK_1_START})/1" | bc -l;);
  else
    BENCHMARK_1_DELTA=$(perl -le "print(${BENCHMARK_1_END} - ${BENCHMARK_1_START})";);
  fi;
  #
  # ------------------------------------------------------------
  #
  BENCHMARK_2_START=$(date +'%s.%N';);
  # ------------------------------
  # START CODE BLOCK #2
  if [ 1 -eq 1 ]; then

    sleep 2;

  fi;
  # END CODE BLOCK #2
  # ------------------------------
  BENCHMARK_2_END=$(date +'%s.%N';)
  if [ -n "$(command -v bc 2>'/dev/null';)" ]; then
    BENCHMARK_2_DELTA=$(echo "scale=4; (${BENCHMARK_2_END} - ${BENCHMARK_2_START})/1" | bc -l;);
  else
    BENCHMARK_2_DELTA=$(perl -le "print(${BENCHMARK_2_END} - ${BENCHMARK_2_START})";);
  fi;
  #
  # ------------------------------------------------------------
  #
  BENCHMARK_1_MINUS_2_DELTA=$(perl -le "print(${BENCHMARK_1_DELTA} - ${BENCHMARK_2_DELTA})";);
  BENCHMARK_2_MINUS_1_DELTA=$(perl -le "print(${BENCHMARK_2_DELTA} - ${BENCHMARK_1_DELTA})";);
  echo -e "------------------------------------------------------------\n";
  echo -e "Runtime Duration - Code Block #1:  ${BENCHMARK_1_DELTA}s";
  echo -e "Runtime Duration - Code Block #2:  ${BENCHMARK_2_DELTA}s";
  echo -e "";
  echo -e "Runtime Difference (Code Block #2 minus Code Block #1):  ${BENCHMARK_2_MINUS_1_DELTA}s";
  echo -e "Runtime Difference (Code Block #1 minus Code Block #2):  ${BENCHMARK_1_MINUS_2_DELTA}s";
  echo -e "------------------------------------------------------------\n";
fi;


# -----------------------------------------------------------