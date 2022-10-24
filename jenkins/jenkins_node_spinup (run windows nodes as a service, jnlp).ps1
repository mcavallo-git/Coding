# ------------------------------------------------------------
#
# Setup a Windows Jenkins Node
#   |
#   |--> Uses Jenkins' JNLP (Java Network Launch Protocol) agent
#   |
#   |--> Runs as a local service
#
# ------------------------------------------------------------

Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force;

# ------------------------------------------------------------
If ($False) { ### RUN THIS SCRIPT:


	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/main/jenkins/jenkins_node_spinup%20(run%20windows%20nodes%20as%20a%20service%2C%20jnlp).ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}
# ------------------------------------------------------------
#
# Instantiate Runtime Variables
#

$WorkingDir = "C:\Jenkins";

$ServiceName = "JenkinsNode";

$Dir_Logs = "${WorkingDir}\log";

$Path_ServiceLogs = "${Dir_Logs}\${ServiceName}.log";

$Path_FQDN = "${WorkingDir}\.server";

$Path_Secret = "${WorkingDir}\.secret";

$Path_NodeName = "${WorkingDir}\.nodename";

$Path_JnlpAgent = "${WorkingDir}\agent.jar";

$Path_ServiceInstaller = "${WorkingDir}\${ServiceName}.exe";

$Path_ServiceConfig = "${WorkingDir}\${ServiceName}.xml";

$Path_JavaExe = ((Get-Command "Java").Source);


