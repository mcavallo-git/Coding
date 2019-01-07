#!/bin/sh

docker-machine rm default;

docker-machine create -d virtualbox --virtualbox-cpu-count=2 --virtualbox-memory=4096 --virtualbox-disk-size=10240 default;

docker-machine stop

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=1234567890abcdefghiJK!' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu

# (Citation) Thanks go out to:  https://github.com/crops/docker-win-mac-docs/wiki/Windows-Instructions-(Docker-Toolbox)

