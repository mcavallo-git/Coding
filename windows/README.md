<!-- ------------------------------------------------------------ -->

***
## <u>Workstation Software</u>

App Name | Source 1 | Source A
--- | --- | ---
**Azure CLI** | [Download (source)](https://aka.ms/installazurecliwindows) |
**AirParrot** | [Download (mirror)](https://www.airsquirrels.com/airparrot/download/) |
**Classic Shell** | [Download (mirror-1)](https://www.softpedia.com/get/Desktop-Enhancements/Shell-Replacements/Classic-Shell.shtml) | [Download (mirror-2)](https://www.fosshub.com/Classic-Shell.html)
**Docker** <sub>*Desktop for Windows*</sub>  | [Download (source)](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe) |
**Cryptomator** | [Download (mirror-1)](https://cryptomator.org/downloads/#winDownload) |
**Effective File Search (EFS)** | [Download (mirror-1)](https://www.softpedia.com/get/System/File-Management/Effective-File-Search.shtml#download) | [Download (mirror-2)](https://effective-file-search.en.lo4d.com/download)
**Git** <sub>*Git SCM*</sub>  | [Download (source)](https://git-scm.com/downloads) |
**Git** <sub>*GitHub Desktop*</sub>  | [Download (source)](https://desktop.github.com) |
**Git** <sub>*Tortoise Git*</sub> | [Download (source)](https://tortoisegit.org/download) |
**Gpg4win** <sub>*GnuPG for Windows*</sub> | [Download (source)](https://www.gpg4win.org/thanks-for-download.html) |
**MobaXterm** | [Download (source)](https://mobaxterm.mobatek.net/download-home-edition.html) |
**Postman** | [Download (source)](https://www.getpostman.com/apps) |
**Reflector** | [Download (mirror)](https://www.airsquirrels.com/reflector) |
**Splashtop** | [Download (source)](https://www.splashtop.com/downloads) |
**Visual Studio Code (VS Code)** | [Download (source)](https://code.visualstudio.com/download) |
**YubiKey** <sub>*Manager*</sub> | [Download (source)](https://www.yubico.com/products/services-software/download/) |

***
### PowerShell

* **[PowerShell Core (Windows/Linux)](https://github.com/PowerShell/PowerShell/releases)**
* **[Cloud Management - AWS CLI](https://aws.amazon.com/powershell)**
* **[Cloud Management - Azure CLI](https://www.powershellgallery.com/packages/az)**

***
#### External Link: [Reddit.com, "What application do you always install on your computer and recommend to everyone?"](https://www.reddit.com/r/AskReddit/comments/4g5sl1/what_application_do_you_always_install_on_your/)

***
#### External Link: [Reddit.com, "[List] Essential Software for your Windows PC"](https://www.reddit.com/r/software/comments/8tx8w7/list_essential_software_for_your_windows_pc/)

<!-- ------------------------------------------------------------ -->

***
## <u>Paths</u>

***
#### Pinned Items, Taskbar (Win10)
###### ```%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar```

***
#### Pinned-Items, Classic Shell (Start-Menu App)
###### ```%USERPROFILE%\AppData\Roaming\ClassicShell\Pinned```

***
#### Startup Items (All Users)
###### ```%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\StartUp```

***
#### Startup Items (My User)
###### ```%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup```

<!-- ------------------------------------------------------------ -->

***
## <u>Workstation Setup (Windows)</u>

***
### Taskbar (Bottom Bar)
##### Unpin Edge, Unpin MS-Store, Hide Cortana, Hide People, Hide Ink, Hide Task-View Button

***
### Notifications (Bottom Right)
##### Right Click ##### Don't show number of new notifications

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


<!-- ------------------------------------------------------------ -->
***