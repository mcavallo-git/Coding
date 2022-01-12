#!/bin/bash
# ------------------------------------------------------------
#
# Timestamp - Filename friendly
#

DATETIME="$(date +'%Y%m%d_%H%M%S')";                # 20210623_012648            <# BEST FOR FILENAMES #>
echo "DATETIME_RFC3339 = [${DATETIME}]";


# ------------------------------------------------------------
#
# Timestamp - RFC-3339 compatible
#

DATETIME_RFC3339="$(date +'%Y-%m-%dT%H:%M:%S%z')";  # 2021-06-23T01:26:58-0400   <# BEST FOR LOG OUTPUTS #>
echo "DATETIME_RFC3339 = [${DATETIME_RFC3339}]";

echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]";  # RFC-3339


# ------------------------------------------------------------
#
# Benchmark (simplistic)
#

if [[ 1 -eq 1 ]]; then
  BENCHMARK_START=$(date +'%s.%N');
  # ------------------------------
  # vvv----- DO ACTIONS TO BENCHMARK, HERE

  sleep 3;

  # ^^^----- DO ACTIONS TO BENCHMARK, HERE
  # ------------------------------
  if [ -n "$(command -v bc 2>'/dev/null';)" ]; then
    BENCHMARK_DELTA=$(echo "scale=4; ($(date +'%s.%N') - ${BENCHMARK_START})/1" | bc -l | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';);
  else
    BENCHMARK_DELTA=$(perl -le "print($(date +'%s.%N') - ${BENCHMARK_START})" | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g');
  fi;
  echo "Finished after ${BENCHMARK_DELTA}s";
fi;


# ------------------------------------------------------------
#
# date - Determine the default output format
#

# As-of mid 2019, the default output-format is '%a %b %d %H:%M:%S %Z %Y' for date
if [ "$(date)" == "$(date +'%a %b %d %H:%M:%S %Z %Y')" ]; then
	echo "Output strings use the same (default) format of '%a %b %d %H:%M:%S %Z %Y'!";
fi;


# Convert from epoch seconds (seconds since 'the epoch', e.g. "1970-01-01 00:00:00") and output using MySQL's DateTime format (YYYY-MM-DD hh:mm:ss)
date --date=@1298589405 +'%Y-%m-%d %H:%M:%S';

# Ex) Get the datetime 1 second just-before the epoch
date --utc --date='1969-12-31 23:59:59' +'%s';


# ------------------------------------------------------------
#
# date - Convert between longhand & shorthand date formats
#

# Ex) Convert a longhand date to shorthand date format (in UTC)
date --utc --date="Feb 15 03:37:34 2022 EST" +'%Y-%m-%dT%H:%M:%SZ';


# ------------------------------------------------------------
#
# Benchmark (detailed)
#   |--> Calls "date" only once before & once after benchmarked-command(s) (e.g. forces single-source, parameter-based referencing of start & end timestamps).
#       Also, performs date-time calculations & datetime/string re-formatting operations >AFTER< the benchmark has finished, not during.
#       This way, we can format the strings as-needed while minimizing inaccuracies with the datetime values.
#

if [[ 1 -eq 1 ]]; then

VERBOSE_OUTPUT=1;

if [ ! -v START_INPUT_DATE} ] || [ -z "${START_INPUT_DATE}" ]; then
START_INPUT_DATE="";
START_SECONDS_NANOSECONDS=$(date +'%s.%N');
else
START_SECONDS_NANOSECONDS=$(date --date="${START_INPUT_DATE}" +'%s.%N');
fi;
echo "Benchmark Started";


echo "RUNNING COMMAND(S)...";
sleep 0.5;


echo "Benchmark Finished";

END_SECONDS_NANOSECONDS=$(date +'%s.%N');

START_EPOCHSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
START_NANOSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
START_MICROSECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-6);
START_MILLISECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-3);
START_DATETIME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%dT%H:%M:%S')";
START_TIMEZONE="$(date --date=@${START_EPOCHSECONDS} +'%z')";
START_TIMESTAMP="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d_%H%M%S')";
START_TIMESTAMP_FILENAME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d_%H-%M-%S')";
START_TIMESTAMP_COMPACT="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d%H%M%S')";
START_SECONDS="$(date --date=@${START_EPOCHSECONDS} +'%s')";
START_DATE_AS_YMD="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d')";
START_DATE_AS_WEEKDAY="$(date --date=@${START_EPOCHSECONDS} +'%a')";

