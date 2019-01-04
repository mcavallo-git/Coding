@ECHO OFF

REM To check the pagefile settings, open a command prompt and run:
wmic pagefileset list /format:list

REM To change the page file size from command line, enter the line below (adapt the location and size)
REM wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=2048

TIMEOUT /T 60

REM Citation: https://social.technet.microsoft.com/Forums/windows/en-US/01b59794-f904-4983-9df3-5da8327f509d
