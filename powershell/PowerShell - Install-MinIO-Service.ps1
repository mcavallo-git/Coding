# ------------------------------------------------------------
#
# PowerShell
#  |--> (Re-)Install MinIO as a local service Service
#
# ------------------------------------------------------------

# Download MinIO for Windows && WinSW Service Creator
$ServiceName = "MinIO Server";
$WorkingDir = "${PSScriptRoot}";
$Dir_Logs = "${WorkingDir}\logs";
$Dir_Data = "${WorkingDir}\data";
$Path_MainRuntime = "${WorkingDir}\minio.exe";
$Path_ServiceInstaller = "${WorkingDir}\${ServiceName}.exe";
$Path_ServiceConfig = "${WorkingDir}\${ServiceName}.xml";
If ((Test-Path "${Dir_Logs}") -Eq $False) { New-Item -Force -ItemType "Directory" -Path ("${Dir_Logs}\") | Out-Null; }
If ((Test-Path "${Dir_Data}") -Eq $False) { New-Item -Force -ItemType "Directory" -Path ("${Dir_Data}\") | Out-Null; }
If ((Test-Path "${WorkingDir}\mongod.exe") -Eq $False) { $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri ("https://dl.min.io/server/minio/release/windows-amd64/minio.exe") -OutFile ("${Path_MainRuntime}"); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; };
If ((Test-Path "${WorkingDir}\${ServiceName}.exe") -Eq $False) { $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri ("https://github.com/winsw/winsw/releases/download/v2.7.0/WinSW.NET4.exe") -OutFile ("${Path_ServiceInstaller}"); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; };
$ServiceArguments = @();
$ServiceArguments += "server";
$ServiceArguments += "`"${Dir_Data}`"";

# Stop the service (whether it already exists or not) 
Write-Host "";
Write-Host "Info:  Stopping existing service `"${ServiceName}`"...";
Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList (@("stop","${ServiceName}")) -Verb ("RunAs") -ErrorAction ("SilentlyContinue");
Start-Sleep 1;

# Delete the service (whether it already exists or not) 
Write-Host "";
Write-Host "Info:  Deleting existing service `"${ServiceName}`"...";
Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList (@("delete","${ServiceName}")) -Verb ("RunAs") -ErrorAction ("SilentlyContinue");
Start-Sleep 1;

# Install (Creates/Adds) the service 
New-Item `
-Force `
-Type "File" `
-Path "${Path_ServiceConfig}" `
-Value ("<service>
	<id>${ServiceName}</id>
	<name>${ServiceName}</name>
	<description>${ServiceName}</description>
	<executable>`"${Path_MainRuntime}`"</executable>
	<arguments>${ServiceArguments}</arguments>
	<logpath>${Dir_Logs}</logpath>
	<logmode>rotate</logmode>
	<onfailure action=`"restart`" delay=`"20 sec`"/>
</service>") | Out-Null;
Start-Process -WorkingDirectory ("${WorkingDir}") -Filepath ("${Path_ServiceInstaller}") -ArgumentList (@("install")) -Verb ("RunAs");

# Wait until MinIO is ready to start to start it
Write-Host "";
Write-Host "Info:  Waiting 5s for service to get on its feet...";
Start-Sleep 5;

# Service should now be installed - Check in services to verify
# Start the service 
Write-Host "";
Write-Host "Info:  Starting service `"${ServiceName}`"...";
Start-Service -Name "${ServiceName}" -ErrorAction ("SilentlyContinue");
Start-Sleep 1;
