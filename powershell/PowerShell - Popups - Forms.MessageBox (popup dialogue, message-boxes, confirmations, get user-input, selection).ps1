# ------------------------------------------------------------
# 
# PowerShell - Popups (Alert, Confirm)
# 
# ------------------------------------------------------------
# 
# Confirmation Popup (get input selection from user)
#   |
#   |--> Includes:  "Yes" button
#   |--> Includes:  "No" button
#   |--> Includes:  Close-window option ("X", top-right)
#
$oReturn=[System.Windows.Forms.MessageBox]::Show("Confirm?","Confirmation Required",[System.Windows.Forms.MessageBoxButtons]::YesNo); Switch ($oReturn) { "Yes" { Write-Host "`"Yes`" selected"; } "No" { Write-Host "`"No`" selected"; } }


# ------------------------------------------------------------
# 
# Alert Popup (output-only)
#   |
#   |--> Includes:  "Yes" button
#   |--> Includes:  Close-window option ("X", top-right)
#
$oReturn=[System.Windows.Forms.Messagebox]::Show("Test alert!"); $oReturn;


# ------------------------------------------------------------
# 
# Ex) Show popup w/ text "Empty the Recycle Bin?" -> If "Yes" button is selected, them Empty the Recycle Bin
#
powershell.exe -NoProfile -WindowStyle Hidden -Command ("[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); If (([System.Windows.Forms.MessageBox]::Show('Empty the Recycle Bin?','Confirmation Required',[System.Windows.Forms.MessageBoxButtons]::YesNo)) -Eq 'Yes') { cmd.exe /C 'ECHO Y|powershell.exe -NoProfile -Command Clear-RecycleBin'; };");


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "MessageBox Class - Displays a message window, also known as a dialog box, which presents a message to the user"  |  https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox
#
#   stackoverflow.com  |  "Powershell unable to find type [System.Windows.Forms.KeyEventHandler]"  |  https://stackoverflow.com/a/27792262
#
#   stackoverflow.com  |  "How to run a PowerShell script without displaying a window?"  |  https://stackoverflow.com/a/45473968
#
#   michlstechblog.info  |  "Powershell: How to show a message box"  |  https://michlstechblog.info/blog/powershell-show-a-messagebox/
#
# ------------------------------------------------------------