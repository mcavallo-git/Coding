#!/bin/bash
# ------------------------------------------------------------
#
# Timestamp formats
#


# Timestamp_Filename               20220117T044440
echo "$(date +'%Y%m%dT%H%M%S';)";

# Timestamp_Filename_ms_TZ         20220117T044440.308-0500
echo "$(date +'%Y%m%dT%H%M%S').$(date +'%N' | cut -c1-3;)$(date +'%z';)";

# Timestamp_Filename_μs_TZ         20220117T044440.308068-0500
echo "$(date +'%Y%m%dT%H%M%S').$(date +'%N' | cut -c1-6;)$(date +'%z';)";

# Timestamp_Filename_μs_TZ         20220117T044440.308068410-0500       <# BEST FOR FILENAMES #>
echo "$(date +'%Y%m%dT%H%M%S.%N%z';)";


# Timestamp_RFC3339                2022-01-17T04:44:40-0500
echo "$(date +'%Y-%m-%dT%H:%M:%S%z';)";

# Timestamp_RFC3339_ms             2022-01-17T04:44:40.308-0500
echo "$(date +'%Y-%m-%dT%H:%M:%S';).$(date +'%N' | cut -c1-3;)$(date +'%z';)";

# Timestamp_RFC3339_μs             2022-01-17T04:44:40.308068-0500
echo "$(date +'%Y-%m-%dT%H:%M:%S';).$(date +'%N' | cut -c1-6;)$(date +'%z';)";

# Timestamp_RFC3339_ns             2022-01-17T04:44:40.308068410-0500
echo "$(date +'%Y-%m-%dT%H:%M:%S.%N%z';)";

# Timestamp_UTC_RFC3339_ns         2022-01-17T09:44:40.308068410Z       <# BEST FOR LOG OUTPUTS #>
echo "$(date --utc +'%Y-%m-%dT%H:%M:%S.%NZ';)";


# ------------------------------------------------------------
#
# Get Timezone Offset
#

if [[ 1 -eq 1 ]]; then
CURRENT_HOUR="$(date +'%H';)";
CURRENT_MINUTE="$(date +'%M';)";
CURRENT_HOUR_UTC="$(env TZ=UTC date +'%H';)";
CURRENT_MINUTE_UTC="$(env TZ=UTC date +'%M';)";
SUMMED_MINUTES="$(echo "((${CURRENT_HOUR}-${CURRENT_HOUR_UTC})*60)+(${CURRENT_MINUTE}-${CURRENT_MINUTE_UTC})"|bc;)";
RAW_OFFSET_HOURS="$(echo "${SUMMED_MINUTES}/60" | bc;)";
RAW_OFFSET_MINUTES="$(echo "${SUMMED_MINUTES}%60"|bc;)";
if [[ ! "${RAW_OFFSET_HOURS:0:1}" =~ [0-9] ]]; then 
  OFFSET_HOURS="${RAW_OFFSET_HOURS:0:1}$(printf "%02d" "${RAW_OFFSET_HOURS:1}";)";
else
  OFFSET_HOURS="$(printf "%02d" "${RAW_OFFSET_HOURS}";)";
fi;
if [[ ! "${RAW_OFFSET_MINUTES:0:1}" =~ [0-9] ]]; then 
  OFFSET_MINUTES="$(printf "%02d" "${RAW_OFFSET_MINUTES:1}";)";
else
  OFFSET_MINUTES="$(printf "%02d" "${RAW_OFFSET_MINUTES}";)";
fi;
TZ_UTC_OFFSET="${OFFSET_HOURS}:${OFFSET_MINUTES}";
echo "TZ_UTC_OFFSET = [ ${TZ_UTC_OFFSET} ]";
fi;


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
START_DATETIME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%dT%H:%M:%S';)";
START_TIMEZONE="$(date --date=@${START_EPOCHSECONDS} +'%z';)";
START_TIMESTAMP="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d_%H%M%S';)";
START_TIMESTAMP_FILENAME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d_%H-%M-%S';)";
START_TIMESTAMP_COMPACT="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d%H%M%S';)";
START_SECONDS="$(date --date=@${START_EPOCHSECONDS} +'%s';)";
START_DATE_AS_YMD="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d';)";
START_DATE_AS_WEEKDAY="$(date --date=@${START_EPOCHSECONDS} +'%a';)";

