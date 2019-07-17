@ECHO OFF

REM *** WINDOWS FAX AND SCAN - Set the default scan save location to a different folder other than [My Documents -> Scanned Documents]

SET "SOURCE=%USERPROFILE%\Documents\Scanned Documents"

SET "DESTINATION=%USERPROFILE%\Desktop"

ROBOCOPY "%SOURCE%" "%DESTINATION%" /COPYALL /DCOPY:T /E /MOVE

DEL /F /S "%SOURCE%"

MKLINK /D "%SOURCE%" "%DESTINATION%"
