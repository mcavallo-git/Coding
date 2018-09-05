
@echo off

	set FolderToDelete=%programdata%\LabTech Client\Cache\watchdog.netcomm.com

	Call:DeleteIfExists "%FolderToDelete%"

	timeout 10

	Exit																

	: DeleteIfExists

		ECHO.
		ECHO  Attempting to delete:
		ECHO    %1
		ECHO.
		
		if EXIST %1 (

		RMDIR %1 /S /Q
		ECHO   Success!

		) else (

		ECHO  Cache folder has already been deleted.

		)

		ECHO.		

		Exit /B
	
