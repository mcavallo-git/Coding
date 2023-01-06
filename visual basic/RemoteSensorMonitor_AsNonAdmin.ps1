If ((GV True).Value) {
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
    For ($i = 0; $i -LT 15; $i++) { If (Get-Process -Name 'HWiNFO64' -EA:0) { Break; } Else { Start-Sleep -Seconds 2; }; };
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