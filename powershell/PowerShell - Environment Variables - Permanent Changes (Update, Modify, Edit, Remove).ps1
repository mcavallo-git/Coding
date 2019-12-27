# ------------------------------------------------------------
# 
# PERMANENTLY modify user/system environment variables in Windows
# 


$Env:Path += ";C:\Program Files (x86)\VMware\VMware Workstation";  # Temporarily APPENDS TO existing path
[Environment]::SetEnvironmentVariable("Path", $Env:Path, [System.EnvironmentVariableTarget]::Machine);  # Permanently updates a system environment variable


$Env:Path += ";C:\Program Files (x86)\VMware\VMware Workstation";
C:\Users\matthew.cavallo\Desktop\2019-12-27 16_20_01-Environment Variables.png
[Environment]::SetEnvironmentVariable("INCLUDE", $Env:INCLUDE, [System.EnvironmentVariableTarget]::User);  # Permanently updates a user environment variable


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