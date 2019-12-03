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
$oReturn=[System.Windows.Forms.MessageBox]::Show("Message Text","Title",[System.Windows.Forms.MessageBoxButtons]::OKCancel)	
Switch ($oReturn) {
    "OK" {
        write-host "You pressed OK"
        # Enter some code
    } 
    "Cancel" {
        write-host "You pressed Cancel"
        # Enter some code
    } 
}


# ------------------------------------------------------------
# 
# Alert Popup (output-only)
#   |
#   |--> Includes:  "OK" button
#   |--> Includes:  Close-window option ("X", top-right)
#
$oReturn=[System.Windows.Forms.Messagebox]::Show("This is the Message text"); $oReturn;


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "MessageBox Class - Displays a message window, also known as a dialog box, which presents a message to the user"  |  https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox?view=netframework-4.8
#
#   michlstechblog.info  |  "Powershell: How to show a message box"  |  https://michlstechblog.info/blog/powershell-show-a-messagebox/
#
# ------------------------------------------------------------