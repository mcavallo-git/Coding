
REM https://windowsreport.com/teredo-is-unable-to-qualify-fix/

NETSH interface Teredo set state disable

TIMEOUT /T 3

NETSH interface Teredo set state type=default

