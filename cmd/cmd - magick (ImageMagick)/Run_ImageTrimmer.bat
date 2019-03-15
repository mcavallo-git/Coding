@ECHO OFF
REM		!!! Prerequisite !!! 
REM			ImageMagick" must be installed for this script to function as-intended
REM			( Download URL:  https://www.imagemagick.org/script/download.php#windows )
ECHO.

REM		Trim the following off each side of the image:
SET TrimTop=0
SET TrimBottom=225
SET TrimRight=0
SET TrimLeft=0

REM		Width to Resize-To
SET ResizeToWidth=1000


REM		Input & Output Directories
SET "INPUT_DIR=__TO_BE_TRIMMED"
SET "OUTPUT_DIR=_FINISHED_ITEMS"

REM		--= ImageMagick  :::  Trim the Image(s) ==-   
FOR %%I IN ("%INPUT_DIR%\*.jpg") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.jpg"
	magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 -resize %ResizeToWidth% "%OUTPUT_DIR%\%%~nI.jpg"
	DEL /f "%%I"
	ECHO.
)

REM	Open the output directory once finished
START explorer.exe "%OUTPUT_DIR%"

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