@ECHO OFF

REM *** WINDOWS FAX AND SCAN - Set the default scan save location to a different folder other than [My Documents -> Scanned Documents]

SET "LINK_PATH=%USERPROFILE%\Documents\Scanned Documents"

SET "TARGET_PATH=%USERPROFILE%\Desktop"

REM Move all items from current destination for scanned-items
REM 
REM ROBOCOPY "%LINK_PATH%" "%TARGET_PATH%" /COPYALL /DCOPY:T /E /MOVE
REM 
REM DEL /F /S "%LINK_PATH%"
REM

MKLINK /D "%LINK_PATH%" "%TARGET_PATH%"

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

SET "LINK_PATH=C:\ProgramData\DockerDesktop\vm-data"
SET "TARGET_PATH=D:\%USERNAME%\ProgramData\DockerDesktop\vm-data"
MKLINK /D "%LINK_PATH%" "%TARGET_PATH%"


REM ------------------------------------------------------------