<!-- ------------------------------------------------------------ ---

This file (on GitHub):

	https://github.com/mcavallo-git/Coding/tree/master/windows#workstation-installs

--- ------------------------------------------------------------- -->

<!-- ------------------------------------------------------------ -->

<h3>Windows - Essential Resources</h3>

Name | Option A | Option B
--- | --- | ---
**Group Policy IDs, etc.** <sub><i>'Group Policy Settings Reference for Windows and Windows Server'</i></sub> | [Download (source)](https://www.microsoft.com/en-us/download/confirmation.aspx?id=25250) |

<hr />


<!-- ------------------------------------------------------------ -->

<h3>Windows - Notable Filepaths</h3>
<details><summary><i>Show/Hide Content</i></summary>
<p>

Purpose | Filepath
--- | ---
**Pinned Items** <sub>*Win10 Taskbar (Stock)*</sub> | ```%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar```
**Pinned Items** <sub>*Classic Shell (App)*</sub> | ```%USERPROFILE%\AppData\Roaming\ClassicShell\Pinned```
**Startup Items** <sub>*Win10 (Current User)*</sub> | ```%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup```
**Startup Items** <sub>*Win10 (All Users)*</sub> | ```%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\StartUp```
**Windows Sounds** <sub>*.wav files (for the most part)*</sub> | ```%SYSTEMROOT%\Media```

</p>
</details>

<hr />


<!-- ------------------------------------------------------------ -->

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

<hr />


<!-- ------------------------------------------------------------ -->

