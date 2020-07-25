#!/bin/bash

# ------------------------------------------------------------
# Simple Timestamp

DATETIMESTAMP="$(date +'%Y%m%d_%H%M%S')";

# ------------------------------------------------------------
# RFC-3339 Timestamp

DATETIMESTAMP="$(date --rfc-3339='seconds';)";


# ------------------------------------------------------------
# Simple Benchmark

BENCHMARK_START=$(date +'%s.%N');
sleep 3;
BENCHMARK_DELTA=$(echo "scale=4; ($(date +'%s.%N') - ${BENCHMARK_START})/1" | bc -l);
echo "  |--> Finished after ${BENCHMARK_DELTA}s";


# ------------------------------------------------------------
#
# 	Date-Time Vars
#		 |--> Make sure that the "date" command is called only once (e.g. make sure to only grab one timestamp)
#		      This way, we can format it however we want without concern of inaccuracies existing between multiple date/timestamp values
#

if [ 1 -eq 1 ]; then

VERBOSE_OUTPUT=1;

START_SECONDS_NANOSECONDS=$(date +'%s.%N');
START_EPOCHSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
START_NANOSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
START_MICROSECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-6);
START_MILLISECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-3);
START_DATETIME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d %H:%M:%S')";
START_TIMESTAMP="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d_%H%M%S')";
START_TIMESTAMP_FILENAME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d_%H-%M-%S')";
START_TIMESTAMP_COMPACT="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d%H%M%S')";
START_SECONDS="$(date --date=@${START_EPOCHSECONDS} +'%s')";
DATE_AS_YMD="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d')";
DATE_AS_WEEKDAY="$(date --date=@${START_EPOCHSECONDS} +'%a')";


echo "RUNNING COMMAND(S) TO BENCHMARK...";
sleep 0.5;


END_SECONDS_NANOSECONDS=$(date +'%s.%N');
END_EPOCHSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
END_NANOSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
END_MICROSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-6);
END_MILLISECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-3);
END_DATETIME=$(date --date=@${END_SECONDS_NANOSECONDS} +'%Y-%m-%d %H:%M:%S');

TOTAL_DECIMALSECONDS=$(echo "${END_SECONDS_NANOSECONDS} - ${START_SECONDS_NANOSECONDS}" | bc);
TOTAL_EPOCHSECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 1));
TOTAL_MILLISECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-3));
TOTAL_MICROSECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-6));

TOTAL_DURATION=$(printf '%02dh %02dm %02d.%06ds' $(echo "${TOTAL_EPOCHSECONDS}/3600" | bc) $(echo "(${TOTAL_EPOCHSECONDS}%3600)/60" | bc) $(echo "${TOTAL_EPOCHSECONDS}%60" | bc) $(echo ${TOTAL_MICROSECONDS}));

if [ ${VERBOSE_OUTPUT} -eq 1 ]; then
echo "";
echo "START_SECONDS_NANOSECONDS = [ ${START_SECONDS_NANOSECONDS} ]";
echo "START_EPOCHSECONDS = [ ${START_EPOCHSECONDS} ]";
echo "START_NANOSECONDS = [ ${START_NANOSECONDS} ]";
echo "START_MICROSECONDS = [ ${START_MICROSECONDS} ]";
echo "START_MILLISECONDS = [ ${START_MILLISECONDS} ]";
echo "START_DATETIME = [ ${START_DATETIME} ]";
echo "START_TIMESTAMP = [ ${START_TIMESTAMP} ]";
echo "START_TIMESTAMP_FILENAME = [ ${START_TIMESTAMP_FILENAME} ]";
echo "START_TIMESTAMP_COMPACT = [ ${START_TIMESTAMP_COMPACT} ]";
echo "START_SECONDS = [ ${START_SECONDS} ]";
echo "";
echo "DATE_AS_YMD = [ ${DATE_AS_YMD} ]";
echo "DATE_AS_WEEKDAY = [ ${DATE_AS_WEEKDAY} ]";
echo "";
echo "END_SECONDS_NANOSECONDS = [ ${END_SECONDS_NANOSECONDS} ]";
echo "END_EPOCHSECONDS = [ ${END_EPOCHSECONDS} ]";
echo "END_NANOSECONDS = [ ${END_NANOSECONDS} ]";
echo "END_MICROSECONDS = [ ${END_MICROSECONDS} ]";
echo "END_MILLISECONDS = [ ${END_MILLISECONDS} ]";
echo "END_DATETIME = [ ${END_DATETIME} ]";
echo "";
echo "TOTAL_DECIMALSECONDS = [ ${TOTAL_DECIMALSECONDS} ]";
echo "TOTAL_EPOCHSECONDS = [ ${TOTAL_EPOCHSECONDS} ]";
echo "TOTAL_MILLISECONDS = [ ${TOTAL_MILLISECONDS} ]";
echo "TOTAL_MICROSECONDS = [ ${TOTAL_MICROSECONDS} ]";
echo "TOTAL_DURATION = [ ${TOTAL_DURATION} ]";
echo "";
fi;

echo "";
echo "Duration: ${TOTAL_DURATION}   (Ran from [ ${START_DATETIME}.${START_NANOSECONDS} ] to [ ${END_DATETIME}.${END_NANOSECONDS} ])";
echo "";

fi;


# ------------------------------------------------------------