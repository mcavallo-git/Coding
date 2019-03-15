@ECHO OFF

REM	takeown
REM		Enables an administrator to recover access to a file that previously was denied, by making the administrator the owner of the file.


REM Syntax
REM		takeown /r  :::  Performs a recursive operation on all files in the specified directory and subdirectories.
REM		takeown /f  :::  Specifies the file name or directory name pattern. You can use the wildcard character * when specifying the pattern. You can also use the syntax ShareName*FileName*.



REM Recursively take ownership over a directory (and all subcontents within)
set DirPathToOwn="C:\path\to\folder\to\own"
takeown /f %DirPathToOwn% /r



REM Recursively take ownership over an entire disk parition volume (and all subcontents within)
set VolumeToOwn="E:"
takeown /f %VolumeToOwn% /r



REM Citation(s)
REM
REM		docs.microsoft.com, "takeown"
REM		https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/takeown
REM
