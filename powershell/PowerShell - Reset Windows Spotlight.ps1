
# Remove Windows Spotlight registration files..?
cmd.exe /c "DEL /F /S /Q /A `"${HOME}/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets`"";
cmd.exe /c "DEL /F /S /Q /A `"${HOME}/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\Settings`"";

# Re-register Windows Spotlight
Get-AppxPackage -Name "Microsoft.Windows.ContentDeliveryManager" | Foreach { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose; };

#
# Citation(s)
#
#		kapilarya.com  :::  "[How To] Re-register Windows Spotlight In Windows 10"  :::  https://www.kapilarya.com/how-to-re-register-windows-spotlight-in-windows-10
#