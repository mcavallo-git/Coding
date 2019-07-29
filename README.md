# Coding
###### See directories (above, on GitHub) on a per-software basis

***
<details><h3><summary>Sync this Repo (via PowerShell)</summary></h3>
<p>

```
<#>Copy->Paste->Run this line of code in PowerShell<#> $GithubOwner="mcavallo-git"; $GithubRepo="Coding"; Write-Host "Task - Sync local git repository to origin `"https://github.com/${GithubOwner}/${GithubRepo}.git`"..." -ForegroundColor Green; If (Test-Path "${HOME}/${GithubRepo}") { Set-Location "${HOME}/${GithubRepo}"; git reset --hard "origin/master"; git pull; } Else { Set-Location "${HOME}"; git clone "https://github.com/${GithubOwner}/${GithubRepo}.git"; } . "${HOME}/${GithubRepo}/powershell/_WindowsPowerShell/Modules/ImportModules.ps1"; Write-Host "`nPass - PowerShell Modules Synchronized`n" -ForegroundColor Cyan;
```

##### Step-by-Step Instructions
* Select the entire line of code (via triple-left-mouseclick on the line of code)
* Copy the selected code (via Ctrl+C)
* Open PowerShell (via Start-Menu keypress -> type 'PowerShell' -> select 'Windows PowerShell' via left-mouseclick or Enter keypress)
* Paste the line of code into the terminal (via Ctrl+V or via right-mouseclick)
* Run the pasted line of code (via Enter keypress)

</p>
</details>
