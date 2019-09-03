# Linux - find (command)



***
### Name - Match using case SENSITIVE search
```find "/var/log" -type 'f' -name "*error*";     ### -name 'filepath' --> case-sensitive search```



***
### Name - Match using case INsensitive search
```find "/var/log" -type 'f' -iname "*error*";    ### -iname 'filepath' --> case-insensitive search```



***
### Filetype - Match Files, only
```find "/var/log" -type 'f' -iname "*error*";    ### -type d --> return files, only```



***
### Filetype - Match Directories, only
```find "/var/log" -type 'd' -iname "*error*";    ### -type d --> return directories, only```



***
### Ignore Path - Exclude a given sub-directory or filepath from returned results
```find "/var/log" -not -path "/var/log/nginx/*"; ### -not -path 'filepath' -->  excludes 'filepath'```



***
### Format Styling - Format the returned results with one (or multiple) file-attributes (as defined by the user)
```find "/var/log" -type "f" -printf "%p %A@\n";  ### printf "%p %A@\n" --> return %p=[fullpath] %A@=[last-modified timestamp (in Unix time)]'```



***
### No-Recursion - Limit matched results to a specific depth of sub-directories - using a maxdepth of 1 only searches within the given directory
```

find '.' -maxdepth 1 -type 'd' -iname '*matched_name*' | wc -l;

```



***
### Ignore Sub-Directory - Find Files in a given directory while IGNORING a given sub-directory
```

find "/var/lib/jenkins" -type 'f' -iname "favicon.ico" -a -not -path "/var/lib/jenkins/workspace/*";

```



***
### Count Files - Count the total number of files within a given directory & its sub-directories
```

find "/var/log" -type 'f' -name "*" | wc -l;

```



***
### Extension (single) - Find files matching one, single extension
```
### refer to script 'find_basenames_extensions.sh' (in this same repo)
```



***
### Extension (list) - Find files matching at least one extension in a list of extensions (defined by user)
```

LOOK_IN_DIRECTORY="$(getent passwd $(whoami) | cut --delimiter=: --fields=6)"; # Current user's home-directory

GENERIC_WEB_FILES=$(find "${LOOK_IN_DIRECTORY}" -type 'f' \( -iname \*.html -o -iname \*.css -o -iname \*.jpg -o -iname \*.png -o -iname \*.gif -o -iname \*.woff2 \));

echo -e "\nFound $(echo "${GENERIC_WEB_FILES}" | wc -l) files matching at least one extension in '${LOOK_IN_DIRECTORY}'\n";

```



***
### Extensions (count) - Count the number of EACH type of file-extension for files within a given directory (and subdirectories)
##### Note: Listed extensions are case-SENSITIVE (e.g. "PDF", "PdF", and "pdf" will be listed separately)
```

find "/var/log" -type 'f' | sed -e 's/.*\.//' | sed -e 's/.*\///' | sort | uniq -c | sort -rn;

```



***
### Last Modified - Find files modified [ in the last X minutes ( see variable X_MINUTES ) ]
```

X_MINUTES=120;
find "/var/log" -mtime -${X_MINUTES} -ls;

```



***
### Last Modified - Find files modified since [ given timestamp ]
```

find "/var/log" -type 'f' -newermt "2018-09-21 13:25:18";

```



***
### Last Modified - Find files modified since [ given timestamp ] --> ROBUSTIFIED
```

modified_SINCE="3 minutes ago"; # "X [seconds/minutes/hours/weeks/months/years] ago"

modified_SINCE="06/01/2018"; # "MM/DD/YYYY" (previous date)

modified_SINCE="Fri Sep 21 13:30:18 UTC-4 2018"; # specific date-time with relative timezone (UTC-4===EST)

modified_SINCE="@1537551572"; # epoch timestamp (in seconds)

find "/var/log" -type 'f' -newermt "$(date --date="${modified_SINCE}" +'%Y-%m-%d %H:%M:%S')";

```



***
### Last Modified - Find files modified since [ given timestamp (formatted in Epoch seconds) ]
```

find "/var/log" -type 'f' -newermt "$(date --date=@1533742394 +'%Y-%m-%d %H:%M:%S')";

```



***
### Last Modified - Find files modified NO LATER THAN [ given timestamp ]
```

find "/var/log" -type 'f' ! -newermt "2018-09-21 13:25:18";

```



***
### Last Modified - Find files modified NO LATER THAN [ given timestamp ] --> ROBUSTIFIED
```

modified_NO_LATER_THAN="3 months ago"; # "X [seconds/minutes/hours/weeks/months/years] ago"

modified_NO_LATER_THAN="06/01/2018"; # "MM/DD/YYYY" (previous date)

modified_NO_LATER_THAN="Fri Sep 21 13:30:18 UTC-4 2018"; # specific date-time with relative timezone (UTC-4===EST)

modified_NO_LATER_THAN="@1537551572"; # epoch timestamp (in seconds)

find "/var/log" -type 'f' -not -newermt "$(date --date="${modified_NO_LATER_THAN}" +'%Y-%m-%d %H:%M:%S')";

```



