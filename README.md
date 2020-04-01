<!-- ------------------------------------------------------------ ---

This file (on GitHub):

	https://github.com/mcavallo-git/Coding#coding

--- ------------------------------------------------------------- -->

<h3 id="coding">DevOps Resource Reference</h3>
<details><summary><i>What is DevOps?</i></summary>
	<br />
	<div>Wikipedia<sup>&nbsp;<a href="https://en.wikipedia.org/wiki/DevOps">[1]</a></sup> states:</div>
	<blockquote>DevOps is a set of practices that combines software development (Dev) and information-technology operations (Ops) which aims to shorten the systems development life cycle and provide continuous delivery with high software quality.</blockquote>
	<div>Atlassian<sup>&nbsp;<a href="https://www.atlassian.com/devops">[4]</a></sup> states:</div>
	<blockquote>DevOps is a set of practices that automates the processes between software development and IT teams, in order that they can build, test, and release software faster and more reliably.<a href="https://www.atlassian.com/devops"><img src="images/archive/devops-loop-illustrations.atlassian.png" /></a></blockquote>
</details>

<hr />


<!-- ------------------------------------------------------------ -->

<h5>Sync PowerShell Modules</h5>
<details><summary><i>Show/Hide Content</i></summary>
	<p>
		<ol>
			<li>
				<div>Prereq: Git SCM - <a href="https://git-scm.com/download/win">Download (source)</a></div>
			</li>
			<li>
				<details><summary>
						<span>Prereq: Git CLI added to PATH (available during installation of Git SCM - click to view screenshot)</span>
					</summary>
					<div style="text-align:center;"><img src="images/archive/git-install.allow-cli.png" height="250" /></div>
				</details>
			</li>
			<li>Prereq: PowerShell Terminal w/ Elevated Privileges, e.g. in "Run as Admin" mode</li>
			<li>
				<div>If Pre-Reqs are met, run the following command to sync PowerShell Modules:</div>
				<pre><code>Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12'; Clear-DnsClientCache; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/sync.ps1?t=$((Date).Ticks)"));</code></pre>
			</li>
			<li>
				<div><sub>Fallback Method:</sub>&nbsp;</div>
				<pre><sub><code>Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12'; $SyncTemp="${Env:TEMP}\sync.$($(Date).Ticks).ps1"; New-Item -Force -ItemType "File" -Path ("${SyncTemp}") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/sync.ps1?t=$((Date).Ticks)"))) | Out-Null; . "${SyncTemp}"; Remove-Item "${SyncTemp}";</code></sub></pre>
			</li>
		</ol>
	</p>
</details>

<hr />


<!-- ------------------------------------------------------------ -->

<h5>Sync Bash Modules</h5>
<details><summary><i>Show/Hide Content</i></summary>
	<p>
		<ol>
			<li>Prereq: Debian-based Linux environment (Ubuntu, Raspbian, Debian, etc.)</li>
			<li>Prereq: SSH Terminal w/ Elevated Privileges, e.g. running as "root" user (or as any sudoer)</li>
			<li>
				<div>If Pre-Reqs are met, run the following command to sync Bash Modules: </div>
				<pre><code>curl -ssL rhel.sh | bash;</code></pre>
			</li>
		</ol>
	</p>
</details>

<hr id="workstation-installs" />


<!-- ------------------------------------------------------------ -->

<h5 id="software">Software</h5>
<details open><summary><i>Show/Hide Content</i></summary>
<br />


<!--
| Left align | Right align | Center align |
| :--------- | :---------: | :----------: |
| This       |    This     |     This     |
| column     |   column    |    column    |
| will       |    will     |     will     |
| be         |     be      |      be      |
| left       |    right    |    center    |
| aligned    |   aligned   |   aligned    |
-->


