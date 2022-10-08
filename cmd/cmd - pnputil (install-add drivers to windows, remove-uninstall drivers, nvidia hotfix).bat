REM ------------------------------------------------------------
REM
REM	pnputil
REM   |
REM   |--> PnPUtil (PnPUtil.exe) is a command line tool that lets an administrator perform actions on driver packages. Some examples include:
REM
REM ------------------------------------------------------------
REM
REM LIST (ENUMERATE) ALL DRIVERS
REM

pnputil.exe /enum-drivers


REM ------------------------------------------------------------
REM
REM INSTALL/ADD DRIVERS VIA ".inf" EXTENSIONED FILES
REM   |
REM   |--> Example: Add all drivers by recursively searching for "*.inf" files under the "C:\Drivers\" directory
REM

pnputil.exe /add-driver C:\Drivers\*.inf /subdirs /install /reboot


REM ------------------------------------------------------------
REM
REM REMOVE DRIVERS  (hotfix example)
REM   |
REM   |--> Removing corrupt DCH nvidia driver on 2019-06-13_08-15-29
REM
REM   Correct driver wouldn't install, and was throwing an error similar to:
REM      "The standard NVIDIA graphics driver is not compatible with this version of Windows"
REM 


REM
REM	STEP 1 - Acquite .inf file which is corrupt/bad and currently attached to graphics card as the primary driver
REM
REM Goto device manager, locate your GPU which is experiencing issues
REM		Right-click -> Properties -> Goto tab "Details" -> Copy the value from property "Inf name"
REM		The copied value should be similar to "oem_.inf" where "_" is an integer which varies per-environment (e.g. per-installed, corrupt driver)
REM		This example uses value "oem3.inf"
REM


REM
REM	STEP 2 - Uninstall the corrupt driver
REM
pnputil /delete-driver oem3.inf /uninstall

REM
REM STEP 3 - Remove the leftovers of the NVIDIA DCH driver
REM
sc delete nvlddmkm


REM
REM STEP 4 - Reinstall your desired drivers from NVIDIA with the CLEAN install option (note: do not use Express settings, as it does not allow this)
REM


REM
REM Done!
REM


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   disq.us  |  "Install Windows Drivers from a Folder Using PowerShell – FlamingKeys – Active Directory, Office 365, PowerShell"  |  http://disq.us/p/22hd4ak
REM
REM   www.techpowerup.com  |  "PSA: "NVIDIA Installer cannot continue" on Windows October 2018 Update and How To Fix It | TechPowerUp"  |  https://www.techpowerup.com/250415
REM
REM ------------------------------------------------------------