@ECHO OFF
setlocal ENABLEDELAYEDEXPANSION

REM      NOTE:   Install "ImageMagick" before running this script
ECHO.

REM      Trim the following off each side of the image:
SET TrimTop=0
SET TrimBottom=0
SET TrimRight=0
SET TrimLeft=0

REM      Width to Resize-To
SET ResizeToWidth=1000

REM      Input Dir
SET "INPUT_DIR=%cd%\__TO_BE_TRIMMED"

REM      Output Dir
SET "OUTPUT_DIR=%cd%\_FINISHED_ITEMS"

REM      Image File-Extension
SET "IMG_EXT=jpg"
REM SET "IMG_EXT=png"

FOR %%I IN ("%INPUT_DIR%\*.!IMG_EXT!") DO (
	
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.!IMG_EXT!"
	
	REM Dynamic variables must be referenced using exlamation marks and NOT percentage signs
	REM   --> i.e. USE >>>   !INPUT_FILEPATH!   <<< AND NOT %INPUT_FILEPATH%
	SET INPUT_FILEPATH=%INPUT_DIR%\%%~nI.!IMG_EXT!
	SET OUTPUT_FILEPATH=%OUTPUT_DIR%\%%~nI.!IMG_EXT!
	SET cmd_getwidth=magick identify -format "%w" "!INPUT_FILEPATH!"
	
	REM for /f "delims=" %%a in ("!cmd_getwidth!") do @set foobar=%%a
	
	FOR /f "delims=" %%A in ( ' !cmd_getwidth! ' ) DO (
ECHO.
ECHO INPUT_DIR=[%INPUT_DIR%]
ECHO.
ECHO OUTPUT_DIR=[%OUTPUT_DIR%]
ECHO.
ECHO %%A

PAUSE
	)
	
	REM ECHO test width via [magick]:
	
	REM magick identify -format '%w' "%OUTPUT_DIR%\%%---TILDE---nI.!IMG_EXT!"
	
	REM magick identify -format '%w' '%image%'
	
	REM magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 -resize %ResizeToWidth% "%OUTPUT_DIR%\%%~nI.!IMG_EXT!"
	
	REM DEL /f "%%I"

)

REM      Open the output directory once finished

REM START explorer.exe "%OUTPUT_DIR%"

EXIT
