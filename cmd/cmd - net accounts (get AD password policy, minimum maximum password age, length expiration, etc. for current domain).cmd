@ECHO OFF
REM ------------------------------------------------------------
REM 
REM cmd - net accounts (get AD password policy, minimum maximum password age, length expiration, etc. for current domain)
REM 
REM ------------------------------------------------------------

REM Show current domain
cmd /c echo %USERDOMAIN%


REM Check Password Policy (for current Domain)
net accounts


REM ------------------------------------------------------------