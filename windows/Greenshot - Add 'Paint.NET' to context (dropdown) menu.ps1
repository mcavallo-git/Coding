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
$INI_CONTENT+="Commandline.Paint.NET=C:\Program Files\Paint.NET\PaintDotNet.exe";
$INI_CONTENT+="`n";
$INI_CONTENT+="Argument.Paint.NET=`"{0}`"";
$INI_CONTENT+="`n";
$INI_CONTENT+="RunInbackground.Paint.NET=True";
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