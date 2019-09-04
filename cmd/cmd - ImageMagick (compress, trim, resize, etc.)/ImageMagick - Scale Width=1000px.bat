@ECHO OFF
REM		!!! Prerequisite !!! 
REM			ImageMagick" must be installed for this script to function as-intended
REM			https://www.imagemagick.org/script/download.php#windows
ECHO.

SET "INPUT_DIR=Input"
SET "OUTPUT_DIR=Output"

SET ResizeToWidthPx=1000

FOR %%I IN ("%INPUT_DIR%\*.jpg") DO (

	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.jpg"

	REM /***  Resize Image to %ResizeToWidthPx% Pixels in Width  ***/
	magick "%%I" -resize %ResizeToWidthPx% "%OUTPUT_DIR%\%%~nI.jpg"

	REM /***  DELETE INPUT IMAGE AFTER WE CONVERTED TO EXPORT IMAGE  ***/
	DEL /f "%%I"

	ECHO.

)

START explorer.exe "%OUTPUT_DIR%"
