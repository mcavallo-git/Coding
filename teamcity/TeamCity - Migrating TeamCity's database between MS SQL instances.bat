REM ------------------------------------------------------------
REM
REM TeamCity --> Migrating Database between SQL instances
REM 
REM ------------------------------------------------------------
REM
REM Migrate
REM C:\TeamCity\bin\maintainDB.cmd migrate -A "C:\ProgramData\JetBrains\TeamCity" -T "C:\ProgramData\JetBrains\TeamCity\config\database.migration-target.properties"
REM
REM
REM Backup
REM C:\TeamCity\bin\maintainDB.cmd backup -A "C:\ProgramData\JetBrains\TeamCity" -S "C:\ProgramData\JetBrains\TeamCity\config\database.properties" -F "Teamcity_Source_Backup"
REM
REM
REM Restore
REM C:\TeamCity\bin\maintainDB.cmd restore -A "C:\ProgramData\JetBrains\TeamCity" -T "C:\database.source.properties" -F "C:\Teamcity_Source_Backup.zip"
REM 
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
REM   developercommunity.visualstudio.com  |  ""The "GetReferenceNearestTargetFrameworkTask" task was not found." when building app project with reference to library project if .NET Core cross-platform development workload not installed - Developer Community"  |  https://developercommunity.visualstudio.com/content/problem/137779/the-getreferencenearesttargetframeworktask-task-wa.html
REM 
REM   stackoverflow.com  |  "node.js - How to fix ReferenceError: primordials is not defined in node - Stack Overflow"  |  https://stackoverflow.com/a/55926692
REM 
REM   stackoverflow.com  |  "visual studio 2017 - MFC development in vs2017 - Stack Overflow"  |  https://stackoverflow.com/a/43075169
REM 
REM   www.jetbrains.com  |  "Migrating to an External Database - Help | TeamCity"  |  https://www.jetbrains.com/help/teamcity/migrating-to-an-external-database.html
REM 
REM ------------------------------------------------------------