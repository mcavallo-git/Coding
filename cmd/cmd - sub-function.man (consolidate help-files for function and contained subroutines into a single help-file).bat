@ECHO OFF

SET LOGFILE="%USERPROFILE%\Desktop\reg.cmd.man"

REG /? > %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG ADD /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG COMPARE /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG COPY /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG DELETE /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG EXPORT /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG FLAGS /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG IMPORT /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG LOAD /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG QUERY /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG RESTORE /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG SAVE /? >> %LOGFILE%
ECHO ------------------------------------------------------------ >> %LOGFILE%
REG UNLOAD /? >> %LOGFILE%
