REM ------------------------------------------------------------
REM
REM cmd - Reset (local) Windows Administrator's Password
REM
REM ------------------------------------------------------------


REM Boot to bootable Windows PE media (create Windows Installation Media w/ a thumb drive if you don't have any)


REM Backup Utilman.exe
COPY /Y C:\Windows\System32\Utilman.exe C:\Windows\System32\Utilman.bak.exe


REM Overwrite Utilman.exe with cmd.exe
COPY /Y C:\Windows\System32\cmd.exe C:\Windows\System32\Utilman.exe


REM Restart the computer
SHUTDOWN /R /T 0

REM  !!!
REM   After machine has rebooted and is back at the login screen, click the "Ease of Access" button (bottom right) to open a command prompt - THIS IS AN ADMIN COMAND PROMPT
REM  !!!


REM Reset desired user's password
NET USER Administrator /active:yes
NET USER Administrator "example_password"


REM If username is not known, inspect all users via...
NET USER


REM If needed, convert Microsoft Account to Local Account (Win8/10 only)
REM (Manually done in windows)


REM Log in using the freshly reset password


REM Restore Utilman.exe from Utilman.bak.exe
COPY /Y C:\Windows\System32\Utilman.bak.exe C:\Windows\System32\Utilman.exe


REM  Restart your computer; create a password reset disk.
SHUTDOWN /R /T 0


REM ------------------------------------------------------------
REM 
REM  Citation(s)
REM 
REM   www.infopackets.com  |  "How to Reset Admin Password for Windows Vista, 7, 8 and 10"  |  https://www.infopackets.com/news/9483/how-reset-any-password-windows-vista-7-8-10
REM 
REM ------------------------------------------------------------