END_EPOCHSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
END_NANOSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
END_MICROSECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-6);
END_MILLISECONDS=$(echo ${END_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-3);
END_DATETIME=$(date --date=@${END_SECONDS_NANOSECONDS} +'%Y-%m-%dT%H:%M:%S');
END_TIMEZONE="$(date --date=@${END_SECONDS_NANOSECONDS} +'%z';)";
END_DATE_AS_YMD="$(date --date=@${END_SECONDS_NANOSECONDS} +'%Y%m%d';)";
END_DATE_AS_WEEKDAY="$(date --date=@${END_SECONDS_NANOSECONDS} +'%a';)";

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
# Taken from "man date"
#
#    FORMAT controls the output.  Interpreted sequences are:
#
#    %%     a literal %
#
#    %a     locale's abbreviated weekday name (e.g., Sun)
#
#    %A     locale's full weekday name (e.g., Sunday)
#
#    %b     locale's abbreviated month name (e.g., Jan)
#
#    %B     locale's full month name (e.g., January)
#
#    %c     locale's date and time (e.g., Thu Mar  3 23:05:25 2005)
#
#    %C     century; like %Y, except omit last two digits (e.g., 20)
#
#    %d     day of month (e.g., 01)
#
#    %D     date; same as %m/%d/%y
#
#    %e     day of month, space padded; same as %_d
#
#    %F     full date; same as %Y-%m-%d
#
#    %g     last two digits of year of ISO week number (see %G)
#
#    %G     year of ISO week number (see %V); normally useful only with %V
#
#    %h     same as %b
#
#    %H     hour (00..23)
#
#    %I     hour (01..12)
#
#    %j     day of year (001..366)
#
#    %k     hour, space padded ( 0..23); same as %_H
#
#    %l     hour, space padded ( 1..12); same as %_I
#
#    %m     month (01..12)
#
#    %M     minute (00..59)
#
#    %n     a newline
#
#    %N     nanoseconds (000000000..999999999)
#
#    %p     locale's equivalent of either AM or PM; blank if not known
#
#    %P     like %p, but lower case
#
#    %q     quarter of year (1..4)
#
#    %r     locale's 12-hour clock time (e.g., 11:11:04 PM)
#
#    %R     24-hour hour and minute; same as %H:%M
#
#    %s     seconds since 1970-01-01 00:00:00 UTC
#
#    %S     second (00..60)
#
#    %t     a tab
#
#    %T     time; same as %H:%M:%S
#
#    %u     day of week (1..7); 1 is Monday
#
#    %U     week number of year, with Sunday as first day of week (00..53)
#
#    %V     ISO week number, with Monday as first day of week (01..53)
#
#    %w     day of week (0..6); 0 is Sunday
#
#    %W     week number of year, with Monday as first day of week (00..53)
#
#    %x     locale's date representation (e.g., 12/31/99)
#
#    %X     locale's time representation (e.g., 23:13:48)
#
#    %y     last two digits of year (00..99)
#
#    %Y     year
#
#    %z     +hhmm numeric time zone (e.g., -0400)
#
#    %:z    +hh:mm numeric time zone (e.g., -04:00)
#
#    %::z   +hh:mm:ss numeric time zone (e.g., -04:00:00)
#
#    %:::z  numeric time zone with : to necessary precision (e.g., -04, +05:30)
#
#    %Z     alphabetic time zone abbreviation (e.g., EDT)
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How can I format a number to 2 decimal places in Perl? - Stack Overflow"  |  https://stackoverflow.com/a/35044678
#
# ------------------------------------------------------------