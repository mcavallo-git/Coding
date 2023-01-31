***

# HWiNFO64 - Good Settings

***

### Prerequisite Install(s)
  - `HWiNFO64` (System Information Tool)
    - Download URL: https://www.hwinfo.com/download
      - Note: Comes `RTSS (RivaTuner Statistics Server)`, a pre-packaged `OSD (On-Screen Display)` utility for viewing metrics in real time
  - `Fira Code`
    - Download URL:  https://fonts.google.com/specimen/Fira+Code
      - Install via Right-Click > `Install for all users`
  - `Fira Sans`
    - Download URL:  https://fonts.google.com/specimen/Fira+Sans
      - Install via Right-Click > `Install for all users`

***

### HWiNFO64 - Good Settings
  - Open `HWiNFO64.EXE` Settings
    - Locate the window titled `HWiNFO64 v_.__-____ Sensor Status` (with numbers where underscores are)
      - Click the cog in the bottom-right hand side of the sensors window --> `HWiNFO64 Sensor Settings` window opens 
    - Tab: `General`
      - Check `Minimize Graphs with Sensors Window`  (bottom left)
      - Check `Log all values for Report (consumes memory)`  (bottom left)
      - Click `Change Font`  (bottom right)
        - Set `Font` to `Fira Code`
        - Set `Font style` to `Regular`
        - Set `Size` to `14`   <-- After you apply changes, if the text in the sensors list is illegible, increase font size as needed
        - Click `OK` in the `Font` window --> window closes
    - Tab: `System Tray`
      - Click sensor `GPU Temperature` in the device list settings  (!!SHORTCUT: Click anywhere in the scroll area, press the `G` key (on your keyboard))
        - Check `Show in Tray`
        - Set `Truncate to:` to `2` (digits)
        - Click the button next to `Font:` to set the font
          - Set `Font` to `Fira Sans`
          - Set `Font style` to `Regular`
          - Set `Size` to `14` (type it into field, manually)
          - Click `OK` in the `Font` window  --> window closes
        - Click the colored square to the right of text `Background:`  --> `Color` window opens 
          - Click `Define Custom Colors >>`
            - Set values { `Red`=`0`, `Green`=`0`, `Blue`=`0` }
            - Click `OK` in the `Color` window --> window closes
        - Click the colored square to the right of text `Text:`  --> `Color` window opens 
          - Click `Define Custom Colors >>`
            - Set values { `Red`=`168`, `Green`=`255`, `Blue`=`0` }
            - Click `OK` in the `Color` window --> window closes
      - Click sensor `CPU Die (average)` in the device list settings  (should be the top sensor under the `CPU [#0]: ...` device)
        - Check `Show in Tray`
        - Set `Truncate to:` to `2` (digits)
        - Click the button next to `Font:` to set the font
          - Set `Font` to `Fira Sans`
          - Set `Font style` to `Regular`
          - Set `Size` to `14` (type it into field, manually)
          - Click `OK` in the `Font` window  --> window closes
        - Click the colored square to the right of text `Background:`  --> `Color` window opens 
          - Click `Define Custom Colors >>`
            - Set values { `Red`=`0`, `Green`=`0`, `Blue`=`0` }
            - Click `OK` in the `Color` window --> window closes
        - Click the colored square to the right of text `Text:`  --> `Color` window opens 
          - Click `Define Custom Colors >>`
            - Set values { `Red`=`0`, `Green`=`255`, `Blue`=`255` }
            - Click `OK` in the `Color` window --> window closes
    - Tab: `OSD (RTSS)`
      - !! Set option(s) [ `Show value in OSD` to Checked ], [ `Show label in OSD` to Checked ], & [ `Use color:` to white (Red=`255`, Green=`255`, Blue=`255`) ] for each of the following sensors:
        - `GPU [#0]: ...`
          - `GPU Power (Total)`
          - `GPU Core Voltage`
          - `GPU Clock`
        - `RTSS`
          - `Framerate`

***

### HWiNFO64 - Backing-up & restoring user settings
- Creating a backup
  - Open HWiNFO64
    - Right-click its icon in the system tray (bottom right)
      - Click `Settings` --> Popup window `HWiNFO64 Settings` opens
        - Click tab `General / User Interface`
          -  Click `Backup User Settings`
            - Save the output (registry) file wherever you see fit (backup location, ideally)
            - The default backup filename is `HWiNFO64_settings.reg`
- Restoring from a backup
  - Right-Click the `HWiNFO64_settings.reg` backup file & select `Merge` to restore the settings

***