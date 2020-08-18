<h3>Microsoft Edge - Uninstall<br /><sub><i>(Note: Automatically installs during Windows Updates as-of 18-Aug-2020)</i></sub></h3>
<hr />
<ul>
	<li>Open an elevated command prompt window (type "cmd.exe" into start menu, right-click it, select "Run as administrator")</li>
	<li>Run (copy-paste) the following commands:</li>
	<li><pre><code>cd %PROGRAMFILES(X86)%\Microsoft\Edge\Application\8*\Installer</code></pre></li>
	<li><pre><code>.\setup.exe --uninstall --force-uninstall --system-level</code></pre></li>
	<li>Done</li>
	<li><i><sub>Note: If the "8*" directory wasn't found in the first command, replace the "8*" with the version of edge which was installed during windows updates, such as "9*", etc.</sub></i></li>
</ul>
<hr />
<h5>Citation(s)</h5>
<ul>
	<li><a href="https://www.windowscentral.com/how-remove-microsoft-edge-windows-10">How to remove Microsoft Edge from Windows 10</a></li>
</ul>
