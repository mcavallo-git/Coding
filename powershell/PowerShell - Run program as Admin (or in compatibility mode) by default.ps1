# ------------------------------------------------------------
#
# Run a given powershell-script as Administrator
#

Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `". '${Fullpath_to_PS1_Script}';`"" -Verb RunAs;


# ------------------------------------------------------------
#
# Run a given executable as Administrator
#

$RegistryKey_RunAsAdmin = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers";
New-Item -Path ("${RegistryKey_RunAsAdmin}") -ErrorAction "SilentlyContinue" | Out-Null;

$ExeList_AlwaysRunAsAdmin = @();
$ExeList_AlwaysRunAsAdmin += "devenv.com";
$ExeList_AlwaysRunAsAdmin += "devenv.exe";
$ExeList_AlwaysRunAsAdmin += "msbuild.exe";

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $ExeList_AlwaysRunAsAdmin.Contains("$($_.Name)".ToLower()) } | ForEach-Object {
Set-ItemProperty -Path ("${RegistryKey_RunAsAdmin}") -Name ("$($_.FullName)") -Type ("String") -Value ("RUNASADMIN") -Force -ErrorAction "SilentlyContinue" | Out-Null;
}


# ------------------------------------------------------------
#
#	Citation(s)
#
#		www.verboon.info  |  "Running an Application as Administrator or in Compatibility Mode – Anything about IT"  |  https://www.verboon.info/2011/03/running-an-application-as-administrator-or-in-compatibility-mode/
#
# ------------------------------------------------------------