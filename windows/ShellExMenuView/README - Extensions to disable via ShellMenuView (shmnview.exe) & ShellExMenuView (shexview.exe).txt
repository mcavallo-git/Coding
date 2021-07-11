------------------------------------------------------------
Explorer --> Right click menu options to disable (reverse lookups)
------------------------------------------------------------

| ================================== | ==================== | ============================================================
| Right-click explorer option        | Exe to disable via   | Extension Name (to disable within exe)                      
| ================================== | ==================== | ============================================================
|                                    |                      |
| More GpgEX options                 | shexview.exe         | Disable "GpgEx"
| Sign and encrypt                   |  ^                   |  ^
|                                    |                      |
| ---------------------------------- | -------------------- | ------------------------------------------------------------
|                                    |                      |
| Convert to PDF in Foxit PhantomPDF | admin powerShell.exe | Get-ChildItem -Path ("C:\Program Files (x86)\Foxit Software\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "ConvertToPDFShellExtension_x64.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };
| Combine files in Foxit PhantomPDF |   + regsvr32.exe      | Get-ChildItem -Path ("C:\Program Files\Foxit Software\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "ConvertToPDFShellExtension_x86.dll" } | Select-Object -First 1 | ForEach-Object { Write-Host "Calling [ regsvr32.exe /u `"$($_.FullName)`" ]..."; regsvr32.exe /u "$($_.FullName)"; };
|                                    |                      |
| ---------------------------------- | -------------------- | ------------------------------------------------------------
|                                    |                      |
| Send with Transfer...              | shexview.exe         | Disable "ContextMenuHandler Class"
| Back up to Dropbox...              |  ^                   |  ^
| Move to Dropbox                    |  ^                   |  ^
|                                    |                      |
| ---------------------------------- | -------------------- | ------------------------------------------------------------
|                                    |                      |
| 7-Zip                              | 7zFM.exe             | Tools > Options > 7-Zip > Context menu items:
| CRC SHA >                          |  ^                   |   ☑ Extract to <Folder>
|                                    |                      |   ☑ Add to archive...
|                                    |                      |   ☑ Add to <Archive>.zip
|                                    |                      |   ☐ (UNCHECK ALL OTHER CONTEXT MENU ITEMS)
|                                    |                      |
| ================================== | ==================== | ============================================================


Disable extension name "ContextMenuHandler Class"




------------------------------------------------------------

 Citation(s)

   support.microsoft.com  |  "How to use the Regsvr32 tool and troubleshoot Regsvr32 error messages"  |  https://support.microsoft.com/en-us/topic/how-to-use-the-regsvr32-tool-and-troubleshoot-regsvr32-error-messages-a98d960a-7392-e6fe-d90a-3f4e0cb543e5

   techdows.com  |  "Disable or remove Foxit Reader's 'Convert to PDF' Right Click Menu item"  |  https://techdows.com/2018/08/disable-or-remove-foxit-reader-convert-to-pdf-right-click-menu-item.html

------------------------------------------------------------