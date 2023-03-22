# ------------------------------------------------------------

# Downloaded latest "Stable version" of "NGINX for Windows" from URL "http://nginx.org/en/download.html"

# Unpack nginx .zip archive to "c:\nginx", ensuring that "nginx.exe" gets unpacked to "c:\nginx\nginx.exe" (to match xml config contents, below)

# ------------------------------------------------------------
## PowerShell (As admin)

# $ROLLBACK_POLICY=(Get-ExecutionPolicy); # "Restricted"

Set-ExecutionPolicy "RemoteSigned";

# ------------------------------------------------------------

# Download "Windows Service Wrapper"
#  |--> To check currently-installed version(s) of .NET Framework, see http://nginx.org/en/docs/windows.html

$(New-Object Net.WebClient).DownloadFile("https://github.com/winsw/winsw/releases/download/v2.7.0/WinSW.NET4.exe", "C:\nginx\service\NGINX-Service.exe") -Verb RunAs;

# ------------------------------------------------------------

# Setup config file for "Windows Service Wrapper"

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

# Run "Windows Service Wrapper" to add NGINX as a Windows Service

# RUN AS ADMIN --> Install NGINX-Service

cd "C:\nginx\service";

NGINX-Service.exe install;


# ------------------------------------------------------------

# If you wish to delete the service

If ($False) {
  TASKKILL /F /FI "IMAGENAME eq NGINX-Service.exe";
  sc.exe delete "NGINX-Service";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "GitHub - winsw/winsw: A wrapper executable that can run any executable as a Windows service, in a permissive license."  |  https://github.com/winsw/winsw
#
#   stackoverflow.com  |  "Add nginx.exe as Windows system service (like Apache)?"  |  https://stackoverflow.com/a/13875396
#
# ------------------------------------------------------------