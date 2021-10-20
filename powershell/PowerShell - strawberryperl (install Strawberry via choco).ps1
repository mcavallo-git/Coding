
<# Install Strawberry via Chocolatey #>
PowerShell -Command "Set-ExecutionPolicy ByPass -Scope CurrentUser -Force; If (-Not (Get-Command 'perl' -ErrorAction SilentlyContinue)) { [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; If (-Not (Get-Command 'choco' -ErrorAction SilentlyContinue)) { Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction SilentlyContinue; }; Start-Process -Filepath ('choco') -ArgumentList (@('feature','enable','-n=allowGlobalConfirmation')) -NoNewWindow -Wait -PassThru -ErrorAction SilentlyContinue | Out-Null; Start-Process -Filepath ('choco') -ArgumentList (@('install','strawberryperl')) -NoNewWindow -Wait -PassThru -ErrorAction SilentlyContinue | Out-Null; };";


Get-WindowsCapability -Online | ? Name -like "OpenSSH*";


# ------------------------------------------------------------
#
# Citation(s)
#
#   chocolatey.org  |  "Chocolatey Software | Strawberry Perl 5.30.2.1"  |  https://chocolatey.org/packages/StrawberryPerl
#
# ------------------------------------------------------------