@ECHO OFF
REM 
REM Windows - Fix glitch where "Hyper-V" role/feature is disabled, yet VMWare Workstation still states it can't start VMs because "VMware Workstation and Hyper-V are not compatible. Remove the Hyper-V Role from the system before runnin VMware Workstation."
REM 
REM ------------------------------------------------------------


bcdedit /set hypervisorlaunchtype Off


REM ------------------------------------------------------------
REM Citation(s)
REM
REM   answers.microsoft.com  |  "Hyper V remnants left over after disabling, preventing other Virtualization software from running in 64-bit mode"  |  https://answers.microsoft.com/en-us/insider/forum/all/hyper-v-remnants-left-over-after-disabling/81e4fef1-d08e-4ef4-8e1e-b24c47bd7677?auth=1
REM
REM ------------------------------------------------------------