

$PasswordPlaintext = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString))));


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "c# - Convert String to SecureString - Stack Overflow"  |  https://stackoverflow.com/a/43084626
#
#   www.scriptinglibrary.com  |  "Passwords and SecureString, How To Decode It with Powershell | Scripting Library"  |  https://www.scriptinglibrary.com/languages/powershell/securestring-how-to-decode-it-with-powershell/
#
# ------------------------------------------------------------