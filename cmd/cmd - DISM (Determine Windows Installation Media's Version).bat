@ECHO Off
REM ------------------------------------------------------------
REM 
REM Windows - Determine Installation-Media / ISO-File's Version
REM 
REM ------------------------------------------------------------
REM 
REM Using DISM /Get-WimInfo


DISM /Get-WimInfo /WimFile:"D:\sources\install.wim"

DISM /Get-WimInfo /WimFile:"D:\sources\install.esd"


REM ------------------------------------------------------------
REM 
REM Using DISM /Get-WimInfo (on file's with multiple indices)	


DISM /Get-WimInfo /WimFile:"D:\sources\install.wim" /Index:1



REM Optionally, run this one-liner in CMD directly or as a batch-file (run as admin) one-level above the "sources" directory

DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:1 > "%~dp0get-iso-version.log"


REM ------------------------------------------------------------
REM
REM  Citation(s)
REM
REM  	docs.microsoft.com  |  "DISM Image Management Command-Line Options"  |  https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-image-management-command-line-options-s14
REM
REM  	docs.microsoft.com  |  "Get-WindowsImage (Module: dism) - Gets information about a Windows image in a WIM or VHD file"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsimage
REM
REM  	howtogeek.com  |  "How to See Which Windows Version and Build is on a DVD, ISO, or USB Drive"  |  https://www.howtogeek.com/362502/how-to-see-which-windows-version-and-build-is-on-a-dvd-iso-or-usb-drive/
REM
REM  	social.technet.microsoft.com  |  "Get-ImageInfo VS Get-Wiminfo"  |  https://social.technet.microsoft.com/Forums/en-US/e1f020cc-2ab8-4528-8d8e-e0260ad82cab/getimageinfo-vs-getwiminfo
REM
REM ------------------------------------------------------------