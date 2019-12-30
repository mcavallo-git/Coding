@ECHO OFF
REM ------------------------------------------------------------
REM
REM
REM  "%USERPROFILE%\Documents\GitHub\Coding\cmd\cmd - VSCode-Workspace.bat"
REM
REM
REM ------------------------------------------------------------
REM
REM TO VIEW LOGS, REPLACE:
REM   1>NUL 2>&1
REM
REM WITH:
REM   1>>%USERPROFILE%\Desktop\VSCode-Workspace.log 2>>&1
REM
REM ------------------------------------------------------------

SET /A VSCODE_ALREADY_RUNNING=0
FOR /F "tokens=2-2 delims= " %%A IN ('TASKLIST /NH /FI "IMAGENAME eq Code.exe" ^| MORE +3') DO (
SET /A VSCODE_ALREADY_RUNNING=1
)

IF %VSCODE_ALREADY_RUNNING% EQU 0 (
ECHO VSCode not found to be on its feet 1>NUL 2>&1
ECHO Calling  [ "C:\Program Files\Microsoft VS Code\Code.exe" "%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace" ]  1>NUL 2>&1
"C:\Program Files\Microsoft VS Code\Code.exe" "%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace" | ECHO 1>NUL 2>&1
FOR /L %%N IN (1,1,10) DO (
FOR /F "tokens=2-2 delims= " %%A IN ('TASKLIST /NH /FI "IMAGENAME eq Code.exe" ^| MORE +3') DO (
ECHO VSCode now on its feet 1>NUL 2>&1
TIMEOUT /T 1 | ECHO 1>NUL 2>&1
GOTO OPEN_TARGET_FILE
)
TIMEOUT /T 1 | ECHO 1>NUL 2>&1
)
)

:OPEN_TARGET_FILE
IF ""%1"" == """" (
ECHO No Inline Arguments - Starting Code-Workspace 1>NUL 2>&1
ECHO Calling  [ "C:\Program Files\Microsoft VS Code\Code.exe" "%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace" ]  1>NUL 2>&1
"C:\Program Files\Microsoft VS Code\Code.exe" "%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace" | ECHO 1>NUL 2>&1
) ELSE (
ECHO At least 1 Inline Argument:  [ %* ]  1>NUL 2>&1
ECHO Calling  [ "C:\Program Files\Microsoft VS Code\Code.exe" %* ]  1>NUL 2>&1
"C:\Program Files\Microsoft VS Code\Code.exe" %* | ECHO 1>NUL 2>&1
)

EXIT 0

REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   stackoverflow.com  |  "Batch File to Check for Running Program and Start if not Running is not working"  |  https://stackoverflow.com/a/28477354
REM
REM   stackoverflow.com  |  "How to increment variable under DOS?"  |  https://stackoverflow.com/a/25632806
REM
REM   stackoverflow.com  |  "If greater than batch files"  |  https://stackoverflow.com/a/9278668
REM
REM ------------------------------------------------------------
