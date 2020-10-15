
Install-Module -Name ("ID3") -Scope ("CurrentUser") -Force -AllowClobber;
Import-Module "ID3";

$TagLib_Filepath = "${Home}\Desktop\test-file.mp3";
$NewTitle = "";

$TagLib_Obj = [TagLib.File]::Create( (Resolve-Path "${TagLib_Filepath}") );
$TagLib_Obj.Tag.Title = "${NewTitle}";
$TagLib_Obj.Save();
$TagLib_Obj = $Null;

# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "c# - How do I use taglib-sharp? - Stack Overflow"  |  https://stackoverflow.com/a/40839588
#
#   www.powershellgallery.com  |  "PowerShell Gallery | ID3 1.1"  |  https://www.powershellgallery.com/packages/ID3
#
#   www.powershellgallery.com  |  "PowerShell Gallery | id3.psm1 1.1"  |  https://www.powershellgallery.com/packages/ID3/1.1/Content/id3.psm1
#
# ------------------------------------------------------------