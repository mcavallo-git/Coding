@ECHO OFF
REM ------------------------------------------------------------
REM
REM Update Certificates used by Windows-based NGINX Server
REM
REM ------------------------------------------------------------
REM RUN THIS SCRIPT
REM
REM
REM   "C:\nginx\certs\nginx-update-certs.bat"
REM
REM
REM ------------------------------------------------------------

NET STOP NGINX-Service

DEL /F "c:\nginx\certs\wildcard.domain.tld\fullchain.pem"
MKLINK "c:\nginx\certs\wildcard.domain.tld\fullchain.pem" "c:\nginx\certs\wildcard.domain.tld_expires-yyyy-MM-ddTHH-mm-ssZ\pem-format\fullchain.pem"

DEL /F "c:\nginx\certs\wildcard.domain.tld\privkey.pem"
MKLINK "c:\nginx\certs\wildcard.domain.tld\privkey.pem" "c:\nginx\certs\wildcard.domain.tld_expires-yyyy-MM-ddTHH-mm-ssZ\pem-format\privkey.pem"

DEL /F "c:\nginx\certs\wildcard.domain.tld\chain.pem"
MKLINK "c:\nginx\certs\wildcard.domain.tld\chain.pem" "c:\nginx\certs\wildcard.domain.tld_expires-yyyy-MM-ddTHH-mm-ssZ\pem-format\chain.pem"

NET START NGINX-Service

TIMEOUT /T 60