END_EPOCHSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
END_NANOSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
END_MICROSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-6);
END_MILLISECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-3);
END_DATETIME=$(date --date=@${END_SECONDS_NANOSECONDS} +'%Y-%m-%dT%H:%M:%S');
END_TIMEZONE="$(date --date=@${END_SECONDS_NANOSECONDS} +'%z')";
END_DATE_AS_YMD="$(date --date=@${END_SECONDS_NANOSECONDS} +'%Y%m%d')";
END_DATE_AS_WEEKDAY="$(date --date=@${END_SECONDS_NANOSECONDS} +'%a')";

TOTAL_DECIMALSECONDS=$(echo "${END_SECONDS_NANOSECONDS} - ${START_SECONDS_NANOSECONDS}" | bc);
TOTAL_EPOCHSECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 1));
TOTAL_MILLISECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-3));
TOTAL_MICROSECONDS=$(printf '%d' $(echo ${TOTAL_DECIMALSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-6));

TOTAL_DURATION=$(printf '%02dh %02dm %02d.%06ds' $(echo "${TOTAL_EPOCHSECONDS}/3600" | bc) $(echo "(${TOTAL_EPOCHSECONDS}%3600)/60" | bc) $(echo "${TOTAL_EPOCHSECONDS}%60" | bc) $(echo ${TOTAL_MICROSECONDS}));

if [ ${VERBOSE_OUTPUT} -eq 1 ]; then
echo "";
echo "START_INPUT_DATE = [ ${START_INPUT_DATE} ]";
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
echo "START_DATE_AS_YMD = [ ${START_DATE_AS_YMD} ]";
echo "START_DATE_AS_WEEKDAY = [ ${START_DATE_AS_WEEKDAY} ]";
echo "";
echo "END_SECONDS_NANOSECONDS = [ ${END_SECONDS_NANOSECONDS} ]";
echo "END_EPOCHSECONDS = [ ${END_EPOCHSECONDS} ]";
echo "END_NANOSECONDS = [ ${END_NANOSECONDS} ]";
echo "END_MICROSECONDS = [ ${END_MICROSECONDS} ]";
echo "END_MILLISECONDS = [ ${END_MILLISECONDS} ]";
echo "END_DATETIME = [ ${END_DATETIME} ]";
echo "END_DATE_AS_YMD = [ ${END_DATE_AS_YMD} ]";
echo "END_DATE_AS_WEEKDAY = [ ${END_DATE_AS_WEEKDAY} ]";
echo "";
echo "TOTAL_DECIMALSECONDS = [ ${TOTAL_DECIMALSECONDS} ]";
echo "TOTAL_EPOCHSECONDS = [ ${TOTAL_EPOCHSECONDS} ]";
echo "TOTAL_MILLISECONDS = [ ${TOTAL_MILLISECONDS} ]";
echo "TOTAL_MICROSECONDS = [ ${TOTAL_MICROSECONDS} ]";
echo "TOTAL_DURATION = [ ${TOTAL_DURATION} ]";
echo "";
fi;

echo "";
echo "Duration: ${TOTAL_DURATION}   (Ran from [ ${START_DATETIME}.${START_MICROSECONDS}${START_TIMEZONE} ] to [ ${END_DATETIME}.${END_MICROSECONDS}${END_TIMEZONE} ])";
echo "";

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How can I format a number to 2 decimal places in Perl? - Stack Overflow"  |  https://stackoverflow.com/a/35044678
#
# ------------------------------------------------------------