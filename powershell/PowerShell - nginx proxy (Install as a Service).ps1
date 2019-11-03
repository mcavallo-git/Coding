# ------------------------------------------------------------
## Using HTTPS to access TeamCity server
# https://confluence.jetbrains.com/display/TCD18/Using+HTTPS+to+access+TeamCity+server?_ga=2.201955857.1631067105.1572703510-1382051871.1572703510

# ------------------------------------------------------------
Downloaded latest "Stable version" of "NGINX for Windows" from URL "http://nginx.org/en/download.html" (nginx-1.16.1 as-of 2019-11-03_00-37-02)

Unpacked nginx prepackaged-directory into "c:\nginx" (to match xml config contents, below)

# ------------------------------------------------------------
## Regedit - Check current version of the .NET Framework
# http://nginx.org/en/docs/windows.html

# ------------------------------------------------------------
## PowerShell (As admin)

$ROLLBACK_POLICY=(Get-ExecutionPolicy); # "Restricted"

Set-ExecutionPolicy "RemoteSigned";

# ------------------------------------------------------------
# Browsed to https://github.com/kohsuke/winsw/releases

Downloaded "WinSW.NET4" from "https://github.com/kohsuke/winsw/releases/download/winsw-v2.2.0/WinSW.NET4.exe" to "${USERPROFILE}/Downloads/."

Renamed "${USERPROFILE}/Downloads/WinSW.NET4" to "${USERPROFILE}/Downloads/TeamcityNginxProxy.exe"

# ------------------------------------------------------------

Respectively created "${USERPROFILE}/Downloads/TeamcityNginxProxy.xml" with contents:

<service>
  <id>TeamCity NGINX Proxy</id>
  <name>TeamCity NGINX Proxy</name>
  <description>TeamCity NGINX Proxy</description>
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

# ------------------------------------------------------------
# Ran CMD (from Start Menu) as ADmin
# -> cd'ed into to the Directory containing the WinSW (renamed) runtime-EXE and config-XML (which, in this case, was the current user's Downloads directory)

cd "%USERPROFILE%\Downloads"

# Kicked off the installation script to add NGINX as a Windows Service
TeamcityNginxProxy.exe install

# ------------------------------------------------------------

# Done!

# ------------------------------------------------------------

# stackoverflow.com  |  "Add nginx.exe as Windows system service (like Apache)?"  |  https://stackoverflow.com/a/13875396

# ------------------------------------------------------------