If ((GV True).Value) {
  SV IS_LOGGED_ON ([bool]((C:\Windows\System32\query.exe user (Get-Content env:\USERNAME) | Select-String ' Active ').Count));
  If (((GV True ).Value) -Eq ((GV IS_LOGGED_ON).Value)) {
    Set-Location 'C:\ISO\HWiNFO64\Reports\';
    SV Logfile ((write HWiNFO64-)+(Get-Date -Format (write yyyy-MM-dd))+(write .csv));
    If (((Get-Process -Name 'HWiNFO64' -EA:0).Count -Eq 0) -Or ((Test-Path ((GV Logfile).Value)) -Eq ((GV False).Value))) {
      Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force;
      Start-Sleep -Seconds 2;
      If (((GV True).Value) -Eq ((GV IS_LOGGED_ON).Value)) {
        Start-Process -Filepath ((Get-Content env:\\ProgramFiles)+(write \AutoHotkey-v2\AutoHotkey64.exe)) -ArgumentList ((Get-Content env:\\USERPROFILE)+(write \Documents\GitHub\Coding\ahk\Archive\Windows_RefreshTrayIcons.ahkv2)) -NoNewWindow;
      };
      Start-Process -Filepath ((write C:\Program)+([string][char]32)+(write Files\HWiNFO64\HWiNFO64.EXE)) -ArgumentList ((write -l)+((GV Logfile).Value)) -NoNewWindow;
      While ((Get-Process -Name 'HWiNFO64' -EA:0) -Eq ((GV Null).Value)) {
        Start-Sleep -Seconds 2;
      };
      Start-Sleep -Seconds 10;
    };
    SV Run_RemoteSensorMonitor ((GV False).Value);
    If (((GV True).Value) -Eq ((GV Run_RemoteSensorMonitor).Value)) {
      SV ErrorActionPreference 0;
      SV ProgressPreference 0;
      SV DefaultPort (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultPort.txt' -EA:0);
      Try {
        (Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format('http://localhost:{0}/',((GV DefaultPort).Value))) -TimeoutSec (2)) | Out-Null;
        SV RequestSuccess 1;
      } Catch {
        SV RequestSuccess 0;
      };
      If ((([int]((Get-Process -Name 'Remote Sensor Monitor' -EA:0).Count)) -Eq 0) -Or (((GV RequestSuccess).Value) -Eq 0)) {
        Set-Location 'C:\ISO\RemoteSensorMonitor';
        Get-Process -Name 'Remote Sensor Monitor' -EA:0 | Stop-Process -Force;
        Start-Sleep -Seconds 1;
        Start-Process -Filepath ('C:\ISO\RemoteSensorMonitor\Remote Sensor Monitor.exe') -ArgumentList ([String]::Format('-p {0} --hwinfo 1 --gpuz 0 --aida64 0 --ohm 0', ((GV DefaultPort).Value))) -NoNewWindow -EA:0;
        If (Test-Path 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0) {
          SV DefaultConf (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0);
          Start-Sleep -Seconds 3;
          Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format('http://localhost:{0}/apply_config',((GV DefaultPort).Value))) -ContentType 'application/ -www-form-urlencoded;charset=UTF-8' -Method 'POST' -Body ((GV DefaultConf).Value);
        };
      };
    };
  };
};