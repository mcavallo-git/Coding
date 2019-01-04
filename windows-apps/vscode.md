
# [Visual Studio Code](https://code.visualstudio.com/download)

***

### [VS-Code - Key Bindings (Hotkeys)]

##### [VSCode - Key Bindings Documentation] (https://code.visualstudio.com/docs/getstarted/keybindings)

##### [VSCode - Default Windows Key Bindings](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf)

*** 

###  [Bracket Matching](https://code.visualstudio.com/docs/editor/editingevolved#_bracket-matching

##### Jump to the matching bracket for selected   {  or  }

##### Default Hotkey:   Ctrl + Shift + \

***



# Tutorial: Settings Sync (VS-Code Extension)
***

### Prep - Creating a GitHub "Personal Access Token"
-> If you haven't already, head on over to github.com and create a specifically-named "Personal Access Token"...
--> URL: https://github.com/settings/tokens
--> Token description: "code-settings-sync"
--> Select scopes: (only select "gist")
---> YOU WILL ONLY BE SHOWN THE TOKEN ONCE - make sure to save your new Personal Access Token in a static location such as LastPass, etc. (token will have a green-background)
***
##### Prep your [GitHub Personal Access Token] by copying it into the clipboard
***
##### Use VS-Code extension "Settings Sync" to sync your settings via your GitHub Personal Access Token
--> Install extension "Settings Sync", by Shan Khan -> reload VS Code after installation completes
---> hit Ctrl+Shift+P -> Type "sync"
----> Select "Sync: Advanced Options" (with down->enter or left-click)
----> Select "Sync: Edit Extension Local Settings" (with down->enter or left-click
-----> The file "syncLocalSettings.json" should open, right click & select "Format Document"
------> Find ["token": ""] and paste your personal access token into token's value: ["token": "PASTE-PERSONAL-ACCESS-TOKEN-HERE"]
***
### Option[A]: You have NEVER synced VS-Code'ssettings via "Settings Sync" before - You must create a New Gist
--> If you haven't synced your VS-Code settings through the "Settings Sync" extension before, you will need to create a new Gist to Sync-to
---> WARNING: If you already have a Gist for "Settings Sync" on GitHub (check by following steps in Option B, Step 1/2), don't be lazy and create a new Gist ontop of your existing one, IT WILL BE A PAIN TO SEPARATE THEM LATER! Also you're not actually 'syncing' anything at that point, except each workstation to their separate cloud (not all together, aka 'synced')
----> If you definitely haven't created a Gist yet, perform the first-time sync to create a new Gist by pressing Shift+Alt+U, which will upload your current settings into a newly-created gist
***
### Option [B]: You HAVE synced VS-Code's settings via "Settings Sync" at least once before - You must obtain your previous Gist-ID
##### [Step 1/2]: Obtain Gist-ID
--> If you are unsure of your existing Gist's ID...
---> Browse to https://gist.github.com & select "See all of your gists" (top-right)
----> Click "cloudSettings" to open your Gist (if none shows up, check any other GitHub account usernames, etc. for your Gist)
-----> Your Gist-ID can be found in the URL (top of browser) -> Syntax is: https://gist.github.com/[GITHUB_USER]/[GIST_ID]
###### [Step 2/2]: Download Gist-ID
-> Prep your Gist-ID by copying it onto the clipboard
--> Force a Gist-Download by pressing Shift+Alt+D
---> Paste your Gist-ID into VS-Code's top dropdown field (when asked for it)
***
