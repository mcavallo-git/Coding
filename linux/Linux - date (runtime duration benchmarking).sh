#!/bin/bash

START_SECONDS="$(date +'%s')";
START_DATETIME="$(date +'%Y-%m-%d %H:%M:%S')";

# Command here...



END_SECONDS="$(date +'%s')";
END_DATETIME="$(date +'%Y-%m-%d %H:%M:%S')";

TOTAL_SECONDS=$((${END_SECONDS}-${START_SECONDS}));
TOTAL_DURATION="$(printf '%02d hours, %02d minutes, %02d seconds' $((${TOTAL_SECONDS}/3600)) $(((${TOTAL_SECONDS}%3600)/60)) $((${TOTAL_SECONDS}%60)))";

echo "Duration: ${TOTAL_DURATION}   (Ran [${START_DATETIME}] to [${END_DATETIME}])";

