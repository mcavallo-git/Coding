@ECHO OFF



REM
REM Date
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`DATE /T`) DO SET CURRENT_DATE=%%F



REM
REM	Time
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`TIME /T`) DO SET CURRENT_TIME=%%F



REM
REM	Timestamp (e.g. Date & Time)
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`DATE /T`) DO SET TIMESTAMP=%TIMESTAMP%%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`TIME /T`) DO SET TIMESTAMP=%TIMESTAMP%%%F



REM
REM	Show Results (for debugging)
REM
ECHO.
ECHO	CURRENT_DATE = %CURRENT_DATE%
ECHO.
ECHO	CURRENT_TIME = %CURRENT_TIME%
ECHO.
ECHO	TIMESTAMP = %TIMESTAMP%



ECHO.
REM
REM Wait to close (to view output before the window closes)
REM
TIMEOUT /T 30


