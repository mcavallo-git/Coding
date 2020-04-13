# ------------------------------------------------------------

$PasswordPlaintext = Read-Host -Prompt 'Type an example Username (in plaintext): ';
Write-Host "You typed `"${PasswordPlaintext}`"";


# ------------------------------------------------------------

$PasswordPlaintext = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString))));


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Read-Host - Reads a line of input from the console."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-5.1
#
#   stackoverflow.com  |  "c# - Convert String to SecureString - Stack Overflow"  |  https://stackoverflow.com/a/43084626
#
#   www.scriptinglibrary.com  |  "Passwords and SecureString, How To Decode It with Powershell | Scripting Library"  |  https://www.scriptinglibrary.com/languages/powershell/securestring-how-to-decode-it-with-powershell/
#
# ------------------------------------------------------------