@ECHO OFF
REM		!!! Prerequisite !!! 
REM			ImageMagick" must be installed for this script to function as-intended
REM			https://www.imagemagick.org/script/download.php#windows
ECHO.

SET "INPUT_DIR=Input"
SET "OUTPUT_DIR=Output"

SET ResizeToWidthPx=1920

REM /***  Resize Image to %ResizeToWidthPx% Pixels in Width  && Delete input image(s) once they've been converted  ***/
SET EXT="bmp"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.png"
	magick "%%I" -resize %ResizeToWidthPx% "%OUTPUT_DIR%\%%~nI.png"
	DEL /f "%%I"
	ECHO.
)
SET EXT="jpg"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%EXT%"
	magick "%%I" -resize %ResizeToWidthPx% "%OUTPUT_DIR%\%%~nI.%EXT%"
	DEL /f "%%I"
	ECHO.
)
SET EXT="png"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%EXT%"
	magick "%%I" -resize %ResizeToWidthPx% "%OUTPUT_DIR%\%%~nI.%EXT%"
	DEL /f "%%I"
	ECHO.
)

START explorer.exe "%OUTPUT_DIR%"

TIMEOUT /T 30
