# ------------------------------------------------------------
#
# Greenshot - Add 'Paint.NET' to context (dropdown) menu
#


If ($True) {
$FULLPATH_GREENSHOT_INI="${env:APPDATA}\Greenshot\Greenshot.ini";
$INI_CONTENT="";
$INI_CONTENT+="[ExternalCommand]";
$INI_CONTENT+="`n";
$INI_CONTENT+="Commands=Paint.NET";
$INI_CONTENT+="`n";
$INI_CONTENT+="RedirectStandardError=True";
$INI_CONTENT+="`n";
$INI_CONTENT+="RedirectStandardOutput=True";
$INI_CONTENT+="`n";
$INI_CONTENT+="ShowStandardOutputInLog=False";
$INI_CONTENT+="`n";
$INI_CONTENT+="ParseForUri=True";
$INI_CONTENT+="`n";
$INI_CONTENT+="OutputToClipboard=False";
$INI_CONTENT+="`n";
$INI_CONTENT+="UriToClipboard=True";
$INI_CONTENT+="`n";
$INI_CONTENT+="Commandline.Paint.NET=C:\Program Files\Paint.NET\PaintDotNet.exe";
$INI_CONTENT+="`n";
$INI_CONTENT+="Argument.Paint.NET=`"{0}`"";
$INI_CONTENT+="`n";
$INI_CONTENT+="RunInbackground.Paint.NET=True";
$INI_CONTENT+="`n";
$INI_CONTENT+="DeletedBuildInCommands=";
Write-Host "";
Write-Host "Greenshot - Add 'Paint.NET' to context (dropdown) menu`n";
Write-Host "Ensure the following content exists in `"${FULLPATH_GREENSHOT_INI}`:`n`n";
Write-Host "${INI_CONTENT}" -NoNewLine -ForegroundColor "Yellow" -BackgroundColor "Black";
Write-Host "`n`n";
Write-Host "Opening notepad in 10 seconds with file `"${FULLPATH_GREENSHOT_INI}`"...";
Start-Sleep -Seconds 10;
notepad.exe "${FULLPATH_GREENSHOT_INI}";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   getgreenshot.org  |  "How can I remove plugins or destinations from Greenshot?"  |  https://getgreenshot.org/faq/how-remove-plugins-or-destinations-from-greenshot/
#
# ------------------------------------------------------------