<!-- https://github.com/mcavallo-git/Coding/blob/main/windows/HWiNFO64/HWiNFO64%20-%20Good%20Settings.md -->

***

# HWiNFO64 - Good Settings

***

### Install HWiNFO64
  - `HWiNFO64` (System Information Tool)
    - Download URL: https://www.hwinfo.com/download
      - <sub>Includes `RTSS (RivaTuner Statistics Server)`, a pre-packaged OSD (On-Screen Display) utility for viewing metrics in real time</sub>

***
### Install Fonts
  - `Fira Code`
    - Download URL:  https://github.com/tonsky/FiraCode/releases
      - Install `.ttf` font(s) via Right-Click > `Install for all users`
  - `Fira Sans`
    - Download URL:  https://fonts.google.com/specimen/Fira+Sans
      - Install `.ttf` font(s) via Right-Click > `Install for all users`

***

### Update HWiNFO64 Configuration
  - Close any running instances (including background instances) of `HWiNFO64`
    - Open file for editing: `C:\Program Files\HWiNFO64\HWiNFO64.INI`
      - Update with settings from: [HWiNFO64.INI](./HWiNFO64.INI)

***

### Update HWiNFO64 User Settings
  - Open `HWiNFO64 Sensors Settings`
    - Run `HWiNFO64.exe`
      - Open the `Sensors Status` page
        - Click the bottom-right `⚙️ (Configure Sensors)` button
  - Update `HWiNFO64 Sensor Settings`
    - Tab: `General`
      - Check `Minimize Graphs with Sensors Window`  (bottom left)
      - Check `Log all values for Report (consumes memory)`  (bottom left)
      - Click `Change Font`  (bottom right)
        - Set `Font` to `Fira Code`
        - Font style: `Regular`
        - Set `Size` to `14`   <-- After you apply changes, if the text in the sensors list is illegible, increase font size as needed
    - Tab: `System Tray`
      - Click sensor `CPU Die (average)` in the device list settings  (should be the top sensor under the `CPU [#0]: ...` device)
        - Check `Show in Tray`
        - Set `Truncate to:` to `2` (digits)
        - `Font`
          - Font: `Fira Sans`
          - Font style: `Regular`
          - Size: `14`
        - `Color`
          - Set `Background` to: { `Red`=`0`, `Green`=`0`, `Blue`=`0` }
          - Set `Text` to: { `Red`=`0`, `Green`=`255`, `Blue`=`255` }
      - Click sensor `GPU Temperature` in the device list settings  (!!SHORTCUT: Click anywhere in the scroll area, press the `G` key (on your keyboard))
        - Check `Show in Tray`
        - Set `Truncate to:` to `2` (digits)
        - `Font`
          - Font: `Fira Sans`
          - Font style: `Regular`
          - Size: `14`
        - `Color`
          - Set `Background` to: { `Red`=`0`, `Green`=`0`, `Blue`=`0` }
          - Set `Text` to: { `Red`=`168`, `Green`=`255`, `Blue`=`0` }
      - Click sensor `Drive Temperature` in the device list settings  (should be the top sensor under the `S.M.A.R.T.: ...` device)
        - Check `Show in Tray`
        - Set `Truncate to:` to `2` (digits)
        - `Font`
          - Font: `Fira Sans`
          - Font style: `Regular`
          - Size: `14`
        - `Color`
          - Set `Background` to: { `Red`=`0`, `Green`=`0`, `Blue`=`0` }
          - Set `Text` to: { `Red`=`255`, `Green`=`138`, `Blue`=`255` }
    - Tab: `OSD (RTSS)`
      - !! Set option(s) [ `Show value in OSD` to Checked ], [ `Show label in OSD` to Checked ], & [ `Use color:` to white (Red=`255`, Green=`255`, Blue=`255`) ] for each of the following sensors:
        - `GPU [#0]: ...`
          - `GPU Power (Total)`
          - `GPU Core Voltage`
          - `GPU Clock`
        - `RTSS`
          - `Framerate`

***

### HWiNFO64 Backups
  - Steps for: `Creating a backup of HWiNFO64 User Settings`
    - Run `HWiNFO64`
      - Right-click its icon in the system tray (bottom right)
        - Click `Settings`
          - Click tab `General / User Interface`
            -  Click `Backup User Settings`
              - Save the output (registry) file wherever you see fit (backup location, ideally)
              - The default backup filename is `HWiNFO64_settings.reg`
  - Steps for: `Restoring from a backup of HWiNFO64 User Settings`
    - Right-Click the `HWiNFO64_settings.reg` backup file & select `Merge` to restore the settings

***
