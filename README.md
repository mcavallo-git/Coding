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
<tr><th colspan="2"><h6 id="esssentials">💿 Esssentials</h6></th></tr>
<tr><td>**AirParrot** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Airplay Client for Windows</i></sub></td><td>[Download (mirror)](https://www.airsquirrels.com/airparrot/download/)</td></tr>
<tr><td>**AutoHotkey (AHK)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Keyboard Macro Program</i></sub></td><td>[Download (source)](https://www.autohotkey.com/download/ahk-install.exe)</td></tr>
<tr><td>**Classic Shell** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Win7 Style Start-Menu</i></sub></td><td>[Download (mirror)](https://www.softpedia.com/get/Desktop-Enhancements/Shell-Replacements/Classic-Shell.shtml)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (fallback)](https://www.fosshub.com/Classic-Shell.html)</sub></td></tr>
<tr><td>**Cryptomator** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Client-Side Cloud-Encryption</i></sub></td><td>[Download (mirror)](https://cryptomator.org/downloads/#winDownload)</td></tr>
<tr><td>**Docker Desktop (for Windows)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Containers</i></sub></td><td>[Download (source)](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)</td></tr>
<tr><td>**Effective File Search (EFS)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Search tool</i></sub></td><td>[Download (mirror)](https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (fallback)](https://effective-file-search.en.lo4d.com/download)</sub></td></tr>
<tr><td>**FoxIt PhantomPDF** <br /><sub>&nbsp;&nbsp;&nbsp;<i>PDF Editor (Paid)</i></sub></td><td>[Download (source)](https://www.foxitsoftware.com/downloads/#Foxit-PhantomPDF-Standard/)</td></tr>
<tr><td>**Git SCM** <br /><sub>&nbsp;&nbsp;&nbsp;<i>CLI Integration</i></sub></td><td>[Download (source)](https://git-scm.com/download/win)</td></tr>
<tr><td>**GitHub Desktop** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Git Daily Driver</i></sub></td><td>[Download (source)](https://desktop.github.com)</td></tr>
<tr><td>**Gpg4win** <br /><sub>&nbsp;&nbsp;&nbsp;<i>GnuPG for Windows</i></sub></td><td>[Download (source)](https://www.gpg4win.org/thanks-for-download.html)</td></tr>
<tr><td>**Handbrake** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Media Transcoder</i></sub></td><td>[Download (source)](https://handbrake.fr/)</td></tr>
<tr><td>**ImageMagick** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Image Editing via Command-Line</i></sub></td><td>[Download (source)](https://www.imagemagick.org/script/download.php#windows)</td></tr>
<tr><td>**KDiff3** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Text Difference Analyzer</i></sub></td><td>[Download (source)](https://sourceforge.net/projects/kdiff3/)</td></tr>
<tr><td>**LastPass** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Password Manager</i></sub></td><td>[Download (source)](https://lastpass.com/download)</td></tr>
<tr><td>**Microsoft Office 365** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Outlook, Word, Excel, PowerPoint, etc.</i></sub></td><td>[Download (source)](https://www.office.com/)<br />&nbsp;&nbsp;&nbsp;<sub><i>Login &rarr; Click "Install Office"</i></sub></td></tr>
<tr><td>**MobaXterm** <br /><sub>&nbsp;&nbsp;&nbsp;<i>XServer for Windows</i></sub></td><td>[Download (source)](https://mobaxterm.mobatek.net/download-home-edition.html)</td></tr>
<tr><td>**Ninite Package Manager** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Includes 7-Zip, Audacity, Chrome, Classic Shell,<br />&nbsp;&nbsp;&nbsp;DropBox, FileZilla, FireFox, GreenShot, HandBrake,<br />&nbsp;&nbsp;&nbsp;NotePad++, Paint.Net, VLC, VS-Code, & WinDirStat</i></sub></td><td>[Download (source)](https://ninite.com/7zip-audacity-chrome-classicstart-dropbox-filezilla-firefox-greenshot-handbrake-notepadplusplus-paint.net-vlc-vscode-windirstat/)</td></tr>
<tr><td>**Notepad++** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Text and Source-Code Editor</i></sub></td><td>[Download (source)](https://notepad-plus-plus.org/downloads/)</td></tr>
<tr><td>**Notepad Replacer** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Redirects NotePad.exe to VSCode, NP++, etc.</i></sub></td><td>[Download (source)](https://www.binaryfortress.com/NotepadReplacer/Download/)</td></tr>
<tr><td>**Reflector** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Airplay Server for Windows</i></sub></td><td>[Download (mirror)](https://www.airsquirrels.com/reflector)</td></tr>
<tr><td>**Remote Mouse** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Mouse & Keyboard control via Phone</i></sub></td><td>[Download (source)](https://www.remotemouse.net/downloads/RemoteMouse.exe)</td></tr>
<tr><td>**Royal TS** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Includes Tools to manage Hyper-V, RDP,<br />&nbsp;&nbsp;&nbsp;SSH, SFTP, Teamviewer, VMware, & more</i></sub></td><td>[Download (mirror)](https://www.royalapps.com/ts/win/download)</td></tr>
<tr><td>**Splashtop Personal** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Client</i></sub></td><td>[Download (source)](https://www.splashtop.com/downloadstart?product=stp&platform=windows-client)</td></tr>
<tr><td>**Splashtop Streamer** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Host/Server</i></sub></td><td>[Download (source)](https://www.splashtop.com/downloadstart?platform=windows)</td></tr>
<tr><td>**Teamviewer** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Host/Server</i></sub></td><td>[Download (source)](https://www.teamviewer.com/en/download/windows/)</td></tr>
<tr><td>**Tortoise Git** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Git Merge Conflict Resolver</i></sub></td><td>[Download (source)](https://tortoisegit.org/download)</td></tr>
<tr><td>**Visual Studio Code** <br /><sub>&nbsp;&nbsp;&nbsp;<i>VS Code - Code Editor</i></sub></td><td>[Download (source)](https://code.visualstudio.com/download)</td></tr>
<tr><td>**WinDirStat** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Disk Usage Analyzer</i></sub></td><td>[Download (source)](https://windirstat.net/download.html)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (fallback)](https://www.fosshub.com/WinDirStat.html)</sub></td></tr>
<tr><td>**Windows 10** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Installation Media Creation Tool</i></sub></td><td>[Download (source)](https://www.microsoft.com/en-us/software-download/windows10)</td></tr>
<tr><th colspan="2"><h6 id="benchmarking">💿 Benchmarking</h6></th></tr>
<tr><td>**CrystalDiskMark** <br /><sub>&nbsp;&nbsp;&nbsp;<i>HDD/SSD Benchmarking</i></sub></td><td>[Download (source)](https://crystalmark.info/en/download/)</td></tr>
<tr><td>**Unigine Benchmarks** <br /><sub>&nbsp;&nbsp;&nbsp;<i>GPU Benchmarking</i></sub></td><td>[Download (source)](https://benchmark.unigine.com/)</td></tr>
<tr><th colspan="2"><h6 id="communication">💿 Communication</h6></th></tr>
<tr><td>**Discord** <br /><sub>&nbsp;&nbsp;&nbsp;<i>VoIP & Digital Distribution</i></sub></td><td>[Download (source)](https://discordapp.com/download)</td></tr>
<tr><td>**Microsoft Teams** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Shared Workspace for Chat, App, and File-Sharing</i></sub></td><td>[Download (source)](https://products.office.com/en-us/microsoft-teams/download-app)</td></tr>
<tr><td>**Skype** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Free Video & Voice Calls</i></sub></td><td>[Download (source)](https://www.skype.com/en/get-skype/)</td></tr>
<tr><td>**Skype for Business** <br /><sub>&nbsp;&nbsp;&nbsp;<i><a href="https://support.microsoft.com/en-us/help/4511540/retirement-of-skype-for-business-online">Services will be retired (inaccessible) on/after July 31, 2021</a></i></sub></td><td>[Download (source)](https://products.office.com/en-us/skype-for-business/download-app)</td></tr>
<tr><th colspan="2"><h6 id="cross-platform">💿 Cross-Platform</h6></th></tr>
<tr><td>**Amazon Web Services CLI** <sub><i>(e.g. "AWS CLI")</sub></i> <br /><sub>&nbsp;&nbsp;&nbsp;<i>Manage & Administer Cloud Services via CLI</i></sub></td><td>[Download (source)](https://aws.amazon.com/powershell)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (PS-gallery)](https://www.powershellgallery.com/packages/AWSPowerShell)</sub><br />&nbsp;&nbsp;&nbsp;<sub>[View Documentation](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)</sub></td></tr>
<tr><td>**Azure CLI** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Manage & Administer Cloud Services via CLI</i></sub></td><td>[Download (source)](https://aka.ms/installazurecliwindows)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (PS-gallery)](https://www.powershellgallery.com/packages/az)</sub><br />&nbsp;&nbsp;&nbsp;<sub>[View Documentation](https://docs.microsoft.com/en-us/cli/azure/reference-index)</sub></td></tr>
<tr><td>**Docker** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Linux LXC Containers</i></sub></td><td>[View (source)](https://get.docker.com)</td></tr>
<tr><td>**Java Standard Edition (SE8)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>JDK - Development-Kit<br />&nbsp;&nbsp;&nbsp;JRE - Runtime Environment<br />&nbsp;&nbsp;&nbsp;Server JRE - For Long-Running Services</i></sub></td><td>[Download (source)](https://www.oracle.com/technetwork/java/javase/downloads/index.html#JDK8)</td></tr>
<tr><td>**PowerShell Core** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Standard Edition</i></sub></td><td>[Download (GitHub)](https://github.com/PowerShell/PowerShell#get-powershell)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (Microsoft)](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux)</sub></td></tr>
<tr><td>**WSL - All Distros** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub></td><td>[Download (source)](https://aka.ms/wslstore)</td></tr>
<tr><td>**WSL - Ubuntu 18.04 LTS** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub></td><td>[Download (source)](https://www.microsoft.com/store/productId/9N9TNGVNDL3Q)</td></tr>
<tr><th colspan="2"><h6 id="dns">💿 DNS</h6></th></tr>
<tr><td>**GoDaddy - Certificate Authority (CA) Bundles** <sub><i><br />&nbsp;&nbsp;&nbsp;Root & Intermediate Certificates</i></sub></td><td>[Download (source)](https://ssl-ccp.godaddy.com/repository?origin=CALLISTO)<sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle" title="A 'CA bundle' is a file that contains root and intermediate certificates. The end-entity certificate along with a CA bundle constitutes the certificate chain.">What is a CA bundle?</a></sub></td></tr>
<tr><td>**Namecheap - Certificate Authority (CA) Bundles** <sub><i><br />&nbsp;&nbsp;&nbsp;Root & Intermediate Certificates</i></sub></td><td>[Download (source)](https://www.namecheap.com/support/knowledgebase/article.aspx/9393/69/where-do-i-find-ssl-ca-bundle)<sub><br />&nbsp;&nbsp;&nbsp;<a href="https://www.namecheap.com/support/knowledgebase/article.aspx/986/69/what-is-ca-bundle" title="A 'CA bundle' is a file that contains root and intermediate certificates. The end-entity certificate along with a CA bundle constitutes the certificate chain.">What is a CA bundle?</a></sub></td></tr>
<tr><th colspan="2"><h6 id="entertainment">💿 Entertainment</h6></th></tr>
<tr><td>**Spotify** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Music Streaming</i></sub></td><td>[Download (source)](https://www.spotify.com/us/download/other/)</td></tr>
<tr><td>**Twitch App** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Live-Streaming & Mod Management</i></sub></td><td>[Download (source)](https://twitch.tv/downloads)</td></tr>
<tr><th colspan="2"><h6 id="hardware-utilities">💿 Hardware Utilities</h6></th></tr>
<tr><td>**ASUS Aura Sync** <br /><sub>&nbsp;&nbsp;&nbsp;<i>RGB Controller</i></sub></td><td>[Download (source)](https://www.asus.com/campaign/aura/us/download.html)</td></tr>
<tr><td>**BalenaEtcher** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Drive Imaging Utility (.iso & .img, especially)</i></sub></td><td>[Download (source)](https://www.balena.io/etcher/)</td></tr>
<tr><td>**Corsair iCue** <br /><sub>&nbsp;&nbsp;&nbsp;<i>RGB Controller (+ Aura API)</i></sub></td><td>[Download (source)](https://www.corsair.com/us/en/downloads)</td></tr>
<tr><td>**Easy2Boot** <br /><sub>&nbsp;&nbsp;&nbsp;<i>USB-drive multiboot software</i></sub></td><td>[Download (source)](https://www.fosshub.com/Easy2Boot.html)</td></tr>
<tr><td>**Intel® DSA** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Intel® Driver & Support Assistant</i></sub></td><td>[Download (source)](https://www.intel.com/content/www/us/en/support/detect.html)</td></tr>
<tr><td>**LG OnScreen Control** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Driver + Software for [ LG 34UC88-B ] Display/Monitor</i></sub></td><td>[Download (source)](http://gscs-b2c.lge.com/downloadFile?fileId=L6Ns5WE6jhENU8Q3PwSyw)<br />&nbsp;&nbsp;&nbsp;<sub>[View Drivers & Software](https://www.lg.com/uk/support/support-product/lg-34UC88-B)</sub></td></tr>
<tr><td>**Logitech G Hub** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Keyboard/Mouse RGB (+3rd Party Tools)</i></sub></td><td>[Download (source)](https://support.logi.com/hc/en-us/articles/360025298133)</td></tr>
<tr><td>**Logitech SetPoint** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Mouse/Keyboard Hotkey Manager</i></sub></td><td>[Download (source)](http://support.logitech.com/software/setpoint)</td></tr>
<tr><td>**PCPartPicker** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Component Pricing/Compatibility Comparisons</i></sub></td><td>[Open (web-service)](https://pcpartpicker.com/user/cavalol/saved/7Q2Mcf)</td></tr>
<tr><td>**RMPrepUSB** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Allows users to easily and quickly 'roll their own' multiboot USB drive</i></sub></td><td>[Download (source)](https://www.fosshub.com/RMPrepUSB.html)</td></tr>
<tr><td>**VMware (ESXi Server Management)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>VMware vSphere, VMware Workstation, VMware Fusion, VMware Player, etc.</i></sub></td><td>[Download (source)](https://my.vmware.com/web/vmware/downloads)</td></tr>
<tr><td>**Yubico Tools** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Security Key Configuration</i></sub></td><td>[Download (source)](https://www.yubico.com/products/services-software/download/)</td></tr>
<tr><td>**WinSW: Windows service wrapper** <br /><sub>&nbsp;&nbsp;&nbsp;<i>(in less restrictive license)</i></sub></td><td>[Download (source)](https://github.com/kohsuke/winsw/)</td></tr>
<tr><th colspan="2"><h6 id="monitoring">💿 Monitoring</h6></th></tr>
<tr><td>**CoreTemp** <br /><sub>&nbsp;&nbsp;&nbsp;<i>CPU temperature monitoring/logging</i></sub></td><td>[Download (source)](https://www.alcpu.com/CoreTemp/)</td></tr>
<tr><td>**CrystalDiskInfo** <br /><sub>&nbsp;&nbsp;&nbsp;<i>HDD temperature & S.M.A.R.T. value monitoring</i></sub></td><td>[Download (source)](https://crystalmark.info/en/download/)</td></tr>
<tr><th colspan="2"><h6 id="personalization">💿 Personalization</h6></th></tr>
<tr><td>**Lockscreen as wallpaper** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Mirrors LockScreen Background onto Desktop</i></sub></td><td>[Download (source)](https://www.microsoft.com/store/productId/9NBLGGH4WR7C)</td></tr>
<tr><th colspan="2"><h6 id="server-runtimes">💿 Server Runtimes</h6></th></tr>
<tr><td>**Docker - Containerized** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Linux LXC Container Management</i></sub></td><td>[View (source)](https://get.docker.com)</td></tr>
<tr><td>**Jenkins - CI/CD Server** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Automates Continuous Integration (CI)<br />&nbsp;&nbsp;&nbsp;Facilitates Continuous-Deployment (CD)</i></sub></td><td>[View (source)](https://jenkins.io)</td></tr>
<tr><th colspan="2"><h6 id="troubleshooting">💿 Troubleshooting</h6></th></tr>
<tr><td>**BlueScreenView** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft</i></sub></td><td>[Download (source)](https://www.nirsoft.net/utils/blue_screen_view.html)</td></tr>
<tr><td>**DigiCert Certificate Utility for Windows** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Certificate Management & Troubleshooting Tool</i></sub></td><td>[Download (source)](https://www.digicert.com/util/)</td></tr>
<tr><td>**DDU (Display Driver Uninstaller)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Removes ALL graphics drivers</i></sub></td><td>[Download (source)](https://www.guru3d.com/files-details/display-driver-uninstaller-download.html)</td></tr>
<tr><td>**DigiCert SSL Tools** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Check Host SSL/TLS, Generate CSR, Check CSR, Searct CT Logs</i></sub></td><td>[Open (web-service)](https://ssltools.digicert.com/checker/)</td></tr>
<tr><td>**FindLinks** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td>[Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/findlinks)</td></tr>
<tr><td>**ImmuniWeb SSLScan (HTTPS)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Application Security Testing (AST) & Attack Surface Management (ASM)</i></sub></td><td>[Open (web-service)](https://www.htbridge.com/ssl/)<br />&nbsp;&nbsp;&nbsp;<sub>[View API Documentation](https://www.immuniweb.com/ssl/API_documentation.pdf)</sub></td></tr>
<tr><td>**Malwarebytes** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Anti-Malware Utility</i></sub></td><td>[Download (source)](https://www.malwarebytes.com/mwb-download/thankyou/)</td></tr>
<tr><td>**Postman** <br /><sub>&nbsp;&nbsp;&nbsp;<i>'API-Development Collaboration Platform' - HTTP [ GET/OPTION/POST/etc. ] Request Debugger</i></sub></td><td>[Download (mirror)](https://www.getpostman.com/downloads)</td></tr>
<tr><td>**ProduKey** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft (Recover lost Windows product key (CD-Key) and Office 2003/2007 product key)</i></sub></td><td>[Download (source)](https://www.nirsoft.net/utils/product_cd_key_viewer.html)</td></tr>
<tr><td>**Process Explorer** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td>[Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer)</td></tr>
<tr><td>**Qualys SSL Server Test (HTTPS)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Application Security Testing (AST) & Attack Surface Management (ASM)</i></sub></td><td>[Open (web-service)](https://www.ssllabs.com/ssltest/)</td></tr>
<tr><td>**TCPView** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub></td><td>[Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview)</td></tr>
<tr><td>**WakeMeOnLan** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft</i></sub></td><td>[Download (source)](https://www.nirsoft.net/utils/wake_on_lan.html)</td></tr>
<tr><td>**WinTail** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Tail for Windows</i></sub></td><td>[Download (source)](https://sourceforge.net/projects/wintail/)</td></tr>
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