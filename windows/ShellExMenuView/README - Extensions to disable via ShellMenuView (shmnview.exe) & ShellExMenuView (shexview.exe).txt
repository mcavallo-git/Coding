------------------------------------------------------------
Explorer --> Context menu (right click) options in Windows explorer (to enable/disable - reverse lookups)
------------------------------------------------------------

| ===================================== | ========================== | ============================================================
|  Context menu (right click) option    |  Exe to apply changes via  |  Action to take
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
| Windows Media Player * (all related)  | shmnview.exe  (app #1)     | Disable row(s) matching:  [Filename]="C:\Program Files (x86)\Windows Media Player\wmplayer.exe"
|                                       |                            | ??? ^ THIS DOESN'T SEEM TO CATCH ALL PLAYLIST ACTIONS ...
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |                            |
| Convert to PDF in Foxit PhantomPDF    | powershell.exe (as admin)  | Get-ChildItem -Path ("C:\Program Files (x86)\Foxit Software\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "ConvertToPDFShellExtension_x64.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };  <# --- #>  Get-ChildItem -Path ("C:\Program Files\Foxit Software\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "ConvertToPDFShellExtension_x86.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };
| Combine files in Foxit PhantomPDF...  |                            |
|                                       |                            |
| ------------------------------------- | -------------------------- | ------------------------------------------------------------
|                                       |  ^                         |
| Edit with Notepad++                   | powershell.exe (as admin)  | Get-ChildItem -Path ("C:\Program Files (x86)\Notepad++\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "NppShell_06.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };  <# --- #>  Get-ChildItem -Path ("C:\Program Files\Notepad++\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "NppShell_06.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };
|                                       |                            |
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
|                                       |                            |
| 7-Zip                                 | 7zFM.exe                   | Tools > Options > 7-Zip > Context menu items:
| CRC SHA >                             |                            |   ☑ Extract to <Folder>
|                                       |                            |   ☑ Add to archive...
|                                       |                            |   ☑ Add to <Archive>.zip
|                                       |                            |   ☐ (UNCHECK ALL OTHER CONTEXT MENU ITEMS)
|                                       |                            |
| ===================================== | -------------------------- | ============================================================


------------------------------------------------------------

 Citation(s)

   stackoverflow.com  |  "bash - How to remove git from menu context in Documents? - Stack Overflow"  |  https://stackoverflow.com/a/49257399

   support.microsoft.com  |  "How to use the Regsvr32 tool and troubleshoot Regsvr32 error messages"  |  https://support.microsoft.com/en-us/topic/how-to-use-the-regsvr32-tool-and-troubleshoot-regsvr32-error-messages-a98d960a-7392-e6fe-d90a-3f4e0cb543e5

   techdows.com  |  "Disable or remove Foxit Reader's 'Convert to PDF' Right Click Menu item"  |  https://techdows.com/2018/08/disable-or-remove-foxit-reader-convert-to-pdf-right-click-menu-item.html

------------------------------------------------------------