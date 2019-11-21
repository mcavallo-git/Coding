@ECHO OFF
EXIT
REM 
REM Windows - MBR2GPT.exe (Converting disk-partition from MBR to GPT & upgrading from BIOS to UEFI boot)
REM 
REM ------------------------------------------------------------
REM 
REM !!! NOTE !!! 
REM 
REM   You must use Windows PE for these commands, e.g. you must boot from Windows 10 Installation Media (on a USB Thumb-Drive or DVD)
REM 
REM   Create Windows (PE) Installation Media via Microsoft's tool @ https://www.microsoft.com/en-us/software-download/windows10
REM 
REM   Restart PC & Boot to Installation Media (by selecting it immediately after powering on PC via 'boot drive' (or similar wording) or by editing boot-order within your BIOS)
REM 
REM ------------------------------------------------------------
REM
REM   Once in Windows PE, find the option to open Command Prompt, and run the following commands:
REM


MBR2GPT.EXE /validate

MBR2GPT.EXE /convert

EXIT

REM If the EXIT command doesn't reboot the PC, then reboot it (manually) & log into Windows as-normal, then run the following command (in CMD.exe within your regular windows instance)


reagentc /disable

reagentc /enable


REM ------------------------------------------------------------
REM 
REM 
REM   If you need to recreate the UEFI Boot partition, refer to resource:  http://woshub.com/how-to-repair-deleted-efi-partition-in-windows-7/
REM 
REM 
REM ------------------------------------------------------------
REM Citation(s)
REM 
REM   youtube.com  |  "Microsoft Mechanics | Shifting from BIOS to UEFI with Windows 10 - MBR2GPT disk conversion tool"  |  https://www.youtube.com/watch?v=hfJep4hmg9o
REM 
REM   woshub.com  |  "How to Restore Deleted EFI Boot Partition in Windows 10/7"  |  http://woshub.com/how-to-repair-deleted-efi-partition-in-windows-7/
REM 
REM   imgur.com  |  "MBR2GPT.exe Demo"  |  https://i.imgur.com/BVGqPjK.jpg
REM 
REM ------------------------------------------------------------