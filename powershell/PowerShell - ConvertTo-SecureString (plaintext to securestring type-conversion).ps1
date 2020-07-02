# ------------------------------------------------------------

# Start with PlainText string
$String_PlainText = "Some_Plaintext_String";


# Convert PlainText string to SecureString
$PlainText_ToSecureString = ConvertTo-SecureString -String ("${String_PlainText}") -AsPlainText -Force;


# Convert from SecureString back to PlainText
$SecureString_ToPlainText = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode(${PlainText_ToSecureString})));
Write-Output "`n`nInitial PlainText string: `"${SecureString_ToPlainText}`"`n`n";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "ConvertTo-SecureString - Converts encrypted standard strings to secure strings. It can also convert plain text to secure strings. It is used with ConvertFrom-SecureString and Read-Host"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-5.1
#
# ------------------------------------------------------------