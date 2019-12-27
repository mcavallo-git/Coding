# ------------------------------------------------------------

# Get environment variables combined from both [ Workstation-Spefific ] & [ User-Specific ] environment variables

# Method 1
Get-ChildItem Env: | Format-List;

# Method A
[Environment]::GetEnvironmentVariables("Process") | Format-List;

Write-Host -NoNewLine 'Press any key to close window...'; $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') | Out-Null; Exit;

# ------------------------------------------------------------

# SYSTEM  environment variables (inspecting)

$EnvSystem = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment');
$EnvSystem;
($EnvSystem.Path) -replace (";","`n")

$EnvSystem.GetType();
$EnvSystem | Measure-Object;

($EnvSystem | Measure-Object).Count;

# ------------------------------------------------------------

# USER environment variables (inspecting)

$EnvUser = Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment';
$EnvUser;
($EnvUser.Path) -replace (";","`n")

$EnvUser.GetType();

# ------------------------------------------------------------

# Inspecting environment variables combined from both [ Workstation-Spefific ] & [ User-Specific ] environment variables

$EnvAll = @();
$EnvAll += $EnvSystem;
$EnvAll += $EnvUser;
$EnvAll;
$EnvAll.GetType();

$EnvAll.Path;
$EnvAll.Path.Split(';');

# ------------------------------------------------------------
#
# Citation(s)
#
#  stackovertflow.com  |  "Windows user environment variable vs. system environment variable"  |  https://stackoverflow.com/a/30675792
#
# ------------------------------------------------------------