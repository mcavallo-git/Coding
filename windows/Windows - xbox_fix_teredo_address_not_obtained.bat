REM ------------------------------------------------------------
REM
REM Hotfix for Windows10 Xbox App's Networking > NAT Error message:
REM   "Teredo is unable to qualify - This may impact your ability to play multiplayer games"
REM
REM ------------------------------------------------------------
REM
REM METHOD 1
REM

REM
REM   1. Press the Windows button on your device or keyboard, or you can select the Windows icon in the lower-left corner of the main screen.
REM
REM   2. Select Settings > Gaming, and then select Xbox Networking.
REM
REM   3. Select Fix it. Windows will try to detect and fix known issues with Teredo. Note You might need to restart your PC for changes to take effect after pressing the Fix it button.
REM


REM ------------------------------------------------------------
REM
REM METHOD 2 (relable back in 2016-2017)
REM

REM
REM   1. Open Win + X menu and choose Device Manager from the list.
REM 
REM   2. When Device Manager opens, go to View and select Show hidden devices from the menu.
REM 
REM   3. Locate Teredo in the Network Adapters section, right-click it and choose Uninstall device. Repeat this for all Teredo devices.
REM 
REM   4. Uninstall anything you see with “Teredo” in it from the right-click menu
REM 
REM   5. Restart your PC and re-enable Teredo with this line in Command Prompt (Admin): netsh interface Teredo set state type=default
REM 
REM   6. Make sure to NOT manually install the Teredo Tunneling Pseudo-Interface adapter as it might cause trouble since it reinstalls automatically
REM


REM ------------------------------------------------------------
REM
REM METHOD 2 (less relable)
REM

NETSH interface Teredo set state disable
TIMEOUT /T 3
NETSH interface Teredo set state type=default


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   support-origin.xbox.com  |  "NAT Type Displays Teredo Is Unable to Qualify | Xbox Console Companion App on Windows 10"  |  https://support-origin.xbox.com/th-TH/xbox-on-windows/social/troubleshoot-party-chat
REM
REM   windowsreport.com  |  "FULL FIX: Teredo is unable to qualify error - Xbox Guides"  |  https://windowsreport.com/teredo-is-unable-to-qualify-fix/
REM
REM ------------------------------------------------------------