<table>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="esssentials"><br />Esssentials<br /><br /></h5></th></tr>
<tr><td><strong>AirServer Universal</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Airplay+, Google Cast+, Miracast</i></sub></td><td><a href="https://www.airserver.com/Download/MacPC">Download (mirror)</a></td></tr>
<tr><td><strong>AutoHotkey (AHK)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Keyboard Macro Program</i></sub></td><td><a href="https://www.autohotkey.com/download/ahk-install.exe">Download (source)</a></td></tr>
<tr><td><strong>Classic Shell</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Win7 Style Start-Menu</i></sub></td><td><a href="https://www.fosshub.com/Classic-Shell.html">Download (mirror)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://raw.githubusercontent.com/mcavallo-git/Coding/master/windows/Classic%20Shell/Menu%20Settings.xml">Menu Settings (import)</a></sub></td></tr>
<tr><td><strong>Docker Desktop (for Windows)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Containers</i></sub></td><td><a href="https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe">Download (source)</a></td></tr>
<tr><td><strong>FoxIt PhantomPDF</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;PDF Editor (Paid)</i></sub></td><td><a href="https://www.foxitsoftware.com/downloads/#Foxit-PhantomPDF-Standard/">Download (source)</a></td></tr>
<tr><td><strong>Git SCM</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;CLI Integration</i></sub></td><td><a href="https://git-scm.com/download/win">Download (source)</a></td></tr>
<tr><td><strong>GitHub Desktop</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Git Daily Driver</i></sub></td><td><a href="https://desktop.github.com">Download (source)</a></td></tr>
<tr><td><strong>Google Chrome</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Free Web Browser<br />&nbsp;&nbsp;&nbsp;Developed by Google<br />&nbsp;&nbsp;&nbsp;<a href="https://peter.sh/experiments/chromium-command-line-switches/">View Command-Line Switches</a></i></sub></td><td><a href="https://www.google.com/chrome/browser/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://chrome.google.com/webstore/detail/material-dark-theme-dark/ddihdomdfpicmiobogkoaideoklkhbah?hl=en">Download (Dark Theme)</a></sub></td></tr>
<tr><td><strong>Mozilla Firefox</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Free Web Browser<br />&nbsp;&nbsp;&nbsp;Developed by the Mozilla Foundation</i></sub></td><td><a href="https://www.mozilla.org/en-US/firefox/download/thanks/">Download (source)</a></td></tr>
<tr><td><strong>Gpg4win</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;GnuPG for Windows</i></sub></td><td><a href="https://www.gpg4win.org/thanks-for-download.html">Download (source)</a></td></tr>
<tr><td><strong>Handbrake</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Multithreaded Video Transcoder</i></sub></td><td><a href="https://handbrake.fr/">Download (source)</a></td></tr>
<tr><td><strong>HandbrakeCLI</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Video Transcoding via CLI<br />&nbsp;&nbsp;&nbsp;<a href="https://handbrake.fr/docs/en/latest/cli/command-line-reference.html">Command line reference</a></i></sub></td><td><a href="https://handbrake.fr/downloads2.php">Download (source)</a></td></tr>
<tr><td><strong>ImageMagick</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;CLI - Compress, Trim, Resize (etc.) Images</i></sub></td><td><a href="https://www.imagemagick.org/script/download.php#windows">Download (source)</a></td></tr>
<tr><td><strong>LastPass</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Password Manager</i></sub></td><td><a href="https://lastpass.com/download">Download (source)</a></td></tr>
<tr><td><strong>Microsoft GPO ADMX/ADML Templates</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;ADMX/ADML files - Group Policy Administrative Template<br />&nbsp;&nbsp;&nbsp;OPAX/OPAL files - Office Customization Tool (OCT)</i></sub></td><td><a href="https://support.microsoft.com/en-us/help/3087759/how-to-create-and-manage-the-central-store-for-group-policy-administra">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=49030">Download (Office ADMX)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://support.microsoft.com/en-us/help/3087759/how-to-create-and-manage-the-central-store-for-group-policy-administra">Docs - AD Central Store</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=25250">Docs - Exhaustive GPO Reference</a></sub></td></tr>
<tr><td><strong>Microsoft Office 365</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Outlook, Word, Excel, PowerPoint, etc.</i></sub></td><td><a href="https://www.office.com/">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><i>Login &rarr; Select "Install Office"</i><br />&nbsp;&nbsp;&nbsp;<a href="https://c2rsetup.officeapps.live.com/c2r/download.aspx?productReleaseID=O365ProPlusRetail&platform=Def&language=en-us">Download (direct)</a></sub></td></tr>
<tr><td><strong>Microsoft Office - Popular Tools</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Management, efficiency, and cli apps</i></sub></td><td><a href="https://www.microsoft.com/en-us/search/DownloadResults.aspx?FORM=DLC&ftapplicableproducts=%5e%22AllDownloads%22&sortby=+weight&q=Office%E2%80%8B">Download (source)</a></sub></td></tr>
<tr><td><strong>Microsoft To Do</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Lists, Tasks & Reminders<br />&nbsp;&nbsp;&nbsp;(successor to Wunderlist)</i></sub></td><td><a href="https://www.microsoft.com/en-us/p/microsoft-to-do-lists-tasks-reminders/9nblggh5r558">Download (source)</a></td></tr>
<tr><td><strong>LogMeIn Rescue Technician Console</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Screen-sharing & Remote-support application</i></sub></td><td><a href="https://help.logmein.com/articles/en_US/Downloads/Technician-Console-Desktop-App">Download (source)</a></td></tr>
<tr><td><strong>MobaXterm</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;XServer for Windows</i></sub></td><td><a href="https://mobaxterm.mobatek.net/download-home-edition.html">Download (source)</a></td></tr>
<tr><td><strong>Notepad++</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Text and Source-Code Editor</i></sub></td><td><a href="https://notepad-plus-plus.org/downloads/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://raw.githubusercontent.com/mcavallo-git/Coding/master/windows/Notepad%2B%2B/NP%2B%2B.zip">Download (Dark Theme)</a></sub></td></tr>
<tr><td><strong>Notepad Replacer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Redirects NotePad.exe to VSCode, NP++, etc.</i></sub></td><td><a href="https://www.binaryfortress.com/NotepadReplacer/Download/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.binaryfortress.com/Data/Download/?package=notepadreplacer&log=100">Download (direct)</a></sub></td></tr>
<tr><td><strong>Reflector</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Airplay Server for Windows</i></sub></td><td><a href="https://www.airsquirrels.com/reflector">Download (mirror)</a></td></tr>
<tr><td><strong>Remote Mouse</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote Mouse & Keyboard control via Phone</i></sub></td><td><a href="https://www.remotemouse.net/downloads/RemoteMouse.exe">Download (source)</a></td></tr>
<tr><td><strong>Royal TS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Cross-Platform Remote Management Solution<br />&nbsp;&nbsp;&nbsp;Includes Tools to manage Hyper-V, RDP,<br />&nbsp;&nbsp;&nbsp;SSH, SFTP, Teamviewer, VMware, & more</i></sub></td><td><a href="https://www.royalapps.com/ts/win/download">Download (mirror)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://content.royalapplications.com/Help/RoyalTS/V3/index.html?ui_keyboardshortcuts.htm">Royal TS - Keyboard Shortcuts</a></sub></td></tr>
<tr><td><strong>Splashtop Personal</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote Access Client</i></sub></td><td><a href="https://www.splashtop.com/downloadstart?product=stp&platform=windows-client">Download (source)</a></td></tr>
<tr><td><strong>Splashtop Streamer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote Access Host/Server</i></sub></td><td><a href="https://www.splashtop.com/downloadstart?platform=windows">Download (source)</a></td></tr>
<tr><td><strong>TeamViewer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote Access Host/Server</i></sub></td><td><a href="https://www.teamviewer.com/en/download/windows/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.teamviewer.com/en/download/previous-versions/">Download (previous versions)</a></sub></td></tr>
<tr><td><strong>Tortoise Git</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Git Merge Conflict Resolver</i></sub></td><td><a href="https://tortoisegit.org/download">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="benchmarking"><br />Benchmarking<br /><br /></h5></th></tr>
<tr><td><strong>3DMark Fire Strike</strong> <sub><br />&nbsp;&nbsp;&nbsp;GPU Benchmark<i><br />&nbsp;&nbsp;&nbsp;DirectX 11 Benchmark (Graphics Cards, GPU)</i></sub></td><td><a href="https://store.steampowered.com/app/402290/3DMark_Fire_Strike_benchmarks/">Download (steam)</a></sub></td></tr>
<tr><td><strong>3DMark Time Spy</strong> <sub><br />&nbsp;&nbsp;&nbsp;GPU Benchmark<i><br />&nbsp;&nbsp;&nbsp;DirectX 12 Benchmark (Graphics Cards, GPU)</i></sub></td><td><a href="https://store.steampowered.com/app/496100/3DMark_Time_Spy_benchmark/">Download (steam)</a></sub></td></tr>
<tr><td><strong>CineBench R20</strong> <sub>by Maxon<br />&nbsp;&nbsp;&nbsp;CPU Benchmark<i><br />&nbsp;&nbsp;&nbsp;Real-World Cross-Platform Test Suite</i></sub></td><td><a href="https://www.maxon.net/en-us/support/downloads/#collapse-64981">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="http://http.maxon.net/pub/cinebench/CinebenchR20.zip">Download (direct)</a></sub></td></tr>
<tr><td><strong>Corona Benchmark</strong> <sub><br />&nbsp;&nbsp;&nbsp;CPU Benchmark<i> ( Rendering )</i></sub></td><td><a href="https://corona-renderer.com/benchmark">Download (source)</a></td></tr>
<tr><td><strong>CrystalDiskMark</strong> <sub><br />&nbsp;&nbsp;&nbsp;Disk Benchmark<br />&nbsp;&nbsp;&nbsp;(HDD, SSD, Thumb-Drive, SD-Card, etc.)<i><br />&nbsp;&nbsp;&nbsp;Open-source IOPS benchmarking tool (HDD/SSD throughput)</i></sub></td><td><a href="https://crystalmark.info/redirect.php?product=CrystalDiskMarkInstaller">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://crystalmark.info/redirect.php?product=CrystalDiskMark">Download (portable)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/p/crystaldiskmark/9nblggh4z6f2?rtc=1&activetab=pivot:overviewtab">Download (win10 app)</a></sub></td></tr>
<tr><td><strong>Guru3D.com</strong> <sub><br />&nbsp;&nbsp;&nbsp;Assorted Benchmarks<br /></sub></td><td><a href="https://www.guru3d.com/files-categories/benchmarks-demos.html">Download (view list)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.guru3d.com/files-get/pcmark-10-download,3.html">DL (PCMark 10)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.guru3d.com/files-get/3dmark-download,4.html">DL (3DMark Time Spy)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.guru3d.com/files-get/futuremark-vrmark-download,2.html">DL (Futuremark VRMark)</a></td></tr>
<tr><td><strong>Passmark PerformanceTest</strong> <sub><br />&nbsp;&nbsp;&nbsp;CPU, RAM, Disk, 2D, 3D Benchmarks<i><br />&nbsp;&nbsp;&nbsp;Easy PC Benchmarking & Confiruation Comparisons</i></sub></td><td><a href="https://www.passmark.com/products/performancetest/download.php">Download (source)</a></td></tr>
<tr><td><strong>Prime95</strong> <sub><br />&nbsp;&nbsp;&nbsp;CPU Torture Test (simulated 100% load)</i></sub></td><td><a href="https://www.guru3d.com/files-details/prime95-download.html">Download (source)</a></td></tr>
<tr><td><strong>SiSoftware Sandra Lite</strong> <sub><br />&nbsp;&nbsp;&nbsp;CPU, GPU, Mobo, RAM, Disk, & More (Benchmarks)<i><br />&nbsp;&nbsp;&nbsp;Computer analysis, diagnosis & benchmarking</i></sub></td><td><a href="https://www.sisoftware.co.uk/download-lite/">Download (source)</a></td></tr>
<tr><td><strong>Unigine Benchmarks</strong> <sub><br />&nbsp;&nbsp;&nbsp;GPU Benchmark(s)<i><br />&nbsp;&nbsp;&nbsp;Heaven Benchmark (Free)</i></sub></td><td><a href="https://benchmark.unigine.com/">Download (source)</a><sub><br />Download (direct):<br />&nbsp;&nbsp;&nbsp;<a href="https://benchmark.unigine.com/heaven"> Heaven </a> | <a href="https://benchmark.unigine.com/superposition"> Superposition </a> | <a href="https://benchmark.unigine.com/valley"> Valley </a></sub></td></tr>
<tr><td><strong>V-Ray Benchmark</strong> <sub><br />&nbsp;&nbsp;&nbsp;GPU Benchmark<i><br />&nbsp;&nbsp;&nbsp;Free V-Ray Rendering Benchmark Utility</i></sub></td><td><a href="https://docs.chaosgroup.com/display/VRAYBENCH">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.techspot.com/downloads/downloadnow/7174/?evp=4390b8ba8b6bcd18f1fd0962b7c35486&file=1">Download (direct)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="communication"><br />Communication<br /><br /></h5></th></tr>
<tr><td><strong>Discord</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;VoIP & Digital Distribution</i></sub></td><td><a href="https://discordapp.com/download">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Teams</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Chat & App/File-Sharing</i></sub></td><td><a href="https://products.office.com/en-us/microsoft-teams/download-app">Download (source)</a></td></tr>
<tr><td><strong>Skype</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Free Video & Voice Calls</i></sub></td><td><a href="https://www.skype.com/en/get-skype/">Download (source)</a></td></tr>
<tr><td><strong>Skype for Business</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;<a href="https://support.microsoft.com/en-us/help/4511540/retirement-of-skype-for-business-online">Service(s) retired after July 31, 2021</a></i></sub></td><td><a href="https://products.office.com/en-us/skype-for-business/download-app">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="cross-platform"><br />Cross-Platform<br /><br /></h5></th></tr>
<tr><td><strong>AWS CLI</strong> <sub><br /><i>&nbsp;&nbsp;&nbsp;Amazon Web Services CLI<br />&nbsp;&nbsp;&nbsp;Manage & Administer Cloud Services via CLI</i></sub></td><td><a href="https://aws.amazon.com/powershell">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.powershellgallery.com/packages/AWSPowerShell">Download (PS-gallery)</a></sub><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.aws.amazon.com/powershell/latest/reference/Index.html">View Documentation</a></sub></td></tr>
<tr><td><strong>AzCopy</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;CLI Utility for copying blobs/files<br />&nbsp;&nbsp;&nbsp;to/from/between Azure Storage Accounts</i></sub></td><td><a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-blobs#copy-blobs-between-storage-accounts">View Docs (pt. 1)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-configure#optimize-throughput">View Docs (pt. 2)</a></sub></td></tr>
<tr><td><strong>Azure CLI (Az CLI)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Manage Azure Services via CLI</i></sub></td><td><a href="https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://aka.ms/installazurecliwindows">Download (direct)</a><br /><br /><details><summary><i>Download (PowerShell one-liner)</i></summary><p><ol><li><pre><code>Set-Location "${Home}\Downloads"; Invoke-WebRequest -Uri "https://aka.ms/installazurecliwindows" -OutFile ".\AzureCLI.msi"; Start-Process "msiexec.exe" -ArgumentList '/I AzureCLI.msi /quiet' -Wait;</code></pre></li></ol></p></details></sub></td></tr>
<tr><td><strong>Azure PowerShell Module</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;<strong>Requires: Az CLI</strong><br />&nbsp;&nbsp;&nbsp;Manage Azure Services via PowerShell cmdlets</i></sub></td><td><a href="https://docs.microsoft.com/en-us/powershell/azure/install-Az-ps">Download (source)</a><sub><br /><br /><br /><details><summary><i>Download (PowerShell one-liner)</i></summary><p><ol><li><pre><code>Install-Module -Name Az -AllowClobber -Scope CurrentUser;</code></pre></li></ol></p></details></sub></td></tr>
<tr><td><strong>Azure SDK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Languages, Frameworks, Management Tools & Extensions</i></sub></td><td><a href="https://docs.microsoft.com/en-us/azure/#pivot=sdkstools&panel=sdkstools-all">View Azure SDKs/Tools</a></sub></td></tr>
<tr><td><strong>Azure Storage Explorer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Management App for Azure Storage Accounts</i></sub></td><td><a href="https://go.microsoft.com/fwlink/?LinkId=708343">Download (direct)</a></sub></td></tr>
<tr><td><strong>Docker</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Leverages Linux LXC Containers</i></sub></td><td><a href="https://get.docker.com">View (source)</a></td></tr>
<tr><td><strong>Java Standard Edition (SE8)</strong> <sub><br /><i>&nbsp;&nbsp;&nbsp;JRE, JDK (Desktop/Server)<br />&nbsp;&nbsp;&nbsp;Server JRE (Server-Only)</i></sub></td><td><a href="https://java.com/en/download/win10.jsp">Download (source)</a></td></tr>
<tr><td><strong>Lua</strong> <sub><br /><i>&nbsp;&nbsp;&nbsp;High-level programming language</i></sub></td><td><a href="https://www.lua.org/download.html">Download (source)</a></td></tr>
<tr><td><strong>Microsoft .NET Framework</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Software framework developed by Microsoft</i></sub></td><td><a href="https://dotnet.microsoft.com/download/dotnet-framework">Download (source)</a><sub><i><br />&nbsp;&nbsp;&nbsp;<a href="https://dotnet.microsoft.com/download/dotnet-framework/net40">Download (Version 4.0-4.8)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/confirmation.aspx?id=21">Download (Version 3.5)<br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/confirmation.aspx?id=3005">Download (Version 3.0)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/confirmation.aspx?id=6523">Download (Version 2.0)</a></i></sub></td></tr>
<tr><td><strong>.NET Core SDK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Cross-platform successor to .NET Framework<br />&nbsp;&nbsp;&nbsp;View <a href="https://docs.microsoft.com/en-us/dotnet/core/sdk">.NET Core SDK overview</a></i></sub></td><td><a href="https://dotnet.microsoft.com/download/dotnet-core/scripts">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-centos7">Download (CentOS 7)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-1804">Download (Ubuntu 18.04)</a></sub></td></tr>
<tr><td><strong>.NET SDKs</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;for Visual Studio<br />&nbsp;&nbsp;&nbsp;.NET Core & .NET Framework SDKs</i></sub></td><td><a href="https://dotnet.microsoft.com/download/visual-studio-sdks">Download (source)</a></td></tr>
<tr><td><strong>PowerShell Core</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Standard Edition</i></sub></td><td><a href="https://github.com/PowerShell/PowerShell#get-powershell">Download (GitHub)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux">Download (Microsoft)</a></sub></td></tr>
<tr><td><strong>VMware ESXi-Customizer-PS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Builds ESXi ISOs using VMware PowerCLI</i></sub></td><td><a href="https://www.v-front.de/p/esxi-customizer-ps.html#download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="http://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1">Download (v2.6.0)</a></sub></td></tr>
<tr><td><strong>VMware PowerCLI / vSphere CLI</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;vSphere Hypervisor (ESXi) PowerShell Tools<br />&nbsp;&nbsp;&nbsp;<a href="https://www.vmware.com/support/developer/PowerCLI/">View VMware PowerCLI Documentation</a><br />&nbsp;&nbsp;&nbsp;<# Nuget Repo #> Install-Module -Name VMware.PowerCLI;</i></sub></td><td><a href="https://www.powershellgallery.com/packages/VMware.PowerCLI/11.5.0.14912921">DL (VMware PowerCLI)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://my.vmware.com/group/vmware/get-download?downloadGroup=VS-CLI-670">DL (vSphere CLI)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://code.vmware.com/tools">DL (other tools)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://code.vmware.com/web/tool/11.5.0/vmware-powercli">View Documentation (source)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://powercli-core.readthedocs.io/">View Documentation (core)</a></sub></td></tr>
<tr><td><strong>Windows Terminal</strong> <i><sub><br />&nbsp;&nbsp;&nbsp;Terminal Emulator for Windows 10</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9N0DX20HK701">Download (source)</a></td></tr>
<tr><td><strong>WiX</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Installer XML Toolset<br />&nbsp;&nbsp;&nbsp;Builds Windows Installer packages from XML</i></sub></td><td><a href="https://wixtoolset.org/releases/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://github.com/wixtoolset/wix3/releases">Download (GitHub)</a></sub></td></tr>
<tr><td><strong>WSL - All Distros</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Subsystem for Linux</i></sub></td><td><a href="https://aka.ms/wslstore">Download (source)</a></td></tr>
<tr><td><strong>WSL - Ubuntu</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Subsystem for Linux</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9N9TNGVNDL3Q">Download (18.04 LTS)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/store/productId/9PJN388HP8C9">Download (16.04 LTS)</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="development"><br />Software Development<br /><br /></h5></th></tr>
<tr><td><strong>Chocolatey</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Package Manager for Windows</i></sub></td><td><a href="https://chocolatey.org/docs/installation#install-with-cmdexe">Download (source)</a></td></tr>
<tr><td><strong>JQ</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Linux JSON Parser</i></sub></td><td><a href="https://github.com/stedolan/jq/releases">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Visual Studio Code</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;e.g. "VS Code", "VS-Code", "VSCode"<sub><i><br />&nbsp;&nbsp;&nbsp;Free Source Code Editor (IDE)<br />&nbsp;&nbsp;&nbsp;<a href="https://code.visualstudio.com/docs/getstarted/settings#_default-settings">View Docs: User and Workspace Settings</a></i></sub></td><td><a href="https://code.visualstudio.com/docs/?dv=win64">Download (direct)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://code.visualstudio.com/download">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync">Extension: Settings Sync</a><br />&nbsp;&nbsp;&nbsp;<a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack">Extension: Azure Tools</a></sub></td></tr>
<tr><td><strong>Microsoft Visual Studio</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;IDE used heavily or Windows .NET & ASP.NET app creation<br />&nbsp;&nbsp;&nbsp;Only the "Community Edition" ( CE ) is free - sign up<br />&nbsp;&nbsp;&nbsp;for Microsoft's free <strong><a href="https://aka.ms/devessentials">Visual Studio Dev Essentials</a></strong> program</i></td><td><a href="https://visualstudio.microsoft.com/vs/community/">Download (source, CE)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://visualstudio.microsoft.com/downloads/">Download (source, 2019/latest)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://visualstudio.microsoft.com/vs/older-downloads/">Download (source, 2017 & older)</a></sub></td></tr>
<tr><td><strong>Microsoft Visual Studio 20xx VC++ Redistributables</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Runtime components of Visual C++ Libraries<br />&nbsp;&nbsp;&nbsp;Scroll down to "Redistributables and Build Tools"</i></td><td><a href="https://visualstudio.microsoft.com/vs/older-downloads/">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Visual Studio Team Services CLI (Preview)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Run VSTS commands from local environment</td><td><a href="https://aka.ms/vsts-cli-windows-installer">Download (source)</a></td></tr>
<tr><td><strong>My Visual Studio</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Homepage for Visual Studio downloads</td><td><a href="https://my.visualstudio.com/Downloads/Featured">Download (source)</a></td></tr>
<tr><td><strong>Node.JS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source, cross-platform, JavaScript runtime environment</i></sub></td><td><a href="https://nodejs.org/en/download/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://nodejs.org/dist/">Download (older versions)</a></sub></td></tr>
<tr><td><strong>NuGet</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-Source Package Manager designed for<br />&nbsp;&nbsp;&nbsp;the Microsoft development platform</i></sub></td><td><a href="https://dist.nuget.org/win-x86-commandline/latest/nuget.exe">Download (source)</a></td></tr>
<tr><td><strong>PoshGui</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source tools & cmdlets for SysAdmins</i></sub></td><td><a href="https://poshgui.com/">Download (source)</a></td></tr>
<tr><td><strong>Remote Server Administration Tools (RSAT)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Allows for scalable management of Windows<br />&nbsp;&nbsp;&nbsp;Servers' attached Roles, Features, & more</i></sub></td><td><a href="https://www.microsoft.com/en-us/download/details.aspx?id=45520">Download (source)</a></td></tr>
<tr><td><strong>Windows ADK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Assessment and Deployment Kit<br />&nbsp;&nbsp;&nbsp;Includes Deployment Tools (Windows image/.iso tools):<br />&nbsp;&nbsp;&nbsp;<sub>&nbsp;&nbsp;&nbsp;DISM, DISM API, & OSCDIMG</sub></i></sub></td><td><a href="https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install?WT.mc_id=thomasmaurer-blog-thmaure#other-adk-downloads">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://go.microsoft.com/fwlink/?linkid=2086042">Download (direct)</a></sub></td></tr>
<tr><td><strong>Windows 10 SDK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Provides the following (for building Windows 10 Apps):<br />&nbsp;&nbsp;&nbsp;Headers, libraries, & tools for Win10 apps</sub></i></sub></td><td><a href="https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://go.microsoft.com/fwlink/p/?linkid=2083338&clcid=0x409">Download (direct)</a></sub></td></tr>
<tr><td><strong>Windows WDK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;<strong>Requires Windows 10 SDK</strong><br />&nbsp;&nbsp;&nbsp;<strong></strong>Microsoft Windows Driver Kit (WDK)<br />&nbsp;&nbsp;&nbsp;Includes Code-Signing Tools/Drivers:<br />&nbsp;&nbsp;&nbsp;<sub>&nbsp;&nbsp;&nbsp;CertMgr, Inf2Cat, MakeCat, MakeCert, Pvk2Pfx, & SignTool</sub></i></sub></td><td><a href="https://docs.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://go.microsoft.com/fwlink/?linkid=2085767">Download (direct)</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="dns"><br />DNS Authority Certificates (HTTPS)<sub><br />Intermediate/Root Certificates, e.g. Certificate Authority Bundles (CABUNDLEs)</sub><br /><br /></h5></th></tr>
<tr><td><strong>COMODO</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;DNS Authority & CABUNDLEs</i></sub></td><td><a href="https://support.comodo.com/index.php?/comodo/Knowledgebase/List/Index/75/instantsslenterprisesslintranetssl">Download (source)</a></td></tr>
<tr><td><strong>GoDaddy</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;DNS Authority & CABUNDLEs</i></sub></td><td><a href="https://ssl-ccp.godaddy.com/repository?origin=CALLISTO">Download (source)</a></td></tr>
<tr><td><strong>IdenTrust</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Timestamping Authority (Code-Signing)</i></sub></td><td><a href="https://www.identrust.com/timestamping-authority-server">Download (source)</a></td></tr>
<tr><td><strong>OpenTimestamps</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Timestamping Authority (Code-Signing)</i></sub></td><td><a href="https://opentimestamps.org/?digest=3bc98a0c89639e3e0b717701877a849bb8b38147402dfb19643cb3bd39894535#stamp-and-verify">Download (source)</a></td></tr>
<tr><td><strong>Namecheap</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;DNS Authority & CABUNDLEs</i></sub></td><td><a href="https://www.namecheap.com/support/knowledgebase/article.aspx/9393/69/where-do-i-find-ssl-ca-bundle">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle" title="A 'CA bundle' is a file that contains root and intermediate certificates. The end-entity certificate along with a CA bundle constitutes the certificate chain.">What is a CA bundle?</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="file-storage"><br />File-Storage<br /><br /></h5></th></tr>
<tr><td><strong>7-Zip</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source file archiver<br />&nbsp;&nbsp;&nbsp;Leverages the LZMA 2 compression algorithm</i></sub></td><td><a href="https://www.7-zip.org/download.html">Download (source)</a></td></tr>
<tr><td><strong>Box</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Desktop App(s)</i></sub></td><td><a href="https://www.box.com/resources/downloads">Download (source)</a></td></tr>
<tr><td><strong>Cryptomator</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Client-Side Cloud-Encryption</i></sub></td><td><a href="https://cryptomator.org/downloads/#winDownload">Download (source)</a></td></tr>
<tr><td><strong>Dropbox</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Desktop App(s)</i></sub></td><td><a href="https://www.dropbox.com/install">Download (source)</a></td></tr>
<tr><td><strong>Google Drive</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Backup and Sync</i></sub></td><td><a href="https://www.google.com/drive/download/">Download (source)</a></td></tr>
<tr><td><strong>iCloud</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Cloud Storage, Device Backup and Sync</i></sub></td><td><a href="https://www.microsoft.com/en-us/p/icloud/9pktq5699m62">Download (win10 app)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://support.apple.com/en-us/HT204283">Download (Desktop App)</a></sub></td></tr>
<tr><td><strong>OneDrive for Windows</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Desktop App(s)</i></sub></td><td><a href="https://onedrive.live.com/about/en-us/download/">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="hardware-utilities"><br />Hardware Utilities/Controllers<br /><br /></h5></th></tr>
<tr><td><strong>ASUS Aura Sync</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;RGB Controller</i></sub></td><td><a href="https://www.asus.com/campaign/aura/us/download.html">Download (source)</a></td></tr>
<tr><td><strong>AMD Ryzen/Radeon Drivers</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;2019-Dec: <a href="https://www.amd.com/en/support/previous-drivers/graphics/amd-radeon-5700-series/amd-radeon-rx-5700-series/amd-radeon-rx-5700-xt">Stability - 19.7.5/19.8.1/19.9.1/19.10.1</a></i></sub></td><td><a href="https://www.amd.com/en/support">Download (source)</a></td></tr>
<tr><td><strong>BalenaEtcher</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Drive Imaging Utility (.iso & .img, especially)</i></sub></td><td><a href="https://www.balena.io/etcher/">Download (source)</a></td></tr>
<tr><td><strong>Corsair iCue</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;RGB Controller (+ Aura API)</i></sub></td><td><a href="https://www.corsair.com/us/en/downloads">Download (source)</a></td></tr>
<tr><td><strong>Easy2Boot</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Multi-ISO Bootable Flash Drive</i></sub></td><td><a href="https://www.fosshub.com/Easy2Boot.html">Download (source)</a></td></tr>
<tr><td><strong>EVGA Precision X1</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;GPU/GRAM Overclocking Software<br />&nbsp;&nbsp;&nbsp;Controls for Core-Clock, Voltage, Fans, & RGB</i></sub></td><td><a href="https://www.evga.com/precisionx1/">Download (source)</a></td></tr>
<tr><td><strong>ESXCLI</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;ESXi Embedded Host Client (SSH)</i></sub></td><td><a href="http://download3.vmware.com/software/vmw-tools/esxui/esxui-signed-latest.vib">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://flings.vmware.com/esxi-embedded-host-client#instructions">Installation (docs)</a></sub></td></tr>
<tr><td><strong>Intel® DSA</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Intel Driver & Support Assistant</i></sub></td><td><a href="https://www.intel.com/content/www/us/en/support/detect.html">Download (source)</a></td></tr>
<tr><td><strong>LG OnScreen Control</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Driver + Software for LG 34UC88-B Display/Monitor</i></sub></td><td><a href="https://www.lg.com/uk/search.lg?search=onscreen+control">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.lg.com/uk/support/support-product/lg-34UC88-B">View Drivers & Software</a></sub></td></tr>
<tr><td><strong>Logitech G Hub</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Keyboard/Mouse RGB (+3rd Party Tools)</i></sub></td><td><a href="https://support.logi.com/hc/en-us/articles/360025298133">Download (source)</a></td></tr>
<tr><td><strong>Logitech Options</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Enhanced functionality for Logitech devices</i></sub></td><td><a href="https://www.logitech.com/en-us/product/options">Download (source)</a></td></tr>
<tr><td><strong>Logitech SetPoint</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Mouse/Keyboard Hotkey Manager</i></sub></td><td><a href="http://support.logitech.com/software/setpoint">Download (source)</a></td></tr>
<tr><td><strong>Logitech Unifying Software</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Add/Remove devices to a Unifying receiver</i></sub></td><td><a href="https://support.logi.com/hc/en-001/articles/360025297913-Unifying-Software">Download (source)</a></td></tr>
<tr><td><strong>Media Feature Pack for Windows</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Required for iCloud Desktop App</i></sub></td><td><a href="https://www.microsoft.com/en-us/software-download/mediafeaturepack">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://software-download.microsoft.com/db/Windows_MediaFeaturePack_x64_1903_V1.msu?t=4ee189cc-b6e5-4270-9584-668bb77cb922&e=1578037636&h=a44afb20246abe7c34d751332e02df5d">Download (v1903, direct)</a></sub></td></tr>
<tr><td><strong>Netgear Switch Discovery Tool</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Locates Netgear Smart Switches on LAN</i></sub></td><td><a href="https://www.netgear.com/support/product/GS908E.aspx#download">Download (source)</a></td></tr>
<tr><td><strong>PCPartPicker</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Component Pricing/Compatibility Comparisons</i></sub></td><td><a href="https://pcpartpicker.com/user/cavalol/saved/7Q2Mcf">Open (web-service)</a></td></tr>
<tr><td><strong>Razer Synapse</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Mouse/Keyboard Hotkey Manager<br />&nbsp;&nbsp;&nbsp;Chroma RGB Controller</i></sub></td><td><a href="https://www.razer.com/synapse">Download (source)</a></td></tr>
<tr><td><strong>RMPrepUSB</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Multiboot formatter for USB-drives</i></sub></td><td><a href="https://www.fosshub.com/RMPrepUSB.html">Download (source)</a></td></tr>
<tr><td><strong>RoboForm</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Multi-platform secure password manager</i></sub></td><td><a href="https://www.roboform.com/download">Download (source)</a></td></tr>
<tr><td><strong>Rufus</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Format/create bootable USB Drives (from .ISOs)</i></sub></td><td><a href="https://rufus.ie/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Ryzen DRAM Calculator</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Helps with overclocking memory<br />&nbsp;&nbsp;&nbsp;on the AMD Ryzen platform</i></sub></td><td><a href="https://www.techpowerup.com/download/ryzen-dram-calculator/">Download (source)</a></td></tr>
<tr><td><strong>Sonos desktop controller</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Control LAN Sonos speakers</i></sub></td><td><a href="https://www.sonos.com/redir/controller_software_pc">Download (source)</a></td></tr>
<tr><td><strong>VMware - All Downloads</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;VMware vSphere, VMware Workstation,<br />&nbsp;&nbsp;&nbsp;VMware Fusion, VMware Player, etc.</i></sub></td><td><a href="https://my.vmware.com/web/vmware/downloads">Download (source)</a></td></tr>
<tr><td><strong>Yubico Tools</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Security Key Configuration</i></sub></td><td><a href="https://www.yubico.com/products/services-software/download/">Download (source)</a></td></tr>
<tr><td><strong>WinSW: Windows service wrapper</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;(in less restrictive license)</i></sub></td><td><a href="https://github.com/kohsuke/winsw/">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="monitoring"><br />Monitoring<br /><br /></h5></th></tr>
<tr><td><strong>CoreTemp <sub>(Core Temp)</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;CPU temperature monitoring/logging</i></sub></td><td><a href="https://www.alcpu.com/CoreTemp/">Download (source)</a></td></tr>
<tr><td><strong>CrystalDiskInfo</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Pulls HDD S.M.A.R.T. Statistics<br />&nbsp;&nbsp;&nbsp;Checks HDD Sector Health</i></sub></td><td><a href="https://crystalmark.info/redirect.php?product=CrystalDiskInfoInstaller">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://crystalmark.info/redirect.php?product=CrystalDiskInfo">Download (portable)</a></sub></td></tr>
<tr><td><strong>Hard Disk Sentinel</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Monitors SSD Temperatures<br />&nbsp;&nbsp;&nbsp;Monitors HDD/SSD ongoing performance<br />&nbsp;&nbsp;&nbsp;Pulls HDD S.M.A.R.T. Statistics<br />&nbsp;&nbsp;&nbsp;Allows custom alerts based on user-defined thresholds</i></sub></td><td><a href="https://www.hdsentinel.com/download.php">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.harddisksentinel.com/hdsentinel_setup.zip">Download (direct)</a></td></tr>
<tr><td><strong>PRTG</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Paessler AG<br />&nbsp;&nbsp;&nbsp;Agentless network monitoring software</i></sub></td><td><a href="https://www.paessler.com/prtg-desktop-app#downloads">Download (source, client)</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="multimedia"><br />Multimedia<br /><br /></h5></th></tr>
<tr><td><strong>Audacity</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source source, cross-platform audio software</a></i></sub></td><td><a href="https://www.fosshub.com/Audacity.html?download">Download (mirror)</a></td></tr>
<tr><td><strong>Dynamic Theme</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Updates/applies bing background & windows spotlight</a></i></sub></td><td><a href="https://www.microsoft.com/store/productId/9NBLGGH1ZBKW">Download (source)</a></td></tr>
<tr><td><strong>Greenshot</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source Screenshot Program<br />&nbsp;&nbsp;&nbsp;Replaces/Upgrades Print screen & Snipping tool</a></i></sub></td><td><a href="https://getgreenshot.org/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Paint.NET</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Free Image & Photo Editing Software<br />&nbsp;&nbsp;&nbsp;<a href="https://www.getpaint.net/doc/latest/KeyboardMouseCommands.html">View Keyboard & Mouse Commands (Hotkeys)</a></i></sub></td><td><a href="https://www.dotpdn.com/downloads/pdn.html">Download (source)</a></td></tr>
<tr><td><strong>RainMeter</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-Source Desktop Customization Utility</i></sub></td><td><a href="http://www.rainmeter.net/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://builds.rainmeter.net/Rainmeter-4.3.1.exe">Download (direct)</a></sub></td></tr>
<tr><td><strong>Spotify</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Music Streaming</i></sub></td><td><a href="https://www.spotify.com/us/download/other/">Download (source)</a></td></tr>
<tr><td><strong>SVG Explorer Extension</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Explorer icon thumbnails for .svg files<br />&nbsp;&nbsp;&nbsp;<a href="https://github.com/tibold/svg-explorer-extension/releases/tag/v0.1.1">View GitHub (Note: Signed .exe broken in Win10)</a></i></sub></td><td><a href="https://github.com/tibold/svg-explorer-extension/releases/download/v0.1.1/dssee_setup_x64_v011.exe">Download (source)</a></td></tr>
<tr><td><strong>Twitch App</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Live-Streaming & Mod Management</i></sub></td><td><a href="https://twitch.tv/downloads">Download (source)</a></td></tr>
<tr><td><strong>VirtualDub</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source Video Capture/Processing Utility<br />&nbsp;&nbsp;&nbsp;Use XVid Video Compression via:<br />&nbsp;&nbsp;&nbsp;   Video > Compression > "Xvid ..." > OK</i></sub></td><td><a href="https://sourceforge.net/projects/virtualdub/files/latest/download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://sourceforge.net/projects/virtualdubffmpeginputplugin/">Download (FFMpeg Codec)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.xvid.com/download/">Download (XVid - EXE)</a><br />&nbsp;&nbsp;&nbsp; &uarr; Download exe & codecs<br />&nbsp;&nbsp;&nbsp;<a href="https://downloads.xvid.com/downloads/">View XVid Source</a></sub></td></tr>
<tr><td><strong>VLC</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source, Cross-Platform Multimedia Player</i></sub></td><td><a href="https://www.videolan.org/vlc/index.html">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="personalization"><br />Personalization<br /><br /></h5></th></tr>
<tr><td><strong>Lockscreen as wallpaper</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Mirrors LockScreen Background onto Desktop</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9NBLGGH4WR7C">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="operating-systems"><br />OS (Operating Systems)<br /><br /></h5></th></tr>
<tr><td><strong>CentOS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Community Enterprise Operating System</i></sub></td><td>
	<details><summary><i>CentOS 8 Mirror(s)</i></summary>
		<h5>
			<ul>
				<li><a href="https://mirror.tzulo.com/centos/8/isos/x86_64/">https://mirror.tzulo.com/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirror.vcu.edu/pub/gnu_linux/centos/8/isos/x86_64/">https://mirror.vcu.edu/pub/gnu_linux/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirrors.rit.edu/centos/8/isos/x86_64/">https://mirrors.rit.edu/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirrors.syringanetworks.net/centos/8/isos/x86_64/">https://mirrors.syringanetworks.net/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirrors.tripadvisor.com/centos/8/isos/x86_64/">https://mirrors.tripadvisor.com/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirror.genesisadaptive.com/centos/8/isos/x86_64/">https://mirror.genesisadaptive.com/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirror.math.princeton.edu/pub/centos/8/isos/x86_64/">https://mirror.math.princeton.edu/pub/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirror.steadfastnet.com/centos/8/isos/x86_64/">https://mirror.steadfastnet.com/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirror.web-ster.com/centos/8/isos/x86_64/">https://mirror.web-ster.com/centos/8/isos/x86_64/</a></li>
				<li><a href="https://mirrors.sonic.net/centos/8/isos/x86_64/">https://mirrors.sonic.net/centos/8/isos/x86_64/</a></li>
				<li><a href="https://packages.oit.ncsu.edu/centos/8/isos/x86_64/">https://packages.oit.ncsu.edu/centos/8/isos/x86_64/</a></li>
			</ul>
		</h5>
	</details>
	<details><summary><i>CentOS 7 Mirror(s)</i></summary>
		<h5>
			<ul>
				<li><a href="https://mirror.tzulo.com/centos/7/isos/x86_64/">https://mirror.tzulo.com/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirror.vcu.edu/pub/gnu_linux/centos/7/isos/x86_64/">https://mirror.vcu.edu/pub/gnu_linux/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirrors.rit.edu/centos/7/isos/x86_64/">https://mirrors.rit.edu/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirrors.syringanetworks.net/centos/7/isos/x86_64/">https://mirrors.syringanetworks.net/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirrors.tripadvisor.com/centos/7/isos/x86_64/">https://mirrors.tripadvisor.com/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirror.genesisadaptive.com/centos/7/isos/x86_64/">https://mirror.genesisadaptive.com/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirror.math.princeton.edu/pub/centos/7/isos/x86_64/">https://mirror.math.princeton.edu/pub/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirror.steadfastnet.com/centos/7/isos/x86_64/">https://mirror.steadfastnet.com/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirror.web-ster.com/centos/7/isos/x86_64/">https://mirror.web-ster.com/centos/7/isos/x86_64/</a></li>
				<li><a href="https://mirrors.sonic.net/centos/7/isos/x86_64/">https://mirrors.sonic.net/centos/7/isos/x86_64/</a></li>
				<li><a href="https://packages.oit.ncsu.edu/centos/7/isos/x86_64/">https://packages.oit.ncsu.edu/centos/7/isos/x86_64/</a></li>
			</ul>
		</h5>
	</details>
	<details><summary><i>CentOS 6 Mirror(s)</i></summary>
		<h5>
			<ul>
				<li><a href="https://mirror.tzulo.com/centos/6/isos/x86_64/">https://mirror.tzulo.com/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirror.vcu.edu/pub/gnu_linux/centos/6/isos/x86_64/">https://mirror.vcu.edu/pub/gnu_linux/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirrors.rit.edu/centos/6/isos/x86_64/">https://mirrors.rit.edu/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirrors.syringanetworks.net/centos/6/isos/x86_64/">https://mirrors.syringanetworks.net/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirrors.tripadvisor.com/centos/6/isos/x86_64/">https://mirrors.tripadvisor.com/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirror.genesisadaptive.com/centos/6/isos/x86_64/">https://mirror.genesisadaptive.com/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirror.math.princeton.edu/pub/centos/6/isos/x86_64/">https://mirror.math.princeton.edu/pub/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirror.steadfastnet.com/centos/6/isos/x86_64/">https://mirror.steadfastnet.com/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirror.web-ster.com/centos/6/isos/x86_64/">https://mirror.web-ster.com/centos/6/isos/x86_64/</a></li>
				<li><a href="https://mirrors.sonic.net/centos/6/isos/x86_64/">https://mirrors.sonic.net/centos/6/isos/x86_64/</a></li>
				<li><a href="https://packages.oit.ncsu.edu/centos/6/isos/x86_64/">https://packages.oit.ncsu.edu/centos/6/isos/x86_64/</a></li>
			</ul>
		</h5>
	</details>
