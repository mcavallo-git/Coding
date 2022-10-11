# ------------------------------------------------------------
#
# PowerShell - Start-Process ... -Verb RunAs  (run as admin)
#
# ------------------------------------------------------------


<# PowerShell/pwsh - Run as admin - Open a new terminal #>
If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -Verb RunAs;


<# PowerShell - Run as admin - Run an AutoHotkey script #> 
Start-Process -Filepath ("${env:ProgramFiles}\AutoHotkey-v2\AutoHotkeyU64.exe") -ArgumentList ("${env:USERPROFILE}\Documents\GitHub\Coding\ahk\_WindowsHotkeys.ahkv2") -Verb RunAs;


<# PowerShell/pwsh - Run as admin (child terminal) - Run 'whoami' #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command Invoke-Expression ((GCM whoami).Source); Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Enable SNMP (Windows 10) #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command Get-WindowsCapability -Online | Where-Object { [Regex]::Match((((GV _).Value).Name),(Write-Output SNMP)).Success } | Where-Object { (((GV _).Value).State) -Eq (Write-Output NotPresent) } | ForEach-Object { ((Write-Output Add-WindowsCapability:)+([String][Char]32)+(((GV _).Value).Name)); Add-WindowsCapability -Online -Name (((GV _).Value).Name); }; Write-Output ((Write-Output Waiting)+([String][Char]32)+(Write-Output 60s...)); Start-Sleep -Seconds 60;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Disable SNMP (Windows 10) #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command Get-WindowsCapability -Online | Where-Object { [Regex]::Match((((GV _).Value).Name),(Write-Output SNMP)).Success } | Where-Object { (((GV _).Value).State) -Eq (Write-Output Installed) } | Sort-Object -Property @{Expression={((GV _).Value).Name};Ascending=((GV False).Value);} | ForEach-Object { ((Write-Output Remove-WindowsCapability:)+([String][Char]32)+(((GV _).Value).Name)); Remove-WindowsCapability -Online -Name (((GV _).Value).Name); }; Write-Output ((Write-Output Waiting)+([String][Char]32)+(Write-Output 60s...)); Start-Sleep -Seconds 60;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Install choco package manager #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; If ((GCM choco -ErrorAction SilentlyContinue) -Eq ((GV null).Value)) { Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString((Write-Output https://chocolatey.org/install.ps1))); }; Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Install Google Chrome #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV LocalTempDir ((GCI env:\TEMP).Value); SV ChromeInstaller (Write-Output ChromeInstaller.exe); SV Process2Monitor ([IO.Path]::GetFileNameWithoutExtension((GV ChromeInstaller).Value)); (New-Object System.Net.WebClient).DownloadFile((Write-Output http://dl.google.com/chrome/install/latest/chrome_installer.exe), (((GV LocalTempDir).Value)+(Write-Output \)+((GV ChromeInstaller).Value)) ); & (((GV LocalTempDir).Value)+(Write-Output \)+((GV ChromeInstaller).Value)) /silent /install; Do { SV ProcessesFound (Get-Process | Where-Object { ((GV Process2Monitor).Value) -contains (((GV _).Value).Name); } | Select-Object -ExpandProperty Name); If ((GV ProcessesFound).Value) { ((Write-Output Still`` running:`` )+(((GV ProcessesFound).Value) -join (Write-Output ``,`` ))) | Write-Host; Start-Sleep -Seconds 2; } Else { Remove-Item -Verbose -Path (((GV LocalTempDir).Value)+(Write-Output \)+((GV ChromeInstaller).Value)) -ErrorAction SilentlyContinue; } } Until (!((GV ProcessesFound).Value)); Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Install Az CLI #>
PowerShell -Command "If (gcm pwsh -EA:0) { sv PS ((gcm pwsh).Source); } Else { sv PS ((gcm powershell).Source); }; Start-Process -Filepath ((gv PS).Value) -ArgumentList ('-Command Write-Host (write Downloading/Installing` Az` CLI...); Set-Location ((GCI env:\TEMP).Value); sv ProgressPreference SilentlyContinue; Invoke-WebRequest -UseBasicParsing -Uri (write https://aka.ms/installazurecliwindows) -OutFile (write .\AzureCLI.msi); Start-Process ((gcm msiexec).Source) -ArgumentList (write /I` AzureCLI.msi` /quiet) -Wait;') -Verb RunAs -Wait -PassThru | Out-Null; If (gcm az -EA:0) { az config set extension.use_dynamic_install=yes_without_prompt; } Else { Write-Host (write Close` and` reopen` terminal` to` use` az` command` -` Fresh` Az` installs` require` a` Windows` restart` to` update` Az` onto` the` PATH` environment` variable); }";

<# PowerShell/pwsh - Run as admin (child terminal) - Install Azure PowerShell Module #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; Install-Module -Name Az -AllowClobber -Force; Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Install Microsoft SQL Server PowerShell Module #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; Install-Module -Name SqlServer -AllowClobber -Force; Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Install VMware PowerCLI / vSphere CLI PowerShell Module #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; Install-Module -Name VMware.PowerCLI -AllowClobber -Force; Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Run Get-System-Specs #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; (New-Object System.Net.WebClient).DownloadFile((Write-Output https://raw.githubusercontent.com/mcavallo-git/Coding/master/cmd/cmd%20-%20Get-SystemSpecs.bat),(((GCI env:\TEMP).Value)+(Write-Output \Get-SystemSpecs.bat))); Start-Process -Filepath ((GCI env:\ComSpec).Value) -ArgumentList (@((Write-Output /C),(((GCI env:\TEMP).Value)+(Write-Output \Get-SystemSpecs.bat)))) -Verb RunAs -Wait -PassThru; Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Start-Process (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
#
# ------------------------------------------------------------