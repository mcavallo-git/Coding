# ------------------------------------------------------------
# PowerShell - Remove invalid filename-filepath characters from string
# ------------------------------------------------------------

If ($True) {

# Remove invalid filename-filepath characters from string

$Invalid_Basename="Invalid<`${!#>  Filename[Characters].txt";

$Valid_Basename="${Invalid_Basename}";
$Valid_Basename=("${Valid_Basename}".Split([System.IO.Path]::GetInvalidFileNameChars()) -join '_');

$Output_Dirname = "${Home}\Desktop\";

Write-Host "";
Write-Host "Invalid_Basename: `"${Invalid_Basename}`"";
Write-Host "";
Write-Host "Valid_Basename: `"${Valid_Basename}`"";
Write-Host "";
Write-Host "Output_Dirname: `"${Output_Dirname}`"";
Write-Host "";

Set-Content -LiteralPath ("${Output_Dirname}\${Valid_Basename}") -Value (Get-Date) -NoNewline;

notepad.exe "${Output_Dirname}\${Valid_Basename}"

};


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "powershell - How to strip illegal characters before trying to save filenames? - Stack Overflow"  |  https://stackoverflow.com/a/52528107
#
# ------------------------------------------------------------