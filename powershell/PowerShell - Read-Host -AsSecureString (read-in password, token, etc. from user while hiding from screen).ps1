

$PasswordPlaintext = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString))));


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.scriptinglibrary.com  |  "Passwords and SecureString, How To Decode It with Powershell | Scripting Library"  |  https://www.scriptinglibrary.com/languages/powershell/securestring-how-to-decode-it-with-powershell/
#
# ------------------------------------------------------------