REM ------------------------------------------------------------
REM
REM sc create
REM   > Creates a subkey and entries for a service in the registry and in the Service Control Manager database
REM
REM ------------------------------------------------------------


sc create SQLBrowser binpath= "C:\Program Files (x86)\Microsoft SQL Server\90\Shared\sqlbrowser.exe" type= share start= auto


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "Sc create | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sc-create#BKMK_examples
REM
REM ------------------------------------------------------------