</td></tr>
<tr><td><strong>FreeNAS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source Storage Operating System<br />&nbsp;&nbsp;&nbsp;Based on FreeBSD & OpenZFS file system<br />&nbsp;&nbsp;&nbsp;<a href="https://www.netcomplete.ch/bwl-knowledge-base/install-freenas-esxi/">FreeNAS as ESXi Storage Controller</a></i></sub></td><td><a href="https://www.freenas.org/download-freenas-release/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://download.freenas.org/stable/x64/">Download (stable)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://download.freenas.org/latest/x64/">Download (latest)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://archive.freenas.org/current-releases">Download (current releases)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://archive.freenas.org/">Download (archived releases)</a></sub></td></tr>
<tr><td><strong>Lubuntu</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Debian Linux</i></sub></td><td><a href="https://lubuntu.me/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Server 2016</strong> <sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/windows-server/get-started/system-requirements">View System Requirements (Minimum)</a></sub></td><td><a href="https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016">Download (source)</a></td></tr>
<tr><td><strong>Ubuntu Desktop</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Debian Linux</i></sub></td><td><a href="https://ubuntu.com/download/desktop">Download (source)</a></td></tr>
<tr><td><strong>Ubuntu Server</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Debian Linux</i></sub></td><td><a href="https://ubuntu.com/download/server">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://mirror.umd.edu/ubuntu-iso/16.04/">Download (16.04 LTS)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://mirror.umd.edu/ubuntu-iso/14.04/">Download (14.04 LTS)</a></sub></td></tr>
<tr><td><strong>ESXi</strong> <sub>
	<i>
		<br />&nbsp;&nbsp;&nbsp;VMware vSphere Hypervisor
		<br />&nbsp;&nbsp;&nbsp;<details><summary>(Docs) ESXi Installation/Setup</summary>
			<h5>
				<ul>
					<li>&nbsp;&nbsp;&nbsp;<a href="https://docs.vmware.com/en/VMware-vSphere/6.7/vsphere-esxi-67-installation-setup-guide.pdf">(Docs) ESXi 6.7 Installation/Setup</a></li>
					<li>&nbsp;&nbsp;&nbsp;<a href="https://docs.vmware.com/en/VMware-vSphere/6.5/vsphere-esxi-vcenter-server-65-installation-setup-guide.pdf">(Docs) ESXi 6.5 Installation/Setup</a></li>
					<li>&nbsp;&nbsp;&nbsp;<a href="https://docs.vmware.com/en/VMware-vSphere/6.0/vsphere-esxi-vcenter-server-602-installation-setup-guide.pdf">(Docs) ESXi 6.0 Installation/Setup</a></li>
					<li>&nbsp;&nbsp;&nbsp;<a href="https://docs.vmware.com/en/VMware-vSphere/5.5/vsphere-esxi-vcenter-server-552-installation-setup-guide.pdf">(Docs) ESXi 5.5 Installation/Setup</a></li>
				</ul>
			</h5>
		</details>
		&nbsp;&nbsp;&nbsp;<a href="https://rufus.ie/">(Docs) Creating a bootable USB-drive w/ Rufus</a>
		<br />&nbsp;&nbsp;&nbsp;Note: Requires a "My VMware" account (free)
	</i></sub></td><td><a href="https://www.vmware.com/go/get-free-esxi">Download (source)</a>
