@ECHO OFF
REM		Moves all files, folders, and subfolders from current directory into Source directory (excludes self, logfile, and EXCLUDE_FILES below, removes from Source)

SET SOURCE=.\

SET DESTINATION=..\___COMPLETE

SET LOGFILE="log.txt"

SET "EXCLUDE_FILE1=%0"

SET "EXCLUDE_FILE2=%LOGFILE%"

SET EXCLUDE_FILE3="SomeExcludedFile.txt"

ROBOCOPY %SOURCE% %DESTINATION% /COPYALL /DCOPY:T /E /MOVE /R:2 /W:5 /XF %EXCLUDE_FILE1% %EXCLUDE_FILE2% %EXCLUDE_FILE3% /IS /Z 

EXIT

REM
REM         Robocopy Usage: https://ss64.com/nt/robocopy.html 
REM
REM              /COPYALL : Copy ALL file info (equivalent to /COPY:DATSOU).
REM              /DCOPY:T : Copy Directory Timestamps.
REM                    /E : Copy Subfolders, including Empty Subfolders.
REM            /LOG+:file : Output status to LOG file (overwrite existing log). (Off for this program)
REM                  /R:n : number of Retries
REM    /XD dirs [dirs]... : eXclude Directories matching given names/paths.
REM    /XF file [file]... : eXclude Files matching given names/paths/wildcards.
REM                  /W:n : Wait time between retries - default is 30 seconds.
REM                    /Z : Copy files in restartable mode (survive network glitch). 
REM


REM ------------------------------------------------------------------------------------------------------------------------------

REM		Robocopy Examples...

REM ------------------------------------------------------------------------------------------------------------------------------

REM mirrors source folder to destination folder
REM 	** OVERWRITES existing files in destination folder (/mir)
REM 	** PRESERVES file integrity (/dcopy:t)
REM 	** IGNORES text files (/xf *.txt)
REM 	** LOGS (appending) to a log file (/log+:".\Robo_Logfile.txt")

ROBOCOPY %SOURCE% %DESTINATION% /mir /dcopy:t /xf *.txt /log+:".\Robo_Logfile.txt"

REM ------------------------------------------------------------------------------------------------------------------------------

REM mirrors source folder to destination folder
REM 	** OVERWRITES existing files in destination folder (/mir)
REM 	** IGNORES files from source (/xd)

ROBOCOPY %SOURCE% %DESTINATION% /mir /copyall /xc /xo /xn /xd C:\Projects\pikebk

REM ------------------------------------------------------------------------------------------------------------------------------

REM appends files from source folder to destination folder
REM 	** ignores old source files if destination file is newer
REM 	** if file is in use [ wait 5 seconds, then retry ] twice

ROBOCOPY %SOURCE% %DESTINATION% /xo /dcopy:t/e /w:5 /r:2

REM ------------------------------------------------------------------------------------------------------------------------------

REM XCOPY: avoid using it
REM 	XCopy cannot copy files with "fully qualified name" (full filepath) over 254 characters long
REM 		(254 characters is apparently the windows maximum path length)

REM ------------------------------------------------------------------------------------------------------------------------------

REM COPY: much less robust than Robocopy
REM		*Using "Copy" to copy files from source to local folder
REM 

ECHO Please do not close, copying file(s)...

COPY "\\lan-server\dir1\dir2\filename.exe" "%~dp0\filename.exe"

REM ------------------------------------------------------------------------------------------------------------------------------

REM Citation(s)
REM  ss64.com, "Robocopy.exe"  :::  https://ss64.com/nt/robocopy.html

REM ------------------------------------------------------------------------------------------------------------------------------