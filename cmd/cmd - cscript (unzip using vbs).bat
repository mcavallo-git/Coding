

REM Using cmd to unpack a .zip archive
setlocal
cd /d %~dp0
set zip_file_path="%cd%\BGInfo.zip"
set unzip_dir_path="%cd%"
Call :UnZipFile %unzip_dir_path% %zip_file_path%
exit /b


:UnZipFile <ExtractTo> <newzipfile>
	set vbs="%temp%\_.vbs"
	if exist %vbs% del /f /q %vbs%
	>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
	>>%vbs% echo If NOT fso.FolderExists(%1) Then
	>>%vbs% echo fso.CreateFolder(%1)
	>>%vbs% echo End If
	>>%vbs% echo set objShell = CreateObject("Shell.Application")
	>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
	>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
	>>%vbs% echo Set fso = Nothing
	>>%vbs% echo Set objShell = Nothing
	cscript //nologo %vbs%
	if exist %vbs% del /f /q %vbs%
EXIT /B


REM Citation(s)
REM		stackoverflow.com, "creating batch script to unzip a file without additional zip tools"
REM		https://stackoverflow.com/questions/21704041/creating-batch-script-to-unzip-a-file-without-additional-zip-tools