@ECHO OFF

REM SWAP  "192.168.0." with the first-three numbers of your subnet's IPv4, or just grab your current IPv4 and use it's first 3 numbers
SET SUBNET=192.168.0.

FOR /L %%N IN (1,1,254) DO @nslookup %SUBNET%%%N %SUBNET%1 >> %USERPROFILE%\Desktop\LAN_Hostnames.txt

TIMEOUT -T 60
