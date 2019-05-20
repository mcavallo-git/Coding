
# ESET
## Exclusion List

***
## Location in-software
``` "Advanced Setup" -"Detection Engine" (Left) -"Basic" (Right) -"Exclusions" -"Edit") ```

***
### Precursor
``` ESET's string-matching requires "\*.*" to exclude all items in a directory   -MCavallo, 2018-02-01 ```

***
### Exclusion list - AV-Collision Avoidance
```
%PROGRAMFILES%\Malwarebytes\*.*
%PROGRAMFILES(X86)%\Malwarebytes' Anti-Malware\*.*
%PROGRAMFILES(X86)%\Malwarebytes Anti-Exploit\*.*
```

***
### Exclusion list - General
```
%LOCALAPPDATA%\GitHubDesktop\*.*
%LOCALAPPDATA%\Programs\Microsoft VS Code\*.*
%LOCALAPPDATA%\Programs\Git\*.*
```
```
%ONEDRIVE%\*.*
%ONEDRIVECOMMERCIAL%\*.*
```
```
%PROGRAMFILES%\Git\*.*
%PROGRAMFILES%\Mailbird\*.*
%PROGRAMFILES%\nodejs\*.*
%PROGRAMFILES%\Microsoft VS Code\*.*
%PROGRAMFILES%\PowerShell\*.*
```
```
%PROGRAMFILES(X86)%\efs\*.*
%PROGRAMFILES(X86)%\FileZilla FTP Client\*.*
%PROGRAMFILES(X86)%\Mailbird\*.*
%PROGRAMFILES(X86)%\Microsoft Office\*.*
%USERPROFILE%\Dropbox\*.*
%USERPROFILE%\Documents\GitHub\*.*
```

### Exclusion list - Process Exclusions
```
C:\Program Files\PowerShell\6\pwsh.exe
C:\Program Files\Git\cmd\git.exe
```