</td></tr>
<tr><td><strong>Windows 10</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Create Windows 10 Installation Media</i></sub></td><td><a href="https://www.microsoft.com/en-us/software-download/windows10">Download (source)</a></td></tr>
<tr><td><strong>Xubuntu</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Debian Linux</i></sub></td><td><a href="https://xubuntu.org/download">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="server-runtimes"><br />Server Applications/Services<br /><br /></h5></th></tr>
<tr><td><strong>Apache httpd</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-Source, Cross-Platform Web Server</sub></td><td><a href="https://httpd.apache.org/download.cgi">Download (source)</a></td></tr>
<tr><td><strong>Dell EMC OMSA <sub>(OpenManage Server Administrator)</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Browser-based Management Utility for Dell iDRAC</br >&nbsp;&nbsp;&nbsp;(1/2) Install Windows Service (Web-Server, Port 1311)</br >&nbsp;&nbsp;&nbsp;(2/2) Install the .vib on desired ESXi host(s)</i></sub></td><td><a href="https://www.dell.com/support/article/en-us/sln312492/support-for-dell-emc-openmanage-server-administrator-omsa">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://dl.dell.com/FOLDER06019899M/1/OM-SrvAdmin-Dell-Web-WINX64-9.4.0-3787_A00.exe">Download (Windows svc)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://dl.dell.com/FOLDER05993176M/1/OM-SrvAdmin-Dell-Web-9.4.0-3776.VIB-ESX65i_A00.zip">Download (ESXI .vib)</a></sub></td></tr>
<tr><td><strong>Dell Platform Specific Bootable ISOs</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Official Dell Driver + Firmware ISOs<br />&nbsp;&nbsp;&nbsp;View <a href="https://www.dell.com/support/article/en-us/sln296810/how-to-create-a-bootable-usb-device-with-rufus-to-update-dell-servers?lang=en">Create Bootable Dell Server ISO</a></i></sub></td><td><a href="https://www.dell.com/support/article/en-us/sln296511/update-poweredge-servers-with-platform-specific-bootable-iso?lang=en#2">Download (source)</a></td></tr>
<tr><td><strong>Docker - Containerized</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Linux LXC Container Management</i></sub></td><td><a href="https://get.docker.com">View (source)</a></td></tr>
<tr><td><strong>Get-SystemSpecs</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Hardware Spec 'Getter' using WMIC</i></sub></td><td><sub><details><summary><i>Download (PowerShell one-liner)</i></summary><p><ol><li><pre><code>(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/mcavallo-git/Coding/master/cmd/cmd%20-%20Get-SystemSpecs.bat","${Env:TEMP}\Get-SystemSpecs.bat"); Start-Process -Filepath ("${Env:ComSpec}") -ArgumentList (@("/C","${Env:TEMP}\Get-SystemSpecs.bat"));</code></pre></li></ol></p></details></sub></td></tr>
<tr><td><strong>Jenkins - CI/CD Server</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Automates Continuous Integration (CI)<br />&nbsp;&nbsp;&nbsp;Facilitates Continuous-Deployment (CD)</i></sub></td><td><a href="https://jenkins.io">View (source)</a></td></tr>
<tr><td><strong>NSSM</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Non-Sucking Service<br />&nbsp;&nbsp;&nbsp;Manager (Windows)</i></sub></td><td><a href="https://github.com/minio/mc">Download (Linux)</a></td></tr>
<tr><td><strong>MinIO Server</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;S3 Storage Server<br />&nbsp;&nbsp;&nbsp;rclone sync source:bucket dest:bucket</i></sub></td><td><a href="https://min.io/download#/linux">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://min.io/download#/windows">Download (Windows)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://dl.min.io/server/minio/release/windows-amd64/minio.exe">Download (direct)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.minio.io/docs/rclone-with-minio-server">Download (rclone)</a></td></tr>
<tr><td><strong>MongoDB</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Document Database</i></sub></td><td><a href="https://www.mongodb.com/download-center/community">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/">Installation Guide</a></sub></td></tr>
<tr><td><strong>Microsoft JDBC Driver</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Java Database Connectivity API<br />&nbsp;&nbsp;&nbsp;Defines how a client may access a database</i></sub></td><td><a href="https://www.microsoft.com/en-us/download/details.aspx?id=56615">Download (source)</a></td></tr>
<tr><td><strong>Microsoft ODBC Driver</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;DLL allowing apps to query T-SQL DBs</i></sub></td><td><a href="https://www.microsoft.com/en-us/download/details.aspx?id=36434">Download (source)</a></td></tr>
<tr><td><strong>Microsoft SQL Server</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows-Based Database Instance<br />&nbsp;&nbsp;&nbsp;View <a href="https://docs.microsoft.com/en-us/sql/database-engine/install-windows/latest-updates-for-microsoft-sql-server">Latest updates for Microsoft SQL Server</a><br />&nbsp;&nbsp;&nbsp;SqlLocalDB - LocalDB<br />&nbsp;&nbsp;&nbsp;SQLEXPR - Express<br />&nbsp;&nbsp;&nbsp;SQLEXPRWT - Express with Tools<br />&nbsp;&nbsp;&nbsp;SQLManagementStudio - SQL Studio Manager Express<br />&nbsp;&nbsp;&nbsp;SQLEXPRADV - Express + Advanced Services</i></sub></td><td><a href="https://www.microsoft.com/en-us/sql-server/sql-server-downloads">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://go.microsoft.com/fwlink/?linkid=866658">Download (source, 2019-express)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=56836">Download (source, 2016-SP2)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=55994">Download (source, 2017-express)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=57474">Download (source, 2014-SP3)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=49996">Download (source, 2012-SP3)</a></sub></td></tr>
<tr><td><strong>Microsoft SSMS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;SQL Server Management Studio<br />&nbsp;&nbsp;&nbsp;SQL Infrastructure Management Tool<br />&nbsp;&nbsp;&nbsp;Troubleshooting:<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Right-Click Instance -> "Activity Monitor"</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms">Download (source)</a></td></tr>
<tr><td><strong>MySQL Workbench</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MySQL Infrastructure Management Tool</i></sub></td><td><a href="https://dev.mysql.com/downloads/workbench/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-8.0.19-winx64.msi">Download (direct)</a></sub></td></tr>
<tr><td><strong>NGINX</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-Source Web Server, Reverse Proxy,<br />&nbsp;&nbsp;&nbsp;Load Balancer, Mail Proxy, & HTTP Cache</sub></td><td><a href="https://nginx.org/en/download.html">Download (source)</a></td></tr>
<tr><td><strong>phpMyAdmin</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MySQL Administration & Management Portal<br />&nbsp;&nbsp;&nbsp;PHP self-host service (add security as-needed)</i></sub></td><td><a href="https://www.phpmyadmin.net/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Webmin</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Web (GUI) based tool for managing Unix system(s)</i></sub></td><td><a href="https://www.redhat.com/sysadmin/webmin">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="troubleshooting"><br />Troubleshooting<br /><br /></h5></th></tr>
<tr><td><strong>AIDA64</strong> <sub><br />&nbsp;&nbsp;&nbsp;Mobile Specsheet (High Verbosity)<br />&nbsp;&nbsp;&nbsp;Mobile version is Free w/ ads<br />&nbsp;&nbsp;&nbsp;Desktop version is Paid $$</i></sub></td><td><a href="https://www.aida64.com/downloads">Download (source)</a></sub></td></tr>
<tr><td><strong>BlueScreenView</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Nirsoft</i></sub></td><td><a href="https://www.nirsoft.net/utils/blue_screen_view.html">Download (source)</a></td></tr>
<tr><td><strong>CCleaner</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Piriform<br />&nbsp;&nbsp;&nbsp;Automated disk & registry cleaning tool</i></sub></td><td><a href="https://www.ccleaner.com/ccleaner/download/standard">Download (source)</a></td></tr>
<tr><td><strong>Cipher Suites in TLS/SSL (Schannel SSP)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;A cipher suite must have algorithms for the tasks:<br />&nbsp;&nbsp;&nbsp;∙ Key exchange<br />&nbsp;&nbsp;&nbsp;∙ Bulk encryption<br />&nbsp;&nbsp;&nbsp;∙ Message authentication</i></sub></td><td><a href="https://docs.microsoft.com/en-us/windows/win32/secauthn/cipher-suites-in-schannel">Download (source)</a></td></tr>
<tr><td><strong>DDU (Display Driver Uninstaller)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Removes ALL graphics drivers</i></sub></td><td><a href="https://www.guru3d.com/files-get/display-driver-uninstaller-download,19.html">Download (source)</a><sub><br >&nbsp;&nbsp;&nbsp;<a href="https://www.guru3d.com/files-details/display-driver-uninstaller-download.html">Download (mirror)</a></sub></td></tr>
<tr><td><strong>DigiCert Certificate Utility</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Certificate Inspection Tool (DigiCertUtil.exe)</i></sub></td><td><a href="https://www.digicert.com/util/DigiCertUtil.zip">Download (direct)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.digicert.com/util/">Download (source)</a></sub></td></tr>
<tr><td><strong>DigiCert SSL Tools</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Check Host SSL/TLS, Generate CSR,<br />&nbsp;&nbsp;&nbsp;Check CSR, Searct CT Logs</i></sub></td><td><a href="https://ssltools.digicert.com/checker/">Open (web-service)</a></td></tr>
<tr><td><strong>Effective File Search (EFS)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Search tool</i></sub></td><td><a href="https://effective-file-search.en.lo4d.com/download">Download (mirror)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download">Download (fallback)</a></sub></td></tr>
<tr><td><strong>FindLinks</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/findlinks">Download (source)</a></td></tr>
<tr><td><strong>IIS Crypto</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Streamlined Windows Server Encryption Management<br />&nbsp;&nbsp;&nbsp;SSL/TLS Certificate Management, Ciphers, etc.</i></sub></td><td><a href="https://www.nartac.com/Products/IISCrypto">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.nartac.com/Downloads/IISCrypto/IISCrypto.exe">Download (direct, GUI)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.nartac.com/Downloads/IISCrypto/IISCryptoCli.exe">Download (direct, CLI)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/windows/win32/secauthn/cipher-suites-in-schannel">Docs - TLS/SSL Cipher Suites</a></sub></td></tr>
<tr><td><strong>ImmuniWeb SSLScan (HTTPS)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Application Security Testing (AST)<br />&nbsp;&nbsp;&nbsp;Attack Surface Management (ASM)</i></sub></td><td><a href="https://www.htbridge.com/ssl/">Open (web-service)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.immuniweb.com/ssl/API_documentation.pdf">View API Documentation</a></sub></td></tr>
<tr><td><strong>KDiff3</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Text Difference Analyzer</i></sub></td><td><a href="https://sourceforge.net/projects/kdiff3/files/latest/download">Download (source)</a></td></tr>
<tr><td><strong>Malwarebytes</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Anti-Malware Utility</i></sub></td><td><a href="https://www.malwarebytes.com/mwb-download/thankyou/">Download (source)</a></td></tr>
<tr><td><strong>MC</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MinIO Client</i></sub></td><td><a href="https://dl.min.io/client/mc/release/windows-amd64/mc.exe">Download (source)</a></td></tr>
<tr><td><strong>NETworkManager</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Network Management/Troubleshooting Tool</i></sub></td><td><a href="https://github.com/BornToBeRoot/NETworkManager#download">Download (source)</a></td></tr>
<tr><td><strong>Postman</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;API-Development Collaboration Platform<br />&nbsp;&nbsp;&nbsp;HTTP GET/OPTION/POST/etc. Request-Debugger<br />&nbsp;&nbsp;&nbsp;View <a href="https://raw.githubusercontent.com/mcavallo-git/Coding/master/postman/postman_collection.json">Demo Collection</a> (Download & Import)</i></sub></td><td><a href="https://getpostman.com/downloads" id="download-postman">Download (mirror)</a></td></tr>
<tr><td><strong>ProduKey</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Nirsoft<br />&nbsp;&nbsp;&nbsp;Recover lost Windows product key(s)</i></sub></td><td><a href="https://www.nirsoft.net/utils/product_cd_key_viewer.html">Download (source)</a></td></tr>
<tr><td><strong>PsTools</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals<br />&nbsp;&nbsp;&nbsp;PsExec, PsService, PsShutdown, PsGetSid, ...</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/psgetsid">Download (source)</a></td></tr>
<tr><td><strong>Process Explorer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer">Download (source)</a></td></tr>
<tr><td><strong>PureVPN</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Commercial Virtual Private Network (VPN) service<br />&nbsp;&nbsp;&nbsp;Owned by GZ Systems Ltd.</i></sub></td><td><a href="https://www.purevpn.com/download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://support.purevpn.com/vpn-servers">PureVPN Servers</a><br />&nbsp;&nbsp;&nbsp;<a href="https://support.purevpn.com/vpn-servers">Win10 VPN Setup</a></sub></td></tr>
<tr><td><strong>Qualys SSL Server Test (HTTPS)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Application Security Testing (AST)<br />&nbsp;&nbsp;&nbsp;Attack Surface Management (ASM)</i></sub></td><td><a href="https://www.ssllabs.com/ssltest/">Open (web-service)</a></td></tr>
<tr><td><strong>TCPView</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview">Download (source)</a></td></tr>
<tr><td><strong>WakeMeOnLan</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Nirsoft</i></sub></td><td><a href="https://www.nirsoft.net/utils/wake_on_lan.html">Download (source)</a></td></tr>
<tr><td><strong>WinDirStat</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Disk Usage Analyzer</i></sub></td><td><a href="https://www.fosshub.com/WinDirStat.html">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://windirstat.net/download.html">Download (fallback)</a></sub></td></tr>
<tr><td><strong>WinTail</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Tail for Windows</i></sub></td><td><a href="https://sourceforge.net/projects/wintail/">Download (source)</a></td></tr>
<tr><td><strong>WireShark</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open-source Packet Analyzer</i></sub></td><td><a href="https://www.wireshark.org/download.html">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="pre-packaged"><br />Pre-Packaged<br /><br /></h5></th></tr>
<tr><td><strong>Ninite Package Manager</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Package Management System</i></sub></td><td><a href="https://ninite.com/7zip-audacity-chrome-classicstart-dropbox-filezilla-firefox-greenshot-handbrake-notepadplusplus-paint.net-vlc-vscode-windirstat/">Download (source)</a><sub><i><br />&nbsp;&nbsp;&nbsp;Includes 7-Zip, Audacity, Chrome, Classic Shell,<br />&nbsp;&nbsp;&nbsp;DropBox, FileZilla, FireFox, GreenShot, HandBrake,<br />&nbsp;&nbsp;&nbsp;NotePad++, Paint.Net, VLC, VS-Code, & WinDirStat</i></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->

</table>

</details>

<hr />


<!-- ------------------------------------------------------------ -->

<li>
	<strong><a href="https://github.com/mcavallo-git/Coding/tree/master/windows#workstation-installs">(Continued) Windows Tips/Tricks</a></strong>
</li>

<hr />


<!-- ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "SignTool.exe (Sign Tool) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/framework/tools/signtool-exe
#
#   en.wikipedia.org  |  "DevOps"  |  https://en.wikipedia.org/wiki/DevOps
#
#   en.wikipedia.org  |  "FreeNAS"  |  https://en.wikipedia.org/wiki/FreeNAS
#
#   reddit.com  |  "[List] Essential Software for your Windows PC"  |  https://www.reddit.com/r/software/comments/8tx8w7/list_essential_software_for_your_windows_pc/
#
#   reddit.com  |  "Most stable driver version for 5700/5700XT?"  |  https://www.reddit.com/r/Amd/comments/d00l3w/most_stable_driver_version_for_57005700xt/ezeakz0/
#
#   reddit.com  |  "What application do you always install on your computer and recommend to everyone?"  |  https://www.reddit.com/r/AskReddit/comments/4g5sl1/what_application_do_you_always_install_on_your/
# 
#   www.atlassian.com  |  "DevOps: Breaking the Development-Operations barrier"  |  https://www.atlassian.com/devops
#
#   www.guru3d.com  |  "Benchmarks & Demos"  |  https://www.guru3d.com/files-categories/benchmarks-demos.html
#
--- ------------------------------------------------------------ -->