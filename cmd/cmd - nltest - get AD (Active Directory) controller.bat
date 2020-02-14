@ECHO OFF


REM Determine AD Controller that current session is using/pointing-to
nltest /dsgetdc:%USERDOMAIN%
PAUSE


REM Find other AD Controllers in the Forest
nltest /dclist:%USERDOMAIN%
PAUSE


REM Locate KDCs (Kerberos "Key Distribution Centers" - Each DC should include this service)
nslookup -type=srv _kerberos._tcp.%USERDNSDOMAIN%
PAUSE


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM		docs.microsoft.com  |  "DsGetDcOpenA function"  |  https://docs.microsoft.com/en-us/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcopena
REM
REM		ss64.com  |  "NLTEST.exe"  |  https://ss64.com/nt/nltest.html
REM
REM ------------------------------------------------------------