<!-- ------------------------------------------------------------ ---

This file (on GitHub):

	https://github.com/mcavallo-git/Coding/tree/master/windows#workstation-installs

--- ------------------------------------------------------------- -->

***
<h3 id="workstation-installs">Workstation Installs (Windows)</h3>
<!-- <details><summary><i>Show/Hide Content</i></summary> -->
<!-- <p> -->

Name | Option A | Option B
--- | --- | ---
**AirParrot** <sub>*Windows Airplay Client*</sub> | [Download (mirror)](https://www.airsquirrels.com/airparrot/download/) |
**Classic Shell** <sub>*Win7 Style Start-Menu*</sub> | [Download (mirror-1)](https://www.softpedia.com/get/Desktop-Enhancements/Shell-Replacements/Classic-Shell.shtml) | [Download (mirror-2)](https://www.fosshub.com/Classic-Shell.html)
**Docker Desktop for Windows** <sub>*Containers*</sub> | [Download (source)](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe) |
**Cryptomator** <sub>*Client-Side Cloud-Encryption*</sub> | [Download (mirror-1)](https://cryptomator.org/downloads/#winDownload) |
**Effective File Search (EFS)** <sub>*Search tool*</sub> | [Download (mirror-1)](https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download) | [Download (mirror-2)](https://effective-file-search.en.lo4d.com/download)
**Git - Git SCM** <sub>*Git Backend Requirement*</sub> | [Download (source)](https://git-scm.com/downloads) |
**Git - GitHub Desktop** <sub>*Git Daily Driver*</sub> | [Download (source)](https://desktop.github.com) |
**Git - Tortoise Git** <sub>*Git Merge Conflict Resolver*</sub> | [Download (source)](https://tortoisegit.org/download) |
**Gpg4win** <sub>*GnuPG for Windows*</sub> | [Download (source)](https://www.gpg4win.org/thanks-for-download.html) |
**Handbrake** <sub>*Media Transcoder*</sub> | [Download (source)](https://handbrake.fr/) |
**MobaXterm** <sub>*XServer for Windows*</sub> | [Download (source)](https://mobaxterm.mobatek.net/download-home-edition.html) |
**Reflector** <sub>*Windows Airplay Server*</sub> | [Download (mirror)](https://www.airsquirrels.com/reflector) |
**Remote Mouse** <sub>*Phone &rarr; Mouse & Keyboard*</sub> | [Download (source)](https://www.remotemouse.net/downloads/RemoteMouse.exe) |
**Royal TS** <sub>*Remote Management Soln.*</sub> | [Download (mirror)](https://www.royalapps.com/ts/win/download) |
**Splashtop** <sub>*Remote Desktop/Support*</sub> | [Download (source)](https://www.splashtop.com/downloads) |
**Visual Studio Code** <sub>*VS Code - Code Editor*</sub> | [Download (source)](https://code.visualstudio.com/download) |
**WinDirStat** <sub>*Disk Usage Analyzer*</sub> | [Download (source)](https://windirstat.net/download.html) | [Download (mirror)](https://www.fosshub.com/WinDirStat.html) |
**Yubico Tools** <sub>*Security Key Configuration*</sub> | [Download (source)](https://www.yubico.com/products/services-software/download/) |

<!-- </p> -->
<!-- </details> -->

<!-- ------------------------------------------------------------ -->

***
<h3>DevOps Tools & Cmdlets</h3>
<details><summary><i>Show/Hide Content</i></summary>
<p>

<h2>Cloud Management Cmdlets</h2>

Name | Option A | Option B | Docs
--- | --- | --- | ---
**AWS CLI (PowerShell)** | [Source](https://aws.amazon.com/powershell) | [Gallery](https://www.powershellgallery.com/packages/AWSPowerShell) | [Docs](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)
**Azure CLI (PowerShell)** | [Source](https://aka.ms/installazurecliwindows) | [Gallery](https://www.powershellgallery.com/packages/az) | [Docs](https://docs.microsoft.com/en-us/cli/azure/reference-index)

***
<h2>Cross-Platform Languages (Install guides)</h2>

Name | Option A | Option B
--- | --- | ---
**PowerShell Core** | [GitHub](https://github.com/PowerShell/PowerShell#get-powershell) | [Microsoft](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux) |

</p>
</details>

<!-- ------------------------------------------------------------ -->

***
<h3>Notable Filepaths (Windows)</h3>
<details><summary><i>Show/Hide Content</i></summary>
<p>

Purpose | Filepath
--- | ---
**Pinned Items** <sub>*Win10 Taskbar (Stock)*</sub> | ```%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar```
**Pinned Items** <sub>*Classic Shell (App)*</sub> | ```%USERPROFILE%\AppData\Roaming\ClassicShell\Pinned```
**Startup Items** <sub>*Win10 (Current User)*</sub> | ```%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup```
**Startup Items** <sub>*Win10 (All Users)*</sub> | ```%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\StartUp```

</p>
</details>

<!-- ------------------------------------------------------------ -->

***
<h3>Productivity Tweaks (Windows)</h3>
<details><summary><i>Show/Hide Content</i></summary>
<p>

### Taskbar (Bottom Bar)
##### Unpin Edge, Unpin MS-Store, Hide Cortana, Hide People, Hide Ink, Hide Task-View Button

***
### Notifications (Bottom Right)
##### Right Click &rarr; Don't show number of new notifications

***
### Put Recycle-Bin on Start-Menu, Remove from Desktop
##### Drag & drop the Recycle Bin from the Desktop into the Start Menu -> Right-click & rename the new shortcut from "Recycle Bin - Shortcut" to "Recycle Bin"
##### Start Menu -> type "desktop icon" -> Select "Themes and Related Settings" -> On the right, select "desktop icon settings" -> uncheck "Recycle Bin" -> Hit "Ok"

***
### Show Hidden Files/Folders, Show File Extensions
##### Start Menu -> type "hidd" -> select "Show hidden files and folders"
###### Enable "Show hidden files and folders
###### Disable "Hide empty drives"
###### Disable "Hide extensions for known file types"
###### Enable "Show libraries" (bottom)
##### Select tab "General" (top)
###### Disable "Show recently used files in Quick Access" (bottom)
###### Disable "Show frequently used folders in Quick Access" (bottom)

***
### Log-into Microsoft Account (personal) to perform ongoing syncs of settings (unless you have a GPO from Office365 Work/School account locking it down)
##### Start Menu -> type "sync" -> select "Sync your settings" -> turn on "Sync settings"

***
### Turn off Notifications
##### Start Menu -> type "notif" -> select "Notifications & action settings" -> disable everything on the first page

***
### Change Power Settings
##### Start Menu -> type "power" -> select "Power & sleep"
##### set "Screen" to turn off after 30 min/30 min
##### set "Sleep" on battery to 1 hour / Never for plugged-in
##### click "additional power settings" (right side) -> "change plan settings" -> "change advanced power settings"
###### "Hard disk" -> "Turn off hard disk after" to 0/0 (Never/Never)
###### "Sleep" -> "Hibernate after" -> 0/0 (Never/Never)
###### "Graphics" -> "Plugged in" -> "Maximum Performance"
###### "Power buttons and lid" -> "lid close action" -> "do nothing" -> power/sleep button -> "sleep"
###### "Processor power management" -> "Maximum processor state" -> 99% / 99% (note: intentionally disabling hyperthreading)
###### select "Ok" 

***
### Remove Recent Items
##### Start Menu -> type "recent" -> select "Show recently opened items in Jump Lists on Start or on the taskbar" -> disable everything on the first page

***
### Enable ClearType
##### Start Menu -> type "clear" -> select "Adjust ClearType text" -> Enable ClearType and click next through all the screens until complete

</p>
</details>

<!-- ------------------------------------------------------------ -->

***
<h3>Citation(s)</h3>
<details><summary><i>Show/Hide Content</i></summary>
<p>

* ###### reddit.com  |  "What application do you always install on your computer and recommend to everyone?"  |  https://www.reddit.com/r/AskReddit/comments/4g5sl1/what_application_do_you_always_install_on_your/

* ###### reddit.com  |  "[List] Essential Software for your Windows PC"  |  https://www.reddit.com/r/software/comments/8tx8w7/list_essential_software_for_your_windows_pc/

</p>
</details>

<!-- ------------------------------------------------------------ -->
