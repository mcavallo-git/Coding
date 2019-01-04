
@ECHO OFF
	SET FolderToDelete=%programdata%\LabTech Client\Cache\
	CALL:DeleteIfExists "%FolderToDelete%"
	TIMEOUT /T 10
	EXIT

	: DeleteIfExists
	ECHO.
	ECHO  Attempting to delete [%1]
	ECHO.
	IF EXIST %1 (
		RMDIR %1 /S /Q
		IF EXIST %1 (
			ECHO Success - Directory [%1] was deleted
		) ELSE (
			ECHO Failed - Directory [%1] could not be deleted
		)

	) ELSE (
		ECHO Failed - Directory [%1] not found while attempting to delete it)
	)
	ECHO.
	EXIT /B

