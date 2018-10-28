

# [touch(1) - Linux man page](https://linux.die.net/man/1/touch)
***


### Create a file
```

touch "~/example_file_name.txt";

```
***


### Set the last-modified date for a file
```

# Set date w/ format: YYYY-MM-DD HH:MM:SS
touch -d "$(date -R --date='2018-10-01 14:54:22')" "~/example_file_name.txt";

# Set date w/ format: @Unix-Seconds
touch -d "$(date -R --date='@1539785880')" "~/example_file_name.txt";

# Set date w/ format: Default Linux 'ls' date
touch -d "$(date -R --date='Oct 01 2018 14:53')" "~/example_file_name.txt";

```
***
