<!-- ------------------------------------------------------------ -->

<h1>Coding</h1>
<h6><i>See directories (above, on GitHub) on a per-software basis</i></h6>

<!-- ------------------------------------------------------------ -->

<hr />
<h3>Sync this Repo (via PowerShell)</h3>
<details><summary><i>Show Content / Hide Content</i></summary>
<p>

<h4><u>Prerequisite - Git must be installed on your local workstation:</u></h4>
<ul>
<li>[Download Git](https://git-scm.com/downloads)</li>
</ul>

<h4><u>Run the following line of code in PowerShell:</u></h4>
<pre><code>
<#>Copy->Paste->Run this line of code in PowerShell<#> $GithubOwner="mcavallo-git"; $GithubRepo="Coding"; Write-Host "Task - Sync local git repository to origin `"https://github.com/${GithubOwner}/${GithubRepo}.git`"..." -ForegroundColor Green; If (Test-Path "${HOME}/${GithubRepo}") { Set-Location "${HOME}/${GithubRepo}"; git reset --hard "origin/master"; git pull; } Else { Set-Location "${HOME}"; git clone "https://github.com/${GithubOwner}/${GithubRepo}.git"; } . "${HOME}/${GithubRepo}/powershell/_WindowsPowerShell/Modules/ImportModules.ps1"; Write-Host "`nPass - PowerShell Modules Synchronized`n" -ForegroundColor Cyan;
</code></pre>

<h4><u>Step-by-Step Instructions:</u></h4>
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
