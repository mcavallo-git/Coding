
$RegistryKey_RunAsAdmin = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers";
New-Item -Path ("${RegistryKey_RunAsAdmin}") -ErrorAction "SilentlyContinue" | Out-Null;

$ExeList_AlwaysRunAsAdmin = @();
$ExeList_AlwaysRunAsAdmin += "devenv.com";
$ExeList_AlwaysRunAsAdmin += "devenv.exe";
$ExeList_AlwaysRunAsAdmin += "msbuild.exe";

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $ExeList_AlwaysRunAsAdmin.Contains("$($_.Name)") } | ForEach-Object {
Set-ItemProperty -Path ("${RegistryKey_RunAsAdmin}") -Name ("$($_.FullName)") -Type ("String") -Value ("RUNASADMIN") -Force -ErrorAction "SilentlyContinue" | Out-Null;
}


# ------------------------------------------------------------
#
#	Citation(s)
#
#		www.verboon.info  |  "Running an Application as Administrator or in Compatibility Mode – Anything about IT"  |  https://www.verboon.info/2011/03/running-an-application-as-administrator-or-in-compatibility-mode/
#
# ------------------------------------------------------------