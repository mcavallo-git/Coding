<!-- ------------------------------------------------------------ -->

<!-- [THIS FILE ON GITHUB] https://github.com/mcavallo-git/Coding#coding [THIS FILE ON GITHUB] -->

<!-- ------------------------------------------------------------ -->

<h1>Coding</h1>
<h6><i>Scripts for Runtime, Maintenance, etc.</i></h6>

<!-- ------------------------------------------------------------ -->

<hr />
<h3>Sync this Repo (via PowerShell)</h3>
<details open><summary><i>Show/Hide Content</i></summary>
<p>

<h4>Prerequisite(s):</h4>
<ul>
<li>Git <sub><i> SCM</i></sub> - <a href="https://git-scm.com/download/win">Download Git</a></li>
</ul>


<h4>Run (in PowerShell):</h4>
<ul>
<li><pre><code><#>Sync PowerShell Scripts: Copy-Paste this code into a PowerShell terminal, then Run it<#> $GithubOwner="mcavallo-git"; $GithubRepo="Coding"; Write-Host "Task - Sync local git repository to origin `"https://github.com/${GithubOwner}/${GithubRepo}.git`"..." -ForegroundColor Green; If (Test-Path "${HOME}/${GithubRepo}") { Set-Location "${HOME}/${GithubRepo}"; git reset --hard "origin/master"; git pull; } Else { Set-Location "${HOME}"; git clone "https://github.com/${GithubOwner}/${GithubRepo}.git"; } . "${HOME}/${GithubRepo}/powershell/_WindowsPowerShell/Modules/ImportModules.ps1"; Write-Host "`nPass - PowerShell Modules Synchronized`n" -ForegroundColor Cyan;</code></pre></li>

</ul>

<h4>Step-by-step (only perform this step if you're unsure how to do the previous, 'copy-paste-run' step):</h4>
<ul>
<li>Select the entire line of code (via triple-left-mouseclick on the line of code)</li>
<li>Copy the selected code (via Ctrl+C)</li>
<li>Open PowerShell (via Start-Menu keypress -> type 'PowerShell' -> select 'Windows PowerShell' via left-mouseclick or Enter keypress)</li>
<li>Paste the line of code into the terminal (via Ctrl+V or via right-mouseclick)</li>
<li>Run the pasted line of code (via Enter keypress)</li>
</ul>

</p>
</details>

<!-- ------------------------------------------------------------ -->
