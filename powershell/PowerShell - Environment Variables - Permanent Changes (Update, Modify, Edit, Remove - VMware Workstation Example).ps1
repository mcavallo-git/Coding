# ------------------------------------------------------------
# 
# PERMANENTLY modify user/system environment variables in Windows
# 

# PERMANENTLY  modify  USER  environment variable, "PATH"
$ADD_PATH = "C:\Program Files (x86)\VMware\VMware Workstation"; `
[Environment]::SetEnvironmentVariable("Path", (((Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment').Path)+(";${ADD_PATH}")), [System.EnvironmentVariableTarget]::User);


# PERMANENTLY  modify  SYSTEM  environment variable, "PATH"
$ADD_PATH = "C:\Program Files (x86)\VMware\VMware Workstation"; `
[Environment]::SetEnvironmentVariable("Path", (((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment').Path)+(";${ADD_PATH}")), [System.EnvironmentVariableTarget]::Machine);



# ------------------------------------------------------------
# 
# TEMPORARILY modify session environment variables in Windows
# 

$Env:Path = "C:\Trash";  # Temporarily REPLACES existing path
$Env:Path += ";C:\Program Files (x86)\VMware\VMware Workstation";  # Temporarily APPENDS TO existing path


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "Setting Windows PowerShell environment variables"  |  https://stackoverflow.com/a/2571200
#
# ------------------------------------------------------------