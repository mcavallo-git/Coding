@ECHO OFF
REM ------------------------------------------------------------
REM
REM  Determine which process is using a given port
REM

REM  NETSTAT.EXE
REM    -a            Displays all connections and listening ports.
REM    -n            Displays addresses and port numbers in numerical form.
REM    -o            Displays the owning process ID associated with each connection.

NETSTAT.EXE -nao | find ":80 "


REM ------------------------------------------------------------

NETSTAT.EXE -a -b

NETSTAT.EXE -o

TIMEOUT /T 60

TASKLIST /FI "IMAGENAME eq java.exe" /NH
REM  |
REM  v
REM java.exe                       828 Services                   0    551,452 K
REM java.exe                      9500 Services                   0     42,700 K
REM java.exe                      9620 Services                   0     22,508 K
REM java.exe                     11044 Services                   0     93,452 K

wmic process where processid=828 get commandline
wmic process where processid=9500 get commandline
wmic process where processid=9600 get commandline
wmic process where processid=11044 get commandline


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   superuser.com  |  "windows - PID:4 using Port 80 - Super User"  |  https://superuser.com/questions/352017/pid4-using-port-80
REM
REM ------------------------------------------------------------