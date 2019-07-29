# Coding

### See directories (above, on GitHub) on a per-software basis

***
### Sync this Repository (via PowerShell):
* ###### Triple click the following line of code and Copy it (via Ctrl+C)
```
<#>Sync PowerShell Codebase<#> $GithubOwner="mcavallo-git"; $GithubRepo="Coding"; Write-Host "Task - Sync local git repository to origin `"https://github.com/${GithubOwner}/${GithubRepo}.git`"..." -ForegroundColor Green; If (Test-Path "${HOME}/${GithubRepo}") { Set-Location "${HOME}/${GithubRepo}"; git reset --hard "origin/master"; git pull; } Else { Set-Location "${HOME}"; git clone "https://github.com/${GithubOwner}/${GithubRepo}.git"; } . "${HOME}/${GithubRepo}/powershell/_WindowsPowerShell/Modules/ImportModules.ps1"; Write-Host "`nPass - PowerShell Modules Synchronized`n" -ForegroundColor Cyan;
```
* ###### Open PowerShell (via Start-Menu -> type 'Windows PowerShell') and Paste (Ctrl+V) the line of code, then hit Enter
