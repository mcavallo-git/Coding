
#
# EXPLANATION OF WHY THIS IS SO DRAWN OUT
#  |
#  |--> The registry only shows a read-only copy of the settings in the Group Policy Editor (gpedit.msc)
#  |
#  |--> The values held in the registry at a given point in time are calculated from the combined group policies applied to the workstation & user (and possibly domain) at any given point in time (and from any given user-reference)
#  |
#  |--> The source of these values is controlled not by setting the registry keys, but by using Group Policy specific commands to set the values which gpedit.msc pulls from, locally
#


Install-Module -Name ("PolicyFileEditor") -Scope ("CurrentUser") -Force;


###
### Manually set Filetype Associations config-file path
###  > Open  [ Local Group Policy Editor ], e.g.  [ gpedit.msc ] 
###   > Computer Configuration
###    > Administrative Templates
###     > Windows Components
###      > File Explorer
###       > Set a default associations configuration file
###
Write-Host "";
Write-Host -NoNewLine "Info:  Enabling Group Policy Administrative Template `"" -ForegroundColor "DarkGray";
Write-Host -NoNewLine "Set a default associations configuration file" -ForegroundColor "Gray";
Write-Host -NoNewLine "`" to value `"" -ForegroundColor "DarkGray";
Write-Host -NoNewLine "${DefaultAssociations_Windows}" -ForegroundColor "Gray";
Write-Host -NoNewLine "`" ..." -ForegroundColor "DarkGray";
Write-Host -NoNewLine "`n";
Set-PolicyFileEntry `
-Path ("${Env:SystemRoot}\System32\GroupPolicy\Machine\Registry.pol") `
-Key ("Software\Policies\Microsoft\Windows\System") `
-ValueName ("DefaultAssociationsConfiguration") `
-Data ("${DefaultAssociations_Windows}") `
-Type ("String");




$HKLM_Path="SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"; `
$Name="MaxCompressionLevel"; `
[UInt32]$Value = 0x00000002; `
$Type="DWord"; `
Write-Host ""; `
Write-Host "The following property sets the value to for Group Policy (gpedit.msc) titled 'Configure compression for RemoteFX data' to:  [ 0 - 'Do not use an RDP compression algorithm' ],  [ 1 - 'Optimized to use less memory' ],  [ 2 - 'Balances memory and network bandwidth' ],  or  [ 3 - 'Optimized to use less network bandwidth' ]"; `
Write-Host -NoNewLine "`n"; `
Set-PolicyFileEntry -Path ("${Env:SystemRoot}\System32\GroupPolicy\Machine\Registry.pol") -Key ("${HKLM_Path}") -ValueName ("${Name}") -Data (${Value}) -Type ("${Type}");


# ------------------------------------------------------------
#
# Citation(s)
#
#		blogs.technet.microsoft.com  |  "Windows 8: Associate a file Type or protocol with a specific app using GPO (e.g:default mail client for MailTo protocol) – Behind Windows Setup & Deployment"  |  https://blogs.technet.microsoft.com/mrmlcgn/2013/02/26/windows-8-associate-a-file-type-or-protocol-with-a-specific-app-using-gpo-e-gdefault-mail-client-for-mailto-protocol/
#
#   docs.microsoft.com  |  "Copy-Item - Copies an item from one location to another"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item
#
#		docs.microsoft.com  |  "RegistryKey Class"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey
#
#   renenyffenegger.ch  |  "Registry: HKEY_CLASSES_ROOT\ProgId"  |  https://renenyffenegger.ch/notes/Windows/registry/tree/HKEY_CLASSES_ROOT/ProgId/index
#
#   social.technet.microsoft.com  |  "Can you use PowerShell to change Group Policies?"  |  https://social.technet.microsoft.com/Forums/windows/en-US/624fa355-54cb-4798-9876-02eb927849a4/can-you-use-powershell-to-change-group-policies?forum=winserverpowershell
#
#		stackoverflow.com  |  "Get file type description for file extensions"  |  https://stackoverflow.com/a/27646804
#
#		superuser.com  |  "How to associate a file with a program in Windows via CMD [duplicate]"  |  https://superuser.com/a/362080
#
#		superuser.com  |  "Why gpedit and the corresponding registry entries are not synchronized?"  |  https://superuser.com/a/1192458
#
#   www.powershellgallery.com  |  "PowerShell Gallery | Commands.ps1 3.0.0"  |  httpshttps://www.powershellgallery.com/packages/PolicyFileEditor/3.0.0/Content/Commands.ps1
#
#   www.powershellgallery.com  |  "PowerShell Gallery | PolicyFileEditor 3.0.1"  |  https://www.powershellgallery.com/packages/PolicyFileEditor
#
# ------------------------------------------------------------