# ------------------------------
#
# PowerShell - Install Python & Pip
#
# ------------------------------

Param(

  [String]$Version = "3.11.3",  # Version of Python to install

  [String]$WorkingDirectory

)

If ($True) {

  # Set the working directory (optional)
  If ((-Not [String]::IsNullOrEmpty("${WorkingDirectory}".Trim())) -And (Test-Path -PathType "Container" -Path ("${WorkingDirectory}"))) {
    Set-Location "${WorkingDirectory}" -EA:0;
  }

  # Runtime variable(s)/settings
  $PythonFilename_32bit = "python-${Version}.exe";
  $PythonFilename_64bit = "python-${Version}-amd64.exe";
  $Python_InstallArgs = "/passive InstallAllUsers=1 PrependPath=1 Include_test=0 Include_pip=1";

  $ProgressPreference = 'SilentlyContinue';

  # Cleanup (before)
  Remove-Item -Path ("${PythonFilename_32bit}") -Force -Confirm:$False -EA:0;
  Remove-Item -Path ("${PythonFilename_64bit}") -Force -Confirm:$False -EA:0;

  # Python (32-bit) - Download & Install
  Write-Host "##[debug] ------------------------------";
  Write-Host "##[debug] Info: Downloading ${PythonFilename_32bit} (Python v${Version} 32-bit)...";
  Invoke-WebRequest -UseBasicParsing -Uri "https://www.python.org/ftp/python/${Version}/${PythonFilename_32bit}" -OutFile ".\${PythonFilename_32bit}";

  Write-Host "##[debug] ------------------------------";
  Write-Host "##[debug] Installing ${PythonFilename_32bit} (Python v${Version} 32-bit)...";
  Start-Process .\${PythonFilename_32bit} -ArgumentList "${Python_InstallArgs}" -Wait;

  # Python (64-bit) - Download & Install
  Write-Host "##[debug] ------------------------------";
  Write-Host "##[debug] Downloading ${PythonFilename_64bit} (Python v${Version} 64-bit)...";
  Invoke-WebRequest -UseBasicParsing -Uri "https://www.python.org/ftp/python/${Version}/${PythonFilename_64bit}" -OutFile ".\${PythonFilename_64bit}";

  Write-Host "##[debug] ------------------------------";
  Write-Host "##[debug] Installing ${PythonFilename_64bit} (Python v${Version} 64-bit)...";
  Start-Process .\${PythonFilename_64bit} -ArgumentList "${Python_InstallArgs}" -Wait;

  # Cleanup (after)
  Remove-Item -Path ("${PythonFilename_32bit}") -Force -Confirm:$False -EA:0;
  Remove-Item -Path ("${PythonFilename_64bit}") -Force -Confirm:$False -EA:0;

  Write-Host "##[debug] ------------------------------";

}


# ------------------------------------------------------------

If ($False) {

# Install Python & Pip (one-liner)
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command Write-Host (Write-Output Downloading` and` installing` Python` 32-bit...); Set-Location ((GCI env:\TEMP).Value); SV ProgressPreference SilentlyContinue; Invoke-WebRequest -UseBasicParsing -Uri (Write-Output https://www.python.org/ftp/python/3.10.4/python-3.10.4.exe) -OutFile (Write-Output .\python-3.10.4.exe); Start-Process .\python-3.10.4.exe -ArgumentList (Write-Output /passive` InstallAllUsers=1` PrependPath=1` Include_test=0` Include_pip=1) -Wait; Write-Host (Write-Output Downloading` and` installing` Python` 64-bit...); Set-Location ((GCI env:\TEMP).Value); SV ProgressPreference SilentlyContinue; Invoke-WebRequest -UseBasicParsing -Uri (Write-Output https://www.python.org/ftp/python/3.10.4/python-3.10.4-amd64.exe) -OutFile (Write-Output .\python-3.10.4-amd64.exe); Start-Process .\python-3.10.4-amd64.exe -ArgumentList (Write-Output /passive` InstallAllUsers=1` PrependPath=1` Include_test=0` Include_pip=1) -Wait;') -Verb RunAs -Wait -PassThru | Out-Null; Write-Host (Write-Output Logout` and` log` back` into` Windows` or` restart` the` current` device` to` use` the` python` command);";

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.python.org  |  "4. Using Python on Windows — Python 3.11.3 documentation"  |  https://docs.python.org/3/using/windows.html
#
#   learn.microsoft.com  |  "Get started with Azure Service Fabric CLI - Azure Service Fabric | Microsoft Learn"  |  https://learn.microsoft.com/en-us/azure/service-fabric/service-fabric-cli
#
#   www.python.org  |  "Download Python | Python.org"  |  https://www.python.org/downloads/
#
# ------------------------------------------------------------
