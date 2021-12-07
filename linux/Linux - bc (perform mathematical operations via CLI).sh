#!/bin/bash
# ------------------------------------------------------------

# Install command "bc" (debian-based distros)
if [ -z "$(command -v bc 2>'/dev/null';)" ]; then
  apt-get update -y; apt-get install -y bc;
fi;


# ------------------------------------------------------------
#
# Example - bc (mathematical operations via CLI)
#

if [ 1 -eq 1 ]; then
  echo -e "\n";
  # ------------------------------------------------------------
  # Setup/run benchmark #1
  BENCHMARK_1_START=$(date +'%s.%N';);
  sleep 2;
  BENCHMARK_1_END=$(date +'%s.%N';)
  BENCHMARK_1_DELTA=$(echo "scale=4; (${BENCHMARK_1_END} - ${BENCHMARK_1_START})/1" | bc -l;);
  echo -e "Runtime Duration - Code Block #1:  ${BENCHMARK_1_DELTA}s";
  # ------------------------------------------------------------
  # Setup/run benchmark #2
  BENCHMARK_2_START=$(date +'%s.%N';);
  sleep 3;
  BENCHMARK_2_END=$(date +'%s.%N';)
  BENCHMARK_2_DELTA=$(echo "scale=4; (${BENCHMARK_2_END} - ${BENCHMARK_1_START})/1" | bc -l;);
  echo -e "Runtime Duration - Code Block #2:  ${BENCHMARK_2_DELTA}s";
  # ------------------------------------------------------------
  #
  # Calculate Results
  #
  BENCHMARK_1_MINUS_2_DELTA=$(echo "scale=4; (${BENCHMARK_1_DELTA} - ${BENCHMARK_2_DELTA})/1" | bc -l;);
  BENCHMARK_2_MINUS_1_DELTA=$(echo "scale=4; (${BENCHMARK_2_DELTA} - ${BENCHMARK_1_DELTA})/1" | bc -l;);
  BENCHMARK_1_DIV_2_DECIMAL=$(echo "scale=4; (${BENCHMARK_1_DELTA}/${BENCHMARK_2_DELTA})" | bc -l;);
  BENCHMARK_1_DIV_2_PERCENTAGE=$(echo "scale=2; (${BENCHMARK_1_DIV_2_DECIMAL}*100)/1" | bc -l;);
  BENCHMARK_2_DIV_1_DECIMAL=$(echo "scale=4; (${BENCHMARK_2_DELTA}/${BENCHMARK_1_DELTA})" | bc -l;);
  BENCHMARK_2_DIV_1_PERCENTAGE=$(echo "scale=2; (${BENCHMARK_2_DIV_1_DECIMAL}*100)/1" | bc -l;);
  echo "";
  if [ $(echo "${BENCHMARK_1_DELTA} < ${BENCHMARK_2_DELTA}" | bc) -eq 1 ]; then
    # Code Block #1 completed more quickly than Code Block #2
    echo "Result:  Code Block #1 (${BENCHMARK_1_DELTA}s) is faster - it completed in ${BENCHMARK_1_DIV_2_PERCENTAGE}% of the time that it took to complete Code Block #2 (${BENCHMARK_2_DELTA}s)";
  else
    # Code Block #1 completed more quickly than Code Block #2
    echo "Result:  Code Block #2 (${BENCHMARK_2_DELTA}s) is faster - it completed in ${BENCHMARK_2_DIV_1_PERCENTAGE}% of the time that it took to complete Code Block #1 (${BENCHMARK_1_DELTA}s)";
  fi;
  echo "";
fi;

# ------------------------------------------------------------