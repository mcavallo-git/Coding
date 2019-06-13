
REM
REM	pnputil
REM
REM Used to delete corrupy (DCH) nvidia driver on 2019-06-13_08-15-29
REM
REM Correct driver wouldn't install, and was throwing an error similar to:
REM "The standard NVIDIA graphics driver is not compatible with this version of Windows"
REM 

REM
REM	STEP 1)
REM
REM Goto device manager, locate your GPU which is experiencing issues
REM		Right-click -> Properties -> Goto tab "Details" -> Copy the value from property "Inf name"
REM		The copied value should be similar to "oem_.inf" where "_" is an integer which varies per-environment (e.g. per-installed, corrupt driver)
REM		This example uses value "oem3.inf"
REM

REM	STEP 2)
REM Uninstall the corrupt driver
pnputil /delete-driver oem3.inf /uninstall

REM STEP 3)
REM Remove the leftovers of the NVIDIA DCH driver
sc delete nvlddmkm

REM STEP 4)
REM	Reinstall your desired drivers from NVidia with the CLEAN install option (note: do not use Express settings, as it does not allow this)
REM

REM
REM Done
REM


REM
REM	Citation(s)
REM	
REM		Thanks to TechPowerup user [ crazyeyesreaper ] on forum [ https://www.techpowerup.com/250415 ]
REM	
