# ------------------------------------------------------------
#
# ! ! Update to use the registry to detect if user is signed in or not
#      |
#      |--> Key:  HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer
#      |--> Property:  UserSignedIn
#
# ------------------------------------------------------------
If ((GV True).Value) {
  SV IS_LOGON_SCRIPT ((GV True).Value);
  SV ACTIVE_SESSION_EXISTS ([bool]((C:\Windows\System32\query.exe user (gc env:\\USERNAME) | Select-String ' Active ').Count));
  If ((((GV True).Value) -Eq ((GV IS_LOGON_SCRIPT).Value)) -Or (((GV False).Value) -Eq ((GV ACTIVE_SESSION_EXISTS).Value))) {
    Set-Location 'C:\ISO\HWiNFO64\Reports\';
    SV Logfile ((write HWiNFO64-)+(Get-Date -Format (write yyyy-MM-dd))+(write .csv));
    If (((Get-Process -Name 'HWiNFO64' -EA:0).Count -Eq 0) -Or ((Test-Path ((GV Logfile).Value)) -Eq ((GV False).Value))) {
      Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force;
      Start-Sleep -Seconds 2;
      If (((GV True).Value) -Eq ((GV IS_LOGON_SCRIPT).Value)) {
        Start-Process -Filepath ((gc env:\\ProgramFiles)+(write \AutoHotkey\v2\AutoHotkey.exe)) -ArgumentList ((gc env:\\REPOS_DIR)+(write \Coding\ahk\Archive\Windows_RefreshTrayIcons.ahkv2)) -NoNewWindow;
      };
      Start-Process -Filepath ((write C:\Program)+([string][char]32)+(write Files\HWiNFO64\HWiNFO64.EXE)) -ArgumentList ((write -l)+((GV Logfile).Value)) -NoNewWindow;
    };
  };
};