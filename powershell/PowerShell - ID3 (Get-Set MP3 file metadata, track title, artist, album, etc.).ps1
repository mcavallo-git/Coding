
Install-Module -Name ("ID3") -Scope ("CurrentUser") -Force -AllowClobber;

$TargetFile = "${Home}\Desktop\test-file.mp3";
$NewTitle = "";

$TagLib_File = [TagLib.File]::Create("${TargetFile}");
$TagLib_File.Tag.Title = "${NewTitle}";
$TagLib_File.Save();


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "c# - How do I use taglib-sharp? - Stack Overflow"  |  https://stackoverflow.com/a/40839588
#
#   www.powershellgallery.com  |  "PowerShell Gallery | ID3 1.1"  |  https://www.powershellgallery.com/packages/ID3
#
# ------------------------------------------------------------