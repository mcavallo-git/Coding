

$RegistryKey_RunAsAdmin = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers";
New-Item -Path ("${RegistryKey_RunAsAdmin}") -ErrorAction "SilentlyContinue" | Out-Null;

$Programs_AlwaysRunAsAdmin = @();
$Programs_AlwaysRunAsAdmin += "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.com";
$Programs_AlwaysRunAsAdmin += "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\MSBuild.exe";
$Programs_AlwaysRunAsAdmin += "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\MSBuild.exe";

ForEach ($EachProgram In ${Programs_AlwaysRunAsAdmin}) {
	New-ItemProperty -Path ("${RegistryKey_RunAsAdmin}") -Name ("${EachProgram}") -PropertyType ("String") -Value ("RUNASADMIN") -ErrorAction "SilentlyContinue" | Out-Null;
}


# ------------------------------------------------------------
#
#	Citation(s)
#
#		www.verboon.info  |  "Running an Application as Administrator or in Compatibility Mode – Anything about IT"  |  https://www.verboon.info/2011/03/running-an-application-as-administrator-or-in-compatibility-mode/
#
# ------------------------------------------------------------