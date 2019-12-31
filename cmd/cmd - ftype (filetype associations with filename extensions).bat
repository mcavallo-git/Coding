REM ------------------------------------------------------------
REM
REM   cmd - ftype (filetype associations with filename extensions)
REM
REM ------------------------------------------------------------


REM List file name extension associations active for current session
ftype


REM Store list of current session's [ filetype associations with filename extensions ] on a file on the desktop
ftype 1>"%USERPROFILE%\Desktop\cmd.ftype.log"
notepad "%USERPROFILE%\Desktop\cmd.ftype.log"


REM General Syntax
REM      <FileType>            Specifies the file type to display or change.
REM      <OpenCommandString>   Specifies the open command string to use when opening files of the specified file type.
REM      /?                    Displays help at the command prompt.

ftype [<FileType>[=[<OpenCommandString>]]]


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "ftype - Displays or modifies file types that are used in file name extension associations"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/ftype
REM
REM ------------------------------------------------------------