

SET DOMAIN_NAME=domain.com

REM Determine AD Controller that current session is using/pointing-to
nltest /dsgetdc:%DOMAIN_NAME%

REM Find other AD Controllers in the Forest
nltest /dclist:%DOMAIN_NAME%


PAUSE

EXIT

REM Citation(s)
REM
REM		ss64.com, "NLTEST.exe"
REM		https://ss64.com/nt/nltest.html
REM