@ECHO Off
Exit

REM ------------------------------------------------------------
REM 
REM Checking issues with DISM using CheckHealth option
DISM /Online /Cleanup-Image /CheckHealth


REM ------------------------------------------------------------
REM 
REM Checking issues with DISM using ScanHealth option
DISM /Online /Cleanup-Image /ScanHealth


REM ------------------------------------------------------------
REM 
REM Repairing issues with DISM using RestoreHealth option
DISM /Online /Cleanup-Image /RestoreHealth



REM ------------------------------------------------------------
REM 
REM Repairing issues with DISM using ISO-Source option
REM  |--> Step 1: Download & Create Win10 Installation Media ( see https://www.microsoft.com/en-us/software-download/windows10 )
REM  |--> Step 2: Replace the drive-letter "F:\" (in the following command) with your installation-media's mount-point:
DISM /Online /Cleanup-Image /RestoreHealth /Source:F:\sources\install.wim


REM ------------------------------------------------------------
REM 
REM Cleaning up the "C:\Windows\WinSxS" folder via DISM:
DISM /Online /Cleanup-Image /StartComponentCleanup


REM ------------------------------------------------------------
REM
REM  Citation(s)
REM
REM  	microsoft.com  |  "Download Windows 10"  |  https://www.microsoft.com/en-us/software-download/windows10
REM
REM  	windowscentral.com  |  "How to use DISM command tool to repair Windows 10 image"  |  https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image
REM
REM  	laptopmag.com  |  "How to Save Space By Cleaning Windows' WinSxS Folder"  |  https://www.laptopmag.com/articles/clean-winsxs-folder-to-save-space
REM
REM ------------------------------------------------------------