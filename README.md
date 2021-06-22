<!-- ------------------------------------------------------------ ---

This file (on GitHub):

	https://github.com/mcavallo-git/Coding#coding

--- ------------------------------------------------------------- -->

<br id="devops-resource-reference" />
<br />
<div style="text-align:left;"><a href="https://github.com/mcavallo-git"><img src="images/icons-avatars/mtrip.281px-borderless.bluepurp.png" height="120" /></a></div>

<h3 >DevOps Resource Reference <sub> [ <a href="https://mcavallo.com">https://mcavallo.com</a> , <a href="https://cava.lol">https://cava.lol</a> ] </h3>
<br />

<details><summary><i>What is DevOps?</i></summary>
	<br />
	<div>Wikipedia<sup>&nbsp;<a href="https://en.wikipedia.org/wiki/DevOps">[1]</a></sup> states:</div>
	<blockquote>DevOps is a set of practices that combines software development (Dev) and information-technology operations (Ops) which aims to shorten the systems development life cycle and provide continuous delivery with high software quality.</blockquote>
	<div>Atlassian<sup>&nbsp;<a href="https://www.atlassian.com/devops">[4]</a></sup> states:</div>
	<blockquote>DevOps is a set of practices that automates the processes between software development and IT teams, in order that they can build, test, and release software faster and more reliably.<a href="https://www.atlassian.com/devops"><img src="images/archive/devops-loop-illustrations.atlassian.png" /></a></blockquote>
</details>

<hr />


<!-- ------------------------------------------------------------ -->

<h5>Bash (Shellscript) Module Sync to [ <a href="https://github.com/mcavallo-git/cloud-infrastructure/tree/master/">mcavallo-git/cloud-infrastructure</a> ] GitHub Repo</h5>
<details><summary><i>Show/Hide Content</i></summary>
	<p>
		<ol>
			<li>Prereq: Debian- or Fedora-based Linux environment (Ubuntu, Raspbian, CentOS, RHEL, etc.)</li>
			<li>Prereq: SSH Terminal w/ Elevated Privileges, e.g. running as "root" user (or as any sudoer)</li>
			<li>
				<div>Action (if above pre-reqs are met): Run the following command to sync Bash modules: </div>
				<pre><code>curl -ssL https://mcavallo.com/sh | bash -s -- --all;</code></pre>
			</li>
			<li>
				<div>Once initial sync completes, you may trigger a manual re-sync via command: </div>
				<pre><code>sync_cloud_infrastructure;</code></pre>
			</li>
		</ol>
	</p>
</details>

<hr />


<!-- ------------------------------------------------------------ -->

<h5>PowerShell Module Sync to [ <a href="https://github.com/mcavallo-git/Coding/tree/master/powershell/_WindowsPowerShell/Modules">mcavallo-git/Coding</a> ] GitHub Repo</h5>
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
				<pre><code>Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/sync.ps1?t=$((Date).Ticks)")); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;</code></pre>
			</li>
			<li>
				<div>Fallback Method:</div>
				<pre><code>Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; $SyncTemp="${Env:TEMP}\sync.$($(Date).Ticks).ps1"; New-Item -Force -ItemType "File" -Path ("${SyncTemp}") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/sync.ps1?t=$((Date).Ticks)"))) | Out-Null; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; . "${SyncTemp}"; Remove-Item "${SyncTemp}";</code></pre>
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
<tr><th colspan="2"><h5 id="essentials"><br />Essentials<br /><br /></h5></th></tr>
<tr><td><strong>AutoHotkey (AHK)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source scripting language for Microsoft Windows</i></sub></td><td><a href="https://www.autohotkey.com/download/ahk-install.exe">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.autohotkey.com/download/2.0/">Download (AHK-v2)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://raw.githubusercontent.com/mcavallo-git/Coding/master/ahk/_WindowsHotkeys.ahkv2">_WindowsHotkeys.ahkv2, by Cavalol</a></sub></td></tr>
<tr><td><strong>Classic Shell</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Provides a Windows-7-style start-menu</i></sub></td><td><a href="https://www.fosshub.com/Classic-Shell.html">Download (mirror)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://raw.githubusercontent.com/mcavallo-git/Coding/master/windows/Classic%20Shell/Menu%20Settings%20(Classic%20Shell).xml">Menu Settings (import)</a></sub></td></tr>
<tr><td><strong>Google Chrome</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Cross Platform web browser developed by Google<br />&nbsp;&nbsp;&nbsp;View <a href="https://support.google.com/chrome/answer/157179?co=GENIE.Platform%3DDesktop&hl=en">Chrome keyboard shortcuts</a><br />&nbsp;&nbsp;&nbsp;View <a href="https://peter.sh/experiments/chromium-command-line-switches/">Chromium Command Line Switches</a><br />&nbsp;&nbsp;&nbsp;</i>
	<details><summary><i>Google Account & Google Chrome settings to apply</i></summary>
		<ul>
			<li><h4>Browse to <code>chrome://flags/#read-later</code> & disable option "Reading List"</h4></li>
			<li><h4>Browse to <code>chrome://settings/content/camera</code> & disable top toggle (should say "Blocked" below "Camera")</h4></li>
			<li><h4>Browse to <code>chrome://settings/content/location</code> & disable top toggle (should say "Blocked" below "Location")</h4></li>
			<li><h4>Browse to <code>chrome://settings/content/notifications</code> & disable option "Sites can ask to send notifications"</h4></li>
			<li><h4>Browse to <code>chrome://settings/syncSetup</code> & disable option "Make searches and browsing better"</h4></li>
			<li><h4>Browse to <code>https://myaccount.google.com/permissions</code> & disable option "Google Account sign-in prompts"</h4></li>
		</ul>
	</details></sub></td><td><a href="https://www.google.com/chrome/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.google.com/chrome/?standalone=1">Download (standalone/offline installer)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://chrome.google.com/webstore/detail/material-dark-theme-dark/ddihdomdfpicmiobogkoaideoklkhbah?hl=en">Download (Dark Theme)</a></sub></td></tr>
<tr><td><strong>Mozilla Firefox</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open source web browser dev. by the Mozilla Foundation</i></sub></td><td><a href="https://www.mozilla.org/en-US/firefox/download/thanks/">Download (source)</a></td></tr>
<tr><td><strong>LastPass</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Password Manager</i></sub></td><td><a href="https://lastpass.com/download">Download (source)</a></td></tr>
<tr><td><strong>Mailbird</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Desktop Email client for Windows 7/8/10</i></sub></td><td><a href="https://www.getmailbird.com">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.getmailbird.com/downloading/">Download (direct)</a></sub></td></tr>
<tr><td><strong>MFA/2FA - OTP Auth (iOS)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MFA/2FA code storage/backup utility w/ widget</i></sub></td><td><a href="https://apps.apple.com/us/app/otp-auth/id659877384">Download (source)</a></td></tr>
<tr><td><strong>MFA/2FA - TOTP Authenticator (Android)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MFA/2FA code storage/backup utility w/ widget</i></sub></td><td><a href="https://play.google.com/store/apps/details?id=com.authenticator.authservice2&hl=en_US&gl=US">Download (source)</a></td></tr>
<tr><td><strong>Microsoft GPO ADMX/ADML Templates</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;ADMX/ADML files - Group Policy Administrative Template<br />&nbsp;&nbsp;&nbsp;OPAX/OPAL files - Office Customization Tool (OCT)<br />&nbsp;&nbsp;&nbsp;<a href="https://support.microsoft.com/en-us/help/3087759/how-to-create-and-manage-the-central-store-for-group-policy-administra">View Docs (AD Central Store)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=25250">View Docs (Exhaustive GPO Reference)</a></i></sub></td><td><a href="https://support.microsoft.com/en-us/help/3087759/how-to-create-and-manage-the-central-store-for-group-policy-administra">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=49030">Download (direct)</a></sub></td></tr>
<tr><td><strong>Microsoft Office 365</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Microsoft Excel, Outlook, PowerPoint, Word, etc.</i></sub></td><td><a href="https://www.office.com/">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><i>Login &rarr; Select "Install Office"</i><br />&nbsp;&nbsp;&nbsp;<a href="https://c2rsetup.officeapps.live.com/c2r/download.aspx?productReleaseID=O365ProPlusRetail&platform=Def&language=en-us">Download (direct)</a></sub></td></tr>
<tr><td><strong>Microsoft To Do</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Lists, Tasks & Reminders<br />&nbsp;&nbsp;&nbsp;(successor to Wunderlist)</i></sub></td><td><a href="https://www.microsoft.com/en-us/p/microsoft-to-do-lists-tasks-reminders/9nblggh5r558">Download (source)</a></td></tr>
<tr><td><strong>MobaXterm</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;XServer for Windows</i></sub></td><td><a href="https://mobaxterm.mobatek.net/download-home-edition.html">Download (source)</a></td></tr>
<tr><td><strong>RoboForm</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Multi-platform secure password manager</i></sub></td><td><a href="https://www.roboform.com/download">Download (source)</a></td></tr>
<tr><td><strong>Webull</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Commission-Free Stock Trading Application/Service</i></sub></td><td><a href="https://www.webull.com/">View (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="benchmarking-results"><br />Benchmarking Reference/Results<br /><br /></h5></th></tr>
<tr><td><strong>3DMark Results (CPU/GPU)</sub></strong> <sub><br />&nbsp;&nbsp;&nbsp;Based on results from various 3DMark software<br/>&nbsp;&nbsp;&nbsp;Quickly compare processors and/or video cards<br/>&nbsp;&nbsp;&nbsp;</i></sub></td><td>View Results:<sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.3dmark.com/search#/?mode=basic">3DMark Search - Basic</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.3dmark.com/search#/?mode=advanced">3DMark Search - Advanced</a></sub></td></tr>
<tr><td><strong>Passmark Results (CPU)</strong> <sub><br />&nbsp;&nbsp;&nbsp;Based on results from Passmark's <a href="https://www.passmark.com/products/performancetest/">PerformanceTest</a> software<br />&nbsp;&nbsp;&nbsp;CPU (Processor) benchmark results<br />&nbsp;&nbsp;&nbsp;Quickly compare different processors</sub></td><td>View Results:<sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.cpubenchmark.net/high_end_cpus.html">cpubenchmark.net - Best Performance</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.cpubenchmark.net/cpu_value_available.html">cpubenchmark.net - Best Value</a></sub></td></tr>
<tr><td><strong>Passmark Results (GPU)</strong> <sub><br />&nbsp;&nbsp;&nbsp;Based on results from Passmark's <a href="https://www.passmark.com/products/performancetest/">PerformanceTest</a> software<br />&nbsp;&nbsp;&nbsp;Video Card (Graphics Card / GPU) benchmark results<br />&nbsp;&nbsp;&nbsp;Quickly compare different video cards</sub></td><td>View Results:<sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.videocardbenchmark.net/high_end_gpus.html">videocardbenchmark.net - Best Performance</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.videocardbenchmark.net/gpu_value.html">videocardbenchmark.net - Best Value</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="benchmarking-tools"><br />Benchmarking Software<br /><br /></h5></th></tr>
<tr><td><strong>3DMark Fire Strike</strong> <sub><br />&nbsp;&nbsp;&nbsp;GPU Benchmark<i><br />&nbsp;&nbsp;&nbsp;DirectX 11 Benchmark (Graphics Cards, GPU)</i></sub></td><td><a href="https://store.steampowered.com/app/402290/3DMark_Fire_Strike_benchmarks/">Download (source)</a></sub></td></tr>
<tr><td><strong>3DMark Time Spy</strong> <sub><br />&nbsp;&nbsp;&nbsp;GPU Benchmark<i><br />&nbsp;&nbsp;&nbsp;DirectX 12 Benchmark (Graphics Cards, GPU)</i></sub></td><td><a href="https://store.steampowered.com/app/496100/3DMark_Time_Spy_benchmark/">Download (source)</a></sub></td></tr>
<tr><td><strong>CineBench R20</strong> <sub>by Maxon<br />&nbsp;&nbsp;&nbsp;CPU Benchmark<i><br />&nbsp;&nbsp;&nbsp;Real-World Cross Platform Test Suite</i></sub></td><td><a href="https://www.maxon.net/en-us/support/downloads/#collapse-64981">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="http://http.maxon.net/pub/cinebench/CinebenchR20.zip">Download (direct)</a></sub></td></tr>
<tr><td><strong>Corona Benchmark</strong> <sub><br />&nbsp;&nbsp;&nbsp;CPU Benchmark<i> ( Rendering )</i></sub></td><td><a href="https://corona-renderer.com/benchmark">Download (source)</a></td></tr>
<tr><td><strong>CrystalDiskMark</strong> <sub><br />&nbsp;&nbsp;&nbsp;Disk Benchmark<br />&nbsp;&nbsp;&nbsp;(HDD, SSD, Thumb-Drive, SD-Card, etc.)<i><br />&nbsp;&nbsp;&nbsp;Open Source IOPS benchmarking tool (HDD/SSD throughput)</i></sub></td><td><a href="https://crystalmark.info/redirect.php?product=CrystalDiskMarkInstaller">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://crystalmark.info/redirect.php?product=CrystalDiskMark">Download (portable)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/p/crystaldiskmark/9nblggh4z6f2?rtc=1&activetab=pivot:overviewtab">Download (win10 app)</a></sub></td></tr>
<tr><td><strong>Free Stopwatch</strong> <sub><br />&nbsp;&nbsp;&nbsp;Time Benchmark<i><br />&nbsp;&nbsp;&nbsp;Free digital stopwatch for Windows</i></sub></td><td><a href="https://free-stopwatch.com/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://free-stopwatch.com/FreeStopwatchSetup.exe">Download (direct, installer)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://free-stopwatch.com/FreeStopwatchPortable.zip">Download (direct, portable)</a></sub></td></tr>
<tr><td><strong>Guru3D.com</strong> <sub><br />&nbsp;&nbsp;&nbsp;Assorted Benchmarks<br /></sub></td><td><a href="https://www.guru3d.com/files-categories/benchmarks-demos.html">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.guru3d.com/files-get/pcmark-10-download,3.html">Download (PCMark 10)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.guru3d.com/files-get/3dmark-download,4.html">Download (3DMark Time Spy)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.guru3d.com/files-get/futuremark-vrmark-download,2.html">Download (Futuremark VRMark)</a></sub></td></tr>
<tr><td><strong>Namebench</strong> <sub><br />&nbsp;&nbsp;&nbsp;Domain Name System (DNS) Benchmark<i><br />&nbsp;&nbsp;&nbsp;Open Source DNS benchmarking utility by Google, Inc</i></sub></td><td><a href="https://code.google.com/archive/p/namebench/downloads">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://namebench.en.softonic.com/">Download (mirror)</a></sub></td></tr>
<tr><td><strong>Passmark PerformanceTest</strong> <sub><br />&nbsp;&nbsp;&nbsp;CPU, RAM, Disk, 2D, 3D Benchmarks<i><br />&nbsp;&nbsp;&nbsp;Easy PC Benchmarking & Confiruation Comparisons</i></sub></td><td><a href="https://www.passmark.com/products/performancetest/download.php">Download (source)</a></td></tr>
<tr><td><strong>Prime95</strong> <sub><br />&nbsp;&nbsp;&nbsp;CPU stress/torture test through Mersene prime calculations<br />&nbsp;&nbsp;&nbsp;Simulates a 100% load on all CPU threads</i></sub></td><td><a href="https://www.guru3d.com/files-details/prime95-download.html">Download (source)</a></td></tr>
<tr><td><strong>SiSoftware Sandra Lite</strong> <sub><br />&nbsp;&nbsp;&nbsp;CPU, GPU, Mobo, RAM, Disk, & More (Benchmarks)<i><br />&nbsp;&nbsp;&nbsp;Computer analysis, diagnosis & benchmarking</i></sub></td><td><a href="https://www.sisoftware.co.uk/download-lite/">Download (source)</a></td></tr>
<tr><td><strong>Unigine Benchmarks</strong> <sub><br />&nbsp;&nbsp;&nbsp;GPU Benchmark(s)<i><br />&nbsp;&nbsp;&nbsp;Heaven Benchmark (Free)</i></sub></td><td><a href="https://benchmark.unigine.com/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;Download (direct):<br />&nbsp;&nbsp;&nbsp;<a href="https://benchmark.unigine.com/heaven"> Heaven </a> | <a href="https://benchmark.unigine.com/superposition"> Superposition </a> | <a href="https://benchmark.unigine.com/valley"> Valley </a></sub></td></tr>
<tr><td><strong>V-Ray Benchmark</strong> <sub><br />&nbsp;&nbsp;&nbsp;GPU Benchmark<i><br />&nbsp;&nbsp;&nbsp;Free V-Ray Rendering Benchmark Utility</i></sub></td><td><a href="https://docs.chaosgroup.com/display/VRAYBENCH">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.techspot.com/downloads/downloadnow/7174/?evp=4390b8ba8b6bcd18f1fd0962b7c35486&file=1">Download (direct)</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="calculations"><br />Calculations<br /><br /></h5></th></tr>
<tr><td><strong>GCF Calculator</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Greatest Common Factor Calculator<br />&nbsp;&nbsp;&nbsp;Determine the greatest/largest integer factor present between a set of numbers</i></sub></td><td><a href="https://www.omnicalculator.com/math/gcf">View (source)</a></td></tr>
<tr><td><strong>LCM Calculator</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Least Common Multiple Calculator<br />&nbsp;&nbsp;&nbsp;Determine the least/lowest common multiple between a set of numbers</i></sub></td><td><a href="https://www.omnicalculator.com/math/lcm">View (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="communication"><br />Communication<br /><br /></h5></th></tr>
<tr><td><strong>Discord</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;VoIP & Digital Distribution</i></sub></td><td><a href="https://discordapp.com/download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86">Download (direct)</a></sub></td></tr>
<tr><td><strong>Microsoft Teams</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Chat & App/File-Sharing</i></sub></td><td><a href="https://products.office.com/en-us/microsoft-teams/download-app">Download (source)</a></td></tr>
<tr><td><strong>Skype</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Free Video & Voice Calls</i></sub></td><td><a href="https://www.skype.com/en/get-skype/">Download (source)</a></td></tr>
<tr><td><strong>Skype for Business</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;<a href="https://support.microsoft.com/en-us/help/4511540/retirement-of-skype-for-business-online">Service(s) retired after July 31, 2021</a></i></sub></td><td><a href="https://products.office.com/en-us/skype-for-business/download-app">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="cross-platform"><br />Cross Platform<br /><br /></h5></th></tr>
<tr><td><strong>AWS CLI</strong> <sub><br /><i>&nbsp;&nbsp;&nbsp;Amazon Web Services CLI<br />&nbsp;&nbsp;&nbsp;Manage & Administer Cloud Services via CLI</i></sub></td><td><a href="https://aws.amazon.com/powershell">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.powershellgallery.com/packages/AWSPowerShell">Download (PS-gallery)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.aws.amazon.com/powershell/latest/reference/Index.html">View Documentation</a></sub></td></tr>
<tr><td><strong>AzCopy</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;CLI Utility for copying blobs/files<br />&nbsp;&nbsp;&nbsp;to/from/between Azure Storage Accounts<br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-blobs#copy-blobs-between-storage-accounts">View Docs (AzCopy - pt. 1)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-configure#optimize-throughput">View Docs (AzCopy - pt. 2)</a></i></sub></td><td><a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10">Download (source)</a></td></tr>
<tr><td><strong>Azure CLI (Az CLI)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Manage Azure Services via CLI (PowerShell/Bash)</i></sub></td><td><a href="https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<details><summary><i>Download (one-liner, PowerShell)</i></summary><p><ul><li><pre><code>Set-Location "${Home}\Downloads"; Invoke-WebRequest -Uri "https://aka.ms/installazurecliwindows" -OutFile ".\AzureCLI.msi"; Start-Process "msiexec.exe" -ArgumentList '/I AzureCLI.msi /quiet' -Wait;</code></pre></li></ul></p></details><details><summary><i>Download (one-liner, Ubuntu/Debian)</i></summary><p><ul><li><pre><code>curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash; az config set extension.use_dynamic_install=yes_without_prompt;</code></pre></li></ul></p></details></sub></td></tr>
<tr><td><strong>Azure PowerShell Module</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;<strong>Requires: Az CLI</strong><br />&nbsp;&nbsp;&nbsp;Manage Azure Services via PowerShell cmdlets</i></sub></td><td><a href="https://docs.microsoft.com/en-us/powershell/azure/install-Az-ps">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<details><summary><i>Download (one-liner, PowerShell)</i></summary><p><ol><li><pre><code>Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force;</code></pre></li></ol></p></details></sub></td></tr>
<tr><td><strong>Azure SDK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Languages, Frameworks, Management Tools & Extensions</i></sub></td><td><a href="https://docs.microsoft.com/en-us/azure/#pivot=sdkstools&panel=sdkstools-all">View (Azure SDKs/Tools)</a></sub></td></tr>
<tr><td><strong>Azure Storage Explorer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Management App for Azure Storage Accounts</i></sub></td><td><a href="https://go.microsoft.com/fwlink/?LinkId=708343">Download (direct)</a></sub></td></tr>
<tr><td><strong>Docker</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Leverages Linux LXC Containers</i></sub></td><td><a href="https://get.docker.com">View (source)</a></td></tr>
<tr><td><strong>Java Standard Edition (SE8)</strong> <sub><br /><i>&nbsp;&nbsp;&nbsp;JRE, JDK (Desktop/Server)<br />&nbsp;&nbsp;&nbsp;Server JRE (Server-Only)</i></sub></td><td><a href="https://java.com/en/download/win10.jsp">Download (source)</a></td></tr>
<tr><td><strong>Lua</strong> <sub><br /><i>&nbsp;&nbsp;&nbsp;High-level programming language</i></sub></td><td><a href="https://www.lua.org/download.html">Download (source)</a></td></tr>
<tr><td><strong>Microsoft .NET Framework</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Software framework developed by Microsoft</i></sub></td><td><a href="https://dotnet.microsoft.com/download/dotnet-framework">Download (source)</a><sub><i><br />&nbsp;&nbsp;&nbsp;<a href="https://dotnet.microsoft.com/download/dotnet-framework/net40">Download (Version 4.0-4.8)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/confirmation.aspx?id=21">Download (Version 3.5)<br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/confirmation.aspx?id=3005">Download (Version 3.0)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/confirmation.aspx?id=6523">Download (Version 2.0)</a></i></sub></td></tr>
<tr><td><strong>.NET Core SDK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;+ dotnet core, dotnet core sdk, asp.net core runtime<br />&nbsp;&nbsp;&nbsp;Cross Platform successor to .NET Framework<br />&nbsp;&nbsp;&nbsp;View <a href="https://docs.microsoft.com/en-us/dotnet/core/sdk">.NET Core SDK overview</a></i></sub></td><td><a href="https://dotnet.microsoft.com/download">Download (Windows)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-centos7">Download (Linux)</a></sub></td></tr>
<tr><td><strong>.NET SDKs</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;for Visual Studio<br />&nbsp;&nbsp;&nbsp;.NET Core & .NET Framework SDKs</i></sub></td><td><a href="https://dotnet.microsoft.com/download/visual-studio-sdks">Download (source)</a></td></tr>
<tr><td><strong>Perl</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Dynamic, High-Level, General-Purpose Programming Language</i></sub></td><td><a href="https://www.perl.org/get.html">Download (source)</a></td></tr>
<tr><td><strong>PowerShell Core</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Standard Edition</i></sub></td><td><a href="https://github.com/PowerShell/PowerShell#get-powershell">Download (GitHub)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux">Download (Microsoft)</a></sub></td></tr>
<tr><td><strong>Python</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Dynamic, High-Level, General-Purpose Programming Language</i></sub></td><td><a href="https://www.python.org/downloads/">Download (source)</a></td></tr>
<tr><td><strong>qBittorrent</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Cross Platform, Open Source BitTorrent client</i></sub></td><td><a href="https://www.qbittorrent.org/">Download (source)</a></td></tr>
<tr><td><strong>VMware ESXi-Customizer-PS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Builds ESXi ISOs using VMware PowerCLI</i></sub></td><td><a href="https://www.v-front.de/p/esxi-customizer-ps.html#download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="http://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1">Download (v2.6.0)</a></sub></td></tr>
<tr><td><strong>VMware PowerCLI / vSphere CLI</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;vSphere Hypervisor (ESXi) PowerShell Tools<br />&nbsp;&nbsp;&nbsp;<a href="https://code.vmware.com/web/tool/11.5.0/vmware-powercli">View Documentation (source)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://powercli-core.readthedocs.io/">View Documentation (core)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.vmware.com/support/developer/PowerCLI/">View Documentation (developer)</a></i></sub></td><td><a href="https://www.powershellgallery.com/packages/VMware.PowerCLI/11.5.0.14912921">Download (VMware PowerCLI)</a><sub><br />&nbsp;&nbsp;&nbsp;<details><summary><i>Download (one-liner, PowerShell)</i></summary><p><ol><li><pre><code>Install-Module -Name VMware.PowerCLI -AllowClobber -Scope CurrentUser -Force;</code></pre></li></ol></p></details><br />&nbsp;&nbsp;&nbsp;<a href="https://my.vmware.com/group/vmware/get-download?downloadGroup=VS-CLI-670">Download (vSphere CLI)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://code.vmware.com/tools">Download (other tools)</a></sub></td></tr>
<tr><td><strong>Windows Terminal</strong> <i><sub><br />&nbsp;&nbsp;&nbsp;Terminal Emulator for Windows 10</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9N0DX20HK701">Download (source)</a></td></tr>
<tr><td><strong>WiX</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Installer XML Toolset<br />&nbsp;&nbsp;&nbsp;Builds Windows Installer packages from XML</i></sub></td><td><a href="https://wixtoolset.org/releases/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://github.com/wixtoolset/wix3/releases">Download (GitHub)</a></sub></td></tr>
<tr><td><strong>WSL - All Distros</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Subsystem for Linux</i></sub></td><td><a href="https://aka.ms/wslstore">Download (source)</a></td></tr>
<tr><td><strong>WSL - Ubuntu</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Subsystem for Linux</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9N9TNGVNDL3Q">Download (18.04 LTS)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/store/productId/9PJN388HP8C9">Download (16.04 LTS)</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="development"><br />Software Development<br /><br /></h5></th></tr>
<tr><td><strong>Chocolatey</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Package Manager for Windows</i></sub></td><td><a href="https://chocolatey.org/docs/installation#install-with-cmdexe">Download (source)</a></td></tr>
<tr><td><strong>Docker Desktop (for Windows)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Containers</i></sub></td><td><a href="https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe">Download (source)</a></td></tr>
<tr><td><strong>Git for Windows</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Git Bash & Git SCM CLI Integrations</i></sub></td><td><a href="https://git-scm.com/download/win">Download (direct)</a></td></tr>
<tr><td><strong>GitHub Desktop</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Git Daily Driver</i></sub></td><td><a href="https://desktop.github.com">Download (source)</a></td></tr>
<tr><td><strong>Gpg4win</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;GnuPG for Windows<br />&nbsp;&nbsp;&nbsp;Contains component installs for [ Kleopatra, GpgOL, & GpgEX ]</i></sub></td><td><a href="https://www.gpg4win.org/thanks-for-download.html">Download (source)</a></td></tr>
<tr><td><strong>JQ</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Linux JSON Parser</i></sub></td><td><a href="https://github.com/stedolan/jq/releases">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Visual Studio Code</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;e.g. "VS Code", "VS-Code", "VSCode"<sub><i><br />&nbsp;&nbsp;&nbsp;Free Source Code Editor (IDE)<br />&nbsp;&nbsp;&nbsp;<a href="https://code.visualstudio.com/docs/getstarted/settings#_default-settings">View Docs: User and Workspace Settings</a></i></sub></td><td><a href="https://code.visualstudio.com/download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://code.visualstudio.com/docs/?dv=win64">Download (direct)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync">Add Extension: Settings Sync</a><br />&nbsp;&nbsp;&nbsp;<a href="https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master/.vscode/vscode.settings">Set User Settings</a><br />&nbsp;&nbsp;&nbsp;<a href="https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master/.vscode/github.code-workspace">Set Workspace Settings</a></sub></td></tr>
<tr><td><strong>Microsoft Visual Studio</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;IDE used heavily or Windows .NET & ASP.NET app creation<br />&nbsp;&nbsp;&nbsp;Only the "Community Edition" ( CE ) is free - sign up<br />&nbsp;&nbsp;&nbsp;for Microsoft's free <strong><a href="https://aka.ms/devessentials">Visual Studio Dev Essentials</a></strong> program</i></td><td><a href="https://visualstudio.microsoft.com/vs/community/">Download (source, CE)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://visualstudio.microsoft.com/downloads/">Download (source, 2019/latest)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://visualstudio.microsoft.com/vs/older-downloads/">Download (source, 2017 & older)</a></sub></td></tr>
<tr><td><strong>Microsoft Visual Studio 20xx VC++ Redistributables</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Runtime components of Visual C++ Libraries<br />&nbsp;&nbsp;&nbsp;Scroll down to "Redistributables and Build Tools"</i></td><td><a href="https://visualstudio.microsoft.com/vs/older-downloads/">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Visual Studio Team Services CLI (Preview)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Run VSTS commands from local environment</td><td><a href="https://aka.ms/vsts-cli-windows-installer">Download (direct)</a></td></tr>
<tr><td><strong>My Visual Studio</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Homepage for Visual Studio downloads</td><td><a href="https://my.visualstudio.com/Downloads/Featured">Download (source)</a></td></tr>
<tr><td><strong>Node.JS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source, Cross Platform, JavaScript runtime environment</i></sub></td><td><a href="https://nodejs.org/en/download/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://nodejs.org/dist/">Download (older versions)</a></sub></td></tr>
<tr><td><strong>Notepad++</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Text and Source-Code Editor</i></sub></td><td><a href="https://notepad-plus-plus.org/downloads/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://raw.githubusercontent.com/mcavallo-git/Coding/master/windows/Notepad%2B%2B/NP%2B%2B.zip">Download (Dark Theme)</a></sub></td></tr>
<tr><td><strong>Notepad Replacer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Redirects notepad.exe calls to use an alternative text editor, instead<br />&nbsp;&nbsp;&nbsp;Text Editor Path:  <b>C:\Program Files\Microsoft VS Code\Code.exe</b></i></sub></td><td><a href="https://www.binaryfortress.com/NotepadReplacer/Download/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.binaryfortress.com/Data/Download/?package=notepadreplacer&log=100">Download (direct)</a></sub></td></tr>
<tr><td><strong>NuGet</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source Package Manager designed for the<br />&nbsp;&nbsp;&nbsp;Microsoft development platform</i></sub></td><td><a href="https://dist.nuget.org/win-x86-commandline/latest/nuget.exe">Download (source)</a></td></tr>
<tr><td><strong>PoshGui</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source tools & cmdlets for SysAdmins</i></sub></td><td><a href="https://poshgui.com/">Download (source)</a></td></tr>
<tr><td><strong>Tortoise Git</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Git Merge Conflict Resolver</i></sub></td><td><a href="https://tortoisegit.org/download">Download (source)</a></td></tr>
<tr><td><strong>Windows ADK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Assessment and Deployment Kit<br />&nbsp;&nbsp;&nbsp;Includes Deployment Tools (Windows image/.iso tools):<br />&nbsp;&nbsp;&nbsp;<sub>&nbsp;&nbsp;&nbsp;DISM, DISM API, & OSCDIMG</sub></i></sub></td><td><a href="https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install?WT.mc_id=thomasmaurer-blog-thmaure#other-adk-downloads">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://go.microsoft.com/fwlink/?linkid=2086042">Download (direct)</a></sub></td></tr>
<tr><td><strong>Windows 10 SDK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Provides the following (for building Windows 10 Apps):<br />&nbsp;&nbsp;&nbsp;Headers, libraries, & tools for Win10 apps</sub></i></sub></td><td><a href="https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://go.microsoft.com/fwlink/p/?linkid=2083338&clcid=0x409">Download (direct)</a></sub></td></tr>
<tr><td><strong>Windows WDK</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;<strong>Requires Windows 10 SDK</strong><br />&nbsp;&nbsp;&nbsp;<strong></strong>Microsoft Windows Driver Kit (WDK)<br />&nbsp;&nbsp;&nbsp;Includes Code-Signing Tools/Drivers:<br />&nbsp;&nbsp;&nbsp;<sub>&nbsp;&nbsp;&nbsp;CertMgr, Inf2Cat, MakeCat, MakeCert, Pvk2Pfx, & SignTool</sub></i></sub></td><td><a href="https://docs.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://go.microsoft.com/fwlink/?linkid=2085767">Download (direct)</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="remote-access"><br />Remote Control, Desktop Sharing<br /><br /></h5></th></tr>
<tr><td><strong>IPMIView</strong> <sub>by Supermicro</sub><sub><i><br />&nbsp;&nbsp;&nbsp;Windows-Based IPMI Tool</sub></td><td><a href="https://www.supermicro.com/en/solutions/management-software/ipmi-utilities#resources">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.supermicro.com/SwDownload/SwSelect_Free.aspx?cat=IPMI">Download (direct)</a></sub></td></tr>
<tr><td><strong>LogMeIn Rescue</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;e.g. "LogMeIn Rescue Technician Console"<br />&nbsp;&nbsp;&nbsp;Screen-sharing & Remote-support application</i></sub></td><td><a href="https://help.logmein.com/articles/en_US/Downloads/Technician-Console-Desktop-App">Download (source)</a></td></tr>
<tr><td><strong>Parsec</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Desktop capturing/streaming application<br />&nbsp;&nbsp;&nbsp;Designed for cloud-based gaming through video streaming<br />&nbsp;&nbsp;&nbsp;Troubleshooting - <sub><a href="https://support.parsecgaming.com/hc/en-us/articles/115003937292">Hosting Parsec On A Laptop With Both Nvidia and Intel GPUs</a></sub></i></sub></td><td><a href="https://parsecgaming.com/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Remote Mouse</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote MnK (Mouse & Keyboard) control via Phone</i></sub></td><td><a href="https://www.remotemouse.net/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.remotemouse.net/downloads/RemoteMouse.exe">Download (direct)</a></sub></td></tr>
<tr><td><strong>Royal TS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Cross Platform Remote Management Solution<br />&nbsp;&nbsp;&nbsp;Manages <code>Hyper-V</code>, <code>RDP</code>, <code>SSH</code>, <code>SFTP</code>, <code>Teamviewer</code>, <code>VMware</code> & more<br />&nbsp;&nbsp;&nbsp;<a href="https://content.royalapplications.com/Help/RoyalTS/V3/index.html?ui_keyboardshortcuts.htm">View Docs (Royal TS - Keyboard Shortcuts)</a></i></sub></td><td><a href="https://www.royalapps.com/ts/win/download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://support.royalapps.com/support/solutions/articles/17000075714-royal-ts-v5-previous-versions">Download (previous versions)</a></sub></td></tr>
<tr><td><strong>RSAT <sub>for Windows 10</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote Server Administration Tools for Windows 10<br />&nbsp;&nbsp;&nbsp;Management Tools for Active Directory (AD) Roles & Services</i></sub></td><td><a href="https://www.microsoft.com/en-us/download/details.aspx?id=45520">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<details><summary><i>Download (one-liner, PowerShell)</i></summary><p><ol><li><pre><code>PowerShell -Command "Start-Process -Filepath ('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe') -ArgumentList ('-Command Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online;') -Verb 'RunAs' -Wait -PassThru | Out-Null;"</code></pre></li></ol></p></details></sub></td></tr>
<tr><td><strong>Splashtop Personal</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote Access Client</i></sub></td><td><a href="https://www.splashtop.com/downloadstart?product=stp&platform=windows-client">Download (source)</a></td></tr>
<tr><td><strong>Splashtop Streamer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote Access Host/Server</i></sub></td><td><a href="https://www.splashtop.com/downloadstart?platform=windows">Download (source)</a></td></tr>
<tr><td><strong>TeamViewer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Remote Access Host/Server</i></sub></td><td><a href="https://www.teamviewer.com/en/download/windows/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.teamviewer.com/en/download/previous-versions/">Download (previous versions)</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="dns"><br />DNS CAbundles/CA bundles<sub><br />Domain Name System <a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle">Certificate Authority Bundles</a><br />SSL/TLS (HTTPS) Intermediate/Root Certificates</sub><br /><br /></h5></th></tr>
<tr><td><strong>COMODO</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;DNS Authority & CABUNDLEs</i></sub></td><td><a href="https://support.comodo.com/index.php?/comodo/Knowledgebase/List/Index/75/instantsslenterprisesslintranetssl">Download (source)</a></td></tr>
<tr><td><strong>GoDaddy</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;DNS Authority & CABUNDLEs</i></sub></td><td><a href="https://ssl-ccp.godaddy.com/repository?origin=CALLISTO">Download (source)</a></td></tr>
<tr><td><strong>IdenTrust</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Timestamping Authority (Code-Signing)</i></sub></td><td><a href="https://www.identrust.com/timestamping-authority-server">Download (source)</a></td></tr>
<tr><td><strong>OpenTimestamps</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Timestamping Authority (Code-Signing)</i></sub></td><td><a href="https://opentimestamps.org/?digest=3bc98a0c89639e3e0b717701877a849bb8b38147402dfb19643cb3bd39894535#stamp-and-verify">Download (source)</a></td></tr>
<tr><td><strong>Namecheap</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;DNS Authority & CABUNDLEs</i></sub></td><td><a href="https://www.namecheap.com/support/knowledgebase/article.aspx/9393/69/where-do-i-find-ssl-ca-bundle">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle" title="A 'CA bundle' is a file that contains root and intermediate certificates. The end-entity certificate along with a CA bundle constitutes the certificate chain.">What is a CA bundle?</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="file-storage"><br />File-Storage<br /><br /></h5></th></tr>
<tr><td><strong>7-Zip</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source file archiver<br />&nbsp;&nbsp;&nbsp;Leverages the LZMA 2 compression algorithm<br />&nbsp;&nbsp;&nbsp;Tools > Options > 7-Zip > Uncheck "CRC SHA" & "Compress ..."</i></sub></td><td><a href="https://www.7-zip.org/download.html">Download (source)</a></td></tr>
<tr><td><strong>Box</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Desktop App(s)</i></sub></td><td><a href="https://www.box.com/resources/downloads">Download (source)</a></td></tr>
<tr><td><strong>Cryptomator</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Client-Side Cloud-Encryption</i></sub></td><td><a href="https://cryptomator.org/downloads/#winDownload">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://cryptomator.org/downloads/win/thanks/">Download (direct)</a></sub></td></tr>
<tr><td><strong>Dropbox</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Desktop App(s)</i></sub></td><td><a href="https://www.dropbox.com/install">Download (source)</a></td></tr>
<tr><td><strong>Google Drive</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Backup and Sync</i></sub></td><td><a href="https://www.google.com/drive/download/">Download (source)</a></td></tr>
<tr><td><strong>iCloud</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Cloud Storage, Device Backup and Sync</i></sub></td><td><a href="https://www.microsoft.com/en-us/p/icloud/9pktq5699m62">Download (win10 app)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://support.apple.com/en-us/HT204283">Download (Desktop App)</a></sub></td></tr>
<tr><td><strong>OneDrive for Windows</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Desktop App(s)</i></sub></td><td><a href="https://onedrive.live.com/about/en-us/download/">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="hardware-utilities"><br />Hardware Utilities/Controllers<br /><br /></h5></th></tr>
<tr><td><strong>AMD Ryzen/Radeon Chipset Drivers</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Amongst other things, resolves issues with "? PCI Device" in Device Manager</i></sub></td><td><a href="https://www.amd.com/en/support">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.amd.com/en/support/chipsets/amd-socket-am4/x570">Download (source, X570)</a></sub></td></tr>
<tr><td><strong>APC PowerChute <sub>(Business Ed.)</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Business Edition - Requires APC "Smart UPS" (Server) type/model device<br />&nbsp;&nbsp;&nbsp;Provides safe system shutdown in the event of an extended power outage</i></sub></td><td><a href="https://www.apc.com/shop/us/en/categories/power/uninterruptible-power-supply-ups-/ups-management/powerchute-business-edition/N-o29ysx">Download (source)</a></td></tr>
<tr><td><strong>APC PowerChute <sub>(Personal Ed.)</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Personal Edition - Requires APC "Back UPS" (Desktop/Workstation) type/model device<br />&nbsp;&nbsp;&nbsp;Provides safe system shutdown in the event of an extended power outage</i></sub></td><td><a href="https://www.apc.com/shop/us/en/categories/power/uninterruptible-power-supply-ups-/ups-management/powerchute-personal-edition/N-1b6nbpp">Download (source)</a></td></tr>
<tr><td><strong>ASUS AI Suite 3</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;ASUS Mobo - Fan Controller</i></sub></td><td><a href="https://www.asus.com/Motherboards-Components/Motherboards/PRIME/PRIME-X570-PRO/HelpDesk_Download/">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><i>Win10 > "Software and Utility" > "Show all" > CTRL+F "Suite"</i><br />&nbsp;&nbsp;&nbsp;<a href="https://dlcdnets.asus.com/pub/ASUS/mb/14Utilities/Ai_stuite3-3.00.69_DIP5-2.00.55_System_Information-2.00.09.zip">Download (direct, V3.00.69)</a></sub></td></tr>
<tr><td><strong>ASUS AURA </strong>(Software/Service) <sub><i><br />&nbsp;&nbsp;&nbsp;ASUS Motherboard Lighting (RGB) Controller for:<br />&nbsp;&nbsp;&nbsp;• LEDs built directly onto the motherboard itself (PCH, IO, etc.)<br />&nbsp;&nbsp;&nbsp;• 3-Pin ARGB headers (on mobo)<br />&nbsp;&nbsp;&nbsp;• 4-Pin RGB header(s) (on mobo)<br />&nbsp;&nbsp;&nbsp;Aura's main executable (controller) located at:<pre><code>C:\Program Files (x86)\LightingService\LightingService.exe</code></pre></i></sub></td><td><a href="https://www.asus.com/campaign/aura/us/download.php">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://help.corsair.com/hc/en-us/articles/360035656371-Enable-Aura-Sync-control-for-your-Corsair-RGB-memory">Download (Aura Sync plugin)</a></sub></td></tr>
<tr><td><strong>BalenaEtcher</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Drive imaging utility (.iso & .img, especially)</i></sub></td><td><a href="https://www.balena.io/etcher/">Download (source)</a></td></tr>
<tr><td><strong>Corsair iCUE</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Fan-Speed & RGB Lighting controller<br />&nbsp;&nbsp;&nbsp;<a href="https://help.corsair.com/hc/en-us/articles/360025166712-Perform-a-clean-reinstallation-of-the-Corsair-Utility-Engine-iCUE-">View Documentation (iCUE clean reinstallation)</a></i></sub></td><td><a href="https://www.corsair.com/us/en/downloads">Download (source)</a></td></tr>
<tr><td><strong>DBAN <sub>(Darik's Boot and Nuke)</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Designed to securely erase a hard disks until its<br />&nbsp;&nbsp;&nbsp;data is permanently removed and no longer recoverable<br />&nbsp;&nbsp;&nbsp;Note: Incompatible with UEFI boot mode</i></sub></td><td><a href="https://dban.org/">Download (source)</a></td></tr>
<tr><td><strong>Easy2Boot</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Multi-ISO Bootable Flash Drive</i></sub></td><td><a href="https://www.fosshub.com/Easy2Boot.html">Download (source)</a></td></tr>
<tr><td><strong>EVGA Precision X1</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;GPU/GRAM Overclocking Software<br />&nbsp;&nbsp;&nbsp;Controls for Core-Clock, Voltage, Fans, & RGB</i></sub></td><td><a href="https://www.evga.com/precisionx1/">Download (source)</a></td></tr>
<tr><td><strong>ESXCLI</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;ESXi Embedded Host Client (SSH)</i></sub></td><td><a href="http://download3.vmware.com/software/vmw-tools/esxui/esxui-signed-latest.vib">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://flings.vmware.com/esxi-embedded-host-client#instructions">Installation (docs)</a></sub></td></tr>
<tr><td><strong>Hubitat Package Manager</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Provides tools to install, uninstall & upgrade 3rd party Hubitat Elevation packages</i></sub></td><td><a href="https://github.com/dcmeglio/hubitat-packagemanager">Download (source)</a></td></tr>
<tr><td><strong>Hubitat Package Repositories</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Mainstream App & Device Code repos for the Hubitat Elevation platform (user-driven)</i></sub></td><td><a href="https://github.com/dcmeglio/hubitat-packagerepositories">Download (source)</a></td></tr>
<tr><td><strong>Intel® DSA</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Intel Driver & Support Assistant</i></sub></td><td><a href="https://www.intel.com/content/www/us/en/support/detect.html">Download (source)</a></td></tr>
<tr><td><strong>ImDisk Toolkit</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;RamDisk utility for Windows<br />&nbsp;&nbsp;&nbsp;Allows mounting of image files</i></sub></td><td><a href="https://sourceforge.net/projects/imdisk-toolkit/">Download (source)</a></td></tr>
<tr><td><strong>LG OnScreen Control</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Driver/Software for LG 34UC88-B (Monitor)</i></sub></td><td><a href="https://www.lg.com/uk/search.lg?search=onscreen+control">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.lg.com/us/support/product/lg-34UC88-B.AUS">View Downloads</a></sub></td></tr>
<tr><td><strong>Logitech G Hub</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Keyboard/Mouse RGB (+3rd Party Tools)</i></sub></td><td><a href="https://support.logi.com/hc/en-us/articles/360025298133">Download (source)</a></td></tr>
<tr><td><strong>Logitech Options</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Enhanced functionality for Logitech devices</i></sub></td><td><a href="https://www.logitech.com/en-us/product/options">Download (source)</a></td></tr>
<tr><td><strong>Logitech SetPoint</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Hotkey manager for Logitech mouse/keyboard devices</i></sub></td><td><a href="http://support.logitech.com/software/setpoint">Download (source)</a></td></tr>
<tr><td><strong>Logitech Unifying Software</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Add/Remove devices to a Unifying receiver</i></sub></td><td><a href="https://support.logi.com/hc/en-001/articles/360025297913-Unifying-Software">Download (source)</a></td></tr>
<tr><td><strong>Media Feature Pack for Windows</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Required for iCloud Desktop App</i></sub></td><td><a href="https://www.microsoft.com/en-us/software-download/mediafeaturepack">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://software-download.microsoft.com/db/Windows_MediaFeaturePack_x64_1903_V1.msu?t=4ee189cc-b6e5-4270-9584-668bb77cb922&e=1578037636&h=a44afb20246abe7c34d751332e02df5d">Download (direct, v1903)</a></sub></td></tr>
<tr><td><strong>Netgear Switch Discovery Tool</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Locates Netgear Smart Switches on LAN</i></sub></td><td><a href="https://www.netgear.com/support/product/GS908E.aspx#download">Download (source)</a></td></tr>
<tr><td><strong>NVIDIA CUDA Toolkit</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Toolkit for developing NVIDIA-based applications<br />&nbsp;&nbsp;&nbsp;Includes NVIDIA System Management Interface (NVIDIA SMI)</i></sub></td><td><a href="https://developer.nvidia.com/cuda-toolkit">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://developer.nvidia.com/cuda-downloads?target_os=Windows&target_arch=x86_64&target_version=10&target_type=exelocal">Download (direct)</a></sub></td></tr>
<tr><td><strong>NVIDIA Drivers</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;You may just hit "Search" to get generic drivers</i></sub></td><td><a href="https://www.nvidia.com/Download/index.aspx">Download (source)</a></td></tr>
<tr><td><strong>PCPartPicker</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Component Pricing/Compatibility Comparisons</i></sub></td><td><a href="https://pcpartpicker.com/b/bH7TwP">Open (web-service)</a></td></tr>
<tr><td><strong>Razer Synapse</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Mouse/Keyboard Hotkey Manager<br />&nbsp;&nbsp;&nbsp;Chroma RGB Controller<br />&nbsp;&nbsp;&nbsp;Disable Auto-Install by blocking permissions to path:<br />&nbsp;&nbsp;&nbsp;<i><code>C:\Windows\Installer\Razer\Installer</code></i></sub></td><td><a href="https://www.razer.com/synapse">Download (source)</a></td></tr>
<tr><td><strong>RMPrepUSB</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Multiboot formatter for USB-drives</i></sub></td><td><a href="https://www.fosshub.com/RMPrepUSB.html">Download (source)</a></td></tr>
<tr><td><strong>Rufus</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Format/create bootable USB Drives (from .ISOs)</i></sub></td><td><a href="https://rufus.ie/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Ryzen DRAM Calculator</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Helps with overclocking memory<br />&nbsp;&nbsp;&nbsp;on the AMD Ryzen platform</i></sub></td><td><a href="https://www.techpowerup.com/download/ryzen-dram-calculator/">Download (source)</a></td></tr>
<tr><td><strong>Samsung Magician</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Optimizes Samsung's solid state drives (SSDs)<br />&nbsp;&nbsp;&nbsp;Contains "Secure Erase" tool which securely wipes SSDs</i></sub></td><td><a href="https://www.samsung.com/semiconductor/minisite/ssd/product/consumer/magician/">Download (source)</a></td></tr>
<tr><td><strong>Sonos desktop controller</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Control LAN Sonos speakers</i></sub></td><td><a href="https://www.sonos.com/redir/controller_software_pc">Download (source)</a></td></tr>
<tr><td><strong>SpeedFan</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Third Party PWM Fan Software Controller</i></sub></td><td><a href="https://www.almico.com/sfdownload.php">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://download.cnet.com/SpeedFan/3000-2094_4-10067444.html">Download (mirror)</a></sub></td></tr>
<tr><td><strong>VMware - All Downloads</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;VMware vSphere, VMware Workstation,<br />&nbsp;&nbsp;&nbsp;VMware Fusion, VMware Player, etc.</i></sub></td><td><a href="https://my.vmware.com/web/vmware/downloads">Download (source)</a></td></tr>
<tr><td><strong>Yubico Tools</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Configuration Utility/Tool for YubiKeys<br />&nbsp;&nbsp;&nbsp;Sets modes for quick-press ('Short Touch') and long-hold ('Long Touch')<br />&nbsp;&nbsp;&nbsp;Reference: <a href="https://duo.com/docs/yubikey">Configuring YubiKeys for OTP use with Duo</a><br />&nbsp;&nbsp;&nbsp;Reference: <a href="https://duo.com/docs/administration-devices#assigning-a-hardware-token-to-an-administrator">Assigning a Hardware Token to an Administrator</a></i></sub></td><td><a href="https://www.yubico.com/products/services-software/download/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.yubico.com/support/download/yubikey-manager/">Download (YubiKey Manager)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.yubico.com/support/download/yubikey-personalization-tools/">Download (YubiKey Personalization Tool)</a></sub></td></tr>
<tr><td><strong>WinSW: Windows service wrapper</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;(in less restrictive license)</i></sub></td><td><a href="https://github.com/kohsuke/winsw/">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="monitoring"><br />Monitoring & Overclocking (Hardware, Service-Status)<br /><br /></h5></th></tr>
<tr><td><strong>Core Temp</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;CPU temperature monitoring/logging</i></sub></td><td><a href="https://www.alcpu.com/CoreTemp/">Download (source)</a></td></tr>
<tr><td><strong>CPU-Z</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Freeware System Profiling and Monitoring Application<br />&nbsp;&nbsp;&nbsp;Shows CPU, Memory, Motherboard, and GPU Hardware Info</i></sub></td><td><a href="https://www.cpuid.com/softwares/cpu-z.html">Download (source)</a></td></tr>
<tr><td><strong>Custom Resolution Utility (CRU)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;EDID (Extended Display Identification Data) editor<br />&nbsp;&nbsp;&nbsp;Allows adding custom monitor resolutions, refresh rates, etc.</i></sub></td><td><a href="https://www.monitortests.com/forum/Thread-Custom-Resolution-Utility-CRU">Download (source)</a></td></tr>
<tr><td><strong>CrystalDiskInfo</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Pulls HDD S.M.A.R.T. Statistics<br />&nbsp;&nbsp;&nbsp;Checks HDD Sector Health</i></sub></td><td><a href="https://crystalmark.info/redirect.php?product=CrystalDiskInfoInstaller">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://crystalmark.info/redirect.php?product=CrystalDiskInfo">Download (portable)</a></sub></td></tr>
<tr><td><strong>Hard Disk Sentinel</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Monitors SSD Temperatures<br />&nbsp;&nbsp;&nbsp;Monitors HDD/SSD ongoing performance<br />&nbsp;&nbsp;&nbsp;Pulls HDD S.M.A.R.T. Statistics<br />&nbsp;&nbsp;&nbsp;Allows custom alerts based on user-defined thresholds</i></sub></td><td><a href="https://www.hdsentinel.com/download.php">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.harddisksentinel.com/hdsentinel_setup.zip">Download (direct)</a></sub></td></tr>
<tr><td><strong>HWiNFO</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Free System Information Tool for Windows<br />&nbsp;&nbsp;&nbsp;View CPU, GPU, Motherboard, USB, & other hardware info<br />&nbsp;&nbsp;&nbsp;Displays hardware's current operating voltages/amps/watts</i></sub></td><td><a href="https://www.hwinfo.com/download/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.fosshub.com/HWiNFO.html">Download (direct)</a></sub></td></tr>
<tr><td><strong>MSI Afterburner</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Overclocking Utility for GPUs (Graphics Processing Units)<br />&nbsp;&nbsp;&nbsp;Monitor for GPU Temperature, Load, and Memory-Usage</i</sub></td><td><a href="https://www.msi.com/page/afterburner">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="http://download.msi.com/uti_exe/vga/MSIAfterburnerSetup.zip">Download (direct)</a></sub></td></tr>
<tr><td><strong>OHW <sub>'Open Hardware Monitor'</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;System Health Monitoring Software<br />&nbsp;&nbsp;&nbsp;Monitors Temperature Sensors, Fan Speeds,<br />&nbsp;&nbsp;&nbsp;Voltages, load, and clock speeds</i></sub></td><td><a href="https://openhardwaremonitor.org/downloads/">Download (source)</a></td></tr>
<tr><td><strong>PRTG Client <sub>'PRTG Desktop'</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Paessler AG<br />&nbsp;&nbsp;&nbsp;Allows you to manage multiple PRTG servers</i></sub></td><td><a href="https://www.paessler.com/prtg-desktop-app#downloads">Download (source)</a></td></tr>
<tr><td><strong>PRTG Server <sub>'PRTG Network Monitor'</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Paessler AG<br />&nbsp;&nbsp;&nbsp;Agentless network monitoring software<br />&nbsp;&nbsp;&nbsp;Update SSL/TLS to use a cert from Windows'<br />&nbsp;&nbsp;&nbsp;local certificate store via <a href="https://www.paessler.com/tools/certificateimporter">PRTG Certificate Importer</a></i></sub></td><td><a href="https://www.paessler.com/prtg">Download (source)</a></td></tr>
<tr><td><strong>Uptime Robot</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Uptime monitoring service (primarily for HTTP/HTTPS hosts)<br />&nbsp;&nbsp;&nbsp;Free for up-to 50 monitors<br />&nbsp;&nbsp;&nbsp;Free monitors poll every 5 minutes</i></sub></td><td><a href="https://uptimerobot.com/">View (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="multimedia"><br />Multimedia<br /><br /></h5></th></tr>
<tr><td><strong>AirServer Universal</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Airplay+, Google Cast+, Miracast</i></sub></td><td><a href="https://www.airserver.com/Download/MacPC">Download (mirror)</a></td></tr>
<tr><td><strong>Audacity</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source source, Cross Platform audio editing software</a></i></sub></td><td><a href="https://www.fosshub.com/Audacity.html?download">Download (mirror)</a></td></tr>
<tr><td><strong>CopyTrans</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Transfer (import/export) data between iOS & Windows-based devices</a></i></sub></td><td><a href="https://www.copytrans.net/download/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.copytrans.net/downloadtrial/">Download (direct)</a></sub></td></tr>
<tr><td><strong>Deepfake</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Synthetic media in which a person in an existing image<br />&nbsp;&nbsp;&nbsp;or video is replaced with someone else's likeness</a></i></sub></td><td><a href="https://github.com/iperov/DeepFaceLab#releases">Download (source)</a></td></tr>
<tr><td><strong>Exiftool</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source screenshot utility<br />&nbsp;&nbsp;&nbsp;Read/write/modify file metadata</a><br />&nbsp;&nbsp;&nbsp;<a href="https://exiftool.org/install.html#Windows">View Documentation (Installing ExifTool)</a></i></sub></td><td><a href="https://exiftool.org/index.html">Download (source)</a></td></tr>
<tr><td><strong>foobar2000</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Freeware Audio Player Utility<br />&nbsp;&nbsp;&nbsp;Modular, Feature-Rich, & User-Flexibile</i></sub></td><td><a href="https://www.foobar2000.org/download">Download (source)</a></td></tr>
<tr><td><strong>FoxIt PhantomPDF</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;PDF Editor (Paid)</i></sub></td><td><a href="https://www.foxitsoftware.com/downloads/#Foxit-PhantomPDF-Standard/">Download (source)</a></td></tr>
<tr><td><strong>Greenshot</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source screenshot utility<br />&nbsp;&nbsp;&nbsp;Replaces/Upgrades Print screen & Snipping tool</a></i></sub></td><td><a href="https://getgreenshot.org/downloads/">Download (source)</a></td></tr>
<tr><td><strong>HandBrake</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Multithreaded Video Transcoder</i></sub></td><td><a href="https://handbrake.fr/">Download (source)</a></td></tr>
<tr><td><strong>HandBrakeCLI</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Video Transcoding via CLI<br />&nbsp;&nbsp;&nbsp;<a href="https://handbrake.fr/docs/en/latest/cli/command-line-reference.html">Command line reference</a></i></sub></td><td><a href="https://handbrake.fr/downloads2.php">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<details><summary><i>Download Auto-Encoder (PowerShell)</i></summary><p><ol><li><pre><code> <# TRIPLE CLICK & PASTE ME INTO POWERSHELL #> $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/windows/HandBrake/HandBrakeCLI-Encoder/HandBrakeCLI-Encoder.ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;</code></pre></li></ol></p></details></sub></td></tr></td></tr>
<tr><td><strong>HTML CSS Color</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Online color library and color tools for developers.<br />&nbsp;&nbsp;&nbsp;Quick color nickname lookups (given a hex color code)</i></sub></td><td><a href="https://www.htmlcsscolor.com/hex/4d4dff">View (source)</a></td></tr>
<tr><td><strong>IconViewer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Allows viewing, copying, and saving (as .ico files) icons contained within programs (.exe) & libraries</a></i></sub></td><td><a href="https://www.botproductions.com/iconview/iconview.html">Download (source)</a></td></tr>
<tr><td><strong>ImageMagick</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;CLI - Compress, Trim, Resize (etc.) Images</i></sub></td><td><a href="https://www.imagemagick.org/script/download.php#windows">Download (source)</a></td></tr>
<tr><td><strong>iTunes</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Apple's Media Library/Player/Radio & Device-Manager Utility</a></i></sub></td><td><a href="https://apple.co/ms">Download (source)</a></td></tr>
<tr><td><strong>OBS <sub>'Open Broadcaster Software'</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source, Cross Platform screen capture ('screencap') utility<br />&nbsp;&nbsp;&nbsp;Allows saving/recording screencaps to local disk<br />&nbsp;&nbsp;&nbsp;Allows live streaming/broadcasting to web services (such as<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Twitch, YouTube, Facebook Live, Twitter, etc.)</i></sub></td><td><a href="https://obsproject.com/download">Download (source)</a></td></tr>
<tr><td><strong>OpD2d</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Direct to disk audio recorder</i></sub></td><td><a href="http://www.opcode.co.uk/opd2d/default.asp">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://opd2d.en.softonic.com/">Download (mirror)</a></sub></td></tr>
<tr><td><strong>Paint.NET</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Free image & photo editing software<br />&nbsp;&nbsp;&nbsp;<a href="https://www.getpaint.net/doc/latest/KeyboardMouseCommands.html">View Keyboard & Mouse Commands (Hotkeys)</a></i></sub></td><td><a href="https://www.dotpdn.com/downloads/pdn.html">Download (source)</a></td></tr>
<tr><td><strong>RainMeter</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source Desktop Customization Utility</i></sub></td><td><a href="http://www.rainmeter.net/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://builds.rainmeter.net/Rainmeter-4.3.1.exe">Download (direct)</a></sub></td></tr>
<tr><td><strong>Reflector</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Airplay Server for Windows<br />&nbsp;&nbsp;&nbsp;Allows PC monitors to be airplayed to</i></sub></td><td><a href="https://www.airsquirrels.com/reflector">Download (mirror)</a></td></tr>
<tr><td><strong>Shadowplay <sub>by NVIDIA</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Hardware-accelerated screen capture ('screencap') utility<br />&nbsp;&nbsp;&nbsp;Requires Windows OS w/ Nvidia GeForce GPU</i></sub></td><td><a href="https://www.nvidia.com/en-us/geforce/geforce-experience/shadowplay/">Download (source)</a></td></tr>
<tr><td><strong>Spotify</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Music Streaming</i></sub></td><td><a href="https://www.spotify.com/us/download/other/">Download (source)</a></td></tr>
<tr><td><strong>SVG Explorer Extension</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Windows Explorer icon thumbnails for .svg files<br />&nbsp;&nbsp;&nbsp;<a href="https://github.com/tibold/svg-explorer-extension/releases/tag/v0.1.1">View GitHub (Note: Signed .exe broken in Win10)</a></i></sub></td><td><a href="https://github.com/tibold/svg-explorer-extension/releases/download/v0.1.1/dssee_setup_x64_v011.exe">Download (source)</a></td></tr>
<tr><td><strong>Twitch App</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Live-Streaming & Mod Management</i></sub></td><td><a href="https://twitch.tv/downloads">Download (source)</a></td></tr>
<tr><td><strong>VirtualDub <sub>Virtual Dub</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source Video Capture, Video Processing, and<br />&nbsp;&nbsp;&nbsp;Video Editing Utility<br />&nbsp;&nbsp;&nbsp;Use XVid Video Compression via:<br />&nbsp;&nbsp;&nbsp;   Video > Compression > "Xvid ..." > OK</i></sub></td><td><a href="https://sourceforge.net/projects/virtualdub/files/latest/download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://sourceforge.net/projects/virtualdubffmpeginputplugin/">Download (FFMpeg Codec)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.xvid.com/download/">Download (XVid - EXE)</a><br />&nbsp;&nbsp;&nbsp; &uarr; Download exe & codecs<br />&nbsp;&nbsp;&nbsp;<a href="https://downloads.xvid.com/downloads/">View XVid Source</a></sub></td></tr>
<tr><td><strong>VLC</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source, Cross Platform Multimedia Player</i></sub></td><td><a href="https://www.videolan.org/vlc/index.html">Download (source)</a></td></tr>
<tr><td><strong>Xbox App</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Xbox Application for Windows 10</i></sub></td><td><a href="https://www.xbox.com/en-US/apps/xbox-app-for-windows-10">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="personalization"><br />Personalization<br /><br /></h5></th></tr>
<tr><td><strong>Dynamic Theme</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Updates/applies bing background & windows spotlight</a></i></sub></td><td><a href="https://www.microsoft.com/store/productId/9NBLGGH1ZBKW">Download (source)</a></td></tr>
<tr><td><strong>Fonts - Fira Code</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Ligature Font (has extra chars like triple equals)</a></i></sub></td><td><a href="https://fonts.google.com/specimen/Fira+Code">Download (source)</a></td></tr>
<tr><td><strong>Fonts - Roboto</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Mechanical skeleton w/ mostly geometric forms</a></i></sub></td><td><a href="https://fonts.google.com/specimen/Roboto">Download (source)</a></td></tr>
<tr><td><strong>Lockscreen as wallpaper</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Use 'Dynamic Theme', instead<br />&nbsp;&nbsp;&nbsp;Mirrors LockScreen Background onto Desktop</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9NBLGGH4WR7C">Download (source)</a></td></tr>
<tr><td><strong>ShellMenuView</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Modifies explorer's right-click menu/dropdown options</i></sub></td><td><a href="https://www.nirsoft.net/utils/shell_menu_view.html">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.nirsoft.net/utils/shmnview-x64.zip">Download (source)</a></sub></td></tr>
<tr><td><strong>ShellExView</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Displays installed shell extensions<br />&nbsp;&nbsp;&nbsp;Allows enabling/disabling shell extensions</i></sub></td><td><a href="https://www.nirsoft.net/utils/shexview.html">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.nirsoft.net/utils/shexview-x64.zip">Download (source)</a></sub></td></tr>
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
<tr><td><strong>Dell PowerEdge Bootable ISOs</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Official Dell Driver + Firmware Bootlable ISOs<br />&nbsp;&nbsp;&nbsp;View <a href="https://www.dell.com/support/article/en-us/sln296511/update-poweredge-servers-with-platform-specific-bootable-iso?lang=en#2">Update PowerEdge Servers with Platform Specific Bootable ISO</a><br />&nbsp;&nbsp;&nbsp;View <a href="https://www.dell.com/support/article/en-us/sln296810/how-to-create-a-bootable-usb-device-with-rufus-to-update-dell-servers?lang=en">Create Bootable Dell Server ISO</a></i></sub></td><td><a href="https://www.dell.com/support/article/en-us/sln296511/update-poweredge-servers-with-platform-specific-bootable-iso?lang=en#2">Download (source)</a></td></tr>
<tr><td><strong>FreeNAS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source Storage Operating System<br />&nbsp;&nbsp;&nbsp;Based on FreeBSD & OpenZFS file system<br />&nbsp;&nbsp;&nbsp;<a href="https://www.netcomplete.ch/bwl-knowledge-base/install-freenas-esxi/">FreeNAS as ESXi Storage Controller</a></i></sub></td><td><a href="https://www.freenas.org/download-freenas-release/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://archive.freenas.org/">Download (archive)</a></sub></td></tr>
<tr><td><strong>Lubuntu</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Debian Linux</i></sub></td><td><a href="https://lubuntu.me/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Server 2016</strong> <sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/windows-server/get-started/system-requirements">View System Requirements (Minimum)</a></sub></td><td><a href="https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016?filetype=ISO">Download (source)</a></td></tr>
<tr><td><strong>Raspberry Pi (Raspi)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Install OS onto SD card using Rufus<br />&nbsp;&nbsp;&nbsp;NOOBS may require Raspberry Pi Imager</i></sub></td><td><a href="https://www.raspberrypi.org/downloads/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.raspberrypi.org/downloads/noobs/">Download (NOOBS OS installer)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.raspberrypi.org/downloads/raspberry-pi-os/">Download (Raspberry Pi OS)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://ubuntu.com/download/raspberry-pi-core">Download (Ubuntu Core)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://ubuntu.com/download/raspberry-pi">Download (Ubuntu Server)</a></sub></td></tr>
<tr><td><strong>Ubuntu Desktop</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Debian Linux</i></sub></td><td><a href="https://ubuntu.com/download/desktop">Download (source)</a></td></tr>
<tr><td><strong>Ubuntu Server</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Debian Linux</i></sub></td><td><a href="https://ubuntu.com/download/server">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://mirror.umd.edu/ubuntu-iso/16.04/">Download (Ubuntu 16.04 LTS)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://mirror.umd.edu/ubuntu-iso/14.04/">Download (Ubuntu 14.04 LTS)</a></sub></td></tr>
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
<tr><td><strong>Windows 10</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Create Win10 Installation Media (Install Media)</i></sub></td><td><a href="https://www.microsoft.com/en-us/software-download/windows10">Download (source)</a></td></tr>
<tr><td><strong>Xubuntu</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Debian Linux</i></sub></td><td><a href="https://xubuntu.org/download">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="server-runtimes"><br />Server Applications (Backend)<br /><br /></h5></th></tr>
<tr><td><strong>Apache httpd</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source, Cross Platform Web Server</sub></td><td><a href="https://httpd.apache.org/download.cgi">Download (source)</a></td></tr>
<tr><td><strong>Artifactory</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Binary Repository Manager (relative to Source Code Repo)<br />&nbsp;&nbsp;&nbsp;Artifact Storage for Build Servers</sub></td><td><a href="https://www.jfrog.com/confluence/display/JFROG/Installing+Artifactory">Install (source)</a></td></tr>
<tr><td><strong>Docker - Containerized</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Linux LXC Container Management</i></sub></td><td><a href="https://get.docker.com">View (source)</a></td></tr>
<tr><td><strong>Jenkins - CI/CD Server</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Automates Continuous Integration (CI)<br />&nbsp;&nbsp;&nbsp;Facilitates Continuous-Deployment (CD)</i></sub></td><td><a href="https://jenkins.io">View (source)</a></td></tr>
<tr><td><strong>NSSM</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Non-Sucking Service<br />&nbsp;&nbsp;&nbsp;Manager (Windows)</i></sub></td><td><a href="https://nssm.cc/download">Download (source)</a></td></tr>
<tr><td><strong>MinIO Server</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;S3 Storage Server<br />&nbsp;&nbsp;&nbsp;rclone sync source:bucket dest:bucket</i></sub></td><td><a href="https://min.io/download#/linux">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://min.io/download#/windows">Download (Windows)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://dl.min.io/server/minio/release/windows-amd64/minio.exe">Download (direct)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.minio.io/docs/rclone-with-minio-server">Download (rclone)</a></sub></td></tr>
<tr><td><strong>MongoDB</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Cross Platform, Document-Oriented Database</i></sub></td><td><a href="https://www.mongodb.com/download-center/community">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/">Installation Guide</a></sub></td></tr>
<tr><td><strong>Microsoft JDBC Driver</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Java Database Connectivity API<br />&nbsp;&nbsp;&nbsp;Defines how a client may access a database</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server">Download (source)</a></td></tr>
<tr><td><strong>Microsoft ODBC Driver</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;DLL allowing apps to query T-SQL DBs</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server">Download (source)</a></td></tr>
<tr><td><strong>Microsoft SQL Server</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Microsoft's Relational Database Management System<br />&nbsp;&nbsp;&nbsp;View <a href="https://docs.microsoft.com/en-us/sql/database-engine/install-windows/latest-updates-for-microsoft-sql-server">Latest updates for Microsoft SQL Server</a><br />&nbsp;&nbsp;&nbsp;SqlLocalDB - LocalDB<br />&nbsp;&nbsp;&nbsp;SQLEXPR - Express<br />&nbsp;&nbsp;&nbsp;SQLEXPRWT - Express with Tools<br />&nbsp;&nbsp;&nbsp;SQLManagementStudio - SQL Studio Manager Express<br />&nbsp;&nbsp;&nbsp;SQLEXPRADV - Express + Advanced Services</i></sub></td><td><a href="https://www.microsoft.com/en-us/sql-server/sql-server-downloads">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://go.microsoft.com/fwlink/?linkid=866658">Download (source, 2019-express)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=56836">Download (source, 2016-SP2)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=55994">Download (source, 2017-express)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/evalcenter/evaluate-sql-server-2014-sp3/">Download (source, 2014-latest)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.microsoft.com/en-us/download/details.aspx?id=49996">Download (source, 2012-SP3)</a></sub></td></tr>
<tr><td><strong>Microsoft SQL Server PowerShell module</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Includes:<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• SQLPS Module<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• SqlServer Module (which contains SQLPS' cmdlets)</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sql/powershell/download-sql-server-ps-module">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<details><summary><i>Download (one-liner, PowerShell)</i></summary><p><ol><li><pre><code>Install-Module -Name SqlServer -AllowClobber -Scope CurrentUser -Force;</code></pre></li></ol></p></details></sub></td></tr>
<tr><td><strong>Microsoft SQLCMD</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Uses ODBC to execute Transact-SQL batches</i><br />&nbsp;&nbsp;&nbsp;!!! Requires Microsoft ODBC Driver !!!</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility">Download (source)</a></td></tr>
<tr><td><strong>NGINX</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source Web Server, Reverse Proxy,<br />&nbsp;&nbsp;&nbsp;Load Balancer, Mail Proxy, & HTTP Cache</sub></td><td><a href="https://nginx.org/en/download.html">Download (source)</a></td></tr>
<tr><td><strong>RunDeck</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Runbook Automation for Ansible Playbooks</i></sub></td><td><a href="https://docs.rundeck.com/docs/administration/install/linux-rpm.html#Open-Source-rundeck">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://hub.docker.com/r/rundeck/rundeck">Download (docker)</a></sub></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="server-management"><br />Server Management/Administration Tools<br /><br /></h5></th></tr>
<tr><td><strong>DB Browser for SQLite</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;SQLite Infrastructure Management Tool</i></sub></td><td><a href="https://sqlitebrowser.org/dl/">Download (source)</a></td></tr>
<tr><td><strong>Dell EMC OMSA <sub>(OpenManage Server Administrator)</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Browser-based Management Utility for Dell iDRAC</br >&nbsp;&nbsp;&nbsp;(1/2) Install Windows Service (Web-Server, Port 1311)</br >&nbsp;&nbsp;&nbsp;(2/2) Install the .vib on desired ESXi host(s)</i></sub></td><td><a href="https://www.dell.com/support/article/en-us/sln312492/support-for-dell-emc-openmanage-server-administrator-omsa">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://dl.dell.com/FOLDER06019899M/1/OM-SrvAdmin-Dell-Web-WINX64-9.4.0-3787_A00.exe">Download (Windows svc)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://dl.dell.com/FOLDER05993176M/1/OM-SrvAdmin-Dell-Web-9.4.0-3776.VIB-ESX65i_A00.zip">Download (ESXI .vib)</a></sub></td></tr>
<tr><td><strong>Microsoft SSMS</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Microsoft SQL Server Management Studio (SSMS)<br />&nbsp;&nbsp;&nbsp;SQL Infrastructure Management Tool<br />&nbsp;&nbsp;&nbsp;Troubleshooting:<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Right-Click Instance -> "Activity Monitor"</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms">Download (source)</a></td></tr>
<tr><td><strong>MySQL Workbench</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MySQL Infrastructure Management Tool</i></sub></td><td><a href="https://dev.mysql.com/downloads/workbench/">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-8.0.19-winx64.msi">Download (direct)</a></sub></td></tr>
<tr><td><strong>NGINX</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source Web Server, Reverse Proxy,<br />&nbsp;&nbsp;&nbsp;Load Balancer, Mail Proxy, & HTTP Cache</sub></td><td><a href="https://nginx.org/en/download.html">Download (source)</a></td></tr>
<tr><td><strong>phpMyAdmin</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MySQL Administration & Management Portal<br />&nbsp;&nbsp;&nbsp;PHP self-host service (add security as-needed)</i></sub></td><td><a href="https://www.phpmyadmin.net/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Robo 3T</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MongoDB Database Management/Administration Tool<br />&nbsp;&nbsp;&nbsp;Open Source GUI/IDE based tool<br />&nbsp;&nbsp;&nbsp;During install, select 'Shell Centric' option</i></sub></td><td><a href="https://robomongo.org/download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://download-test.robomongo.org/windows/robo3t-1.3.1-windows-x86_64-7419c406.exe">Download (direct)</a></sub></td></tr>
<tr><td><strong>Webmin</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Web (GUI) based tool for managing Unix system(s)</i></sub></td><td><a href="https://www.redhat.com/sysadmin/webmin">Download (source)</a></td></tr>
<!-- -->
<!-- ------------------------------------------------------------ -->
<!-- -->
<tr><th colspan="2"><h5 id="troubleshooting"><br />Troubleshooting<br /><br /></h5></th></tr>
<tr><td><strong>AIDA64</strong> <sub><br />&nbsp;&nbsp;&nbsp;Mobile Specsheet (High Verbosity)<br />&nbsp;&nbsp;&nbsp;Mobile version is Free w/ ads<br />&nbsp;&nbsp;&nbsp;Desktop version is Paid $$</i></sub></td><td><a href="https://www.aida64.com/downloads">Download (source)</a></sub></td></tr>
<tr><td><strong>Autologon</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/autologon">Download (source)</a></td></tr>
<tr><td><strong>BlueScreenView</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Nirsoft</i></sub></td><td><a href="https://www.nirsoft.net/utils/blue_screen_view.html">Download (source)</a></td></tr>
<tr><td><strong>Burp Suite <sub>Community Edition</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Manual Toolkit for Exploring Web Security</i></sub></td><td><a href="https://portswigger.net/burp/communitydownload">Download (source)</a></td></tr>
<tr><td><strong>CCleaner</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Piriform<br />&nbsp;&nbsp;&nbsp;Automated disk & registry cleaning tool</i></sub></td><td><a href="https://www.ccleaner.com/ccleaner/download/standard">Download (source)</a></td></tr>
<tr><td><strong>Cipher Suites in TLS/SSL (Schannel SSP)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;A cipher suite must have algorithms for the tasks:<br />&nbsp;&nbsp;&nbsp;∙ Key exchange<br />&nbsp;&nbsp;&nbsp;∙ Bulk encryption<br />&nbsp;&nbsp;&nbsp;∙ Message authentication</i></sub></td><td><a href="https://docs.microsoft.com/en-us/windows/win32/secauthn/cipher-suites-in-schannel">Download (source)</a></td></tr>
<tr><td><strong>DDU (Display Driver Uninstaller)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Removes ALL graphics drivers</i></sub></td><td><a href="https://www.guru3d.com/files-get/display-driver-uninstaller-download,19.html">Download (source)</a><sub><br >&nbsp;&nbsp;&nbsp;<a href="https://www.guru3d.com/files-details/display-driver-uninstaller-download.html">Download (mirror)</a></sub></td></tr>
<tr><td><strong>DigiCert Certificate Utility</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Certificate Inspection Tool (DigiCertUtil.exe)</i></sub></td><td><a href="https://www.digicert.com/util/">Download (source)</a></td></tr>
<tr><td><strong>DigiCert SSL Tools</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Check Host SSL/TLS, Generate CSR,<br />&nbsp;&nbsp;&nbsp;Check CSR, Searct CT Logs</i></sub></td><td><a href="https://ssltools.digicert.com/checker/">Open (web-service)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master/usr/local/bin/csr_generator">Generate CSR (HTTPS)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://knowledge.digicert.com/solution/SO29005.html">Generate CSR (Code Signing)</a></sub></td></tr>
<tr><td><strong>Effective File Search (EFS)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Search tool</i></sub></td><td><a href="https://effective-file-search.en.lo4d.com/download">Download (mirror)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download">Download (fallback)</a></sub></td></tr>
<tr><td><strong>FindLinks</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/findlinks">Download (source)</a></td></tr>
<tr><td><strong>Get System Specs</strong> <sub>(Get-SystemSpecs)</sub><sub><i><br />&nbsp;&nbsp;&nbsp;Hardware Spec 'Getter' using WMIC</i></sub></td><td><sub><details><summary><i>Download (one-liner, PowerShell)</i></summary><p><ol><li><pre><code>(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/mcavallo-git/Coding/master/cmd/cmd%20-%20Get-SystemSpecs.bat","${Env:TEMP}\Get-SystemSpecs.bat"); Start-Process -Filepath ("${Env:ComSpec}") -ArgumentList (@("/C","${Env:TEMP}\Get-SystemSpecs.bat"));</code></pre></li></ol></p></details></sub></td></tr>
<tr><td><strong>IIS Crypto</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Streamlined Windows Server Encryption Management<br />&nbsp;&nbsp;&nbsp;SSL/TLS Certificate Management, Ciphers, etc.</i></sub></td><td><a href="https://www.nartac.com/Products/IISCrypto">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.nartac.com/Downloads/IISCrypto/IISCrypto.exe">Download (direct, GUI)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://www.nartac.com/Downloads/IISCrypto/IISCryptoCli.exe">Download (direct, CLI)</a><br />&nbsp;&nbsp;&nbsp;<a href="https://docs.microsoft.com/en-us/windows/win32/secauthn/cipher-suites-in-schannel">Docs - TLS/SSL Cipher Suites</a></sub></td></tr>
<tr><td><strong>ImmuniWeb SSLScan (HTTPS)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Application Security Testing (AST)<br />&nbsp;&nbsp;&nbsp;Attack Surface Management (ASM)</i></sub></td><td><a href="https://www.htbridge.com/ssl/">View (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.immuniweb.com/ssl/API_documentation.pdf">View Documentation (API)</a></sub></td></tr>
<tr><td><strong>KDiff3</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Text Difference Analyzer</i></sub></td><td><a href="https://sourceforge.net/projects/kdiff3/files/latest/download">Download (source)</a></td></tr>
<tr><td><strong>Malwarebytes</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Anti-Malware Utility</i></sub></td><td><a href="https://www.malwarebytes.com/mwb-download/thankyou/">Download (source)</a></td></tr>
<tr><td><strong>Microsoft .NET Repair Tool</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Detects & Repairs corrupt .NET Framework installations</i></sub></td><td><a href="https://support.microsoft.com/en-us/help/2698555/microsoft-net-framework-repair-tool-is-available">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://aka.ms/DotnetRepairTool">Download (direct)</a></sub></td></tr>
<tr><td><strong>Microsoft Edge <sub>(Remove, Uninstall)</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Installs via Windows Updates as-of August 2020<br />&nbsp;&nbsp;&nbsp;</i></sub></td><td><a href="windows/Windows%20-%20Microsoft%20Edge%20(Remove%2C%20Uninstall).md#uninstall_guide">View Uninstall Guide</a></td></tr>
<tr><td><strong>MC</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;MinIO Client</i></sub></td><td><a href="https://dl.min.io/client/mc/release/windows-amd64/mc.exe">Download (source)</a></td></tr>
<tr><td><strong>NETworkManager<sub>&nbsp;&nbsp;&nbsp;(Network Manager)</sub></strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Network Management/Troubleshooting Tool<br />&nbsp;&nbsp;&nbsp;Settings-filepaths (set to use Cloud-Synced filepath):<br />&nbsp;&nbsp;&nbsp;> "Settings" (cog @ bottom-left) > "Profiles" > "Location"</i></sub></td><td><a href="https://borntoberoot.net/NETworkManager/Download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://github.com/BornToBeRoot/NETworkManager#download">Download (GitHub)</a></sub></td></tr>
<tr><td><strong>Postman</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;API-Development Collaboration Platform<br />&nbsp;&nbsp;&nbsp;HTTP GET/OPTION/POST/etc. Request-Debugger<br />&nbsp;&nbsp;&nbsp;View <a href="https://raw.githubusercontent.com/mcavallo-git/Coding/master/postman/postman_collection.json">Demo Collection</a> (Download & Import)</i></sub></td><td><a href="https://getpostman.com/downloads" id="download-postman">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://dl.pstmn.io/download/latest/win64">Download (direct)</a></sub></td></tr>
<tr><td><strong>ProduKey</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Nirsoft<br />&nbsp;&nbsp;&nbsp;Recover lost Windows product key(s)</i></sub></td><td><a href="https://www.nirsoft.net/utils/product_cd_key_viewer.html">Download (source)</a></td></tr>
<tr><td><strong>PsTools</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals<br />&nbsp;&nbsp;&nbsp;PsExec, PsService, PsShutdown, PsGetSid, ...</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/psgetsid">Download (source)</a></td></tr>
<tr><td><strong>Process Explorer</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer">Download (source)</a></td></tr>
<tr><td><strong>PureVPN</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Commercial Virtual Private Network (VPN) service<br />&nbsp;&nbsp;&nbsp;Owned by GZ Systems Ltd.</i></sub></td><td><a href="https://www.purevpn.com/download">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://support.purevpn.com/vpn-servers">PureVPN Servers</a><br />&nbsp;&nbsp;&nbsp;<a href="https://support.purevpn.com/vpn-servers">Win10 VPN Setup</a></sub></td></tr>
<tr><td><strong>Qualys SSL Server Test (HTTPS)</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Application Security Testing (AST)<br />&nbsp;&nbsp;&nbsp;Attack Surface Management (ASM)</i></sub></td><td><a href="https://www.ssllabs.com/ssltest/">Open (web-service)</a></td></tr>
<tr><td><strong>TCPView</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview">Download (source)</a></td></tr>
<tr><td><strong>WakeMeOnLan</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;by Nirsoft</i></sub></td><td><a href="https://www.nirsoft.net/utils/wake_on_lan.html">Download (source)</a></td></tr>
<tr><td><strong>WinDirStat</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Disk Usage Analyzer</i></sub></td><td><a href="https://www.fosshub.com/WinDirStat.html">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://windirstat.net/download.html">Download (fallback)</a></sub></td></tr>
<tr><td><strong>WinTail</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Tail for Windows</i></sub></td><td><a href="https://sourceforge.net/projects/wintail/">Download (source)</a></td></tr>
<tr><td><strong>WireShark</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Open Source Packet Analyzer</i></sub></td><td><a href="https://www.wireshark.org/download.html">Download (source)</a></td></tr>
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

<ul>
	<li><strong><a href="windows#windows-one-time-setup">(Continued) Windows One-time setup (per device)</a></strong></li>
	<li><strong><a href="hotkeys/browser-hotkeys.txt">(Continued) Web-Browser & Windows-Explorer Hotkeys</a></strong></li>
</ul>

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