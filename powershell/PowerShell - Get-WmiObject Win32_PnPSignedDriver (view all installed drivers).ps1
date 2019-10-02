
Get-WmiObject Win32_PnPSignedDriver | Select-Object devicename, driverversion | Sort-Object devicename


# ------------------------------------------------------------
#
# Citation(s)
#
#		docs.microsoft.com  |  "Win32_VideoController class"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videocontroller
#
#		docs.microsoft.com  |  "Win32_VideoConfiguration class"  |  https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-videoconfiguration
#
#		itprotoday.com  |  "Check Installed Driver Versions Using PowerShell"  |  https://www.itprotoday.com/powershell/check-installed-driver-versions-using-powershell
#
# ------------------------------------------------------------
