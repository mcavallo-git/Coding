# ------------------------------------------------------------
#
# PowerShell - install_pwsh (one-liner - install PowerShell Core (pwsh))
#

PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command Set-Location ((GCI env:\TEMP).Value); SV ProgressPreference SilentlyContinue; SV PWSH_HTML ((Invoke-WebRequest -UseBasicParsing -Uri (Write-Output https://github.com/PowerShell/PowerShell/releases/latest)).RawContent); SV REGEX_MATCHES ([Regex]::Match(((GV PWSH_HTML).Value), (Write-Output \/PowerShell\/PowerShell\/releases\/download\/v``([0-9\.]+``)\/))); If ((((GV REGEX_MATCHES).Value).Success) -NE ((GV False).Value)) { SV PWSH_LATEST_VERSION (((GV REGEX_MATCHES).Value).Groups[1].Value); SV DOWNLOAD_BASENAME ((Write-Output PowerShell``-)+((GV PWSH_LATEST_VERSION).Value)+(Write-Output ``-win``-x64.msi)); SV DOWNLOAD_URI ((Write-Output https://github.com/PowerShell/PowerShell/releases/download/v)+((GV PWSH_LATEST_VERSION).Value)+(Write-Output /)+((GV DOWNLOAD_BASENAME).Value)); SV OUTPUT_FULLPATH (((GCI env:\TEMP).Value)+(Write-Output \)+((GV DOWNLOAD_BASENAME).Value)); Invoke-WebRequest -UseBasicParsing -Uri ((GV DOWNLOAD_URI).Value) -OutFile ((GV DOWNLOAD_BASENAME).Value); Start-Process ((GCM msiexec).Source) -ArgumentList (@((Write-Output /I),((GV DOWNLOAD_BASENAME).Value),(Write-Output /quiet)) -join ([String][Char]32)) -Wait; }; Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "Coding/README.md at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/blob/master/README.md#readme
#
# ------------------------------------------------------------