# ------------------------------
# PowerShell - Set-Content, Add-Content (set, overwrite or append content onto target filepath)
# ------------------------------


If ($True) {
  # Ex 1) Create a test file on the desktop and run it
  $Path_TestScript = "${Env:UserProfile}\Desktop\test_set-content_$(Get-Date -UFormat '%Y%m%d-%H%M%S').ps1";
  Set-Content -Path ("${Path_TestScript}") -Value ("Get-Item `"`${PSCommandPath}`" | Format-List *;");
  . "${Path_TestScript}";
}


# ------------------------------

If ($True) {

  # Ex 2) Remove invalid filename-filepath characters from string

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


# ------------------------------
#
# Add-Content - Append to file (there is no "Set-Content -Append")
#  |
#  |--> Note that Add-Content always append a newline - You may be able to workaround this with Write-Output + Out-File (need to test)
#

Add-Content -Path ("${OutputFile}") -Value ("Append Onto File");

Write-Output "Append Onto File" | Add-Content -Path ("${OutputFile}");


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Add-Content (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content
#
#   learn.microsoft.com  |  "Set-Content (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-content
#
#   stackoverflow.com  |  "How to list all properties of a PowerShell object - Stack Overflow"  |  https://stackoverflow.com/a/7259178
#
#   stackoverflow.com  |  "powershell - How to strip illegal characters before trying to save filenames? - Stack Overflow"  |  https://stackoverflow.com/a/52528107
#
# ------------------------------------------------------------