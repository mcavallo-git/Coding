#!/bin/sh

###==------------------------------------------------------------------------------------------------------------------------

## 2019-01-07,MCavallo
##    On my Workstaiton which had Windows 7, I came across the fact that "Docker for Windows" is only for
##    Windows 10 (or above) - Windows 7 users must install "Docker Toolbox", which is their older way of doing things.
##
##    After installing "Docker Toolbox", it created virtual boxes with insufficient memory for MSSQL's docker image, so
##    I had to perform the following steps to upgrade the amount of RAM allocated to the "Docker Toolbox" service (in Win10,
##    this is the easy, usual click-and-drag to set memory allocated, which happens on the fly. Win7 requires a that you
##    fully recreate the virtualbox image.)
##

docker-machine rm default;

docker-machine create -d virtualbox --virtualbox-cpu-count=2 --virtualbox-memory=4096 --virtualbox-disk-size=10240 default;

docker-machine stop;

### DOCS - https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables?view=sql-server-2017

###==------------------------------------------------------------------------------------------------------------------------

# Guide (citation):  https://github.com/crops/docker-win-mac-docs/wiki/Windows-Instructions-(Docker-Toolbox)

##!! CHANGING PORT FROM 1433 !!##
# -->> https://support.microsoft.com/en-us/help/307645/you-cannot-connect-to-sql-server-on-any-port-other-than-1433-if-you-us
# In Microsoft SSMS, at login, select "Options", "Additional Connection Parameters", and add the line: Server=ComputerName, PortNumber

# echo "SomeSecurePassword1@" > "/mssql_creds";

# port="1414";
port="1433" \
&& \
docker_img="mcr.microsoft.com/mssql/server" \
&& \
docker run \
--name "mssql" \
--env "ACCEPT_EULA=Y" \
--env "MSSQL_SA_PASSWORD=$(cat /mssql_creds)" \
--env "MSSQL_PID=Enterprise" \
--publish "${port}:1433" \
--detach \
"${docker_img}" \
&& \
winpty docker exec \
-it "mssql" \
script -q -c "ln -sf ../../opt/mssql-tools/bin/sqlcmd usr/bin/sqlcmd" /dev/null;


docker run \
--name "mssql" \
--env "ACCEPT_EULA=Y" \
--env "MSSQL_SA_PASSWORD=$(cat /mssql_creds)" \
--env "MSSQL_PID=Enterprise" \
--publush 1433:1433 \
--detached \
mcr.microsoft.com/mssql/server;

winpty docker exec \
-it "mssql" \
script -q -c "ln -sf ../../opt/mssql-tools/bin/sqlcmd usr/bin/sqlcmd" /dev/null;

winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"sp_configure 'show advanced options';\" -S localhost -U sa -P $(cat /mssql_creds)" "/dev/null";

# (Citation) Pulled from: https://hub.docker.com/_/microsoft-mssql-server

winpty docker exec -it "mssql" script -q -c "opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $(cat /mssql_creds)" "/dev/null";

# server=$(docker-machine inspect | grep IPAddress);
# port=1433;
# user=sa;
# pass=$(cat /mssql_creds);

winpty docker exec -it "mssql" script -q -c "bin/bash" "/dev/null";

winpty docker exec -it "mssql" script -q -c "sqlcmd -S localhost -U sa -P $(cat /mssql_creds)" "/dev/null";

winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"sp_databases\" -S localhost -U sa -P $(cat /mssql_creds)" /dev/null;

winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"sp_databases\" -S localhost -U sa -P $(cat /mssql_creds)" /dev/null;

winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"select * from sys.databases\" -S localhost -U sa -P $(cat /mssql_creds)" /dev/null;

winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"select database_id, name, user_access from sys.databases\" -S localhost -U sa -P $(cat /mssql_creds)" /dev/null;

winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"SELECT hostname, net_library, net_address FROM sys.sysprocesses WHERE spid = @@SPID\" -S localhost -U sa -P $(cat /mssql_creds)" /dev/null;

winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"select CONNECTIONPROPERTY('client_net_address') AS client_net_address\" -S localhost -U sa -P $(cat /mssql_creds)" /dev/null;

winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"select CONNECTIONPROPERTY('local_net_address') AS local_net_address\" -S localhost -U sa -P $(cat /mssql_creds)" /dev/null;


#
SELECT hostname, net_library, net_address
FROM sys.sysprocesses
WHERE spid = @@SPID
#


winpty docker exec -it "mssql" script -q -c "sqlcmd -Q \"sp_configure 'show advanced options', 1; GO; RECONFIGURE; GO; sp_configure 'Agent XPs', 1; GO; RECONFIGURE; GO; \" -S localhost -U sa -P $(cat /mssql_creds)" /dev/null;

#
# winpty docker exec -it "mssql" script -q -c "sqlcmd -S localhost -U sa -P $(cat /mssql_creds)" "/dev/null";
# sp_configure 'show advanced options', 1;
# GO;
# RECONFIGURE;
# GO;
# sp_configure 'Agent XPs', 1;
# GO;
# RECONFIGURE;
# GO;
#