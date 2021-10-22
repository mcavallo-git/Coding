# ------------------------------------------------------------
#
# PowerShell - Get installed drivers versions via Get-WmiObject Win32_PnPSignedDriver
#


Get-WmiObject Win32_PnPSignedDriver | Select-Object devicename, driverversion | Sort-Object devicename


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-WmiObject"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject
#
#   docs.microsoft.com  |  "Win32\_PnPSignedDriver class | Microsoft Docs"  |  https://docs.microsoft.com/en-us/previous-versions/windows/desktop/whqlprov/win32-pnpsigneddriver
#
#   itprotoday.com  |  "Check Installed Driver Versions Using PowerShell"  |  https://www.itprotoday.com/powershell/check-installed-driver-versions-using-powershell
#
# ------------------------------------------------------------