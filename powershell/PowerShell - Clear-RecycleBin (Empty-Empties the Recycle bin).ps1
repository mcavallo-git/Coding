# ------------------------------------------------------------
# 
# Empty Recycle Bin -> Show popup w/ text "Empty the Recycle Bin?" -> If "Yes" button is selected, them Empty the Recycle Bin
# 
If (([System.Windows.Forms.MessageBox]::Show('Empty the Recycle Bin?','Empty Recycle Bin',[System.Windows.Forms.MessageBoxButtons]::YesNo)) -Eq 'Yes') { cmd.exe /C 'ECHO Y|PowerShell.exe -NoProfile -Command Clear-RecycleBin'; };


# ------------------------------------------------------------
# 
# Empty Recycle Bin -> Immediately (no confirmation req'd)
# 
cmd.exe /C 'ECHO Y|PowerShell.exe -NoProfile -Command Clear-RecycleBin';


# ------------------------------------------------------------
# Citation(s)
# 
#   winaero.com  |  "Empty Recycle Bin automatically in Windows 10"  |  https://winaero.com/blog/empty-recycle-bin-automatically-in-windows-10/
# 
# ------------------------------------------------------------