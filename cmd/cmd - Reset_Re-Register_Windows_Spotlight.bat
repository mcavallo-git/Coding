@ECHO OFF

:: Reset Windows Spotlight
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\Settings"

:: Re-register Windows Spotlight
PowerShell -ExecutionPolicy Unrestricted -Command "& {$ManifestPath = (Get-AppxPackage *ContentDeliveryManager*).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $ManifestPath}"



REM	------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		tenforums.com  |  "How to Reset and Re-register Windows Spotlight in Windows 10"  |  https://www.tenforums.com/tutorials/82156-reset-re-register-windows-spotlight-windows-10-a.html
REM
REM	------------------------------------------------------------