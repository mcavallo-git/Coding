------------------------------------------------------------
Explorer --> Context menu (right click) options in Windows explorer (to enable/disable - reverse lookups)
------------------------------------------------------------

| ===================================== | ========================== | ============================================================
|  Context menu (right click) option    |  Exe to apply changes via  | Action to take
| ===================================== | ========================== | ============================================================
|                                       |                            |
| More GpgEX options                    | shexview.exe  (app $2)     | Disable row(s) matching:  [Extension Name]="GpgEX", [Description]="GnuPG shell extensions"
| Sign and encrypt                      |                            |
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Send with Transfer...                 | shexview.exe  (app #2)     | Disable row(s) matching:  [Extension Name]="ContextMenuHandler Class", [Description]="Dropbox Shell Extension"
| Back up to Dropbox...                 |                            |
| Move to Dropbox                       |                            |
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Scan with Microsoft Defender...       | shexview.exe  (app #2)     | Disable row(s) matching:  [Extension Name]="EPP", [Description]="Microsoft Security Client Shell Extension"
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Open in PDF X-Change Editor           | shexview.exe  (app #2)     | Disable row(s) matching:  [Description]="HTML to PDF Converter IE addin"
|                                       |                            | Disable row(s) matching:  [Description]="PDF-XChange Shell Extension"
|                                       |                            | Disable row(s) matching:  [Description]="PDF-XChange Shell Menu Extension"
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| OneDrive * (all related)              | shexview.exe  (app #2)     | !!! ENABLE !!! row(s) matching:  [Extension Name]="FileSyncEx", [Description]="Microsoft OneDrive Shell Extension"
|                                       |                            |
|    Always keep on this device         |                            |   (KEEP ENABLED)
|    Free up space                      |                            |   (KEEP ENABLED)
|    Unlock Personal Vault              |                            |   (KEEP ENABLED)
|                                       |                            |
|    View online                        |                            |   (FIND OUT HOW TO DISABLE WITHOUT KILLING ALL OTHER ONEDRIVE CONTEXT MENU ITEMS)
|    Share                              |                            |   (FIND OUT HOW TO DISABLE WITHOUT KILLING ALL OTHER ONEDRIVE CONTEXT MENU ITEMS)
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |                            |
| Windows Media Player * (all related)  | powershell.exe (as admin)  | Disable via:
|                                       |                            |   Get-WindowsOptionalFeature -Online | Where-Object { $_.State -NE "Disabled" } | Where-Object { @("MediaPlayback","WindowsMediaPlayer").Contains($_.FeatureName) -Eq $True } | Disable-WindowsOptionalFeature -Online -NoRestart; <# <-- Disable Windows Media Player [ Windows Features ] #> 
|    Add to Windows Media Player list   |                            |
|    Play with Windows Media Player     |                            |
|    Shop for music online              |                            |
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |                            |
| Convert to PDF in Foxit PhantomPDF    | powershell.exe (as admin)  | Disable via:
| Combine files in Foxit PhantomPDF...  |                            |   Get-ChildItem -Path ("C:\Program Files (x86)\Foxit Software\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "ConvertToPDFShellExtension_x64.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };  <# --- #>  Get-ChildItem -Path ("C:\Program Files\Foxit Software\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "ConvertToPDFShellExtension_x86.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Edit with Notepad++                   | powershell.exe (as admin)  | Get-ChildItem -Path ("C:\Program Files (x86)\Notepad++\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "NppShell_06.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };  <# --- #>  Get-ChildItem -Path ("C:\Program Files\Notepad++\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "NppShell_06.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Git GUI Here                          | powershell.exe (as admin)  | Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_CLASSES_ROOT\LibraryFolder\background\shell\git_gui") -Confirm:$False | Out-Null;
|                                       |                            | Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_CLASSES_ROOT\Directory\background\shell\git_gui") -Confirm:$False | Out-Null;
|                                       |                            | Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_CLASSES_ROOT\Directory\Shell\git_gui") -Confirm:$False | Out-Null;
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Git Bash Here                         | powershell.exe (as admin)  | Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_CLASSES_ROOT\LibraryFolder\background\shell\git_shell") -Confirm:$False | Out-Null;
|                                       |                            | Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_CLASSES_ROOT\Directory\background\shell\git_shell") -Confirm:$False | Out-Null;
|                                       |                            | Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_CLASSES_ROOT\Directory\Shell\git_shell") -Confirm:$False | Out-Null;
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Edit with Paint 3D (images)           | powershell.exe (as admin)  | Disable via:
|                                       |                            |   @(".3mf",".bmp",".fbx",".gif",".glb",".jfif",".jpe",".jpeg",".jpg",".obj",".ply",".png",".stl",".tif",".tiff") | ForEach-Object { Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\${_}\Shell\3D Edit") -Confirm:$False | Out-Null; }; 
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Rotate right (images)                 | powershell.exe (as admin)  | Disable via:
| Rotate left  (images)                 |                            |   @(".avci",".avif",".bmp",".dds",".dib",".gif",".heic",".heif",".ico",".jfif",".jpe",".jpeg",".jpg",".jxr",".png",".rle",".tif",".tiff",".wdp",".webp") | ForEach-Object { Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_CLASSES_ROOT\SystemFileAssociations\${_}\ShellEx\ContextMenuHandlers\ShellImagePreview") -Confirm:$False | Out-Null; }; 
|                                       |                            |
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Edit with Photos (images)             | powershell.exe (as admin)  | Disable via:
|                                       |                            |   Step 1/2 Get User SID to disable context menu entry for (via powershell terminal running as user to apply to):   (((whoami /user /fo table /nh) -split ' ')[1]);
|                                       |                            |   Step 2/2 (as powershell admin):   "UserSID" | ForEach-Object { $UserSID="${_}"; New-ItemProperty -Force -LiteralPath ("Registry::HKEY_USERS\${UserSID}\Software\Classes\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit") -Name ("ProgrammaticAccessOnly") -PropertyType ("String") -Value ("") | Out-Null; }; 
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Create a new video (images)           | powershell.exe (as admin)  | Disable via:
|                                       |                            |   Step 1/2 Get User SID to disable context menu entry for (via powershell terminal running as user to apply to):   (((whoami /user /fo table /nh) -split ' ')[1]);
|                                       |                            |   Step 2/2 (as powershell admin):   "UserSID" | ForEach-Object { $UserSID="${_}"; Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_USERS\${UserSID}\SOFTWARE\Classes\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellCreateVideo") -Confirm:$False | Out-Null; Remove-Item -Force -Recurse -LiteralPath ("Registry::HKEY_USERS\${UserSID}\SOFTWARE\Classes\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\ShellCreateVideo") -Confirm:$False | Out-Null; }; 
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Set as Desktop Background (images)    | powershell.exe (as admin)  | Disable via:
|                                       |                            |   @(".avci",".avcs",".avif",".avifs",".bmp",".dib",".gif",".heic",".heics",".heif",".heifs",".jfif",".jpe",".jpeg",".jpg",".png",".tif",".tiff",".wdp") | ForEach-Object { New-ItemProperty -Force -LiteralPath ("Registry::HKEY_CLASSES_ROOT\SystemFileAssociations\${_}\Shell\setdesktopwallpape") -Name ("Extended") -PropertyType ("String") -Value ("") | Out-Null; }; 
|                                       |                            |   @(".avci",".avcs",".avif",".avifs",".bmp",".dib",".gif",".heic",".heics",".heif",".heifs",".jfif",".jpe",".jpeg",".jpg",".png",".tif",".tiff",".wdp") | ForEach-Object { New-ItemProperty -Force -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\${_}\Shell\setdesktopwallpaper") -Name ("Extended") -PropertyType ("String") -Value ("") | Out-Null; }; 
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |                            |
| 7-Zip                                 | 7zFM.exe                   | Disable via:
| CRC SHA >                             |                            |   Tools > Options > 7-Zip > Context menu items:
| CRC SHA >                             |                            |     ☐ (Uncheck all)
| CRC SHA >                             |                            |     ☑ Extract to <Folder>   (Check)
|                                       |                            |     ☑ Add to archive...     (Check)
|                                       |                            |     ☑ Add to <Archive>.zip  (Check)
|                                       |                            |     
|                                       |                            |
| ===================================== | -------------------------- | ============================================================


------------------------------------------------------------

 Citation(s)

   stackoverflow.com  |  "bash - How to remove git from menu context in Documents? - Stack Overflow"  |  https://stackoverflow.com/a/49257399

   support.microsoft.com  |  "How to use the Regsvr32 tool and troubleshoot Regsvr32 error messages"  |  https://support.microsoft.com/en-us/topic/how-to-use-the-regsvr32-tool-and-troubleshoot-regsvr32-error-messages-a98d960a-7392-e6fe-d90a-3f4e0cb543e5

   techdows.com  |  "Disable or remove Foxit Reader's 'Convert to PDF' Right Click Menu item"  |  https://techdows.com/2018/08/disable-or-remove-foxit-reader-convert-to-pdf-right-click-menu-item.html

   www.tenforums.com  |  "Add or Remove Rotate Left and Rotate Right Context Menu in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/122613-add-remove-rotate-left-rotate-right-context-menu-windows-10-a.html

   www.tenforums.com  |  "Add or Remove Create a New Video context menu in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/119154-add-remove-create-new-video-context-menu-windows-10-a.html

   www.windowscentral.com  |  "How to remove 'Edit with Photos' and 'Edit with Paint 3D' from Windows 10's context menu | Windows Central"  |  https://www.windowscentral.com/how-remove-edit-photos-and-edit-paint-3d-context-menu-windows-10

------------------------------------------------------------