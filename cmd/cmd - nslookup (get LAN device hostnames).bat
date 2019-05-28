@REM NOTE: Replace "192.168.0." with subnet to be scanned for devices

SET SUBNET=192.168.0.

FOR /L %%N IN (1,1,254) DO @nslookup %SUBNET%%%N %SUBNET%1 >> DeviceHostnamesLAN.txt

TIMEOUT -T 60
