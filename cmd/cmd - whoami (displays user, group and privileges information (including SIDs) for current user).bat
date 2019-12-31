REM ------------------------------------------------------------
REM
REM   cmd - whoami (displays user, group and privileges information (including SIDs) for current user)
REM
REM ------------------------------------------------------------


REM Get ALL the info! (about current user)
WHOAMI /ALL


REM Syntax
REM     /upn           Displays the user name in user principal name (UPN) format.
REM     /fqdn          Displays the user name in fully qualified domain name (FQDN) format.
REM     /logonid       Displays the logon ID of the current user.
REM     /user          Displays the current domain and user name and the security identifier (SID).
REM     /groups        Displays the user groups to which the current user belongs.
REM     /priv          Displays the security privileges of the current user.
REM     /fo <Format>   Specifies the output format. Valid values include:
REM            table   Displays output in a table. This is the default value.
REM            list    Displays output in a list.
REM            csv     Displays output in comma-separated value (CSV) format.
REM     /all           Displays all information in the current access token, including the current user name, security identifiers (SID), privileges, and groups that the current user belongs to.
REM     /nh            Specifies that the column header should not be displayed in the output. This is valid only for table and CSV formats.
REM     /?             Displays help at the command prompt.
whoami [/upn | /fqdn | /logonid]
whoami {[/user] [/groups] [/priv]} [/fo <Format>] [/nh]
whoami /all [/fo <Format>] [/nh]


REM Show domain\username
whoami


REM Store list of current session's [ user, group and privileges information ] on a file on the desktop
WHOAMI /USER /FO TABLE /NH 1>"%USERPROFILE%\Desktop\cmd.whoami.log"
notepad "%USERPROFILE%\Desktop\cmd.whoami.log"


REM Example) Get User Info (including SID, via CMD)
WHOAMI /USER /FO TABLE /NH


REM Example) Get User SID (via PowerShell)
PowerShell -Command "$UserSid = (&{If(Get-Command ^"WHOAMI^" -ErrorAction ^"SilentlyContinue^") { (WHOAMI /USER /FO TABLE /NH).Split(^" ^")[1] } Else { $Null }}); $UserSid;"


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "whoami - Displays user, group and privileges information for the user who is currently logged on to the local system"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/whoami
REM
REM ------------------------------------------------------------