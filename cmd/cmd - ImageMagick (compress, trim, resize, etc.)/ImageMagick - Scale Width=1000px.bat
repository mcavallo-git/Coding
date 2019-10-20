@ECHO OFF
REM		!!! Prerequisite !!! 
REM			ImageMagick" must be installed for this script to function as-intended
REM			https://www.imagemagick.org/script/download.php#windows
ECHO.

SET "INPUT_DIR=Input"
SET "OUTPUT_DIR=Output"

SET ResizeToWidthPx=1000

REM /***  Resize Image to %ResizeToWidthPx% Pixels in Width  && Delete input image(s) once they've been converted  ***/
FOR %%I IN ("%INPUT_DIR%\*.jpg") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.jpg"
	magick "%%I" -resize %ResizeToWidthPx% "%OUTPUT_DIR%\%%~nI.jpg"
	REM DEL /f "%%I"
	ECHO.
)

FOR %%I IN ("%INPUT_DIR%\*.png") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.png"
	magick "%%I" -resize %ResizeToWidthPx% "%OUTPUT_DIR%\%%~nI.png"
	REM DEL /f "%%I"
	ECHO.
)

START explorer.exe "%OUTPUT_DIR%"

TIMEOUT /T 30
