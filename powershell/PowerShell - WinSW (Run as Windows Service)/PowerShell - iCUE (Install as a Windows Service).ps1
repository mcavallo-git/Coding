# ------------------------------------------------------------

Set-ExecutionPolicy "RemoteSigned";

# ------------------------------------------------------------

$EXE_FULLPATH="C:\Program Files (x86)\Corsair\CORSAIR iCUE Software\iCUE.exe";

$EXE_BASENAME = ([System.IO.Path]::GetFileNameWithoutExtension(${EXE_FULLPATH}));

$EXE_DIRNAME = ([System.IO.Path]::GetDirectoryName(${EXE_FULLPATH}));

$SVC_BASENAME = "${EXE_BASENAME}-Service";

$SVC_DIRNAME = "${EXE_DIRNAME}\${SVC_BASENAME}";

If ((Test-Path "${SVC_DIRNAME}") -Eq $False) {
	New-Item -ItemType Directory -Path "${SVC_DIRNAME}";
}

$SVC_LOGS_DIRNAME = "${SVC_DIRNAME}\logs";

If ((Test-Path "${SVC_LOGS_DIRNAME}") -Eq $False) {
	New-Item -ItemType Directory -Path "${SVC_LOGS_DIRNAME}";
}

# Download/Setup WinSW Executable
$(New-Object Net.WebClient).DownloadFile("https://github.com/kohsuke/winsw/releases/download/winsw-v2.2.0/WinSW.NET4.exe", "${SVC_DIRNAME}\${SVC_BASENAME}.exe");

# Create/Setup WinSW Configuration
New-Item `
-Type "File" `
-Path "${SVC_DIRNAME}\${SVC_BASENAME}.xml" `
-Value ("
<service>
	<id>${SVC_BASENAME}</id>
	<name>${SVC_BASENAME}</name>
	<description>${SVC_BASENAME}</description>
	<executable>${EXE_FULLPATH}</executable>
	<logpath>${SVC_LOGS_DIRNAME}\</logpath>
	<logmode>roll</logmode>
	<depend></depend>
	<startargument>-p</startargument>
	<startargument>${EXE_DIRNAME}</startargument>
	<stopexecutable>${EXE_FULLPATH}</stopexecutable>
	<stopargument>-p</stopargument>
	<stopargument>${EXE_DIRNAME}</stopargument>
	<stopargument>-s</stopargument>
	<stopargument>stop</stopargument>
</service>
");

# ------------------------------------------------------------
# Ran CMD (from Start Menu) as ADmin
# -> cd'ed into to the Directory containing the WinSW (renamed) runtime-EXE and config-XML

cd "${SVC_DIRNAME}";

# Kicked off the installation script to add NGINX as a Windows Service

Start-Process -Filepath ("${SVC_BASENAME}.exe") -ArgumentList ("install") -Verb ("RunAs") -WindowStyle ("Hidden");


# ------------------------------------------------------------

# Done!

# ------------------------------------------------------------
# If you wish to delete the service:

If ($False) {
	TASKKILL /F /FI "IMAGENAME eq ${SVC_BASENAME}.exe";
	sc delete "${SVC_BASENAME}";
}

# ------------------------------------------------------------

# stackoverflow.com  |  "Add nginx.exe as Windows system service (like Apache)?"  |  https://stackoverflow.com/a/13875396

# ------------------------------------------------------------