@ECHO OFF
REM		!!! Prerequisite !!! 
REM			ImageMagick" must be installed for this script to function as-intended
REM			https://www.imagemagick.org/script/download.php#windows
ECHO.

REM		Trim the following off each side of the image:
SET TrimTop=0
SET TrimBottom=225
SET TrimRight=0
SET TrimLeft=0

REM		Width to Resize-To
REM SET ResizeToWidth=1000

REM		Input & Output Directories
SET "INPUT_DIR=Input"
SET "OUTPUT_DIR=Output"

REM		--= ImageMagick  :::  Trim the Image(s) ==-
SET EXT="bmp"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%EXT%"
	REM magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 -resize %ResizeToWidth% "%OUTPUT_DIR%\%%~nI.%EXT%"
	magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 "%OUTPUT_DIR%\%%~nI.%EXT%"
	DEL /f "%%I"
	ECHO.
)
SET EXT="jpg"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%EXT%"
	REM magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 -resize %ResizeToWidth% "%OUTPUT_DIR%\%%~nI.%EXT%"
	magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 "%OUTPUT_DIR%\%%~nI.%EXT%"
	DEL /f "%%I"
	ECHO.
)
SET EXT="png"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%EXT%"
	REM magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 -resize %ResizeToWidth% "%OUTPUT_DIR%\%%~nI.%EXT%"
	magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 "%OUTPUT_DIR%\%%~nI.%EXT%"
	DEL /f "%%I"
	ECHO.
)

REM	Open the output directory once finished
START explorer.exe "%OUTPUT_DIR%"

REM TIMEOUT /T 30

EXIT

REM [ToDo] Determine if images are portrait or landscape via imagick
REM
REM ECHO test width via [magick]:
REM
REM magick identify -format '%w' "%OUTPUT_DIR%\%%---TILDE---nI.!IMG_EXT!"
REM
REM magick identify -format '%w' '%image%'
REM
REM magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 -resize %ResizeToWidth% "%OUTPUT_DIR%\%%~nI.!IMG_EXT!"
REM
REM DEL /f "%%I"