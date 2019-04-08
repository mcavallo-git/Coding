
***
# Windows Symbolic Links (mklink)


***
### * Syntax (mklink)
###### Note: The file/directory [LINK] must not already exist (or mklink will fail)
```
mklink /d "[LINK]" "[TARGET]"
```


***
### * Syntax (mklink)
###### Note: Outputs results to desktop
```
DIR /AL /S %SYSTEMDRIVE% | find "SYMLINK" > %USERPROFILE%\Desktop\all-symlinks.txt
```


***
### * Examples (mklink) - Windows Fax and Scan
##### Redirects the default scan save location (for the current user) to save to their desktop, instead
```
mklink /d "%USERPROFILE%\Documents\Scanned Documents" "%USERPROFILE%\Desktop"
```

