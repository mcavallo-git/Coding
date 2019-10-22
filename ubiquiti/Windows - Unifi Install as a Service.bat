@ECHO OFF

REM ------------------------------------------------------------
REM Install "Java SE"
REM   |--> https://www.java.com/en/download/win10.jsp
REM
REM ------------------------------------------------------------
REM Install "UniFi Controller for Windows"
REM   |--> https://www.ui.com/download/unifi
REM
REM ------------------------------------------------------------
REM Open the controller to allow the software to setup its
REM database, confirm UAC checks, etc.

"%USERPROFILE%\Ubiquiti UniFi\lib\ace.jar" ui




REM ------------------------------------------------------------
REM Install Java-based Unifi Service
REM   |--> Hit Start on your Keyboard
REM    |--> Type "cmd"
REM     |--> (Combo keyboard+mouse press) Ctrl + Shift + Left-Click the returned "cmd.exe" in the start menu to "Run as Admin"
REM      |--> Copy/Paste the following commands, one-by-one

cd "%USERPROFILE%\Ubiquiti UniFi\"
java -jar lib\ace.jar installsvc
java -jar lib\ace.jar startsvc


REM
REM ------------------------------------------------------------
EXIT


REM ------------------------------------------------------------
REM If, Later, you wish to remove the controller service (upgraded to
REM Cloud-Key, removing all Unifi devices, etc.), run the following
REM command in an admin CMD promptto remove the service:

cd "%USERPROFILE%\Ubiquiti UniFi\"
java -jar lib\ace.jar uninstallsvc


REM ------------------------------------------------------------
REM Verify Working State
REM   |--> Restart machine (to get on a fresh slate, or if you want yo call it simulating the havoc of day-to-day use, that's fine, too)
REM    |--> After reboot, log back in and make sure not to open the Unifi controller software
REM     |--> Also, check taskbar/notification area to make sure you cant see it running (it should be running as a background service any time the PC is on)
REM      |--> Browse to the webpage https://localhost:8443/
REM       |--> If the page loads the unifi controller, then you have configured the service as-intended
REM
REM ------------------------------------------------------------
REM Citation(s)
REM
REM   help.unifi.com  |  "UniFi - How to Install & Upgrade the UniFi Network Controller Software"  |  https://help.ubnt.com/hc/en-us/articles/360012282453-UniFi-How-to-Install-Upgrade-the-UniFi-Network-Controller-Software#4
REM 
REM   help.unifi.com  |  "UniFi - Run the Controller as a Windows Service"  |  https://help.ubnt.com/hc/en-us/articles/205144550-UniFi-Run-the-Controller-as-a-Windows-service
REM
REM ------------------------------------------------------------