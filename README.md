<!-- ------------------------------------------------------------ -->

<h1>Coding</h1>
<h6><i>See directories (above, on GitHub) on a per-software basis</i></h6>

<!-- ------------------------------------------------------------ -->

<hr />
<h3>Sync this Repo (via PowerShell)</h3>
<details><summary><i>Show/Hide Content</i></summary>
<p>

<h4>Prerequisite(s):</h4>
<ul>
<li>Git <sub><i> SCM</i></sub> - <a href="https://git-scm.com/download/win">Download Git</a></li>
</ul>


<h4>Instructions (simplified):</h4>
<ul>
<li>Run the following line of code in PowerShell:</li>
</ul>
<pre><code>
<#>Copy->Paste->Run this line of code in PowerShell<#> $GithubOwner="mcavallo-git"; $GithubRepo="Coding"; Write-Host "Task - Sync local git repository to origin `"https://github.com/${GithubOwner}/${GithubRepo}.git`"..." -ForegroundColor Green; If (Test-Path "${HOME}/${GithubRepo}") { Set-Location "${HOME}/${GithubRepo}"; git reset --hard "origin/master"; git pull; } Else { Set-Location "${HOME}"; git clone "https://github.com/${GithubOwner}/${GithubRepo}.git"; } . "${HOME}/${GithubRepo}/powershell/_WindowsPowerShell/Modules/ImportModules.ps1"; Write-Host "`nPass - PowerShell Modules Synchronized`n" -ForegroundColor Cyan;
</code></pre>

<h4>Instructions (step-by-step):</h4>
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
