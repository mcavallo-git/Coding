REM ------------------------------------------------------------
REM
REM TeamCity --> Migrating Database between SQL instances
REM 
REM C:\TeamCity\bin\maintainDB.cmd migrate -A "C:\ProgramData\JetBrains\TeamCity" -T "C:\ProgramData\JetBrains\TeamCity\config\database.migration-target.properties"
REM
REM ------------------------------------------------------------


connectionUrl=jdbc:sqlserver://SERVER_FQDN:1433;databaseName=DATABASE_NAME

connectionProperties.user=SQL_USERNAME
connectionProperties.password=SQL_PASSWORD

maxConnections=50
poolPreparedStatements=true


REM ------------------------------------------------------------
REM 
REM Citation(s)
REM 
REM   www.jetbrains.com  |  "Migrating to an External Database - Help | TeamCity"  |  https://www.jetbrains.com/help/teamcity/migrating-to-an-external-database.html
REM 
REM ------------------------------------------------------------