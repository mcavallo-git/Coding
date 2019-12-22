<!-- 

This file (on GitHub):

https://github.com/mcavallo-git/Coding/search?q=%22relative+shortcut%22

-->

# Windows - relative shortcut pathing


### URL shortcut which opens in FireFox (specifically)
*Note that this we will be making use of the environment variable "%USERPROFILE%", which, by default, is the user directory located at "C:\Users\YOUR_USER"*
* Begin at your Windows Desktop, located at "%USERPROFILE%\Desktop"
* Create a folder on the desktop named "test_rel"
* Within the newly created "test_rel" directory, create a new file named "index.html" with some arbirary HTML contents
* Right-click newly created "test_rel" directory create a new -> shortcut
--> Type the location of the item: "%PROGRAMFILES%\Mozilla Firefox\firefox.exe" index.html
--> Type a name for this shortcut: relative_shortcut
--> Right click the complete shortcut --> Properties (or Alt+DoubleClick) --> Set the value for 'Start in' to "%cd%"
* Attempt to open the "relative_shortcut" Hyperlink (by double-clicking it in Windows Explorer)
* If Firefox opens w/ the HTML you entered, you have completed this tutorial! Otherwise, if you don't have firefox installed etc. tinker with it to fix and learn it! You got this
*To automatically perform the above step(s) via CMD:*
```
mkdir "%USERPROFILE%\Desktop\test_rel"
ECHO ^<div style=^"font-size:24px;^"^>This shortcut contains a working directory, or 'Start in' of ^%cd^%, which resolves to [ %USERPROFILE%\Desktop\test_rel ].^<br^>This file was targeted relatively off of the working directory as, simply, index.html. No fullpath needed^</div^> > "%USERPROFILE%\Desktop\test_rel\index.html"
SET TargetPath='"%PROGRAMFILES%\Mozilla Firefox\firefox.exe"'
SET Arguments='"index.html"'
SET FullName='%USERPROFILE%\Desktop\test_rel\relative_shortcut.lnk'
SET WorkingDirectory='%cd%'
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut(%FullName%); $S.TargetPath=(%TargetPath%); $S.Arguments=(%Arguments%); $S.WorkingDirectory=('%'+'c'+'d'+'%'); $S.Save(); $S.FullName;"
explorer.exe "mkdir %USERPROFILE%\Desktop\test_rel"
```
***
* If you have a shortcut which opens in a browser, you have completed this tutorial! Otherwise, if you don't have firefox installed etc. tinker with it to fix and learn it! You got this


### Directory shortcut which opens in Windows Explorer
* Open the directory you want to place the shortcut in -> Right Click (whitespace) -> "New" -> "Shortcut"
* In the field ```Type the location of the item```, enter:
```
%windir%\explorer.exe "..\."
```
* Hit Enter or Select "Next" to continue
* In the field ```Type a name for this shortcut:```, enter:
```
Open parent directory
```
* Hit Enter or Select "Finish" to create the shortcut
* Right-Click the newly created Shortcut -> "Properties"
* Remove/Backspace all characters in the ```Start in:``` field (make sure it is empty) -> Select "OK" to update the shortcut
* Attempt to open the shortcut (by double-clicking it in Windows Explorer)


<!-- ------------------------------------------------------------ -->

<!-- Citation(s) -->

<!--   stackoverflow.com  |  "Making a Windows shortcut start relative to where the folder is?"  |  https://stackoverflow.com/a/8163798 -->

<!-- ------------------------------------------------------------ -->