# ------------------------------------------------------------
#
# Ensure the existence of the primary runtime/working directory
#
If ((Test-Path "${WorkingDir}\") -Eq $False) {
	New-Item -Force -ItemType "Directory" -Path ("${WorkingDir}\") | Out-Null;
}
Write-Host "";
Write-Host "Info:  Using Working-Directory `"${WorkingDir}`"";


# ------------------------------------------------------------
#
# Ensure the existence of the logs directory
#
If ((Test-Path "${Dir_Logs}\") -Eq $False) {
	New-Item -Force -ItemType "Directory" -Path ("${Dir_Logs}\") | Out-Null;
}


# ------------------------------------------------------------
#
# Ensure the existence of a file containing the Jenkins Node-Name for this Node
#
If ((Test-Path "${Path_NodeName}") -Eq $False) {
	New-Item -Force -ItemType ("File") -Path ("${Path_NodeName}") -Value ("$(${Env:COMPUTERNAME})") | Out-Null;
}
If (([String]::IsNullOrEmpty((Get-Content -Path ("${Path_FQDN}")))) -Eq $True) {
	Set-Content -Path ("${Path_NodeName}") -Value ("$(${Env:COMPUTERNAME})");
}
$Jenkins_NodeName = ([String](Get-Content -Path ("${Path_NodeName}"))).Trim();
Write-Host "";
Write-Host "Info:  Using Node-Name `"${Jenkins_NodeName}`" from file `"${Path_NodeName}`"";


# ------------------------------------------------------------
#
# Ensure the existence of a file containing the Jenkins server FQDN
#
If (((Test-Path "${Path_FQDN}") -Eq $False) -Or (([String]::IsNullOrEmpty((Get-Content -Path ("${Path_FQDN}")))) -Eq $True)) {
	If ((Test-Path "${Path_FQDN}") -Eq $False) {
		New-Item -Force -ItemType ("File") -Path ("${Path_FQDN}") -Value ("") | Out-Null;
	}
	Write-Host "";
	Write-Host "Error:  File containing Jenkins Server's FQDN is empty/not-found:  `"${Path_FQDN}`"";
	Write-Host "   |";
	Write-Host "   |--> Resolution";
	Write-Host "          Copy-Paste your Jenkins website's FQDN (including scheme) into filepath `"${Path_FQDN}`"" -ForegroundColor "Green";
	Write-Host "          Example:   https://jenkins.example.com";
	Write-Host "";
	If (([String]::IsNullOrEmpty((Get-Content -Path ("${Path_FQDN}")))) -Eq $True) {
		Set-Content -Path ("${Path_FQDN}") -Value ("https://REPLACE_ME_WITH_JENKINS_URL");
	}
	Notepad "${Path_FQDN}";
	Write-Host -NoNewLine "`n`n  Once you have performed above step(s), please press any key to continue...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	If (((Test-Path "${Path_FQDN}") -Eq $False) -Or (([String]::IsNullOrEmpty((Get-Content -Path ("${Path_FQDN}")))) -Eq $True)) {
		Write-Host "";
		Write-Host "Error:  File still empty/invalid `"${Path_Secret}`", exiting after 60s...";
		Start-Sleep 60;
		Exit 1;
	}
}
$Jenkins_FQDN = ([String](Get-Content -Path ("${Path_FQDN}"))).Trim();
Write-Host "";
Write-Host "Info:  Using Jenkins FQDN `"${Jenkins_FQDN}`" from file `"${Path_FQDN}`"";


# ------------------------------------------------------------
#
# Ensure the existence of a file containing the Jenkins Node's "secret" token (essentially a node-based password)
#
If (((Test-Path "${Path_Secret}") -Eq $False) -Or (([String]::IsNullOrEmpty((Get-Content -Path ("${Path_Secret}")))) -Eq $True)) {
	If ((Test-Path "${Path_Secret}") -Eq $False) {
		New-Item -Force -ItemType ("File") -Path ("${Path_Secret}") -Value ("") | Out-Null;
	}
	Write-Host "";
	Write-Host "Error:  File containing Jenkins Server's Secret (for this Node) is empty/not-found:  `"${Path_Secret}`"";
	Write-Host "   |";
	Write-Host "   |--> Resolution";
	Write-Host "          Copy-Paste this Node's `"secret`" (from your Jenkins website) into filepath `"${Path_Secret}`"" -ForegroundColor "Green";
	Write-Host "          Walkthrough:";
	Write-Host "            Browse to your Jenkins Server's Node-Management Page";
	Write-Host "               |--> via URL >  https://YOUR_JENKINS_FQDN/computer/";
	Write-Host "               |-->via Jenkins' GUI >  Select 'Jenkins' (top-left) > 'Manage Jenkins' > 'Manage Nodes and Clouds'";
	Write-Host "            Open Configuration for this Node ( Hostname: `"${Jenkins_NodeName}`" )";
	Write-Host "               |--> via URL >  https://YOUR_JENKINS_FQDN/computer/${Jenkins_NodeName}/";
	Write-Host "               |--> via Jenkins' GUI >  Select this Node ( Hostname: `"${Jenkins_NodeName}`" ) > Select 'Configure' (icon is a Cog/Gear)";
	Write-Host "            Copy the text `"-secret [COPY_THIS_SECRET]`" and paste into local filepath `"${Path_Secret}`"";
	Write-Host "";
	If (([String]::IsNullOrEmpty((Get-Content -Path ("${Path_Secret}")))) -Eq $True) {
		Set-Content -Path ("${Path_Secret}") -Value ("REPLACE_ME_WITH___SECRET");
	}
	Notepad "${Path_Secret}";
	Write-Host -NoNewLine "`n`n  Once you have performed above step(s), please press any key to continue...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	If (((Test-Path "${Path_Secret}") -Eq $False) -Or (([String]::IsNullOrEmpty((Get-Content -Path ("${Path_Secret}")))) -Eq $True)) {
		Write-Host "";
		Write-Host "Error:  File still empty/invalid `"${Path_Secret}`", exiting after 60s...";
		Start-Sleep 60;
		Exit 1;
	}
}
$Jenkins_Secret = ([String](Get-Content -Path ("${Path_Secret}"))).Trim();
Write-Host "";
Write-Host "Info:  Using Jenkins Server-FQDN `"[ HIDDEN ]`" from file `"${Path_Secret}`"";


# ------------------------------------------------------------
#
# Ensure the existence of the Jenkins JNLP Agent (executable which connects nodes to Jenkins)
#
$URL_DownloadAgent = "${Jenkins_FQDN}/jnlpJars/agent.jar";
Write-Host "";
Write-Host "Info:  Downloading Service Installer from `"${URL_DownloadAgent}`" to `"${Path_JnlpAgent}`"...";
Invoke-WebRequest -UseBasicParsing -Uri ("${URL_DownloadAgent}") -OutFile ("${Path_JnlpAgent}");
If ((Test-Path "${Path_JnlpAgent}") -Eq $False) {
	Write-Host "";
	Write-Host "Error:  File empty/invalid: Jekins JNLP Agent (executable which connects nodes to Jenkins) @ filepath `"${Path_JnlpAgent}`", exiting after 60s...";
	Start-Sleep 60;
	Exit 1;
}


# ------------------------------------------------------------
#
# Setup the service to connect the Jenkins Node to the Jenkins Server
#   |
#   |--> Download & leverage [ winsw: Windows service wrapper ]
#

$URL_JnlpTarget = "${Jenkins_FQDN}/computer/${Jenkins_NodeName}/slave-agent.jnlp";
$URL_ServiceInstaller = "https://github.com/winsw/winsw/releases/download/v2.7.0/WinSW.NET4.exe";

If ((Test-Path "${Path_ServiceInstaller}") -Eq $False) {
	Write-Host "";
	Write-Host "Info:  Downloading Service Installer from `"${URL_ServiceInstaller}`" to `"${Path_ServiceInstaller}`"...";
	Invoke-WebRequest -UseBasicParsing -Uri ("${URL_ServiceInstaller}") -OutFile ("${Path_ServiceInstaller}");
}
If ((Test-Path "${Path_ServiceInstaller}") -Eq $False) {
	Write-Host "";
	Write-Host "Warning:  File empty/invalid: Service-Installer executable @ filepath `"${Path_ServiceInstaller}`", continuing after 10s...";
	Start-Sleep 10;
}

$JavaArguments = @();
$JavaArguments += "-jar `"${Path_JnlpAgent}`"";
$JavaArguments += "-jnlpUrl `"${URL_JnlpTarget}`"";
$JavaArguments += "-secret `"${Jenkins_Secret}`"";
$JavaArguments += "-workDir `"${WorkingDir}`"";
$JavaArguments += "-noCertificateCheck";

$JavaArguments_Str = $JavaArguments -Join ' ';

$BinPath="java ${JavaArguments_Str}";

# Create the service-configuration (used by service installer)
# New-Item `
# -Force `
# -Type "File" `
# -Path "${Path_ServiceConfig}" `
# -Value ("
# <service>
# 	<id>${ServiceName}</id>
# 	<name>${ServiceName}</name>
# 	<description>${ServiceName}</description>
# 	<executable>'${Path_JavaExe}'</executable>
# 	<logpath>${WorkingDir}\</logpath>
# 	<logmode>roll</logmode>
# 	<depend></depend>
# 	<startargument>-jar</startargument>
# 	<startargument>'${Path_JnlpAgent}'</startargument>
# 	<startargument>-jnlpUrl</startargument>
# 	<startargument>'${URL_JnlpTarget}'</startargument>
# 	<startargument>-secret</startargument>
# 	<startargument>'${Jenkins_Secret}'</startargument>
# 	<startargument>-workDir</startargument>
# 	<startargument>'${WorkingDir}'</startargument>
# 	<startargument>-noCertificateCheck</startargument>
# 	<stopexecutable>'${Path_JavaExe}'</stopexecutable>
# 	<stopargument>stop</stopargument>
# </service>
# ") | Out-Null;

# Create the service-configuration (used by service installer)
New-Item `
-Force `
-Type "File" `
-Path "${Path_ServiceConfig}" `
-Value ("<service>
	<id>${ServiceName}</id>
	<name>${ServiceName}</name>
	<description>${ServiceName}</description>
	<executable>java</executable>
	<arguments>${JavaArguments_Str}</arguments>
	<logpath>${Path_ServiceLogs}</logpath>
	<logmode>rotate</logmode>
	<onfailure action=`"restart`" delay=`"20 sec`"/>
</service>") | Out-Null;

# Delete the service (whether it already exists or not)
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
Write-Host "";
Write-Host "Info:  Installing service `"${ServiceName}`" via executable `"${Path_ServiceInstaller}`"...";
Start-Process -WorkingDirectory ("${WorkingDir}") -Filepath ("${Path_ServiceInstaller}") -ArgumentList (@("install")) -Verb ("RunAs");
Start-Sleep 1;

# Start the service
Write-Host "";
Write-Host "Info:  Starting service `"${ServiceName}`"...";
Start-Service -Name "${ServiceName}" -ErrorAction ("SilentlyContinue");
Start-Sleep 1;

# Verify service exists
Write-Host "";
Write-Host "Info:  Checking for local services with name `"${ServiceName}`"...";
Get-Service -Name ("${ServiceName}");

Start-Sleep 15;
Exit 0;


# ------------------------------------------------------------
# If you wish to delete the service:
#
# If ($False) {
	# TASKKILL /F /FI "IMAGENAME eq Jenkins-JNLP-Service.exe";
	# sc delete "Jenkins-JNLP-Service";
# }
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Start-Process - Starts one or more processes on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
#
#   docs.microsoft.com  |  "Start-Service - Starts one or more stopped services"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-service
#
#   stackoverflow.com  |  "Add nginx.exe as Windows system service (like Apache)?"  |  https://stackoverflow.com/a/13875396
#
# ------------------------------------------------------------