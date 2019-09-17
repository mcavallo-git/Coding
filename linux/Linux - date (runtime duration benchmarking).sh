#!/bin/bash

START_SECONDS_NANOSECONDS=$(date +'%s.%N'); echo "START_SECONDS_NANOSECONDS=${START_SECONDS_NANOSECONDS}"; \
START_EPOCHSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1); echo "START_EPOCHSECONDS=${START_EPOCHSECONDS}"; \
START_NANOSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9); echo "START_NANOSECONDS=${START_NANOSECONDS}"; \
START_MICROSECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-6); echo "START_MICROSECONDS=${START_MICROSECONDS}"; \
START_MILLISECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-3); echo "START_MILLISECONDS=${START_MILLISECONDS}"; \
START_DATETIME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d %H:%M:%S')"; echo "START_DATETIME=${START_DATETIME}"; \
START_TIMESTAMP="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d_%H%M%S')"; echo "START_TIMESTAMP=${START_TIMESTAMP}"; \
START_TIMESTAMP_FILENAME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d_%H-%M-%S')"; echo "START_TIMESTAMP_FILENAME=${START_TIMESTAMP_FILENAME}"; \
START_TIMESTAMP_COMPACT="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d%H%M%S')"; echo "START_TIMESTAMP_COMPACT=${START_TIMESTAMP_COMPACT}"; \
START_SECONDS="$(date --date=@${START_EPOCHSECONDS} +'%s')"; echo "START_SECONDS=${START_SECONDS}"; \
START_FRACTION_SECONDS="$(date --date=@${START_EPOCHSECONDS} +'%N')"; echo "START_FRACTION_SECONDS=${START_FRACTION_SECONDS}"; \
DATE_AS_YMD="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d')"; echo "DATE_AS_YMD=${DATE_AS_YMD}"; \
TODAY_AS_WEEKDAY="$(date --date=@${START_EPOCHSECONDS} +'%a')"; echo "TODAY_AS_WEEKDAY=${TODAY_AS_WEEKDAY}";


# Command here...
sleep 0.5; # Example command - sleep half a second


END_TIMESTAMP=$(date +'%s.%N');
END_EPOCHSECONDS=$(echo ${END_TIMESTAMP} | cut --delimiter '.' --fields 1);
END_MILLISECONDS=$(echo ${END_TIMESTAMP} | cut --delimiter '.' --fields 2 | cut --characters 1-3);
END_MICROSECONDS=$(echo ${END_TIMESTAMP} | cut --delimiter '.' --fields 2 | cut --characters 1-6);
END_DATETIME=$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d %H:%M:%S');

END_DATETIME="$(date +'%Y-%m-%d %H:%M:%S')";


TOTAL_DECIMALSECONDS=$(echo "${END_TIMESTAMP} - ${START_TIMESTAMP}" | bc)

TOTAL_EPOCHSECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 1));
TOTAL_MILLISECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-3));
TOTAL_MICROSECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-6));

TOTAL_DURATION=$(printf '%02dh %02dm %02d.%06ds' $(echo "${TOTAL_EPOCHSECONDS}/3600" | bc) $(echo "(${TOTAL_EPOCHSECONDS}%3600)/60" | bc) $(echo "${TOTAL_EPOCHSECONDS}%60" | bc) $(echo ${TOTAL_MICROSECONDS}));

echo "\$START_TIMESTAMP = [${START_TIMESTAMP}]  ";
echo "\$END_TIMESTAMP = [${END_TIMESTAMP}]  ";

echo "\$TOTAL_DECIMALSECONDS = [${TOTAL_DECIMALSECONDS}]  ";

echo "\$TOTAL_EPOCHSECONDS = [${TOTAL_EPOCHSECONDS}]";
echo "\$TOTAL_MILLISECONDS = [${TOTAL_MILLISECONDS}]";
echo "\$TOTAL_MICROSECONDS = [${TOTAL_MICROSECONDS}]";

echo "Duration: ${TOTAL_DURATION}   (Ran [${START_DATETIME}] to [${END_DATETIME}])";
