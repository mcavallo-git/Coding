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
				<pre><code>Start-Process PowerShell.exe $(New-Object Net.WebClient).DownloadString('https://sync.mcavallo.com/ps') -Verb RunAs;</code></pre>
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
				<pre><code>curl -ssL "https://sync.mcavallo.com/$(date +'%N').sh" | sudo bash;</code></pre>
			</li>
		</ol>
	</p>
</details>

<hr id="workstation-installs" />


<!-- ------------------------------------------------------------ -->

<h5 id="software">Software</h5>
<details open><summary><i>Show/Hide Content</i></summary>
<br />


<table>
<tr><th>Name<br /><sub>&nbsp;&nbsp;&nbsp;<i>Description</i></sub></th><th>Source <br /><sub>&nbsp;&nbsp;&nbsp;<i>Docs, etc.</i></sub></th></tr>
<tr><th colspan="2"><h6 id="esssentials">Esssentials</h6></th></tr>
<tr><td><h6>AirParrot</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Airplay Client for Windows</i></sub></td><td><a href="https://www.airsquirrels.com/airparrot/download/">Download (mirror)</a></td></tr>
<tr><td><h6>AutoHotkey (AHK)</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Keyboard Macro Program</i></sub></td><td><a href="https://www.autohotkey.com/download/ahk-install.exe">Download (source)</a></td></tr>
<tr><td><h6>Classic Shell</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Win7 Style Start-Menu</i></sub></td><td><a href="https://www.fosshub.com/Classic-Shell.html">Download (mirror)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://www.softpedia.com/get/Desktop-Enhancements/Shell-Replacements/Classic-Shell.shtml">Download (fallback)</a></sub></td></tr>
<tr><td><h6>Cryptomator</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Client-Side Cloud-Encryption</i></sub></td><td><a href="https://cryptomator.org/downloads/#winDownload">Download (mirror)</a></td></tr>
<tr><td><h6>Docker Desktop (for Windows)</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Containers</i></sub></td><td><a href="https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe">Download (source)</a></td></tr>
<tr><td><h6>Effective File Search (EFS)</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Search tool</i></sub></td><td><a href="https://effective-file-search.en.lo4d.com/download">Download (mirror)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download">Download (fallback)</a></sub></td></tr>
<tr><td><h6>FoxIt PhantomPDF</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>PDF Editor (Paid)</i></sub></td><td><a href="https://www.foxitsoftware.com/downloads/#Foxit-PhantomPDF-Standard/">Download (source)</a></td></tr>
<tr><td><h6>Git SCM</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>CLI Integration</i></sub></td><td><a href="https://git-scm.com/download/win">Download (source)</a></td></tr>
<tr><td><h6>GitHub Desktop</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Git Daily Driver</i></sub></td><td><a href="https://desktop.github.com">Download (source)</a></td></tr>
<tr><td><h6>Gpg4win</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>GnuPG for Windows</i></sub></td><td><a href="https://www.gpg4win.org/thanks-for-download.html">Download (source)</a></td></tr>
<tr><td><h6>Handbrake</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Media Transcoder</i></sub></td><td><a href="https://handbrake.fr/">Download (source)</a></td></tr>
<tr><td><h6>ImageMagick</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Image Editing via Command-Line</i></sub></td><td><a href="https://www.imagemagick.org/script/download.php#windows">Download (source)</a></td></tr>
<tr><td><h6>KDiff3</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Text Difference Analyzer</i></sub></td><td><a href="https://sourceforge.net/projects/kdiff3/">Download (source)</a></td></tr>
<tr><td><h6>LastPass</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Password Manager</i></sub></td><td><a href="https://lastpass.com/download">Download (source)</a></td></tr>
<tr><td><h6>Microsoft Office 365</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Outlook, Word, Excel, PowerPoint, etc.</i></sub></td><td><a href="https://www.office.com/">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><i>Login &rarr; Click "Install Office"</i></sub></td></tr>
<tr><td><h6>MobaXterm</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>XServer for Windows</i></sub></td><td><a href="https://mobaxterm.mobatek.net/download-home-edition.html">Download (source)</a></td></tr>
<tr><td><h6>Ninite Package Manager</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Includes 7-Zip, Audacity, Chrome, Classic Shell,<br />&nbsp;&nbsp;&nbsp;DropBox, FileZilla, FireFox, GreenShot, HandBrake,<br />&nbsp;&nbsp;&nbsp;NotePad++, Paint.Net, VLC, VS-Code, & WinDirStat</i></sub></td><td><a href="https://ninite.com/7zip-audacity-chrome-classicstart-dropbox-filezilla-firefox-greenshot-handbrake-notepadplusplus-paint.net-vlc-vscode-windirstat/">Download (source)</a></td></tr>
<tr><td><h6>Notepad++</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Text and Source-Code Editor</i></sub></td><td><a href="https://notepad-plus-plus.org/downloads/">Download (source)</a></td></tr>
<tr><td><h6>Notepad Replacer</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Redirects NotePad.exe to VSCode, NP++, etc.</i></sub></td><td><a href="https://www.binaryfortress.com/NotepadReplacer/Download/">Download (source)</a></td></tr>
<tr><td><h6>Reflector</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Airplay Server for Windows</i></sub></td><td><a href="https://www.airsquirrels.com/reflector">Download (mirror)</a></td></tr>
<tr><td><h6>Remote Mouse</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Mouse & Keyboard control via Phone</i></sub></td><td><a href="https://www.remotemouse.net/downloads/RemoteMouse.exe">Download (source)</a></td></tr>
<tr><td><h6>Royal TS</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Includes Tools to manage Hyper-V, RDP,<br />&nbsp;&nbsp;&nbsp;SSH, SFTP, Teamviewer, VMware, & more</i></sub></td><td><a href="https://www.royalapps.com/ts/win/download">Download (mirror)</a></td></tr>
<tr><td><h6>Splashtop Personal</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Client</i></sub></td><td><a href="https://www.splashtop.com/downloadstart?product=stp&platform=windows-client">Download (source)</a></td></tr>
<tr><td><h6>Splashtop Streamer</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Host/Server</i></sub></td><td><a href="https://www.splashtop.com/downloadstart?platform=windows">Download (source)</a></td></tr>
<tr><td><h6>Teamviewer</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Host/Server</i></sub></td><td><a href="https://www.teamviewer.com/en/download/windows/">Download (source)</a></td></tr>
<tr><td><h6>Tortoise Git</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Git Merge Conflict Resolver</i></sub></td><td><a href="https://tortoisegit.org/download">Download (source)</a></td></tr>
<tr><td><h6>Visual Studio Code</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>VS Code - Code Editor</i></sub></td><td><a href="https://code.visualstudio.com/download">Download (source)</a></td></tr>
<tr><td><h6>WinDirStat</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Disk Usage Analyzer</i></sub></td><td><a href="https://www.fosshub.com/WinDirStat.html">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://windirstat.net/download.html">Download (fallback)</a></sub></td></tr>
<tr><td><h6>Windows 10</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Installation Media Creation Tool</i></sub></td><td><a href="https://www.microsoft.com/en-us/software-download/windows10">Download (source)</a></td></tr>
<tr><th colspan="2"><h6 id="benchmarking">Benchmarking</h6></th></tr>
<tr><td><h6>CrystalDiskMark</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>HDD/SSD Benchmarking</i></sub></td><td><a href="https://crystalmark.info/en/download/">Download (source)</a></td></tr>
<tr><td><h6>Unigine Benchmarks</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>GPU Benchmarking</i></sub></td><td><a href="https://benchmark.unigine.com/">Download (source)</a></td></tr>
<tr><th colspan="2"><h6 id="communication">Communication</h6></th></tr>
<tr><td><h6>Discord</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>VoIP & Digital Distribution</i></sub></td><td><a href="https://discordapp.com/download">Download (source)</a></td></tr>
<tr><td><h6>Microsoft Teams</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Shared Workspace for Chat, App, and File-Sharing</i></sub></td><td><a href="https://products.office.com/en-us/microsoft-teams/download-app">Download (source)</a></td></tr>
<tr><td><h6>Skype</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Free Video & Voice Calls</i></sub></td><td><a href="https://www.skype.com/en/get-skype/">Download (source)</a></td></tr>
<tr><td><h6>Skype for Business</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i><a href="https://support.microsoft.com/en-us/help/4511540/retirement-of-skype-for-business-online">Services will be retired (inaccessible) on/after July 31, 2021</a></i></sub></td><td><a href="https://products.office.com/en-us/skype-for-business/download-app">Download (source)</a></td></tr>
<tr><th colspan="2"><h6 id="cross-platform">Cross-Platform</h6></th></tr>
<tr><td>**Amazon Web Services CLI** <sub><i>(e.g. "AWS CLI")</sub></i> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Manage & Administer Cloud Services via CLI</i></sub></td><td><a href="https://docs.aws.amazon.com/powershell/latest/reference/Index.html">Download (source)](https://aws.amazon.com/powershell)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (PS-gallery)](https://www.powershellgallery.com/packages/AWSPowerShell)</sub><br />&nbsp;&nbsp;&nbsp;<sub>[View Documentation</a></sub></td></tr>
<tr><td><h6>Azure CLI</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Manage & Administer Cloud Services via CLI</i></sub></td><td><a href="https://docs.microsoft.com/en-us/cli/azure/reference-index">Download (source)](https://aka.ms/installazurecliwindows)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (PS-gallery)](https://www.powershellgallery.com/packages/az)</sub><br />&nbsp;&nbsp;&nbsp;<sub>[View Documentation</a></sub></td></tr>
<tr><td><h6>Docker</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Linux LXC Containers</i></sub></td><td><a href="https://get.docker.com">View (source)</a></td></tr>
<tr><td><h6>Java Standard Edition (SE8)</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>JDK - Development-Kit<br />&nbsp;&nbsp;&nbsp;JRE - Runtime Environment<br />&nbsp;&nbsp;&nbsp;Server JRE - For Long-Running Services</i></sub></td><td><a href="https://www.oracle.com/technetwork/java/javase/downloads/index.html#JDK8">Download (source)</a></td></tr>
<tr><td><h6>PowerShell Core</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Standard Edition</i></sub></td><td><a href="https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux">Download (GitHub)](https://github.com/PowerShell/PowerShell#get-powershell)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (Microsoft)</a></sub></td></tr>
<tr><td><h6>WSL - All Distros</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub></td><td><a href="https://aka.ms/wslstore">Download (source)</a></td></tr>
<tr><td><h6>WSL - Ubuntu 18.04 LTS</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9N9TNGVNDL3Q">Download (source)</a></td></tr>
<tr><th colspan="2"><h6 id="dns">DNS</h6></th></tr>
<tr><td>**GoDaddy - Certificate Authority (CA) Bundles** <sub><i><br />&nbsp;&nbsp;&nbsp;Root & Intermediate Certificates</i></sub></td><td><a href="https://ssl-ccp.godaddy.com/repository?origin=CALLISTO">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle" title="A 'CA bundle' is a file that contains root and intermediate certificates. The end-entity certificate along with a CA bundle constitutes the certificate chain.">What is a CA bundle?</a></sub></td></tr>
<tr><td>**Namecheap - Certificate Authority (CA) Bundles** <sub><i><br />&nbsp;&nbsp;&nbsp;Root & Intermediate Certificates</i></sub></td><td><a href="https://www.namecheap.com/support/knowledgebase/article.aspx/9393/69/where-do-i-find-ssl-ca-bundle">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle" title="A 'CA bundle' is a file that contains root and intermediate certificates. The end-entity certificate along with a CA bundle constitutes the certificate chain.">What is a CA bundle?</a></sub></td></tr>
<tr><th colspan="2"><h6 id="entertainment">Entertainment</h6></th></tr>
<tr><td><h6>Spotify</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Music Streaming</i></sub></td><td><a href="https://www.spotify.com/us/download/other/">Download (source)</a></td></tr>
<tr><td><h6>Twitch App</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Live-Streaming & Mod Management</i></sub></td><td><a href="https://twitch.tv/downloads">Download (source)</a></td></tr>
<tr><th colspan="2"><h6 id="hardware-utilities">Hardware Utilities</h6></th></tr>
<tr><td><h6>ASUS Aura Sync</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>RGB Controller</i></sub></td><td><a href="https://www.asus.com/campaign/aura/us/download.html">Download (source)</a></td></tr>
<tr><td><h6>BalenaEtcher</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Drive Imaging Utility (.iso & .img, especially)</i></sub></td><td><a href="https://www.balena.io/etcher/">Download (source)</a></td></tr>
<tr><td><h6>Corsair iCue</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>RGB Controller (+ Aura API)</i></sub></td><td><a href="https://www.corsair.com/us/en/downloads">Download (source)</a></td></tr>
<tr><td><h6>Easy2Boot</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>USB-drive multiboot software</i></sub></td><td><a href="https://www.fosshub.com/Easy2Boot.html">Download (source)</a></td></tr>
<tr><td><h6>Intel® DSA</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Intel® Driver & Support Assistant</i></sub></td><td><a href="https://www.intel.com/content/www/us/en/support/detect.html">Download (source)</a></td></tr>
<tr><td><h6>LG OnScreen Control</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Driver + Software for <a href="https://www.lg.com/uk/support/support-product/lg-34UC88-B"> LG 34UC88-B ] Display/Monitor</i></sub></td><td>[Download (source)](http://gscs-b2c.lge.com/downloadFile?fileId=L6Ns5WE6jhENU8Q3PwSyw)<br />&nbsp;&nbsp;&nbsp;<sub>[View Drivers & Software</a></sub></td></tr>
<tr><td><h6>Logitech G Hub</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Keyboard/Mouse RGB (+3rd Party Tools)</i></sub></td><td><a href="https://support.logi.com/hc/en-us/articles/360025298133">Download (source)</a></td></tr>
<tr><td><h6>Logitech SetPoint</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Mouse/Keyboard Hotkey Manager</i></sub></td><td><a href="http://support.logitech.com/software/setpoint">Download (source)</a></td></tr>
<tr><td><h6>PCPartPicker</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Component Pricing/Compatibility Comparisons</i></sub></td><td><a href="https://pcpartpicker.com/user/cavalol/saved/7Q2Mcf">Open (web-service)</a></td></tr>
<tr><td><h6>RMPrepUSB</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Allows users to easily and quickly 'roll their own' multiboot USB drive</i></sub></td><td><a href="https://www.fosshub.com/RMPrepUSB.html">Download (source)</a></td></tr>
<tr><td><h6>VMware (ESXi Server Management)</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>VMware vSphere, VMware Workstation, VMware Fusion, VMware Player, etc.</i></sub></td><td><a href="https://my.vmware.com/web/vmware/downloads">Download (source)</a></td></tr>
<tr><td><h6>Yubico Tools</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Security Key Configuration</i></sub></td><td><a href="https://www.yubico.com/products/services-software/download/">Download (source)</a></td></tr>
<tr><td><h6>WinSW: Windows service wrapper</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>(in less restrictive license)</i></sub></td><td><a href="https://github.com/kohsuke/winsw/">Download (source)</a></td></tr>
<tr><th colspan="2"><h6 id="monitoring">Monitoring</h6></th></tr>
<tr><td><h6>CoreTemp</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>CPU temperature monitoring/logging</i></sub></td><td><a href="https://www.alcpu.com/CoreTemp/">Download (source)</a></td></tr>
<tr><td><h6>CrystalDiskInfo</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>HDD temperature & S.M.A.R.T. value monitoring</i></sub></td><td><a href="https://crystalmark.info/en/download/">Download (source)</a></td></tr>
<tr><th colspan="2"><h6 id="personalization">Personalization</h6></th></tr>
<tr><td><h6>Lockscreen as wallpaper</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Mirrors LockScreen Background onto Desktop</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9NBLGGH4WR7C">Download (source)</a></td></tr>
<tr><th colspan="2"><h6 id="server-runtimes">Server Runtimes</h6></th></tr>
<tr><td><h6>Docker - Containerized</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Linux LXC Container Management</i></sub></td><td><a href="https://get.docker.com">View (source)</a></td></tr>
<tr><td><h6>Jenkins - CI/CD Server</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Automates Continuous Integration (CI)<br />&nbsp;&nbsp;&nbsp;Facilitates Continuous-Deployment (CD)</i></sub></td><td><a href="https://jenkins.io">View (source)</a></td></tr>
<tr><th colspan="2"><h6 id="troubleshooting">Troubleshooting</h6></th></tr>
<tr><td><h6>BlueScreenView</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft</i></sub></td><td><a href="https://www.nirsoft.net/utils/blue_screen_view.html">Download (source)</a></td></tr>
<tr><td><h6>DigiCert Certificate Utility for Windows</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Certificate Management & Troubleshooting Tool</i></sub></td><td><a href="https://www.digicert.com/util/">Download (source)</a></td></tr>
<tr><td><h6>DDU (Display Driver Uninstaller)</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Removes ALL graphics drivers</i></sub></td><td><a href="https://www.guru3d.com/files-details/display-driver-uninstaller-download.html">Download (source)</a></td></tr>
<tr><td><h6>DigiCert SSL Tools</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Check Host SSL/TLS, Generate CSR, Check CSR, Searct CT Logs</i></sub></td><td><a href="https://ssltools.digicert.com/checker/">Open (web-service)</a></td></tr>
<tr><td><h6>FindLinks</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/findlinks">Download (source)</a></td></tr>
<tr><td><h6>ImmuniWeb SSLScan (HTTPS)</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Application Security Testing (AST) & Attack Surface Management (ASM)</i></sub></td><td><a href="https://www.immuniweb.com/ssl/API_documentation.pdf">Open (web-service)](https://www.htbridge.com/ssl/)<br />&nbsp;&nbsp;&nbsp;<sub>[View API Documentation</a></sub></td></tr>
<tr><td><h6>Malwarebytes</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Anti-Malware Utility</i></sub></td><td><a href="https://www.malwarebytes.com/mwb-download/thankyou/">Download (source)</a></td></tr>
<tr><td><h6>Postman</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>'API-Development Collaboration Platform' - HTTP <a href="https://www.getpostman.com/downloads"> GET/OPTION/POST/etc. ] Request Debugger</i></sub></td><td>[Download (mirror)</a></td></tr>
<tr><td><h6>ProduKey</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft (Recover lost Windows product key (CD-Key) and Office 2003/2007 product key)</i></sub></td><td><a href="https://www.nirsoft.net/utils/product_cd_key_viewer.html">Download (source)</a></td></tr>
<tr><td><h6>Process Explorer</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer">Download (source)</a></td></tr>
<tr><td><h6>Qualys SSL Server Test (HTTPS)</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Application Security Testing (AST) & Attack Surface Management (ASM)</i></sub></td><td><a href="https://www.ssllabs.com/ssltest/">Open (web-service)</a></td></tr>
<tr><td><h6>TCPView</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview">Download (source)</a></td></tr>
<tr><td><h6>WakeMeOnLan</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft</i></sub></td><td><a href="https://www.nirsoft.net/utils/wake_on_lan.html">Download (source)</a></td></tr>
<tr><td><h6>WinTail</h6> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Tail for Windows</i></sub></td><td><a href="https://sourceforge.net/projects/wintail/">Download (source)</a></td></tr>
</table>

</details>

<hr />


<!-- ------------------------------------------------------------ -->

<li>
	<strong><a href="https://github.com/mcavallo-git/Coding/tree/master/windows#workstation-installs">(Continued) Windows Tips/Tricks</a></strong>
</li>

<hr />


<!-- ------------------------------------------------------------ -->

<h3>Citation(s)</h3>
<details><summary><i>Show/Hide Content</i></summary>
<p>

* ###### [1] en.wikipedia.org  |  "DevOps"  |  https://en.wikipedia.org/wiki/DevOps

* ###### [2] reddit.com  |  "What application do you always install on your computer and recommend to everyone?"  |  https://www.reddit.com/r/AskReddit/comments/4g5sl1/what_application_do_you_always_install_on_your/

* ###### [3] reddit.com  |  "[List] Essential Software for your Windows PC"  |  https://www.reddit.com/r/software/comments/8tx8w7/list_essential_software_for_your_windows_pc/

* ###### [4] atlassian.com  |  "DevOps: Breaking the Development-Operations barrier"  |  https://www.atlassian.com/devops

</p>
</details>

<hr />


<!-- ------------------------------------------------------------ -->