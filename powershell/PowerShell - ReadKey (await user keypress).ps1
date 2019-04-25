
# Wait for user to press any key

Write-Host -NoNewLine "`n`n  Awaiting KeyPress...";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host (("`n`n  You pressed the `"")+($KeyPress.Character)+("`" Key`n`n"));


Write-Host -NoNewLine "`n`n  Press any key to exit...";
$KeyPressExit = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

#
# Thanks to stackoverflow user 'Knuckle-Dragger' on forum: https://stackoverflow.com/questions/20886243
#
