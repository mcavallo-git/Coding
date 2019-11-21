@ECHO OFF
EXIT
REM 
REM Windows - MBR2GPT.exe (Converting disk-partition from MBR to GPT & upgrading from BIOS to UEFI boot)
REM 
REM ------------------------------------------------------------


REM Run the following commands using WinPE (Bootable Windows-10 Installation Media on a USB Thumb-Drive or DVD)

MBR2GPT.EXE /validate

MBR2GPT.EXE /convert




REM See Demo-Screenshot @ https://imgur.com/BVGqPjK



REM ------------------------------------------------------------
REM Citation(s)
REM 
REM   youtube.com  |  "Microsoft Mechanics | Shifting from BIOS to UEFI with Windows 10 - MBR2GPT disk conversion tool"  |  https://www.youtube.com/watch?v=hfJep4hmg9o
REM 
REM ------------------------------------------------------------