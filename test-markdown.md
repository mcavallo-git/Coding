[[_TOC_]]

# Code block - No language specification
```
START_SECONDS_NANOSECONDS=$(date +'%s.%N');
START_EPOCHSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
START_NANOSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
START_MICROSECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-6);
START_DATETIME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d %H:%M:%S';)";
START_TIMESTAMP="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d_%H%M%S';)";
```


# Code block - Bash language specification
```bash
START_SECONDS_NANOSECONDS=$(date +'%s.%N');
START_EPOCHSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
START_NANOSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
START_MICROSECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-6);
START_DATETIME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d %H:%M:%S';)";
START_TIMESTAMP="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d_%H%M%S';)";
```
