REM ------------------------------------------------------------
REM
REM Windows - Default run commands to-remember (.msc, .cpl, .exe)
REM 
REM ------------------------------------------------------------
REM 
REM How to run Control Panel tools by typing a command [ cited in "Citation(s)", below ]
REM 

control access.cpl		REM Accessibility Options 
control sysdm.cpl add new hardware		REM Add New Hardware 
control appwiz.cpl		REM Add/Remove Programs 
control timedate.cpl		REM Date/Time Properties 
control desk.cpl		REM Display Properties 
control findfast.cpl		REM FindFast 
control fonts		REM Fonts Folder 
control inetcpl.cpl		REM Internet Properties 
control joy.cpl		REM Joystick Properties 
control main.cpl keyboard		REM Keyboard Properties 
control mlcfg32.cpl		REM Microsoft Exchange 
control wgpocpl.cpl		REM Microsoft Mail Post Office 
control modem.cpl		REM Modem Properties 
control main.cpl		REM Mouse Properties 
control mmsys.cpl		REM Multimedia Properties 
control netcpl.cpl		REM Network Properties (ncpa.cpl is previous version)
control password.cpl		REM Password Properties 
control main.cpl pc card (PCMCIA)		REM PC Card 
control printers		REM Printers Folder 
control intl.cpl		REM Regional Settings 
control sticpl.cpl		REM Scanners and Cameras 
control mmsys.cpl sounds		REM Sound Properties 
control sysdm.cpl		REM System Properties 


REM ------------------------------------------------------------
REM 
REM Description of Control Panel (.cpl) Files [ cited in "Citation(s)", below ]
REM 

access.cpl		REM Accessibility properties
appwiz.cpl		REM Add/Remove Programs properties
desk.cpl		REM Display properties
findFast.cpl		REM FindFast (included with Microsoft Office for Windows 95)
inetcpl.cpl		REM Internet properties
intl.cpl		REM Regional Settings properties
joy.cpl		REM Joystick properties
main.cpl		REM Mouse, Fonts, Keyboard, and Printers properties
mlcfg32.cpl		REM Microsoft Exchange or Windows Messaging properties
mmsys.cpl		REM Multimedia properties
modem.cpl		REM Modem properties
netcpl.cpl		REM Network properties
odbccp32.cpl		REM Data Sources (32-bit ODBC, included w/ Microsoft Office)
password.cpl		REM Password properties
sticpl.cpl		REM Scanners and Cameras properties
sysdm.cpl		REM System properties and Add New Hardware wizard
themes.cpl		REM Desktop Themes 
timeDate.cpl		REM Date/Time properties
wgpocpl.cpl		REM Microsoft Mail Post Office


REM ------------------------------------------------------------
REM 
REM Windows Server start Add Roles and Features Wizard command
REM 

ServerManager.exe -arw

REM ------------------------------------------------------------
REM 
REM Windows 10 -  Server start Add Roles and Features Wizard command
REM 

OptionalFeatures.exe


REM ------------------------------------------------------------
REM Citation(s)
REM
REM   recouncedthoughts.wordpress.com  |  "Run Commands, cpl, msc files for everyday use"  |  https://renouncedthoughts.wordpress.com/2014/05/08/run-commands-cpl-msc-files-for-everyday-use/
REM
REM   superuser.com  |  "Windows Server start Add Roles and Features Wizard command"  |  https://superuser.com/a/1387227
REM
REM   support.microsoft.com  |  "Description of Control Panel (.cpl) Files"  |  https://support.microsoft.com/en-us/help/149648/description-of-control-panel-cpl-files
REM
REM   support.microsoft.com  |  "How to run Control Panel tools by typing a command"  |  https://support.microsoft.com/en-us/help/192806/how-to-run-control-panel-tools-by-typing-a-command
REM
REM ------------------------------------------------------------