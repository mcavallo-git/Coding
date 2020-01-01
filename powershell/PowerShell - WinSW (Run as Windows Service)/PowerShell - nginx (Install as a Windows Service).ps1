# ------------------------------------------------------------
## Using HTTPS to access TeamCity server

# ------------------------------------------------------------

# Downloaded latest "Stable version" of "NGINX for Windows" from URL "http://nginx.org/en/download.html" (nginx-1.16.1 as-of 2019-11-03_00-37-02)

# Unpacked nginx prepackaged-directory into "c:\nginx" (to match xml config contents, below)

# ------------------------------------------------------------
## Regedit - Check current version of the .NET Framework
# http://nginx.org/en/docs/windows.html

# ------------------------------------------------------------
## PowerShell (As admin)

# $ROLLBACK_POLICY=(Get-ExecutionPolicy); # "Restricted"

Set-ExecutionPolicy "RemoteSigned";

# ------------------------------------------------------------

# Download "WinSW.NET4" from "https://github.com/kohsuke/winsw/releases/download/winsw-v2.2.0/WinSW.NET4.exe" to "C:\nginx\service\NGINX-Service.exe"

$(New-Object Net.WebClient).DownloadFile("https://github.com/kohsuke/winsw/releases/download/winsw-v2.2.0/WinSW.NET4.exe", "C:\nginx\service\NGINX-Service.exe");

# Invoke-WebRequest -Uri "https://github.com/kohsuke/winsw/releases/download/winsw-v2.2.0/WinSW.NET4.exe" -OutFile "C:\nginx\service\NGINX-Service.exe"

# ------------------------------------------------------------

# Setup "C:\nginx\service\NGINX-Service.xml"


New-Item `
-Type "File" `
-Path "C:\nginx\service\NGINX-Service.xml" `
-Value ("
<service>
	<id>NGINX-Service</id>
	<name>NGINX-Service</name>
	<description>NGINX-Service</description>
	<executable>c:\nginx\nginx.exe</executable>
	<logpath>c:\nginx\</logpath>
	<logmode>roll</logmode>
	<depend></depend>
	<startargument>-p</startargument>
	<startargument>c:\nginx</startargument>
	<stopexecutable>c:\nginx\nginx.exe</stopexecutable>
	<stopargument>-p</stopargument>
	<stopargument>c:\nginx</stopargument>
	<stopargument>-s</stopargument>
	<stopargument>stop</stopargument>
</service>
");

# ------------------------------------------------------------
# Ran CMD (from Start Menu) as ADmin
# -> cd'ed into to the Directory containing the WinSW (renamed) runtime-EXE and config-XML

cd "C:\nginx\service";

# Kicked off the installation script to add NGINX as a Windows Service

NGINX-Service.exe install;

# ------------------------------------------------------------

# Done!

# ------------------------------------------------------------
# If you wish to delete the service:

If ($False) {
	TASKKILL /F /FI "IMAGENAME eq NGINX-Service.exe";
	sc delete "NGINX-Service";
}

# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "WebClient.DownloadFile Method - Downloads the resource with the specified URI to a local file"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfile
#
#   stackoverflow.com  |  "Add nginx.exe as Windows system service (like Apache)?"  |  https://stackoverflow.com/a/13875396
#
# ------------------------------------------------------------