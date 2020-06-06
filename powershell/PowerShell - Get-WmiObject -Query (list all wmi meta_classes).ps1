
If (($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) { $Host.UI.RawUI.BufferSize = (New-Object ((($Host.UI.RawUI).BufferSize).GetType().FullName) (16384, $Host.UI.RawUI.BufferSize.Height)); }; <# Update PowerShell console width to 16384 characters #>


(Get-WmiObject -Query "SELECT * FROM meta_class").Name;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Retrieving a WMI Class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/wmisdk/retrieving-a-class
#
# ------------------------------------------------------------