# [find(1) - Linux man linux](https://linux.die.net/man/1/find)
***


### Search a given directory for any files whose basename matches a given substring
```
find "/var/log" -type 'f' -name "*error*";
```
***


### Get the total number of files within a given directory & its sub-directories
```
find "/var/log" -type 'f' -name "*" | wc -l;
```
***


### Get the total number of EACH file-extension within a given directory & its sub-directories
#####   |--> note: extensions are case-insensitive, ex) "PDF" and "pdf" are separated
```
find "/var/log" -type 'f' | sed -e 's/.*\.//' | sed -e 's/.*\///' | sort | uniq -c | sort -rn;
```
***


### Find files modified in the last X minutes
```
find "/var/log" -mtime -120 -ls;
```
***


### Find files modified since Epoch timestamp
```
find "/var/log" -type 'f' -newermt "$(date --date=@1533742394 +'%Y-%m-%d %H:%M:%S')";
```
***


### Find files modified since given point-in-time
```
find "/var/log" -type 'f' -newermt "2018-09-21 13:25:18";
```
##### Robustify
```
modified_SINCE="3 minutes ago"; # "X [seconds/minutes/hours/weeks/months/years] ago"
modified_SINCE="06/01/2018"; # "MM/DD/YYYY" (previous date)
modified_SINCE="Fri Sep 21 13:30:18 UTC-4 2018"; # specific date-time with relative timezone (UTC-4===EST)
modified_SINCE="@1537551572"; # epoch timestamp (in seconds)
find "/var/log" -type 'f' -newermt "$(date --date="${modified_SINCE}" +'%Y-%m-%d %H:%M:%S')";
```
***


### Find files modified NO LATER THAN given point-in-time
```
find "/var/log" -type 'f' ! -newermt "2018-09-21 13:25:18";
```
##### Robustify
```
modified_NO_LATER_THAN="3 months ago"; # "X [seconds/minutes/hours/weeks/months/years] ago"
modified_NO_LATER_THAN="06/01/2018"; # "MM/DD/YYYY" (previous date)
modified_NO_LATER_THAN="Fri Sep 21 13:30:18 UTC-4 2018"; # specific date-time with relative timezone (UTC-4===EST)
modified_NO_LATER_THAN="@1537551572"; # epoch timestamp (in seconds)
find "/var/log" -type 'f' -not -newermt "$(date --date="${modified_NO_LATER_THAN}" +'%Y-%m-%d %H:%M:%S')";
```
***


### Find files modified BETWEEN two points-in-time
##### (Combining the last-two use cases)
```
modified_AFTER="2018-09-21 10:05:18";
modified_NO_LATER_THAN="2018-09-21 13:37:19";
find '/var/log' -type 'f' -regex '^/var/log/nginx/.*$' -newermt "${modified_AFTER}" ! -newermt "${modified_NO_LATER_THAN}"
```
***
