<h3>Microsoft Edge - Uninstall App<br/><sub><i>(Auto Installs via Windows Updates as-of August 2020)</i></sub></h3>
<hr />
<h6>Open an elevated Command Prompt terminal (open Start Menu > type "cmd" > right-click "Command Prompt" app > select "Run as administrator")</h6>
<h6>Run the following commands (copy-paste into cmd terminal):</h6>
<ul>
	<li><pre><code>cd %PROGRAMFILES(X86)%\Microsoft\Edge\Application\8*\Installer</code></pre></li>
	<li><pre><code>.\setup.exe --uninstall --force-uninstall --system-level</code></pre></li>
	<li>Done</li>
</ul>
<h6><i><sub>Note: If the "8*" directory wasn't found in the first command, replace the "8*" with the version of edge which was installed during windows updates, such as "9*", etc.</sub></i></h6>
<hr />
<h5>Citation(s)</h5>
<ul>
	<li><a href="https://www.windowscentral.com/how-remove-microsoft-edge-windows-10">How to remove Microsoft Edge from Windows 10</a></li>
</ul>
