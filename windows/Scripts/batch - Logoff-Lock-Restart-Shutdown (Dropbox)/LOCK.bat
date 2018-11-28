
@ECHO OFF
  
  REM    Created by 
  REM      [ Matt Cavallo ]
  REM      [ mcavallo@boneal.com ]
  REM      [ 2017-11-30 ]
  
  REM   Get the Username of the Current User
SET USERNAME_TARGET=%username%

  REM   Find Session-ID tied to specified user
SET USER_SESSION_ID=NOTFOUND
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %USERNAME_TARGET%') DO (
  @IF "%%b"=="Active" (
    SET USER_SESSION_ID=%%a
  )
)

 REM   If a Session is found for this Username
 REM     ( If this User is currently logged in )
IF NOT %USER_SESSION_ID%==NOTFOUND (

    REM   Lock the Workstation
  RUNDLL32 USER32.DLL,LockWorkStation
  
    REM   Wait 1 second so that the user may have immediate visual
    REM   confirmation (reassurance) that the PC is locked before we
    REM   close user's connection to host
  TIMEOUT /T 1 > NUL
  
    REM   Kill the RDP Session
    REM   (Closes the Remote-Deskop window on the Client's End)
  TSDISCON %USER_SESSION_ID%
  
)

  REM  If Session wasn't found (etc.) show this instead
  REM  of immediately closing the CMD window
TIMEOUT /T 30