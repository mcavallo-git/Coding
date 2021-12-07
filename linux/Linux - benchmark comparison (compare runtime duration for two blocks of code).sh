if [ 1 -eq 1 ]; then
  # ------------------------------

  # Set how many times to run each code block
  LOOP_ITERATIONS=1000;

  # ------------------------------
  # Ensure command "bc" exists
  if [ -z "$(command -v bc 2>'/dev/null';)" ]; then
    apt-get update -y; apt-get install -y bc;
  fi;

  echo -e "\n";

  # ------------------------------------------------------------
  #
  # Setup/run benchmark #1
  #
  BENCHMARK_1_START=$(date +'%s.%N';);
  for i in $(seq ${LOOP_ITERATIONS}); do # ---- START CODE BLOCK #1

    # sed - Trim leading whitespace && trailing whitespace (method 1)
    echo "  a  b  c  d  " | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' 1>/dev/null 2>&1;

  done; # ------------------------------------- END CODE BLOCK #1
  BENCHMARK_1_END=$(date +'%s.%N';)
  BENCHMARK_1_DELTA=$(echo "scale=4; (${BENCHMARK_1_END} - ${BENCHMARK_1_START})/1" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);

  # ------------------------------------------------------------
  #
  # Setup/run benchmark #2
  #
  BENCHMARK_2_START=$(date +'%s.%N';);
  for i in $(seq ${LOOP_ITERATIONS}); do # ---- START CODE BLOCK #2

    # sed - Trim leading whitespace && trailing whitespace (method 2)
    echo "  a  b  c  d  " | sed -e 's/^[ \t]*//;s/[ \t]*$//' 1>/dev/null 2>&1;

  done; # ------------------------------------- END CODE BLOCK #2
  BENCHMARK_2_END=$(date +'%s.%N';)
  BENCHMARK_2_DELTA=$(echo "scale=4; (${BENCHMARK_2_END} - ${BENCHMARK_1_START})/1" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);

  # ------------------------------------------------------------
  #
  # Calculate Results
  #

  BENCHMARK_1_MINUS_2_DELTA=$(echo "scale=4; (${BENCHMARK_1_DELTA} - ${BENCHMARK_2_DELTA})/1" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);
  BENCHMARK_2_MINUS_1_DELTA=$(echo "scale=4; (${BENCHMARK_2_DELTA} - ${BENCHMARK_1_DELTA})/1" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);

  BENCHMARK_1_DIV_2_DECIMAL=$(echo "scale=4; (${BENCHMARK_1_DELTA}/${BENCHMARK_2_DELTA})" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);
  BENCHMARK_1_DIV_2_PERCENTAGE=$(echo "scale=2; (${BENCHMARK_1_DIV_2_DECIMAL}*100)/1" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);

  BENCHMARK_2_DIV_1_DECIMAL=$(echo "scale=4; (${BENCHMARK_2_DELTA}/${BENCHMARK_1_DELTA})" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);
  BENCHMARK_2_DIV_1_PERCENTAGE=$(echo "scale=2; (${BENCHMARK_2_DIV_1_DECIMAL}*100)/1" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);

  # ------------------------------------------------------------
  #
  # Show Results
  #
  echo "";
  echo "------------------------------";
  echo "Results:";
  echo "";
  echo "  -  Runtime Duration - Code Block #1:  ${BENCHMARK_1_DELTA}s";
  echo "  -  Runtime Duration - Code Block #2:  ${BENCHMARK_2_DELTA}s";
  echo "";
  echo "------------------------------";
  echo "Winner:";
  if [ $(echo "${BENCHMARK_1_DELTA} < ${BENCHMARK_2_DELTA}" | bc;) -eq 1 ]; then
    # Code Block #1 ran faster
    echo "";
    echo "  ! ! !     CODE BLOCK #1    ! ! !";
    echo "  -  Ran [ ${BENCHMARK_2_DIV_1_DECIMAL} ] times as fast as Code Block #2";
    echo "  -  Completed in [ ${BENCHMARK_1_DIV_2_PERCENTAGE}% ] of the time that it took Code Block #2 to complete";

  else
    # Code Block #2 ran faster
    echo "";
    echo "  ! ! !     CODE BLOCK #2    ! ! !";
    echo "";
    echo "  -  Ran [ ${BENCHMARK_1_DIV_2_DECIMAL} ] times as fast as Code Block #1";
    echo "  -  Completed in [ ${BENCHMARK_2_DIV_1_PERCENTAGE}% ] of the time that it took Code Block #1 to complete";
  fi;
  echo "";
  echo "------------------------------";
  echo "";

fi;
