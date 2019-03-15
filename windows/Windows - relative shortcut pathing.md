# Windows - relative shortcut pathing

#### Example

* Begin at the Windows desktop, located at "%USERPROFILE%\Desktop".
*Note that this we will be making use of the environment variable "%USERPROFILE%", which, by default, is the user directory located at "C:\Users\YOUR_USER"*

***
* Create a folder on the desktop named "test_rel"
*Perform this step via cmd:*
```
mkdir %USERPROFILE%\Desktop\test_rel

```

***
* Within the newly created "test_rel" directory, create a new file named "index.html" with the contents: '<div style="font-size:50px;">Hello World</div>'
*Perform this step via cmd:*
```
ECHO ^<div style=^"font-size:24px;^"^>This shortcut contains a working directory, or 'Start in' of ^%cd^%, which resolves to [ %USERPROFILE%\Desktop\test_rel ].^<br^>This file was targeted relatively off of the working directory as, simply, index.html. No fullpath needed^</div^> > "%USERPROFILE%\Desktop\test_rel\index.html"

``` 

***
* Right-click newly created "test_rel" directory create a new -> shortcut
--> Type the location of the item: "%PROGRAMFILES%\Mozilla Firefox\firefox.exe" index.html
--> Type a name for this shortcut: relative_shortcut
--> Right click the complete shortcut --> Properties (or Alt+DoubleClick) --> Set the value for 'Start in' to "%cd%"
*Perform this step via cmd:*
```
SET TargetPath='"%PROGRAMFILES%\Mozilla Firefox\firefox.exe"'
SET Arguments='"index.html"'
SET FullName='%USERPROFILE%\Desktop\test_rel\relative_shortcut.lnk'
SET WorkingDirectory='%cd%'
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut(%FullName%); $S.TargetPath=(%TargetPath%); $S.Arguments=(%Arguments%); $S.WorkingDirectory=('%'+'c'+'d'+'%'); $S.Save(); $S.FullName;"

```