***
### Last Modified - Find files modified BETWEEN [ given timestamp ] and [ given timestamp ]
```

modified_AFTER="2018-09-21 10:05:18";

modified_NO_LATER_THAN="2018-09-21 13:37:19";

find '/var/log' -type 'f' -regex '^/var/log/nginx/.*$' -newermt "${modified_AFTER}" ! -newermt "${modified_NO_LATER_THAN}";

```



***
### Ownership (Group) - Find files w/ group ownership equal to GID "1000", then update their group ownership to GID "500"
```

find "/" -gid "1000" -exec chgrp --changes "500" '{}' \;

```



***
### Encoding - Determine a file's encoding (utf-8, ascii, etc.)
```

file -bi '/var/log/nginx/error.log';

```



# Examples



***
### Example - List items whose absolute filepath matches a given name, but do not end with a given extension
#####  ex) Find all Ubuntu "apt" repositories matching "/etc/apt/sources.list"* while ignoring "*.save" files, which are backups of each repo-file (backed-up by apt)
```
find "/etc/apt/sources.list"* \
-type f \
-not -name *".save" \
-exec echo -e '\n→ apt package-repositories in "{}" :' \; \
-exec grep -h ^deb '{}' \; \
;
```



***
### Example - Delete items within a directory older than X days
#####  ex) Cleanup NGINX Logs
```
DIRECTORY_TO_CLEAN="/var/log/nginx/";

OLDER_THAN_DAYS=7;

find ${DIRECTORY_TO_CLEAN} \
-type f \
-mtime +${OLDER_THAN_DAYS} \
-exec printf "$(date +'%Y-%m-%d %H:%M:%S') $(whoami)@$(hostname) | " \; \
-exec rm -v -- '{}' \; \
;

```



***
### Example - Update any files-found which match the source-file's exact same filename & extension
#####  ex) phpMyAdmin login logo
```

# Show the results which will be overwritten
PMA_LOGO_LOGIN="/var/www/html/themes/original/img/logo_right.png" && \
find "/" -name "$(basename ${PMA_LOGO_LOGIN})" -type f -not -path "$(dirname ${PMA_LOGO_LOGIN})/*" -exec echo '{}' \;

# Overwrite the results w/ source-file
PMA_LOGO_LOGIN="/var/www/html/themes/original/img/logo_right.png" && \
find "/" -name "$(basename ${PMA_LOGO_LOGIN})" -type f -not -path "$(dirname ${PMA_LOGO_LOGIN})/*" -exec cp -f "${PMA_LOGO_LOGIN}" '{}' \;

```



***
### Example - Perform multiple actions within a for-loop on any items matching given find-command
#####  ex) phpMyAdmin css searching (for specific class declaration)
```

GREP_STRING=".all100";
for EACH_FILE in $(find "/" -name "*.css*"); do
	GREP_RESULTS="$(cat ${EACH_FILE} | grep -n ${GREP_STRING})";
	if [ -n "${GREP_RESULTS}" ]; then
		echo -e "\n------------------------------------------------------------";
		echo "${EACH_FILE}";
		echo "${GREP_RESULTS}";
	fi;
done;

```



***
### Example - Find files whose file-size is [ GREATER-THAN ], [ LESS-THAN ], or [ BETWEEN ] given value(s)
```

## GREATER-THAN
filesize_GREATER_THAN="1048576c";
find '/var/log' -type 'f' -size "+${filesize_GREATER_THAN}" -printf "% 20s %p\n" | sort --numeric-sort;


## LESS-THAN
filesize_LESS_THAN="1048576c";
find '/var/log' -type 'f' -size "-${filesize_LESS_THAN}" -printf "% 20s %p\n" | sort --numeric-sort;

## BETWEEN
filesize_GREATER_THAN="0c";
filesize_LESS_THAN="1048576c";
find '/var/log' -type 'f' -size "+${filesize_GREATER_THAN}" -size "-${filesize_LESS_THAN}" -printf "% 20s %p\n" | sort --numeric-sort;

```


***
#### MAN (manual) - The following is a paraphrased excerpt from running the command [ man find ] on Ubuntu 18.04, 2019-06-03 18-11-11:
```

man find

'...
      
     -size n[cwbkMG]
      'b' for 512-byte blocks (default)
      'c' for bytes
      'w' for two-byte words
      'k' for Kibibytes (KiB, 1024 bytes)
      'M' for Mebibytes (MiB, 1048576 bytes)
      'G' for Gibibytes (GiB, 1073741824 bytes)
      
       The size does not count indirect blocks, but it does count blocks in sparse files that are not actually
       allocated.  Bear in mind that the `%k' and `%b' format specifiers of -printf handle sparse  files  dif‐
       ferently.  The `b' suffix always denotes 512-byte blocks and never 1024-byte blocks, which is different
       to the behaviour of -ls.
      
       The + and - prefixes signify greater than and less than, as usual; i.e., an exact size of n units  does
       not  match.   Bear  in  mind  that  the size is rounded up to the next unit. Therefore -size -1M is not
       equivalent to -size -1048576c.  The former only matches empty files, the latter matches files from 0 to
       1,048,575 bytes.
      
...'

```



***
# Citation(s)
### linux.die.net  |  "find(1) - Linux man linux"  |  https://linux.die.net/man/1/find
