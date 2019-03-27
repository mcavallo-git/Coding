
# Wait for user to press any key
Write-Host -NoNewLine "Press any key to continue...";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

#
# Thanks to user 'Knuckle-Dragger' on stackoverflow: https://stackoverflow.com/questions/20886243
#