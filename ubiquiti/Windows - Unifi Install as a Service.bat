@ECHO OFF

REM 
REM Install Java
REM   |
REM   |--> Updated Installer - Java SE (Standard Edition, Win10) --> https://www.java.com/en/download/win10.jsp

REM Install Unifi Controller
REM   |
REM   |--> Updated Installer - UniFi Controller for Windows --> https://www.ui.com/download/unifi

REM Open a Command Prompt (CMD.exe) as admin & run the following commands:

cd "%USERPROFILE%\Ubiquiti UniFi\"

java -jar lib\ace.jar installsvc

java -jar lib\ace.jar startsvc

REM
REM Verify completion by restarting machine, making sure you don't see the software running after you login (also check taskbar/notification area), then browse to https://localhost:8443/
REM   |
REM   |--> If the page loads the unifi controller, then you have configured the service as-intended
REM

REM ------------------------------------------------------------
REM Citation(s)
REM
REM   help.unifi.com  |  "UniFi - How to Install & Upgrade the UniFi Network Controller Software"  |  https://help.ubnt.com/hc/en-us/articles/360012282453-UniFi-How-to-Install-Upgrade-the-UniFi-Network-Controller-Software#4
REM 
REM   help.unifi.com  |  "UniFi - Run the Controller as a Windows Service"  |  https://help.ubnt.com/hc/en-us/articles/205144550-UniFi-Run-the-Controller-as-a-Windows-service
REM
REM ------------------------------------------------------------