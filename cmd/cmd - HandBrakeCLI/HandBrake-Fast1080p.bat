@ECHO OFF
REM
REM		!!! Prerequisite !!!
REM
REM			HandBrakeCLI must be installed for this script to function as-intended
REM 
REM			Download [ HandBrakeCLI ] Application from URL [ https://handbrake.fr/downloads2.php ]
REM
REM			Extract [ HandBrakeCLI.exe ] from aforementioned URL (downloads as a .zip archive as-of 20191222-070342 CST)
REM	
REM			Place the extracted file at filepath [ C:\Program Files\HandBrake\HandBrakeCLI.exe ]
REM 


REM "C:\Program Files\HandBrake\HandBrakeCLI.exe" --preset "Fast 1080p30"



REM ------------------------------------------------------------

for /R H:\Video\ %%F in (*.mkv) do (

"C:\Program Files\HandBrake\HandBrakeCLI.exe" --preset-import-file "C:\Users\user1\Desktop\bluraypreset.json" -Z "bluraypreset" -i "%%~fF" -o "%%~dpF%%~nF_conv.mkv"

if exist "%%~dpF%%~nF_conv.mkv" (
	del "%%~fF"
	ren "%%~dpF%%~nF_conv.mkv" "%%~nxF"
)

)


REM		Input & Output Directories
SET "INPUT_DIR=Input"
SET "OUTPUT_DIR=Output"

REM		--= ImageMagick  :::  Trim the Image(s) ==-
SET EXT="bmp"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%EXT%"
	magick "%%I" -gravity south -chop 0x%TrimBottom% -gravity north -chop 0x%TrimTop% -gravity east -chop %TrimRight%x0 -gravity west -chop %TrimLeft%x0 -resize %ResizeToWidth% "%OUTPUT_DIR%\%%~nI.%EXT%"
	DEL /f "%%I"
	ECHO.
)

REM	Open the output directory once finished
START explorer.exe "%OUTPUT_DIR%"

TIMEOUT /T 30

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