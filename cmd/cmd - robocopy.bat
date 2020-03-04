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
REM                   /IS : Include Same files.
REM                    /Z : Copy files in restartable mode (survive network glitch). 
REM


REM ------------------------------------------------------------

REM		Robocopy Examples...

REM ------------------------------------------------------------

REM Mirrors source folder to destination folder
REM 	** OVERWRITES existing files in destination folder (/mir)
REM 	** PRESERVES file integrity (/dcopy:t)
REM 	** IGNORES text files (/xf *.txt)
REM 	** LOGS (appending) to a log file (/log+:".\Robo_Logfile.txt")

ROBOCOPY %SOURCE% %DESTINATION% /mir /dcopy:t /xf *.txt /log+:".\Robo_Logfile.txt"


REM ------------------------------------------------------------

REM Mirrors source folder to destination folder
REM 	** OVERWRITES existing files in destination folder (/mir)
REM 	** IGNORES files from source (/xd)

ROBOCOPY %SOURCE% %DESTINATION% /mir /copyall /xc /xo /xn /xd C:\Projects\pikebk


REM ------------------------------------------------------------

REM Appends files from source folder to destination folder
REM 	** IGNORES files which are newer on destination than sourcew (/xo)
REM 	** RETRIES 2x per-file (if file is in use, etc.) and waits 5s each attempt (/w:5 /r:2)
REM 	** PRESERVES file integrity (/dcopy:t)
REM 	** LOGS (appending) to a log file (/log+:".\Robo_Logfile.txt")
REM 	** RECURSES into subfolders, including empty subfolders (/e)

ROBOCOPY %SOURCE% %DESTINATION% /xo /dcopy:t /e /w:5 /r:2 /log+:".\Robo_Logfile.txt"


REM ------------------------------------------------------------

REM Ex) Recursively copy directories & subcontents to another drive (/e)
REM     Allow for ability to run same command later just to update destination w/ newer files from source (/xo)


ROBOCOPY "E:\SOURCE" "F:\DESINATION" /xo /dcopy:t /e /w:5 /r:2 /log+:"C:\ISO\Robo_Logfile.txt""


REM ------------------------------------------------------------
REM 
REM XCOPY: avoid using it
REM 	XCopy cannot copy files with "fully qualified name" (full filepath) over 254 characters long
REM 		(254 characters is apparently the windows maximum path length)
REM 
REM 
REM ------------------------------------------------------------
REM 
REM COPY: much less robust than Robocopy
REM		*Using "Copy" to copy files from source to local folder
REM 
REM 
REM ECHO Please do not close, copying file(s)...
REM COPY "\\lan-server\dir1\dir2\filename.exe" "%~dp0\filename.exe"
REM 
REM 
REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   ss64.com  |  "Robocopy "Robust File Copy" - Windows CMD - SS64.com"  |  https://ss64.com/nt/robocopy.html
REM
REM ------------------------------------------------------------