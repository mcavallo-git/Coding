<h3>Microsoft Edge - Remove, Uninstall<h3>
<h6><i>(Auto Installs via Windows Updates as-of August 2020)</i></h6>
<hr/>
<h6>Open an elevated Command Prompt terminal</h6>
<ul>
	<li><pre><code>Open the Start Menu</code></pre></li>
	<li><pre><code>Type "cmd"</code></pre></li>
	<li><pre><code>Right-click "Command Prompt"</code></pre></li>
	<li><pre><code>Select "Run as administrator"</code></pre></li>
</ul>
<h6>Run the following commands (triple-click each of them and copy-paste them into the cmd terminal from previous step):</h6>
<ul>
	<li><pre><code>cd %PROGRAMFILES(X86)%\Microsoft\Edge\Application\8*\Installer</code></pre></li>
	<li><pre><code>.\setup.exe --uninstall --force-uninstall --system-level</code></pre></li>
</ul>
<h6>Done</h6>
<h6><i>Note: If the "8*" directory wasn't found in the first command, replace the "8*" with the version of edge which was installed during windows updates, such as "9*", etc.</i></h6>
<hr/>
<h5>Citation(s)</h5>
<ul>
	<li><a href="https://www.windowscentral.com/how-remove-microsoft-edge-windows-10">How to remove Microsoft Edge from Windows 10</a></li>
</ul>
