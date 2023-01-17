#!/bin/bash
# ------------------------------
# Linux - wslpath, wslvar (convert WSL paths to Windows paths)
# ------------------------------
# ------------------------------
# ------------------------------

  if [ 1 -eq 1 ]; then
    #
    # Create symbolic links from your WSL instance back to their associated Windows files
    #
    # ------------------------------
    #
    # Links to Windows user-specific filepaths
    #

    USERPROFILE="$(wslpath -u "$(wslvar --sys "USERPROFILE";)";)";

    # C-Drive (to allow git to target the same user credentials across Git-Bash & WSL)
    C_DRIVE="$(realpath "/mnt/c";)";
    if [[ -n "${C_DRIVE}" ]] && [[ -e "${C_DRIVE}" ]] && [[ ! -e "/c" ]]; then
      ln -sf "${C_DRIVE}" "/$(basename "${C_DRIVE}";)";
    fi;

    # Desktop
    DESKTOP="$(realpath "${USERPROFILE}/Desktop";)";
    if [[ -n "${DESKTOP}" ]] && [[ -e "${DESKTOP}" ]] && [[ ! -e "${HOME}/Desktop" ]]; then
      ln -sf "${DESKTOP}" "${HOME}/Desktop";
    fi;

    # .npmrc
    NPMRC="$(realpath "${USERPROFILE}/.npmrc";)";
    if [[ -n "${NPMRC}" ]] && [[ -e "${NPMRC}" ]] && [[ ! -e "${HOME}/.npmrc" ]]; then
      ln -sf "${NPMRC}" "${HOME}/.npmrc";
    fi;

    # .pat
    PAT="$(realpath "${USERPROFILE}/.pat";)";
    if [[ -n "${PAT}" ]] && [[ -e "${PAT}" ]] && [[ ! -e "${HOME}/.pat" ]]; then
      ln -sf "${PAT}" "${HOME}/.pat";
    fi;

    # ------------------------------
    #
    # Links to general Windows executables/binaries
    #

    # CMD.exe
    CMD_EXE="$(WIN_SYS32_EXE="cmd.exe"; if [ -n "$(command -v ${WIN_SYS32_EXE} 2>'/dev/null';)" ]; then echo "$(realpath "$(command -v "${WIN_SYS32_EXE}";)" 2>'/dev/null';)"; elif [ -f "$(find /mnt/*/Windows/System32/${WIN_SYS32_EXE} -mindepth 0 -maxdepth 0 -type f | head -n 1;)" ]; then find /mnt/*/Windows/System32/${WIN_SYS32_EXE} -mindepth 0 -maxdepth 0 -type f | head -n 1; else echo "$(realpath "$(wslpath -u "$(wslvar -s "windir";)";)/System32/${WIN_SYS32_EXE}";)"; fi;)";
    if [[ -n "${CMD_EXE}" ]] && [[ -e "${CMD_EXE}" ]]; then
      sudo ln -sf "${CMD_EXE}" "/usr/local/bin/cmd.exe";
      sudo ln -sf "/usr/local/bin/cmd.exe" "/usr/local/bin/cmd";
    fi;

    # explorer.exe
    EXPLORER_EXE="$(WIN_EXE="explorer.exe"; if [ -n "$(command -v ${WIN_EXE} 2>'/dev/null';)" ]; then echo "$(realpath "$(command -v "${WIN_EXE}";)" 2>'/dev/null';)"; elif [ -f "$(find /mnt/*/Windows/${WIN_EXE} -mindepth 0 -maxdepth 0 -type f | head -n 1;)" ]; then find /mnt/*/Windows/${WIN_EXE} -mindepth 0 -maxdepth 0 -type f | head -n 1; else echo "$(realpath "$(wslpath -u "$(wslvar -s "windir";)";)/${WIN_EXE}";)"; fi;)";
    if [[ -n "${EXPLORER_EXE}" ]] && [[ -e "${EXPLORER_EXE}" ]]; then
      sudo ln -sf "${EXPLORER_EXE}" "/usr/local/bin/explorer.exe";
      sudo ln -sf "/usr/local/bin/explorer.exe" "/usr/local/bin/explorer";
    fi;

    # notepad.exe
    NOTEPAD_EXE="$(WIN_SYS32_EXE="notepad.exe"; if [ -n "$(command -v ${WIN_SYS32_EXE} 2>'/dev/null';)" ]; then echo "$(realpath "$(command -v "${WIN_SYS32_EXE}";)" 2>'/dev/null';)"; elif [ -f "$(find /mnt/*/Windows/System32/${WIN_SYS32_EXE} -mindepth 0 -maxdepth 0 -type f | head -n 1;)" ]; then find /mnt/*/Windows/System32/${WIN_SYS32_EXE} -mindepth 0 -maxdepth 0 -type f | head -n 1; else echo "$(realpath "$(wslpath -u "$(wslvar -s "windir";)";)/System32/${WIN_SYS32_EXE}";)"; fi;)";
    if [[ -n "${NOTEPAD_EXE}" ]] && [[ -e "${NOTEPAD_EXE}" ]]; then
      sudo ln -sf "${NOTEPAD_EXE}" "/usr/local/bin/notepad.exe";
      sudo ln -sf "/usr/local/bin/notepad.exe" "/usr/local/bin/notepad";
    fi;

    # powershell.exe
    POWERSHELL_EXE="$(if [ -n "$(command -v powershell.exe 2>'/dev/null';)" ]; then echo "$(realpath "$(command -v "powershell.exe";)";)"; elif [ -f "$(find /mnt/*/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -mindepth 0 -maxdepth 0 -type f | head -n 1;)" ]; then find /mnt/*/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -mindepth 0 -maxdepth 0 -type f | head -n 1; else echo "$(wslpath -u "$(wslvar -s "windir";)";)/System32/WindowsPowerShell/v1.0/powershell.exe"; fi;)";
    if [[ -n "${POWERSHELL_EXE}" ]] && [[ -e "${POWERSHELL_EXE}" ]]; then
      sudo ln -sf "${POWERSHELL_EXE}" "/usr/local/bin/powershell.exe";
      sudo ln -sf "/usr/local/bin/powershell.exe" "/usr/local/bin/powershell";
    fi;

    # wsl.exe
    WSL_EXE="$(WIN_SYS32_EXE="wsl.exe"; if [ -n "$(command -v ${WIN_SYS32_EXE} 2>'/dev/null';)" ]; then echo "$(realpath "$(command -v "${WIN_SYS32_EXE}";)" 2>'/dev/null';)"; elif [ -f "$(find /mnt/*/Windows/System32/${WIN_SYS32_EXE} -mindepth 0 -maxdepth 0 -type f | head -n 1;)" ]; then find /mnt/*/Windows/System32/${WIN_SYS32_EXE} -mindepth 0 -maxdepth 0 -type f | head -n 1; else echo "$(realpath "$(wslpath -u "$(wslvar -s "windir";)";)/System32/${WIN_SYS32_EXE}";)"; fi;)";
    if [[ -n "${WSL_EXE}" ]] && [[ -e "${WSL_EXE}" ]]; then
      sudo ln -sf "${WSL_EXE}" "/usr/local/bin/wsl.exe";
      sudo ln -sf "/usr/local/bin/wsl.exe" "/usr/local/bin/wsl";
    fi;

  fi;

# ------------------------------
# ------------------------------
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
# NOTE:  It is MUCH faster to use Linux's "find" command instead of wslpath + wslvar, e.g.:
#

# Get cmd.exe's filepath for WSL via Linux's find module
find /mnt/*/Windows/System32/cmd.exe -mindepth 0 -maxdepth 0 -type f | head -n 1;

# Get cmd.exe's filepath for WSL via wslvar + wslpath modules
find $(wslpath -u "$(wslvar -s "ComSpec";)";);


# ------------------------------
#
#
# wslvar
#    -s, --sys - use data from system local & global variables.
#    -l, --shell - use data from Shell folder environment variables.
#    -S, --getsys - show available system local & global variables.
#    -L, --getshell - show available Shell folder environment variables.


# Use [ wslvar + wslpath ] to convert Windows environment variables to Linux filepaths
if [ 1 -eq 1 ]; then
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


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Working across file systems | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/wsl/filesystems
#
# ------------------------------------------------------------