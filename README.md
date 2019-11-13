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

Name | Option A | Option B
--- | --- | ---
**AirParrot** <sub><i>Airplay Client for Windows</i></sub> | [Download (mirror)](https://www.airsquirrels.com/airparrot/download/) |
**AutoHotkey (AHK)** <sub><i>Keyboard Macro Program</i></sub> | [Download (source)](https://www.autohotkey.com/download/ahk-install.exe) |
**Classic Shell** <sub><i>Win7 Style Start-Menu</i></sub> | [Download (mirror-1)](https://www.softpedia.com/get/Desktop-Enhancements/Shell-Replacements/Classic-Shell.shtml) | [Download (mirror-2)](https://www.fosshub.com/Classic-Shell.html)
**Cryptomator** <sub><i>Client-Side Cloud-Encryption</i></sub> | [Download (mirror-1)](https://cryptomator.org/downloads/#winDownload) |
**Docker Desktop (for Windows)** <sub><i>Containers</i></sub> | [Download (source)](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe) |
**Effective File Search (EFS)** <sub><i>Search tool</i></sub> | [Download (mirror-1)](https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download) | [Download (mirror-2)](https://effective-file-search.en.lo4d.com/download)
**FoxIt PhantomPDF** <sub><i>PDF Editor (Paid)</i></sub> | [Download (source)](https://www.foxitsoftware.com/downloads/#Foxit-PhantomPDF-Standard/) |
**Git SCM** <sub><i>CLI Integration</i></sub> | [Download (source)](https://git-scm.com/download/win) |
**GitHub Desktop** <sub><i>Git Daily Driver</i></sub> | [Download (source)](https://desktop.github.com) |
**Gpg4win** <sub><i>GnuPG for Windows</i></sub> | [Download (source)](https://www.gpg4win.org/thanks-for-download.html) |
**Handbrake** <sub><i>Media Transcoder</i></sub> | [Download (source)](https://handbrake.fr/) |
**ImageMagick** <sub><i>Image Editing via Command-Line</i></sub> | [Download (source)](https://www.imagemagick.org/script/download.php#windows) |
**KDiff3** <sub><i>Text Difference Analyzer</i></sub> | [Download (source)](https://sourceforge.net/projects/kdiff3/) |
**LastPass** <sub><i>Password Manager</i></sub> | [Download (source)](https://lastpass.com/download) |
**Microsoft Office 365** <sub><i>Outlook, Word, Excel, PowerPoint, etc.</i></sub> | [Login to Office365](https://www.office.com/) → Select "Install Office" |
**MobaXterm** <sub><i>XServer for Windows</i></sub> | [Download (source)](https://mobaxterm.mobatek.net/download-home-edition.html) |
**Ninite Package Management** <sub><i>Installs: 7-Zip + Audacity + Chrome + ClassicShell + DropBox + FileZilla + FireFox + GreenShot + HandBrake + NotePad++ + Paint.Net + VLC + VS-Code + WinDirStat</i></sub> | [Download (source)](https://ninite.com/7zip-audacity-chrome-classicstart-dropbox-filezilla-firefox-greenshot-handbrake-notepadplusplus-paint.net-vlc-vscode-windirstat/) |
**Notepad++** <sub><i>Text and Source-Code Editor</i></sub> | [Download (source)](https://notepad-plus-plus.org/downloads/) |
**Notepad Replacer** <sub><i>Redirects NotePad.exe to VSCode, NP++, etc.</i></sub> | [Download (source)](https://www.binaryfortress.com/NotepadReplacer/Download/) |
**Reflector** <sub><i>Airplay Server for Windows</i></sub> | [Download (mirror)](https://www.airsquirrels.com/reflector) |
**Remote Mouse** <sub><i>Remote Mouse & Keyboard control via Phone</i></sub> | [Download (source)](https://www.remotemouse.net/downloads/RemoteMouse.exe) |
**Royal TS** <sub><i>Remote Management Soln.</i></sub> | [Download (mirror)](https://www.royalapps.com/ts/win/download) |
**Splashtop Personal** <sub><i>Remote Access Client</i></sub> | [Download (source)](https://www.splashtop.com/downloadstart?product=stp&platform=windows-client) |
**Splashtop Streamer** <sub><i>Remote Access Host/Server</i></sub> | [Download (source)](https://www.splashtop.com/downloadstart?platform=windows) |
**Teamviewer** <sub><i>Remote Access Host/Server</i></sub> | [Download (source)](https://www.teamviewer.com/en/download/windows/) |
**Tortoise Git** <sub><i>Git Merge Conflict Resolver</i></sub> | [Download (source)](https://tortoisegit.org/download) |
**Visual Studio Code** <sub><i>VS Code - Code Editor</i></sub> | [Download (source)](https://code.visualstudio.com/download) |
**WinDirStat** <sub><i>Disk Usage Analyzer</i></sub> | [Download (source)](https://windirstat.net/download.html) | [Download (mirror)](https://www.fosshub.com/WinDirStat.html) |
**Windows 10** <sub><i>Creates Installation Media</i></sub> | [Download (source)](https://www.microsoft.com/en-us/software-download/windows10) |

<hr />

<!-- ------------------------------------------------------------ -->
<h3 id="software-platform">Windows Software - Cross-Platform Tools</h3>

Name | Option A | Option B
--- | --- | ---
**AWS CLI (PowerShell)** | [Download (source)](https://aws.amazon.com/powershell) or [Download (gallery)](https://www.powershellgallery.com/packages/AWSPowerShell) | [Docs](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)
**Azure CLI (PowerShell)** | [Download (source)](https://aka.ms/installazurecliwindows) or [Download (gallery)](https://www.powershellgallery.com/packages/az) | [Docs](https://docs.microsoft.com/en-us/cli/azure/reference-index)
**Java SE** <sub><i>(Java Standard Edition, Win10)</i></sub> | [Download (source)](https://www.java.com/en/download/win10.jsp) |
**Java JDK, JRE** <sub><i>(Java Development-Kit, Runtime-Environment, Win10)</i></sub> | [Download (source)](https://www.oracle.com/technetwork/java/javase/downloads/index.html) |
**PowerShell Core** <sub><i>Standard Edition</i></sub> | [Download (github)](https://github.com/PowerShell/PowerShell#get-powershell) | [Download (microsoft)](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux) |
**Ubuntu 16.04 LTS** <sub><i>WSL (Windows Subsystem for Linux)</i></sub> | [Download (source)](https://www.microsoft.com/store/productId/9PJN388HP8C9) |
**Ubuntu 18.04 LTS** <sub><i>WSL (Windows Subsystem for Linux)</i></sub> | [Download (source)](https://www.microsoft.com/store/productId/9N9TNGVNDL3Q) |

<hr />


<!-- ------------------------------------------------------------ -->
<h3>Windows Software - Benchmarking</h3>

Name | Option A | Option B
--- | --- | ---
**CoreTemp** <sub><i>CPU Temperature Logging</i></sub> | [Download (source)](https://www.alcpu.com/CoreTemp/) |
**CrystalDiskInfo** <sub><i>Disk Info</i></sub> | [Download (source)](https://crystalmark.info/en/download/) |
**CrystalDiskMark** <sub><i>Disk Benchmarking</i></sub> | [Download (source)](https://crystalmark.info/en/download/) |
**UNIGINE Benchmarks** <sub><i>GPU Benchmarking</i></sub> | [Download (source)](https://benchmark.unigine.com/) |

<hr />


<!-- ------------------------------------------------------------ -->
<h3>Windows Software - Communication</h3>

Name | Option A | Option B
--- | --- | ---
**Discord** <sub><i>VoIP & Digital Distribution</i></sub> | [Download (source)](https://discordapp.com/download) |
**Nicrosoft Teams** <sub><i>Shared Workspace for Chat, App, and File-Sharing</i></sub> | [Download (source)](https://products.office.com/en-us/microsoft-teams/download-app) |
**Skype** <sub><i>Free Video & Voice Calls</i></sub> | [Download (source)](https://www.skype.com/en/get-skype/) |
**Skype for Business** <sub><i>Microsoft service will be retired after [ July 31, 2021 ]</i></sub> | [Download (source)](https://products.office.com/en-us/skype-for-business/download-app) |


<!-- ------------------------------------------------------------ -->
<h3>Windows Software - Entertainment</h3>

Name | Option A | Option B
--- | --- | ---
**Lockscreen as wallpaper** <sub><i>Mirrors LockScreen Background onto Desktop</i></sub> | [Download (source)](https://www.microsoft.com/store/productId/9NBLGGH4WR7C) |
**Spotify** <sub><i>Music Streaming</i></sub> | [Download (source)](https://www.spotify.com/us/download/other/) |
**Twitch App** <sub><i>Live-Streaming & Mod Management</i></sub> | [Download (source)](https://twitch.tv/downloads) |

<hr />


<!-- ------------------------------------------------------------ -->
<h3 id="hardware-installs">Windows Software - Controllers/Drivers/Utilities & Other</h3>

Name | Option A | Option B
--- | --- | ---
**ASUS Aura Sync** <sub><i>RGB Controller</i></sub> | [Download (source)](https://www.asus.com/campaign/aura/us/download.html) |
**balenaEtcher** <sub><i>Drive Imaging Utility (.iso & .img, especially)</i></sub> | [Download (source)](https://www.balena.io/etcher/) |
**Corsair iCue** <sub><i>RGB Controller (+ Aura API)</i></sub> | [Download (source)](https://www.corsair.com/us/en/downloads) |
**Easy2Boot** <sub><i>USB-drive multiboot software</i></sub> | [Download (source)](https://www.fosshub.com/Easy2Boot.html) |
**Intel® DSA** <sub><i>Intel® Driver & Support Assistant</i></sub> | [Download (source)](https://www.intel.com/content/www/us/en/support/detect.html) |
**LG OnScreen Control** <sub><i>Driver + Software for [ LG 34UC88-B ] Display/Monitor</i></sub> | [Drivers & Software](https://www.lg.com/uk/support/support-product/lg-34UC88-B) | [Download (source)](http://gscs-b2c.lge.com/downloadFile?fileId=L6Ns5WE6jhENU8Q3PwSyw) |
**Logitech G Hub** <sub><i>Keyboard/Mouse RGB (+3rd Party Tools)</i></sub> | [Download (source)](https://support.logi.com/hc/en-us/articles/360025298133) |
**Logitech SetPoint** <sub><i>Mouse/Keyboard Hotkey Manager</i></sub> | [Download (source)](http://support.logitech.com/software/setpoint) |
**RMPrepUSB** <sub><i>Allows users to easily and quickly 'roll their own' multiboot USB drive</i></sub> | [Download (source)](https://www.fosshub.com/RMPrepUSB.html) |
**VMware (ESXi Server Management)** <sub><i>VMware vSphere, VMware Workstation, VMware Fusion, VMware Player, etc.</i></sub> | [Download (source)](https://my.vmware.com/web/vmware/downloads) |
**Yubico Tools** <sub><i>Security Key Configuration</i></sub> | [Download (source)](https://www.yubico.com/products/services-software/download/) |
**winsw: Windows service wrapper** <sub><i>(in less restrictive license)</i></sub> | [Config/Download (GitHub)](https://github.com/kohsuke/winsw/) |

<hr />


<!-- ------------------------------------------------------------ -->
<h3>Windows Software - Troubleshooting Utilities</h3>

Name | Option A | Option B
--- | --- | ---
**BlueScreenView** <sub><i>by Nirsoft</i></sub> | [Download (source)](https://www.nirsoft.net/utils/blue_screen_view.html) |
**digicert Certificate Utility for Windows** <sub><i>Certificate Management & Troubleshooting Tool</i></sub> | [Download (source)](https://www.digicert.com/util/) |
**DDU (Display Driver Uninstaller)** <sub><i>Removes ALL graphics drivers</i></sub> | [Download (source)](https://www.guru3d.com/files-details/display-driver-uninstaller-download.html) |
**FindLinks** <sub><i>by Sysinternals</i></sub> | [Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/findlinks) |
**Postman** <sub><i>'API-Development Collaboration Platform' - HTTP [ GET/OPTION/POST/etc. ] Request Debugger</i></sub> | [Download (mirror)](https://www.getpostman.com/downloads) |
**Process Explorer** <sub><i>by Sysinternals</i></sub> | [Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer) |
**TCPView** <sub><i>by Sysinternals</i></sub> | [Download (source)](https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview) |
**WinTail** <sub><i>Tail for Windows</i></sub> | [Download (source)](https://sourceforge.net/projects/wintail/) |
**WakeMeOnLan** <sub><i>by Nirsoft</i></sub> | [Download (source)](https://www.nirsoft.net/utils/wake_on_lan.html) |
**ProduKey** <sub><i>by Nirsoft (Recover lost Windows product key (CD-Key) and Office 2003/2007 product key)</i></sub> | [Download (source)](https://www.nirsoft.net/utils/product_cd_key_viewer.html) |

<hr />

<!-- ------------------------------------------------------------ -->
<h3>Linux/WSL Software - Tools & Utilities</h3>

Name | Option A | Option B
--- | --- | ---
**Docker** <sub><i>Linux LXC Containers</i></sub> | [View (source)](https://get.docker.com) |
**Jenkins** <sub><i>CI/CD Server</i></sub> | [View (source)](https://jenkins.io) |

<hr />

<!-- ------------------------------------------------------------ -->
<h3>Web-Based Services - Tools & Utilities</h3>

Name | Option A | Option B
--- | --- | ---
**digicert SSL Tools** <sub><i>Check Host SSL/TLS, Generate CSR, Check CSR, Searct CT Logs</i></sub> | [Download (source)](https://ssltools.digicert.com/checker/) |
**Qualys SSL Server Test** <sub><i>Powered by Qualys SSL Labs (Test SSL, TLS, HTTPS) </i></sub> | [Download (source)](https://www.ssllabs.com/ssltest/) |
**ImmuniWeb® SSLScan** <sub><i>Test SSL & TLS, Email TLS/STARTTLS | Comply with PCI DSS, HIPAA & NIST (SSL, TLS, HTTPS)</i></sub> | [Download (source)](https://www.htbridge.com/ssl/) |
**PCPartPicker** <sub><i>Component Pricing/Compatibility Comparisons</i></sub> | [View (source)](https://pcpartpicker.com/user/cavalol/saved/7Q2Mcf) |

<hr />

<!-- ------------------------------------------------------------ -->
<h3>DNS Certificate-Chains/Root-Certs</h3>

Name | Option A | Option B
--- | --- | ---
**GoDaddy** <sub><i>Certificate Chain</i></sub> | [View (source)](https://ssl-ccp.godaddy.com/repository?origin=CALLISTO) |
**Namecheap** <sub><i>Certificate Chain</i></sub> | [View (source)](https://www.namecheap.com/support/knowledgebase/article.aspx/9393/69/where-do-i-find-ssl-ca-bundle) |

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