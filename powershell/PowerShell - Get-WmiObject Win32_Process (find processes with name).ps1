# ------------------------------------------------------------

$PROCESS_NAME="nginx"; (Get-WmiObject -Query "SELECT * FROM Win32_Process " | Where-Object { ${_}.ProcessName -Like "*${PROCESS_NAME}*" });


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-WmiObject"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject
#
#   docs.microsoft.com  |  "Win32_Process class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-process
#
# ------------------------------------------------------------