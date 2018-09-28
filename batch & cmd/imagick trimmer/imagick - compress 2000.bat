@ECHO OFF
REM ImageMagick must be installed to computer running this script
ECHO.

SET "INPUT_DIR=__TO_BE_TRIMMED"
SET "OUTPUT_DIR=_FINISHED_ITEMS"

FOR %%I IN ("%INPUT_DIR%\*.jpg") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.jpg"
	REM /***  RESIZE TO 1000px WIDTH  ***/
	magick "%%I" -resize 2000 "%OUTPUT_DIR%\%%~nI.jpg"
	REM /***  DELETE INPUT IMAGE AFTER WE CONVERTED TO EXPORT IMAGE  ***/
	DEL /f "%%I"
	ECHO.
)

START explorer.exe "%OUTPUT_DIR%"
