@ECHO OFF
REM ------------------------------------------------------------
REM
REM
REM  "%USERPROFILE%\Documents\GitHub\Coding\cmd\cmd - VSCode-Workspace.bat"
REM
REM
REM ------------------------------------------------------------

SET /A VSCODE_ALREADY_RUNNING=0
FOR /F "tokens=2-2 delims= " %%A IN ('TASKLIST /NH /FI "IMAGENAME eq Code.exe" ^| MORE +3') DO (
SET /A VSCODE_ALREADY_RUNNING=1
)

IF %VSCODE_ALREADY_RUNNING% EQU 0 (
START "%ProgramFiles%\Microsoft VS Code\Code.exe" "%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace" | ECHO 1>NUL 2>&1
FOR /L %%N IN (1,1,10) DO (
FOR /F "tokens=2-2 delims= " %%A IN ('TASKLIST /NH /FI "IMAGENAME eq Code.exe" ^| MORE +3') DO (
TIMEOUT /T 1 | ECHO 1>NUL 2>&1
GOTO OPEN_TARGET_FILE
)
TIMEOUT /T 1 | ECHO 1>NUL 2>&1
)
)

:OPEN_TARGET_FILE
IF ""%1"" == """" (
START "%ProgramFiles%\Microsoft VS Code\Code.exe" "%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace" | ECHO 1>NUL 2>&1
) ELSE (
START "%ProgramFiles%\Microsoft VS Code\Code.exe" "%*" | ECHO 1>NUL 2>&1
)


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