<!-- ------------------------------------------------------------ ---

This file (on GitHub):

	https://github.com/mcavallo-git/Coding#coding

--- ------------------------------------------------------------- -->

<h3 id="coding">
	Coding<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<sub>↳ <i id="readme">Scripts, tools, & utilities to enhance Windows workstation efficiency & versatility</i></sub>
</h3>

<hr />


<!-- ------------------------------------------------------------ -->

<ul>

<!-- ------------------------------------------------------------ -->

<li><details open><summary>
		<strong>Sync PowerShell Modules</strong>
	</summary>
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
</li>

<hr />


<!-- ------------------------------------------------------------ -->

<li><details open><summary>
		<strong>Sync Bash Modules</strong>
	</summary>
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
</li>

<hr />


<!-- ------------------------------------------------------------ -->
<h3 id="workstation-installs">Windows Software - Workstation Essentials</h3>

Name | Download |
--- | ---
**AirParrot** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Airplay Client for Windows</i></sub> | [Download (mirror)](https://www.airsquirrels.com/airparrot/download/) |
**AutoHotkey (AHK)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Keyboard Macro Program</i></sub> | [Download (source)](https://www.autohotkey.com/download/ahk-install.exe) |
**Classic Shell** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Win7 Style Start-Menu</i></sub> | [Download (mirror)](https://www.softpedia.com/get/Desktop-Enhancements/Shell-Replacements/Classic-Shell.shtml)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (fallback)](https://www.fosshub.com/Classic-Shell.html)</sub> |
**Cryptomator** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Client-Side Cloud-Encryption</i></sub> | [Download (mirror)](https://cryptomator.org/downloads/#winDownload) |
**Docker Desktop (for Windows)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Containers</i></sub> | [Download (source)](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe) |
**Effective File Search (EFS)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Search tool</i></sub> | [Download (mirror)](https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (fallback)](https://effective-file-search.en.lo4d.com/download)</sub> |
**FoxIt PhantomPDF** <br /><sub>&nbsp;&nbsp;&nbsp;<i>PDF Editor (Paid)</i></sub> | [Download (source)](https://www.foxitsoftware.com/downloads/#Foxit-PhantomPDF-Standard/) |
**Git SCM** <br /><sub>&nbsp;&nbsp;&nbsp;<i>CLI Integration</i></sub> | [Download (source)](https://git-scm.com/download/win) |
**GitHub Desktop** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Git Daily Driver</i></sub> | [Download (source)](https://desktop.github.com) |
**Gpg4win** <br /><sub>&nbsp;&nbsp;&nbsp;<i>GnuPG for Windows</i></sub> | [Download (source)](https://www.gpg4win.org/thanks-for-download.html) |
**Handbrake** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Media Transcoder</i></sub> | [Download (source)](https://handbrake.fr/) |
**ImageMagick** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Image Editing via Command-Line</i></sub> | [Download (source)](https://www.imagemagick.org/script/download.php#windows) |
**KDiff3** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Text Difference Analyzer</i></sub> | [Download (source)](https://sourceforge.net/projects/kdiff3/) |
**LastPass** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Password Manager</i></sub> | [Download (source)](https://lastpass.com/download) |
**Microsoft Office 365** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Outlook, Word, Excel, PowerPoint, etc.</i></sub> | [Download (source)](https://www.office.com/)<br />&nbsp;&nbsp;&nbsp;<sub><i>Login &rarr; Click "Install Office"</i></sub> |
**MobaXterm** <br /><sub>&nbsp;&nbsp;&nbsp;<i>XServer for Windows</i></sub> | [Download (source)](https://mobaxterm.mobatek.net/download-home-edition.html) |
**Ninite Package Management** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Installs: 7-Zip, Audacity, Chrome, Classic Shell,<br />&nbsp;&nbsp;&nbsp;DropBox, FileZilla, FireFox, GreenShot, HandBrake,<br />&nbsp;&nbsp;&nbsp;NotePad++, Paint.Net, VLC, VS-Code, & WinDirStat</i></sub> | [Download (source)](https://ninite.com/7zip-audacity-chrome-classicstart-dropbox-filezilla-firefox-greenshot-handbrake-notepadplusplus-paint.net-vlc-vscode-windirstat/) |
**Notepad++** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Text and Source-Code Editor</i></sub> | [Download (source)](https://notepad-plus-plus.org/downloads/) |
**Notepad Replacer** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Redirects NotePad.exe to VSCode, NP++, etc.</i></sub> | [Download (source)](https://www.binaryfortress.com/NotepadReplacer/Download/) |
**Reflector** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Airplay Server for Windows</i></sub> | [Download (mirror)](https://www.airsquirrels.com/reflector) |
**Remote Mouse** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Mouse & Keyboard control via Phone</i></sub> | [Download (source)](https://www.remotemouse.net/downloads/RemoteMouse.exe) |
**Royal TS** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Management Soln.</i></sub> | [Download (mirror)](https://www.royalapps.com/ts/win/download) |
**Splashtop Personal** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Client</i></sub> | [Download (source)](https://www.splashtop.com/downloadstart?product=stp&platform=windows-client) |
**Splashtop Streamer** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Host/Server</i></sub> | [Download (source)](https://www.splashtop.com/downloadstart?platform=windows) |
**Teamviewer** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Remote Access Host/Server</i></sub> | [Download (source)](https://www.teamviewer.com/en/download/windows/) |
**Tortoise Git** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Git Merge Conflict Resolver</i></sub> | [Download (source)](https://tortoisegit.org/download) |
**Visual Studio Code** <br /><sub>&nbsp;&nbsp;&nbsp;<i>VS Code - Code Editor</i></sub> | [Download (source)](https://code.visualstudio.com/download) |
**WinDirStat** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Disk Usage Analyzer</i></sub> | [Download (source)](https://windirstat.net/download.html)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (fallback)](https://www.fosshub.com/WinDirStat.html)</sub> |
**Windows 10** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Creates Installation Media</i></sub> | [Download (source)](https://www.microsoft.com/en-us/software-download/windows10) |

<hr />

<!-- ------------------------------------------------------------ -->
<h3 id="software-platform">Windows Software - Cross-Platform Tools</h3>

Name | Option A | Option B
--- | --- | ---
**Amazon Web Services (AWS) CLI (PowerShell)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Amazon Web Services Management/Administration Tool<br />&nbsp;&nbsp;&nbsp;Cloud Management & Administration</i></sub> | [Download (source)](https://aws.amazon.com/powershell)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (PS-gallery)](https://www.powershellgallery.com/packages/AWSPowerShell)</sub><br />&nbsp;&nbsp;&nbsp;<sub>[View Documentation](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)</sub> |
**Azure CLI (PowerShell)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Azure Management/Administration Tool</i></sub> | [Download (source)](https://aka.ms/installazurecliwindows)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (PS-gallery)](https://www.powershellgallery.com/packages/az)</sub><br />&nbsp;&nbsp;&nbsp;<sub>[View Documentation](https://docs.microsoft.com/en-us/cli/azure/reference-index)</sub> |
**Java SE** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Java Standard Edition, Win10</i></sub> | [Download (source)](https://www.java.com/en/download/win10.jsp) |
**Java JDK, JRE** <br /><sub>&nbsp;&nbsp;&nbsp;<i>(Java Development-Kit, Runtime-Environment, Win10)</i></sub> | [Download (source)](https://www.oracle.com/technetwork/java/javase/downloads/index.html) |
**PowerShell Core** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Standard Edition</i></sub> | [Download (GitHub)](https://github.com/PowerShell/PowerShell#get-powershell)<br />&nbsp;&nbsp;&nbsp;<sub>[Download (Microsoft)](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux)</sub> |
**WSL - All Distros** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub> | [Download (source)](https://aka.ms/wslstore) |
**WSL - Ubuntu 16.04 LTS** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub> | [Download (source)](https://www.microsoft.com/store/productId/9PJN388HP8C9) |
**WSL - Ubuntu 18.04 LTS** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Windows Subsystem for Linux</i></sub> | [Download (source)](https://www.microsoft.com/store/productId/9N9TNGVNDL3Q) |

<hr />


<!-- ------------------------------------------------------------ -->
<h3>Windows Software - Benchmarking</h3>

Name | Option A | Option B
--- | --- | ---
**CoreTemp** <br /><sub>&nbsp;&nbsp;&nbsp;<i>CPU Temperature Logging</i></sub> | [Download (source)](https://www.alcpu.com/CoreTemp/) |
**CrystalDiskInfo** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Disk Info</i></sub> | [Download (source)](https://crystalmark.info/en/download/) |
**CrystalDiskMark** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Disk Benchmarking</i></sub> | [Download (source)](https://crystalmark.info/en/download/) |
**UNIGINE Benchmarks** <br /><sub>&nbsp;&nbsp;&nbsp;<i>GPU Benchmarking</i></sub> | [Download (source)](https://benchmark.unigine.com/) |

<hr />


<!-- ------------------------------------------------------------ -->
<h3>Windows Software - Communication</h3>

Name | Option A | Option B
--- | --- | ---
**Discord** <br /><sub>&nbsp;&nbsp;&nbsp;<i>VoIP & Digital Distribution</i></sub> | [Download (source)](https://discordapp.com/download) |
**Nicrosoft Teams** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Shared Workspace for Chat, App, and File-Sharing</i></sub> | [Download (source)](https://products.office.com/en-us/microsoft-teams/download-app) |
**Skype** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Free Video & Voice Calls</i></sub> | [Download (source)](https://www.skype.com/en/get-skype/) |
**Skype for Business** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Microsoft service will be retired after [ July 31, 2021 ]</i></sub> | [Download (source)](https://products.office.com/en-us/skype-for-business/download-app) |


<!-- ------------------------------------------------------------ -->
<h3>Windows Software - Entertainment</h3>

Name | Option A | Option B
--- | --- | ---
**Lockscreen as wallpaper** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Mirrors LockScreen Background onto Desktop</i></sub> | [Download (source)](https://www.microsoft.com/store/productId/9NBLGGH4WR7C) |
**Spotify** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Music Streaming</i></sub> | [Download (source)](https://www.spotify.com/us/download/other/) |
**Twitch App** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Live-Streaming & Mod Management</i></sub> | [Download (source)](https://twitch.tv/downloads) |

<hr />


<!-- ------------------------------------------------------------ -->
<h3 id="hardware-installs">Windows Software - Controllers/Drivers/Utilities & Other</h3>

Name | Option A | Option B
--- | --- | ---
**ASUS Aura Sync** <br /><sub>&nbsp;&nbsp;&nbsp;<i>RGB Controller</i></sub> | [Download (source)](https://www.asus.com/campaign/aura/us/download.html) |
**balenaEtcher** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Drive Imaging Utility (.iso & .img, especially)</i></sub> | [Download (source)](https://www.balena.io/etcher/) |
**Corsair iCue** <br /><sub>&nbsp;&nbsp;&nbsp;<i>RGB Controller (+ Aura API)</i></sub> | [Download (source)](https://www.corsair.com/us/en/downloads) |
**Easy2Boot** <br /><sub>&nbsp;&nbsp;&nbsp;<i>USB-drive multiboot software</i></sub> | [Download (source)](https://www.fosshub.com/Easy2Boot.html) |
**Intel® DSA** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Intel® Driver & Support Assistant</i></sub> | [Download (source)](https://www.intel.com/content/www/us/en/support/detect.html) |
**LG OnScreen Control** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Driver + Software for [ LG 34UC88-B ] Display/Monitor</i></sub> | [Download (source)](http://gscs-b2c.lge.com/downloadFile?fileId=L6Ns5WE6jhENU8Q3PwSyw)<br />&nbsp;&nbsp;&nbsp;<sub>[View Drivers & Software](https://www.lg.com/uk/support/support-product/lg-34UC88-B)</sub> |
**Logitech G Hub** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Keyboard/Mouse RGB (+3rd Party Tools)</i></sub> | [Download (source)](https://support.logi.com/hc/en-us/articles/360025298133) |
**Logitech SetPoint** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Mouse/Keyboard Hotkey Manager</i></sub> | [Download (source)](http://support.logitech.com/software/setpoint) |
**RMPrepUSB** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Allows users to easily and quickly 'roll their own' multiboot USB drive</i></sub> | [Download (source)](https://www.fosshub.com/RMPrepUSB.html) |
**VMware (ESXi Server Management)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>VMware vSphere, VMware Workstation, VMware Fusion, VMware Player, etc.</i></sub> | [Download (source)](https://my.vmware.com/web/vmware/downloads) |
**Yubico Tools** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Security Key Configuration</i></sub> | [Download (source)](https://www.yubico.com/products/services-software/download/) |
**WinSW: Windows service wrapper** <br /><sub>&nbsp;&nbsp;&nbsp;<i>(in less restrictive license)</i></sub> | [Download (source)](https://github.com/kohsuke/winsw/) |

<hr />


<!-- ------------------------------------------------------------ -->
<h3>Windows Software - Troubleshooting Utilities</h3>

Name | Option A | Option B
--- | --- | ---
**BlueScreenView** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft</i></sub> | [Download (source)](https://www.nirsoft.net/utils/blue_screen_view.html) |
**DigiCert Certificate Utility for Windows** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Certificate Management & Troubleshooting Tool</i></sub> | [Download (source)](https://www.digicert.com/util/) |
**DDU (Display Driver Uninstaller)** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Removes ALL graphics drivers</i></sub> | [Download (source)](https://www.guru3d.com/files-details/display-driver-uninstaller-download.html) |
**FindLinks** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub> | [Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/findlinks) |
**Postman** <br /><sub>&nbsp;&nbsp;&nbsp;<i>'API-Development Collaboration Platform' - HTTP [ GET/OPTION/POST/etc. ] Request Debugger</i></sub> | [Download (mirror)](https://www.getpostman.com/downloads) |
**Process Explorer** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub> | [Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer) |
**TCPView** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Sysinternals</i></sub> | [Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview) |
**WinTail** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Tail for Windows</i></sub> | [Download (source)](https://sourceforge.net/projects/wintail/) |
**WakeMeOnLan** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft</i></sub> | [Download (source)](https://www.nirsoft.net/utils/wake_on_lan.html) |
**ProduKey** <br /><sub>&nbsp;&nbsp;&nbsp;<i>by Nirsoft (Recover lost Windows product key (CD-Key) and Office 2003/2007 product key)</i></sub> | [Download (source)](https://www.nirsoft.net/utils/product_cd_key_viewer.html) |

<hr />

<!-- ------------------------------------------------------------ -->
<h3>Linux-Based Software - Tools & Utilities</h3>

Name | Option A | Option B
--- | --- | ---
**Docker** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Linux LXC Containers</i></sub> | [View (source)](https://get.docker.com) |
**Jenkins** <br /><sub>&nbsp;&nbsp;&nbsp;<i>CI/CD Server</i></sub> | [View (source)](https://jenkins.io) |

<hr />

<!-- ------------------------------------------------------------ -->
<h3>Web-Based Services - Tools & Utilities</h3>

Name | Option A | Option B
--- | --- | ---
**DigiCert SSL Tools** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Check Host SSL/TLS, Generate CSR, Check CSR, Searct CT Logs</i></sub> | [Download (source)](https://ssltools.digicert.com/checker/) |
**Qualys SSL Server Test** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Powered by Qualys SSL Labs (Test SSL, TLS, HTTPS) </i></sub> | [Download (source)](https://www.ssllabs.com/ssltest/) |
**ImmuniWeb® SSLScan** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Test SSL & TLS (HTTPS), Email TLS/STARTTLS<br />&nbsp;&nbsp;&nbsp;Comply with PCI DSS, HIPAA & NIST</i></sub> | [Download (source)](https://www.htbridge.com/ssl/) |
**PCPartPicker** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Component Pricing/Compatibility Comparisons</i></sub> | [View (source)](https://pcpartpicker.com/user/cavalol/saved/7Q2Mcf) |

<hr />

<!-- ------------------------------------------------------------ -->
<h3>DNS Certificate-Chains/Root-Certs</h3>

Name | Option A | Option B
--- | --- | ---
**GoDaddy** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Certificate Chain</i></sub> | [View (source)](https://ssl-ccp.godaddy.com/repository?origin=CALLISTO) |
**Namecheap** <br /><sub>&nbsp;&nbsp;&nbsp;<i>Certificate Chain</i></sub> | [View (source)](https://www.namecheap.com/support/knowledgebase/article.aspx/9393/69/where-do-i-find-ssl-ca-bundle) |

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

* ###### reddit.com  |  "What application do you always install on your computer and recommend to everyone?"  |  https://www.reddit.com/r/AskReddit/comments/4g5sl1/what_application_do_you_always_install_on_your/

* ###### reddit.com  |  "[List] Essential Software for your Windows PC"  |  https://www.reddit.com/r/software/comments/8tx8w7/list_essential_software_for_your_windows_pc/

</p>
</details>

<hr />


<!-- ------------------------------------------------------------ -->

</ul>


<!-- ------------------------------------------------------------ -->