@ECHO OFF

REM *** WINDOWS FAX AND SCAN - Set the default scan save location to a different folder other than [My Documents -> Scanned Documents]

SET "LINK_PATH=%USERPROFILE%\Documents\Scanned Documents"

SET "TARGET_PATH=%USERPROFILE%\Desktop"

ROBOCOPY "%LINK_PATH%" "%TARGET_PATH%" /COPYALL /DCOPY:T /E /MOVE

DEL /F /S "%LINK_PATH%"

MKLINK /D "%LINK_PATH%" "%TARGET_PATH%"

REM View a list of symbolic links
REM 
REM DIR /AL /S "%USERPROFILE%\"
REM

TIMEOUT /T 60
