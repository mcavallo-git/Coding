# ------------------------------------------------------------
#
# PowerShell - New-Item, Set-ItemProperty
#
# ------------------------------------------------------------
#
### Creating Registry keys using  [ New-Item -Force ... ]
#   |--> Upside - Creates ALL parent registry keys
#   |--> Downside - DELETES all properties & child-keys if key already exists
#   |--> Takeaway - Always use  [ Test-Path ... ]  to verify registry keys don't exist before using  [ New-Item -Force ... ]  to create the key
#
If ((Test-Path -Path ('Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced')) -Eq $False) {
	### Explorer Settings - Setting to [ 0 ] selects "Show hidden files, folders, and drives", setting to [ 1 ] selects "Don't show hidden files, folders, or drives"
	New-Item -Force -Path ('Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced') | Out-Null;
}
Set-ItemProperty -Force -Path ('Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced') -Name ('Hidden') -Value (0) | Out-Null;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "New-Item recursive registry keys"  |  https://stackoverflow.com/a/21770519
#
# ------------------------------------------------------------