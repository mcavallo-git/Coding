
REM @Echo Off

Set DirectoryToDelete=%USERPROFILE%\Desktop\Test_DeleteIfExists

Call:DeleteIfExists "%DirectoryToDelete%"

Timeout 10

Exit

REM : DeleteIfExists <DirectoryBeingDeleted>
: DeleteIfExists
IF EXIST %1 (
	Rem Documentation: Rmdir https://technet.microsoft.com/en-us/library/bb490990.aspx
	Rmdir %1 /S /Q
	EXIT /B
)