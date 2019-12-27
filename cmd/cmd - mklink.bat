@ECHO OFF
REM 
REM MKLINK /D "%NEW_LINK%" "%EXISTENT_TARGET%"
REM 
REM ------------------------------------------------------------
REM 
REM *** WINDOWS FAX AND SCAN - Set the default scan save location to a different folder other than [My Documents -> Scanned Documents]

SET "NEW_LINK=%USERPROFILE%\Documents\Scanned Documents"

SET "EXISTENT_TARGET=%USERPROFILE%\Desktop"

REM Move all items from current destination for scanned-items
REM 
REM ROBOCOPY "%NEW_LINK%" "%EXISTENT_TARGET%" /COPYALL /DCOPY:T /E /MOVE
REM 
REM DEL /F /S "%NEW_LINK%"
REM

MKLINK /D "%NEW_LINK%" "%EXISTENT_TARGET%"


REM 
REM Link local user's Pictures (Bing Backgrounds & Windows Spotlight) to Local OneDrive Directory's Pictures
REM 
REM MKLINK /D "%USERPROFILE%\Pictures\Bing Backgrounds" "%OneDrive%\Images\Wallpapers\Bing Backgrounds"
REM 
REM MKLINK /D "%USERPROFILE%\Pictures\Windows Spotlight" "%OneDrive%\Images\Wallpapers\Windows Spotlight"
REM 


REM View a list of MKLINKs (symbolic links) associated with target, to verify that the new MKLINK was created as-intended
REM 
REM DIR /AL /S "%USERPROFILE%\"
REM

TIMEOUT /T 60
EXIT 1

REM ------------------------------------------------------------
REM
REM   Docker Desktop - Link VM-Data to different directory
REM

SET "NEW_LINK=C:\ProgramData\DockerDesktop\vm-data"
SET "EXISTENT_TARGET=D:\%USERNAME%\ProgramData\DockerDesktop\vm-data"
MKLINK /D "%NEW_LINK%" "%EXISTENT_TARGET%"


REM ------------------------------------------------------------