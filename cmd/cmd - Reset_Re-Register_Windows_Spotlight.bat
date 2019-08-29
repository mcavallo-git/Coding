@ECHO OFF

:: Reset Windows Spotlight
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\Settings"

:: Re-register Windows Spotlight
REM PowerShell -ExecutionPolicy Unrestricted -Command "& {$ManifestPath = (Get-AppxPackage *ContentDeliveryManager*).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $ManifestPath}"
PowerShell -ExecutionPolicy Unrestricted -Command "& {Get-AppxPackage -User ($(whoami)) -Name 'Microsoft.Windows.ContentDeliveryManager' | ForEach { Add-AppxPackage -Path (($_.InstallLocation)+('\AppxManifest.xml')) -DisableDevelopmentMode -Register; }}"



REM	------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		tenforums.com  |  "How to Reset and Re-register Windows Spotlight in Windows 10"  |  https://www.tenforums.com/tutorials/82156-reset-re-register-windows-spotlight-windows-10-a.html
REM
REM	------------------------------------------------------------