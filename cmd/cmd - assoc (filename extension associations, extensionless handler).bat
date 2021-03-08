REM ------------------------------------------------------------
REM
REM   cmd - assoc (filename extension associations)
REM
REM ------------------------------------------------------------


REM General Syntax
assoc [.EXTENSION]=[NEW_ASSOCIATION]


REM List file name extension associations active for current session
assoc


REM Store list of current session's [ filename extension associations ] on a file on the desktop
assoc 1>"%USERPROFILE%\Desktop\cmd.assoc.log"
notepad "%USERPROFILE%\Desktop\cmd.assoc.log"


REM Example) Treat extensionless files as though they were text files
assoc .=txtfile


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "assoc - Displays or modifies file name extension associations"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/assoc
REM
REM ------------------------------------------------------------