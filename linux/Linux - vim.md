# [vim(1) - Linux man page](https://linux.die.net/man/1/vim)
***

### Opening a file w/ Vim
##### Calling:
```vim ~/some/filepath;```
##### will perform:
###### Attempt to open the file in Vim (if filepath is accessible & file exists)
###### Attempt to create the file & open it in Vim (if filepath is accessible & file doesn't exist)
###### Error-out with error displayed (if filepath is inaccessible)

***

### Vim - Basic Shortcuts

Intended Outcome | Environment | Keystroke | (cont.) | (cont.) |
--- | --- | --- | --- | ---
Open file with Vim | Linux Bash | ```vim "~/some/really long/file path";``` | | 
Stop editing<br>(Leave 'insert' mode) | Vim (while running) | Esc | | 
Start editing<br>(Enter 'insert' mode) | Vim (while running) | Esc | i | Enter
Save changes to file | Vim (while running) | Esc | :w | Enter
Exit Vim | Vim (while running) | Esc | :q | Enter
Save changes &<br>Exit Vim | Vim (while running) | Esc | :wq | Enter

***

### Vim - Advanced Shortcuts

Intended Outcome | Environment | Keystroke | (cont.) | (cont.) |
--- | --- | --- | --- | ---
Delete all lines in file | Vim (while running) | Esc | :1,$d | Enter
Remove all blank lines (aka any<br>lines with only spaces, tabs, & newlines) | Vim (while running) | Esc | :g/^$/d | Enter

***

##### References
######  :g/^$/d  -  2018-06-18 from user 'soulmerge' on [Stack Overflow](https://stackoverflow.com/questions/706076/vim-delete-blank-lines]
