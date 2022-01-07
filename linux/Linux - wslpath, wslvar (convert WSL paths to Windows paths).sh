#!/bin/bash
# ------------------------------
# Linux - wslpath, wslvar (convert WSL paths to Windows paths)
# ------------------------------
#
# wslpath 
#    -a    force result to absolute path format
#    -u    translate from a Windows path to a WSL path (default)
#    -w    translate from a WSL path to a Windows path
#    -m    translate from a WSL path to a Windows path, with '/' instead of '\'
#

wslpath -u 'C:\Windows\System32';  # Outputs:  /mnt/c/Windows/System32

wslpath -w "/";  # Outputs:  \\wsl$\Ubuntu\


# ------------------------------
#
#
# wslvar
#    -s, --sys - use data from system local & global variables.
#    -l, --shell - use data from Shell folder environment variables.
#    -S, --getsys - show available system local & global variables.
#    -L, --getshell - show available Shell folder environment variables.


# Use [ wslvar + wslpath ] to convert Windows environment variables to Linux filepaths
if [[ 1 -eq 1 ]]; then
wslpath -u "$(wslvar -s "windir";)";              # Outputs:  /mnt/c/Windows
wslpath -u "$(wslvar -s "windir";)/System32";     # Outputs:  /mnt/c/Windows/System32
wslpath -u "$(wslvar -s "USERPROFILE";)";         # Outputs:  /mnt/c/Users/USER
wslpath -u "$(wslvar -s "SystemDrive";)/Default"; # Outputs:  /mnt/c/Default
wslpath -u "$(wslvar -s "SystemDrive";)/Users";   # Outputs:  /mnt/c/Users
wslpath -u "$(wslvar -l "Desktop";)";             # Outputs:  /mnt/c/Users/USER/Desktop
wslpath -u "$(wslvar -l "Personal";)";            # Outputs:  /mnt/c/Users/USER/Documents
wslpath -u "$(wslvar -l "AppData";)";             # Outputs:  /mnt/c/Users/USER/AppData/Roaming
wslpath -u "$(wslvar -l "Local AppData";)";       # Outputs:  /mnt/c/Users/USER/AppData/Local
fi;


# Note: wslpath isn't able to convert paths without a backslash on them, such as Windows' environment variable "SystemDrive"
echo "$(wslpath -u "$(wslvar -s "SystemDrive")";)";  # Outputs:  C:
echo "$(wslpath -u "$(wslvar -s "SystemDrive")/";)";  # Outputs:  /mnt/c/


# ------------------------------
#
# wslpath can convert Linux filepaths to Windows relative filepaths, as well
#

echo "$(wslpath -w "/";)";     # Outputs:  \\wsl$\Ubuntu\
echo "$(wslpath -w "/root";)"; # Outputs:  \\wsl$\Ubuntu\root
echo "$(wslpath -w "/tmp";)"; # Outputs:   \\wsl$\Ubuntu\tmp


# ------------------------------