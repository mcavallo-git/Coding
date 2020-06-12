

REM Get a list of RDP (Remote Desktop) sessions which are connected to localhost (current server/workstation)
query session


REM Get a list of RDP (Remote Desktop) sessions which are connected to target server/workstation
SET HOST="servername"
query session /server:%HOST%


REM AD-Environment/Forced-Domain (avoid resolution of target host's domain-name) - Get a list of RDP (Remote Desktop) sessions which are connected to target server/workstation
SET HOST="servername.%USERDNSDOMAIN%"
query session /server:%HOST%


REM The [ qwinsta ] command is the same as the [ query session ] command.
qwinsta


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "query-session"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/query-session
REM
REM   docs.microsoft.com  |  "qwinsta"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/qwinsta
REM
REM ------------------------------------------------------------