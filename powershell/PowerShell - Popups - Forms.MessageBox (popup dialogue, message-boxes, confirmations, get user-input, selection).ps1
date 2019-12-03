# ------------------------------------------------------------
# 
# PowerShell - Popups (Alert, Confirm)
# 
# ------------------------------------------------------------
# 
# Confirmation Popup (get input selection from user)
#   |
#   |--> Includes:  "OK" button
#   |--> Includes:  "Cancel" button
#   |--> Includes:  Close-window option ("X", top-right)
#
$oReturn=[System.Windows.Forms.MessageBox]::Show("Confirm?","Not Title",[System.Windows.Forms.MessageBoxButtons]::OKCancel); Switch ($oReturn) { "OK" { Write-Host "`"OK`" selected"; } "Cancel" { Write-Host "`"Cancel`" selected"; } }


# ------------------------------------------------------------
# 
# Alert Popup (output-only)
#   |
#   |--> Includes:  "OK" button
#   |--> Includes:  Close-window option ("X", top-right)
#
$oReturn=[System.Windows.Forms.Messagebox]::Show("Test alert!"); $oReturn;


# ------------------------------------------------------------
# 
# Ex) Show popup w/ text "Empty the Recycle Bin?" -> If "OK" button is selected, them Empty the Recycle Bin
#
PowerShell.exe -Command "[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); If (([System.Windows.Forms.MessageBox]::Show('Empty the Recycle Bin?','Empty Recycle Bin',[System.Windows.Forms.MessageBoxButtons]::OKCancel)) -Eq 'OK') { cmd.exe /C 'ECHO Y|PowerShell.exe -NoProfile -Command Clear-RecycleBin'; };";



# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "MessageBox Class - Displays a message window, also known as a dialog box, which presents a message to the user"  |  https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox
#
#   stackoverflow.com  |  "Powershell unable to find type [System.Windows.Forms.KeyEventHandler]"  |  https://stackoverflow.com/a/27792262
#
#   michlstechblog.info  |  "Powershell: How to show a message box"  |  https://michlstechblog.info/blog/powershell-show-a-messagebox/
#
# ------------------------------------------------------------