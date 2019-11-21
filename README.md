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
<tr><th colspan="2"><h5 id="esssentials"><br />Esssentials<br /><br /></h5></th></tr>
<tr><td><strong>AirParrot</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Airplay Client for Windows</i></sub></td><td><a href="https://www.airsquirrels.com/airparrot/download/">Download (mirror)</a></td></tr>
<tr><td><strong>AutoHotkey (AHK)</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Keyboard Macro Program</i></sub></td><td><a href="https://www.autohotkey.com/download/ahk-install.exe">Download (source)</a></td></tr>
<tr><td><strong>Classic Shell</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Win7 Style Start-Menu</i></sub></td><td><a href="https://www.fosshub.com/Classic-Shell.html">Download (mirror)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://www.softpedia.com/get/Desktop-Enhancements/Shell-Replacements/Classic-Shell.shtml">Download (fallback)</a></sub></td></tr>
<tr><td><strong>Cryptomator</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Client-Side Cloud-Encryption</i></sub></td><td><a href="https://cryptomator.org/downloads/#winDownload">Download (mirror)</a></td></tr>
<tr><td><strong>Docker Desktop (for Windows)</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Containers</i></sub></td><td><a href="https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe">Download (source)</a></td></tr>
<tr><td><strong>Effective File Search (EFS)</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Search tool</i></sub></td><td><a href="https://effective-file-search.en.lo4d.com/download">Download (mirror)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download">Download (fallback)</a></sub></td></tr>
<tr><td><strong>FoxIt PhantomPDF</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>PDF Editor (Paid)</i></sub></td><td><a href="https://www.foxitsoftware.com/downloads/#Foxit-PhantomPDF-Standard/">Download (source)</a></td></tr>
<tr><td><strong>Git SCM</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>CLI Integration</i></sub></td><td><a href="https://git-scm.com/download/win">Download (source)</a></td></tr>
<tr><td><strong>GitHub Desktop</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Git Daily Driver</i></sub></td><td><a href="https://desktop.github.com">Download (source)</a></td></tr>
<tr><td><strong>Gpg4win</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>GnuPG for Windows</i></sub></td><td><a href="https://www.gpg4win.org/thanks-for-download.html">Download (source)</a></td></tr>
<tr><td><strong>Handbrake</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Media Transcoder</i></sub></td><td><a href="https://handbrake.fr/">Download (source)</a></td></tr>
<tr><td><strong>ImageMagick</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Image Editing via Command-Line</i></sub></td><td><a href="https://www.imagemagick.org/script/download.php#windows">Download (source)</a></td></tr>
<tr><td><strong>KDiff3</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Text Difference Analyzer</i></sub></td><td><a href="https://sourceforge.net/projects/kdiff3/">Download (source)</a></td></tr>
<tr><td><strong>LastPass</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Password Manager</i></sub></td><td><a href="https://lastpass.com/download">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Office 365</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Outlook, Word, Excel, PowerPoint, etc.</i></sub></td><td><a href="https://www.office.com/">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><i>Login &rarr; Click "Install Office"</i></sub></td></tr>
<tr><td><strong>MobaXterm</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>XServer for Windows</i></sub></td><td><a href="https://mobaxterm.mobatek.net/download-home-edition.html">Download (source)</a></td></tr>
<tr><td><strong>Ninite Package Manager</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Includes 7-Zip, Audacity, Chrome, Classic Shell,<br />&nbsp;&nbsp;&nbsp;DropBox, FileZilla, FireFox, GreenShot, HandBrake,<br />&nbsp;&nbsp;&nbsp;NotePad++, Paint.Net, VLC, VS-Code, & WinDirStat</i></sub></td><td><a href="https://ninite.com/7zip-audacity-chrome-classicstart-dropbox-filezilla-firefox-greenshot-handbrake-notepadplusplus-paint.net-vlc-vscode-windirstat/">Download (source)</a></td></tr>
<tr><td><strong>Notepad++</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Text and Source-Code Editor</i></sub></td><td><a href="https://notepad-plus-plus.org/downloads/">Download (source)</a></td></tr>
<tr><td><strong>Notepad Replacer</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Redirects NotePad.exe to VSCode, NP++, etc.</i></sub></td><td><a href="https://www.binaryfortress.com/NotepadReplacer/Download/">Download (source)</a></td></tr>
<tr><td><strong>Reflector</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Airplay Server for Windows</i></sub></td><td><a href="https://www.airsquirrels.com/reflector">Download (mirror)</a></td></tr>
<tr><td><strong>Remote Mouse</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Mouse & Keyboard control via Phone</i></sub></td><td><a href="https://www.remotemouse.net/downloads/RemoteMouse.exe">Download (source)</a></td></tr>
<tr><td><strong>Royal TS</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Includes Tools to manage Hyper-V, RDP,<br />&nbsp;&nbsp;&nbsp;SSH, SFTP, Teamviewer, VMware, & more</i></sub></td><td><a href="https://www.royalapps.com/ts/win/download">Download (mirror)</a></td></tr>
<tr><td><strong>Splashtop Personal</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Client</i></sub></td><td><a href="https://www.splashtop.com/downloadstart?product=stp&platform=windows-client">Download (source)</a></td></tr>
<tr><td><strong>Splashtop Streamer</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Host/Server</i></sub></td><td><a href="https://www.splashtop.com/downloadstart?platform=windows">Download (source)</a></td></tr>
<tr><td><strong>Teamviewer</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Host/Server</i></sub></td><td><a href="https://www.teamviewer.com/en/download/windows/">Download (source)</a></td></tr>
<tr><td><strong>Tortoise Git</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Git Merge Conflict Resolver</i></sub></td><td><a href="https://tortoisegit.org/download">Download (source)</a></td></tr>
<tr><td><strong>Visual Studio Code</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>VS Code - Code Editor</i></sub></td><td><a href="https://code.visualstudio.com/download">Download (source)</a></td></tr>
<tr><td><strong>WinDirStat</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Disk Usage Analyzer</i></sub></td><td><a href="https://www.fosshub.com/WinDirStat.html">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://windirstat.net/download.html">Download (fallback)</a></sub></td></tr>
<tr><td><strong>Windows 10</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Installation Media Creation Tool</i></sub></td><td><a href="https://www.microsoft.com/en-us/software-download/windows10">Download (source)</a></td></tr>
<tr><th colspan="2"><h5 id="benchmarking"><br />Benchmarking<br /><br /></h5></th></tr>
<tr><td><strong>CrystalDiskMark</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>HDD/SSD Benchmarking</i></sub></td><td><a href="https://crystalmark.info/en/download/">Download (source)</a></td></tr>
<tr><td><strong>Unigine Benchmarks</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>GPU Benchmarking</i></sub></td><td><a href="https://benchmark.unigine.com/">Download (source)</a></td></tr>
<tr><th colspan="2"><h5 id="communication"><br />Communication<br /><br /></h5></th></tr>
<tr><td><strong>Discord</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>VoIP & Digital Distribution</i></sub></td><td><a href="https://discordapp.com/download">Download (source)</a></td></tr>
<tr><td><strong>Microsoft Teams</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Chat & App/File-Sharing</i></sub></td><td><a href="https://products.office.com/en-us/microsoft-teams/download-app">Download (source)</a></td></tr>
<tr><td><strong>Skype</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Free Video & Voice Calls</i></sub></td><td><a href="https://www.skype.com/en/get-skype/">Download (source)</a></td></tr>
<tr><td><strong>Skype for Business</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i><a href="https://support.microsoft.com/en-us/help/4511540/retirement-of-skype-for-business-online">Services will be retired<br />&nbsp;&nbsp;&nbsp;on/after July 31, 2021</a></i></sub></td><td><a href="https://products.office.com/en-us/skype-for-business/download-app">Download (source)</a></td></tr>
<tr><th colspan="2"><h5 id="cross-platform"><br />Cross-Platform<br /><br /></h5></th></tr>
<tr><td><strong>AWS CLI</strong> <br /><sub><i>&nbsp;&nbsp;&nbsp;Amazon Web Services CLI<br />&nbsp;&nbsp;&nbsp;Manage & Administer Cloud Services via CLI</i></sub></td><td><a href="https://aws.amazon.com/powershell">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://www.powershellgallery.com/packages/AWSPowerShell">Download (PS-gallery)</a></sub><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://docs.aws.amazon.com/powershell/latest/reference/Index.html">View Documentation</a></sub></td></tr>
<tr><td><strong>Azure CLI</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Manage & Administer Cloud Services via CLI</i></sub></td><td><a href="https://aka.ms/installazurecliwindows">Download (source</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://www.powershellgallery.com/packages/az">Download (PS-gallery)</a></sub><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://docs.microsoft.com/en-us/cli/azure/reference-index">View Documentation</a></sub></td></tr>
<tr><td><strong>Docker</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Linux LXC Containers</i></sub></td><td><a href="https://get.docker.com">View (source)</a></td></tr>
<tr><td><strong>Java Standard Edition (SE8)</strong> <br /><sub><i>&nbsp;&nbsp;&nbsp;Server JRE - For Long-Running Services<br />&nbsp;&nbsp;&nbsp;JRE - Runtime Environment<br />&nbsp;&nbsp;&nbsp;JDK - Development-Kit</i></sub></td><td><a href="https://www.oracle.com/technetwork/java/javase/downloads/index.html#JDK8">Download (source)</a></td></tr>
<tr><td><strong>PowerShell Core</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Standard Edition</i></sub></td><td><a href="https://github.com/PowerShell/PowerShell#get-powershell">Download (GitHub)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux">Download (Microsoft)</a></sub></td></tr>
<tr><td><strong>WSL - All Distros</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub></td><td><a href="https://aka.ms/wslstore">Download (source)</a></td></tr>
<tr><td><strong>WSL - Ubuntu 18.04 LTS</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9N9TNGVNDL3Q">Download (source)</a></td></tr>
<tr><th colspan="2"><h5 id="dns"><br />DNS<br /><br /></h5></th></tr>
<tr><td><strong>GoDaddy</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Certificate Authority (CA) Bundles<br />&nbsp;&nbsp;&nbsp;Root & Intermediate Certificates</i></sub></td><td><a href="https://ssl-ccp.godaddy.com/repository?origin=CALLISTO">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle" title="A 'CA bundle' is a file that contains root and intermediate certificates. The end-entity certificate along with a CA bundle constitutes the certificate chain.">What is a CA bundle?</a></sub></td></tr>
<tr><td><strong>Namecheap</strong> <sub><i><br />&nbsp;&nbsp;&nbsp;Certificate Authority (CA) Bundles<br />&nbsp;&nbsp;&nbsp;Root & Intermediate Certificates</i></sub></td><td><a href="https://www.namecheap.com/support/knowledgebase/article.aspx/9393/69/where-do-i-find-ssl-ca-bundle">Download (source)</a><sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle" title="A 'CA bundle' is a file that contains root and intermediate certificates. The end-entity certificate along with a CA bundle constitutes the certificate chain.">What is a CA bundle?</a></sub></td></tr>
<tr><th colspan="2"><h5 id="entertainment"><br />Entertainment<br /><br /></h5></th></tr>
<tr><td><strong>Spotify</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Music Streaming</i></sub></td><td><a href="https://www.spotify.com/us/download/other/">Download (source)</a></td></tr>
<tr><td><strong>Twitch App</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Live-Streaming & Mod Management</i></sub></td><td><a href="https://twitch.tv/downloads">Download (source)</a></td></tr>
<tr><th colspan="2"><h5 id="hardware-utilities"><br />Hardware Utilities/Controllers<br /><br /></h5></th></tr>
<tr><td><strong>ASUS Aura Sync</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>RGB Controller</i></sub></td><td><a href="https://www.asus.com/campaign/aura/us/download.html">Download (source)</a></td></tr>
<tr><td><strong>BalenaEtcher</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Drive Imaging Utility (.iso & .img, especially)</i></sub></td><td><a href="https://www.balena.io/etcher/">Download (source)</a></td></tr>
<tr><td><strong>Corsair iCue</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>RGB Controller (+ Aura API)</i></sub></td><td><a href="https://www.corsair.com/us/en/downloads">Download (source)</a></td></tr>
<tr><td><strong>Easy2Boot</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>USB-drive multiboot software</i></sub></td><td><a href="https://www.fosshub.com/Easy2Boot.html">Download (source)</a></td></tr>
<tr><td><strong>Intel® DSA</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Intel® Driver & Support Assistant</i></sub></td><td><a href="https://www.intel.com/content/www/us/en/support/detect.html">Download (source)</a></td></tr>
<tr><td><strong>LG OnScreen Control</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Driver + Software for LG 34UC88-B Display/Monitor</i></sub></td><td><a href="http://gscs-b2c.lge.com/downloadFile?fileId=L6Ns5WE6jhENU8Q3PwSyw">Download (source)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://www.lg.com/uk/support/support-product/lg-34UC88-B">View Drivers & Software</a></sub></td></tr>
<tr><td><strong>Logitech G Hub</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Keyboard/Mouse RGB (+3rd Party Tools)</i></sub></td><td><a href="https://support.logi.com/hc/en-us/articles/360025298133">Download (source)</a></td></tr>
<tr><td><strong>Logitech SetPoint</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Mouse/Keyboard Hotkey Manager</i></sub></td><td><a href="http://support.logitech.com/software/setpoint">Download (source)</a></td></tr>
<tr><td><strong>PCPartPicker</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Component Pricing/Compatibility Comparisons</i></sub></td><td><a href="https://pcpartpicker.com/user/cavalol/saved/7Q2Mcf">Open (web-service)</a></td></tr>
<tr><td><strong>RMPrepUSB</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Multiboot formatter for USB-drives</i></sub></td><td><a href="https://www.fosshub.com/RMPrepUSB.html">Download (source)</a></td></tr>
<tr><td><strong>Sonos desktop controller</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Control LAN Sonos speakers</i></sub></td><td><a href="https://www.sonos.com/redir/controller_software_pc">Download (source)</a></td></tr>
<tr><td><strong>VMware (ESXi Server Management)</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>VMware vSphere, VMware Workstation,<br />&nbsp;&nbsp;&nbsp;VMware Fusion, VMware Player, etc.</i></sub></td><td><a href="https://my.vmware.com/web/vmware/downloads">Download (source)</a></td></tr>
<tr><td><strong>Yubico Tools</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Security Key Configuration</i></sub></td><td><a href="https://www.yubico.com/products/services-software/download/">Download (source)</a></td></tr>
<tr><td><strong>WinSW: Windows service wrapper</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>(in less restrictive license)</i></sub></td><td><a href="https://github.com/kohsuke/winsw/">Download (source)</a></td></tr>
<tr><th colspan="2"><h5 id="monitoring"><br />Monitoring<br /><br /></h5></th></tr>
<tr><td><strong>CoreTemp</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>CPU temperature monitoring/logging</i></sub></td><td><a href="https://www.alcpu.com/CoreTemp/">Download (source)</a></td></tr>
<tr><td><strong>CrystalDiskInfo</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>HDD temperature & S.M.A.R.T. value monitoring</i></sub></td><td><a href="https://crystalmark.info/en/download/">Download (source)</a></td></tr>
<tr><th colspan="2"><h5 id="personalization"><br />Personalization<br /><br /></h5></th></tr>
<tr><td><strong>Lockscreen as wallpaper</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Mirrors LockScreen Background onto Desktop</i></sub></td><td><a href="https://www.microsoft.com/store/productId/9NBLGGH4WR7C">Download (source)</a></td></tr>
<tr><th colspan="2"><h5 id="server-runtimes"><br />Server Runtimes<br /><br /></h5></th></tr>
<tr><td><strong>Docker - Containerized</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Linux LXC Container Management</i></sub></td><td><a href="https://get.docker.com">View (source)</a></td></tr>
<tr><td><strong>Jenkins - CI/CD Server</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Automates Continuous Integration (CI)<br />&nbsp;&nbsp;&nbsp;Facilitates Continuous-Deployment (CD)</i></sub></td><td><a href="https://jenkins.io">View (source)</a></td></tr>
<tr><th colspan="2"><h5 id="troubleshooting"><br />Troubleshooting<br /><br /></h5></th></tr>
<tr><td><strong>BlueScreenView</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft</i></sub></td><td><a href="https://www.nirsoft.net/utils/blue_screen_view.html">Download (source)</a></td></tr>
<tr><td><strong>DigiCert Certificate Utility</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Certificate Inspection Tool</i></sub></td><td><a href="https://www.digicert.com/util/">Download (source)</a></td></tr>
<tr><td><strong>DDU (Display Driver Uninstaller)</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Removes ALL graphics drivers</i></sub></td><td><a href="https://www.guru3d.com/files-details/display-driver-uninstaller-download.html">Download (source)</a></td></tr>
<tr><td><strong>DigiCert SSL Tools</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Check Host SSL/TLS, Generate CSR,<br />&nbsp;&nbsp;&nbsp;Check CSR, Searct CT Logs</i></sub></td><td><a href="https://ssltools.digicert.com/checker/">Open (web-service)</a></td></tr>
<tr><td><strong>FindLinks</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/findlinks">Download (source)</a></td></tr>
<tr><td><strong>ImmuniWeb SSLScan (HTTPS)</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Application Security Testing (AST)<br />&nbsp;&nbsp;&nbsp;Attack Surface Management (ASM)</i></sub></td><td><a href="https://www.htbridge.com/ssl/">Open (web-service)</a><br />&nbsp;&nbsp;&nbsp;<sub><a href="https://www.immuniweb.com/ssl/API_documentation.pdf">View API Documentation</a></sub></td></tr>
<tr><td><strong>Malwarebytes</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Anti-Malware Utility</i></sub></td><td><a href="https://www.malwarebytes.com/mwb-download/thankyou/">Download (source)</a></td></tr>
<tr><td><strong>Postman</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>API-Development Collaboration Platform<br />&nbsp;&nbsp;&nbsp;HTTP GET/OPTION/POST/etc. Request-Debugger</i></sub></td><td>[Download (mirror)</a></td></tr>
<tr><td><strong>ProduKey</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft<br />&nbsp;&nbsp;&nbsp;Recover lost Windows product key(s)</i></sub></td><td><a href="https://www.nirsoft.net/utils/product_cd_key_viewer.html">Download (source)</a></td></tr>
<tr><td><strong>Process Explorer</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer">Download (source)</a></td></tr>
<tr><td><strong>Qualys SSL Server Test (HTTPS)</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Application Security Testing (AST)<br />&nbsp;&nbsp;&nbsp;Attack Surface Management (ASM)</i></sub></td><td><a href="https://www.ssllabs.com/ssltest/">Open (web-service)</a></td></tr>
<tr><td><strong>TCPView</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td><a href="https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview">Download (source)</a></td></tr>
<tr><td><strong>WakeMeOnLan</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft</i></sub></td><td><a href="https://www.nirsoft.net/utils/wake_on_lan.html">Download (source)</a></td></tr>
<tr><td><strong>WinTail</strong> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Tail for Windows</i></sub></td><td><a href="https://sourceforge.net/projects/wintail/">Download (source)</a></td></tr>
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