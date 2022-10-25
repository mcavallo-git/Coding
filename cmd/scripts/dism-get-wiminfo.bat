@ECHO Off
REM ------------------------------------------------------------
REM 
REM Windows - Determine Installation-Media / ISO-File's Version, Build-Number, etc.
REM 
REM ------------------------------------------------------------

REM Copy this batch-file one-level above the "sources" directory, then run it as admin


DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:1 > "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:2 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:3 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:4 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:5 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:6 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:7 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:8 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:9 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:10 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:11 >> "%~dp0get-iso-version.log"
DISM /Get-WimInfo /WimFile:"%~dp0sources\install.wim" /Index:12 >> "%~dp0get-iso-version.log"

EXIT

REM ------------------------------------------------------------
REM 
REM Using DISM /Get-WimInfo


DISM /Get-WimInfo /WimFile:"D:\sources\install.wim"

DISM /Get-WimInfo /WimFile:"D:\sources\install.esd"


REM ------------------------------------------------------------
REM 
REM Using DISM /Get-WimInfo (on file's with multiple indices)	


DISM /Get-WimInfo /WimFile:"D:\sources\install.wim" /Index:1


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "DISM Image Management Command-Line Options"  |  https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-image-management-command-line-options-s14
REM
REM   docs.microsoft.com  |  "Get-WindowsImage (Module: dism) - Gets information about a Windows image in a WIM or VHD file"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsimage
REM
REM   howtogeek.com  |  "How to See Which Windows Version and Build is on a DVD, ISO, or USB Drive"  |  https://www.howtogeek.com/362502/how-to-see-which-windows-version-and-build-is-on-a-dvd-iso-or-usb-drive/
REM
REM   social.technet.microsoft.com  |  "Get-ImageInfo VS Get-Wiminfo"  |  https://social.technet.microsoft.com/Forums/en-US/e1f020cc-2ab8-4528-8d8e-e0260ad82cab/getimageinfo-vs-getwiminfo
REM
REM ------------------------------------------------------------