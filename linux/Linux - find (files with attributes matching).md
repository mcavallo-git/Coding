
# [find(1) - Linux man linux](https://linux.die.net/man/1/find)



***
### Basic 'find' (file-search) examples
```find "/var/log" -type 'f' -name "*error*";```   *-name 'search'   ### case-sensitive search*

```find "/var/log" -type 'f' -iname "*error*";```   *-iname 'search'   ### case-insensitive search*

```find "/var/log" -type 'd' -iname "*error*";```   *-type d   ### directories*

```find "/var/log" -type "f" -printf "%p %A@\n";``` *show results' fullpath (%p) & last-modified date in Unix time (%A@)*




***
### Find Folders within another directory which match a given, case-insensitive string (no recursion)
```
find '.' -maxdepth 1 -type 'd' -iname '*matched_name*' | wc -l;
```



### Get the total number of files within a given directory & its sub-directories
***
### Get the total number of files within a given directory & its sub-directories
```
find "/var/log" -type 'f' -name "*" | wc -l;
```



***
### File Extension (Single) - Locate all files with a specific file-extension in a specific directory (and subdirectories)
```
### look for script (in this same repo):  'find_basenames_extensions.sh'
```
***



### File Extensions (Many) - Same as previous - But find files matching at least one extension requested
```
LOOK_IN_DIRECTORY="$(getent passwd $(whoami) | cut --delimiter=: --fields=6)"; # Current user's home-directory

GENERIC_WEB_FILES=$(find "${LOOK_IN_DIRECTORY}" -type 'f' \( -iname \*.html -o -iname \*.css -o -iname \*.jpg -o -iname \*.png -o -iname \*.gif -o -iname \*.woff2 \));

echo -e "\nFound $(echo "${GENERIC_WEB_FILES}" | wc -l) files matching at least one extension in '${LOOK_IN_DIRECTORY}'\n";

```



***
### Get the total number of EACH file-extension within a given directory & its sub-directories
##### --> Note: extensions are case-insensitive, ex) "PDF" and "pdf" are separated
```
find "/var/log" -type 'f' | sed -e 's/.*\.//' | sed -e 's/.*\///' | sort | uniq -c | sort -rn;
```



***
### Find files modified in the last X minutes
```find "/var/log" -mtime -120 -ls;```



***
### Find files modified since Epoch timestamp
```find "/var/log" -type 'f' -newermt "$(date --date=@1533742394 +'%Y-%m-%d %H:%M:%S')";```




***
### Find files modified since given point-in-time
```find "/var/log" -type 'f' -newermt "2018-09-21 13:25:18";```
## --> Robustify
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
## --> Robustify
```
modified_NO_LATER_THAN="3 months ago"; # "X [seconds/minutes/hours/weeks/months/years] ago"

modified_NO_LATER_THAN="06/01/2018"; # "MM/DD/YYYY" (previous date)

modified_NO_LATER_THAN="Fri Sep 21 13:30:18 UTC-4 2018"; # specific date-time with relative timezone (UTC-4===EST)

modified_NO_LATER_THAN="@1537551572"; # epoch timestamp (in seconds)

find "/var/log" -type 'f' -not -newermt "$(date --date="${modified_NO_LATER_THAN}" +'%Y-%m-%d %H:%M:%S')";
```



***
### Find files modified BETWEEN two points-in-time
#####  --> Note: combines the previous two models of [since] and [not-after]
```
modified_AFTER="2018-09-21 10:05:18";

modified_NO_LATER_THAN="2018-09-21 13:37:19";

find '/var/log' -type 'f' -regex '^/var/log/nginx/.*$' -newermt "${modified_AFTER}" ! -newermt "${modified_NO_LATER_THAN}"
```



***
### Determine a file's encoding (utf-8, ascii, etc.)
```file -bi '/var/log/nginx/error.log'```



***
### Delete items within a directory older than X days
#####  ex) Cleanup NGINX Logs
```
DIRECTORY_TO_CLEAN="/var/log/nginx/";

KEEP_NEWER_THAN_DAYS=7;

find ${DIRECTORY_TO_CLEAN} -maxdepth 1 -type f -mtime +${KEEP_NEWER_THAN_DAYS} -exec rm -v -- '{}' \;
```



***
