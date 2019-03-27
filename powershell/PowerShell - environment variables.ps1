
# Get environment variables combined from both [ Workstation-Spefific ] & [ User-Specific ] environment variables

Get-ChildItem Env:;

Write-Host -NoNewLine 'Press any key to close window...'; $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') | Out-Null; Exit;

# -------------------------------------------------------------------------------------------------------------------------------------------- #

# Inspecting [ Workstation-Spefific ] environment variables

$EnvSystem = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment');
$EnvSystem;

$EnvSystem.GetType();
$EnvSystem | Measure-Object;

($EnvSystem | Measure-Object).Count;

# -------------------------------------------------------------------------------------------------------------------------------------------- #

# Inspecting [ User-Spefific ] environment variables

$EnvUser = Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment';
$EnvUser;
$EnvUser.GetType();

# -------------------------------------------------------------------------------------------------------------------------------------------- #

# Inspecting environment variables combined from both [ Workstation-Spefific ] & [ User-Specific ] environment variables

$EnvAll = @();
$EnvAll += $EnvSystem;
$EnvAll += $EnvUser;
$EnvAll;
$EnvAll.GetType();

$EnvAll.Path;
$EnvAll.Path.Split(';');

### Indices
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
