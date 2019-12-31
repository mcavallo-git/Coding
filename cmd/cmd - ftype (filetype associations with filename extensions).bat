REM ------------------------------------------------------------
REM
REM   cmd - ftype (filetype associations with filename extensions)
REM
REM ------------------------------------------------------------

REM List file name extension associations active for current session
assoc


REM Treat extensionless files as though they were text files
assoc .=txtfile


REM General Syntax
assoc [.EXTENSION]=[NEW_ASSOCIATION]


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "Displays or modifies file types that are used in file name extension associations"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/ftype
REM
REM ------------------------------------------------------------