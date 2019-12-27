# ------------------------------------------------------------
# 
# PERMANENTLY modify user/system environment variables in Windows
# 

### Modify a system environment variable
[Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)


### Modify a user environment variable
[Environment]::SetEnvironmentVariable("INCLUDE", $env:INCLUDE, [System.EnvironmentVariableTarget]::User)


# ------------------------------------------------------------
# 
# TEMPORARILY modify session environment variables in Windows
# 

$env:Path = "SomeRandomPath";  # (replaces existing path) 
$env:Path += ";SomeRandomPath";  # (appends to existing path)


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "Setting Windows PowerShell environment variables"  |  https://stackoverflow.com/a/2571200
#
# ------------------------------------------------------------