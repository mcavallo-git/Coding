@ECHO OFF
REM ------------------------------------------------------------
REM		!!! Prerequisite !!!
REM			ImageMagick" must be installed for this script to function as-intended
REM			https://www.imagemagick.org/script/download.php#windows
REM ------------------------------------------------------------
REM NEED TO SETUP SCRIPT TO DOWNLOAD LATEST PORTABLE IMAGEMAGICK VERSION FROM:
REM
REM   SOURCE - https://www.imagemagick.org/script/download.php#windows
REM
REM   DIRECT (v7.1.0.2) - https://download.imagemagick.org/ImageMagick/download/binaries/ImageMagick-7.1.0-2-portable-Q16-x64.zip
REM
REM ------------------------------------------------------------
ECHO.

SET "INPUT_DIR=Input"
SET "OUTPUT_DIR=Output"

REM /***  Convert images && Delete input image(s) once they've been converted  ***/
FOR %%I IN ("%INPUT_DIR%\*.png") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.jpg"
	magick "%%I" "%OUTPUT_DIR%\%%~nI.jpg"
	DEL /f "%%I"
	ECHO.
)

START explorer.exe "%OUTPUT_DIR%"

REM TIMEOUT /T 30

EXIT
