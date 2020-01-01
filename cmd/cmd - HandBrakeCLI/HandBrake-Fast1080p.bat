@ECHO OFF
REM ------------------------------------------------------------
REM	!!! Prerequisite !!!
REM		HandBrakeCLI must be installed for this script to function as-intended
REM		Download [ HandBrakeCLI ] Application from URL [ https://handbrake.fr/downloads2.php ]
REM		Extract [ HandBrakeCLI.exe ] from aforementioned URL (downloads as a .zip archive as-of 20191222-070342 CST)
REM		Place the extracted file at filepath [ C:\Program Files\HandBrake\HandBrakeCLI.exe ]
REM ------------------------------------------------------------
REM 
REM Instantiate Runtime Variable(s)
REM

SET "PRESET_NAME=Fast 1080p30"
SET "INPUT_DIR=Input"
SET "OUTPUT_DIR=Output"
SET "OUTPUT_EXT=mp4"

REM ------------------------------------------------------------
REM	Compress input video(s) using HandBrakeCLI

SET EXT="vob"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%"
	"HandBrakeCLI.exe" --preset "%PRESET_NAME%" -i "%%I" -o "%OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%"
	IF EXIST "%OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%" (
		DEL /f "%%I"
	)
	ECHO.
)

SET EXT="mpg"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%"
	"HandBrakeCLI.exe" --preset "%PRESET_NAME%" -i "%%I" -o "%OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%"
	IF EXIST "%OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%" (
		DEL /f "%%I"
	)
	ECHO.
)

SET EXT="mov"
FOR %%I IN ("%INPUT_DIR%\*.%EXT%") DO (
	ECHO|set /p="   %%I  --->  %OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%"
	"HandBrakeCLI.exe" --preset "%PRESET_NAME%" -i "%%I" -o "%OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%"
	IF EXIST "%OUTPUT_DIR%\%%~nI.%OUTPUT_EXT%" (
		DEL /f "%%I"
	)
	ECHO.
)


REM ------------------------------------------------------------
REM 
REM ### Original Script (see Citation(s), below)
REM 
REM FOR /R H:\Video\ %%F IN (*.mkv) DO (
REM 	"C:\Program Files\HandBrake\HandBrakeCLI.exe" --preset "Fast 1080p30" -i "%%~fF" -o "%%~dpF%%~nF_conv.mkv"
REM 	IF EXIST "%%~dpF%%~nF_conv.mkv" (
REM 		DEL "%%~fF"
REM 		REN "%%~dpF%%~nF_conv.mkv" "%%~nxF"
REM 	)
REM )


REM ------------------------------------------------------------
REM	Once finished, open the output directory
START explorer.exe "%OUTPUT_DIR%"
TIMEOUT /T 30
EXIT


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   reddit.com  |  "A HandBrake script to run through subfolders and convert to a custom preset"  |  https://www.reddit.com/r/PleX/comments/9anvle/a_handbrake_script_to_run_through_subfolders_and/
REM
REM ------------------------------------------------------------
