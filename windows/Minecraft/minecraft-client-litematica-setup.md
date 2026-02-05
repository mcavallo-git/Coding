# Minecraft Client Mods Setup

***
<!-- ------------------------------------------------------------ -->

# Fabric (Mod Loader) - Installation

- ### Fabric (Mod loader for Minecraft)
  - [Download](https://fabricmc.net/) | [Install Guide](https://wiki.fabricmc.net/install)
  - Mods directory: `%APPDATA%\.minecraft\mods`

- ### Fabric API (Mod, Prerequisite for many mods, including Litematica)
  - [Download](http://github.com/FabricMC/fabric-api/releases/latest) | [Source Code](https://github.com/FabricMC/fabric-api)
    - Place downloaded `.jar` file into Fabric mods directory at `%APPDATA%\.minecraft\mods`

***
<!-- ------------------------------------------------------------ -->

# Litematica (Mod) - Installation

- Description: Used for simplified creation of downloaded community schematics

- ### MaLiLib (Mod, Prerequisite for Litematica)
  - [Download](https://modrinth.com/mod/malilib) | [Source Code](https://github.com/maruohon/malilib/)
    - Place downloaded `.jar` file into Fabric mods directory at `%APPDATA%\.minecraft\mods`

- ### Litematica (Mod)
  - [Download](https://modrinth.com/mod/litematica) | [Source Code](https://github.com/maruohon/litematica/)
    - Place downloaded `.jar` file into Fabric mods directory at `%APPDATA%\.minecraft\mods`

- ### Litematica Printer (Mod)
  - [Download](https://modrinth.com/mod/litematica-printer) | [Source Code](https://github.com/aleksilassila/litematica-printer)
    - Place downloaded `.jar` file into Fabric mods directory at `%APPDATA%\.minecraft\mods`

# Litematica (Mod) - Setup/Usage

- ### Download Schematic
  - Download schematics from [Minecraft Schematics](https://www.minecraft-schematics.com/search/)
    - ⚠️ Watch out for "Non-free" (paid) schematics when searching
    - Place downloaded `.schem` file into Fabric mods directory at `%APPDATA%\.minecraft\schematics`

- ### Import Schematic
  - Run Minecraft using Fabric
    - Press "M" to open Litematica, then select "Schematic Manager"
    - Select the schematic to import, then select "Import"
      - This will convert the `.schem` file to a `.litematic` file
        - `.litematic` files show with a "L" on Litematic schema selection screens - always use those

- ### Load Schematic
  - Run Minecraft using Fabric
    - Press "M" to open Litematica, then select "Load Schematics"
    - Select the schematic to load, then select "Load Schematic"

- ### View Schematic's Material List
  - Run Minecraft using Fabric
    - Press "M" to open Litematica, then select "Load Schematics"
    - Select the schematic to view the materials of, then select "Material List"

- ### Schematic Placement
  - Run Minecraft using Fabric
    - Press "M" to open Litematica, then select "Schematic Placements"
    - On the far right of the loaded schematic, press "Configure"
    - On the far right, under "Placement Origin", select the "+/-" buttons to move the schematic to the desired X/Y/Z location
      - Left-clicking "+/-" increases it
      - Right-clicking "+/-" decreases it

- ### Replace parts in a schematic
  - Run Minecraft using Fabric
    - Hold a stick in your hand
      - Press CTRL + Mouse-Scroll until "Mode [9/9]: Edit Schematic" is shown at the bottom left
    - Press "M" to open Litematica, then select "Configuration Menu"
      - Set a hotkey for "schematicEditReplaceall"
    - Look at the block in the schematic to replace, hold the desired replacment block in your hand, then hold the "schematicEditReplaceall" hotkey and right click to replace all target blocks in schematic with held block

- ### EasyPlace Setup
  - Run Minecraft using Fabric
    - Press "M" to open Litematica, then select "Configuration Menu"
      - Select "Hotkeys" at the top
        - Next to "easyPlaceToggle", press the "NONE" button to set the hotkey
          - Set the hotkey to "PERIOD" (the "." key)

- ### Toggle Printing (auto-place blocks near you)
  - Note: Printing places templated stairs in the correct orientation ✔️
  - Run Minecraft using Fabric
    - Press "M" to open Litematica, then select "Configuration Menu"
      - Select "Hotkeys" at the top
        - Next to "togglePrintingMode", press the "NONE" button to set the hotkey
          - Set the hotkey to "GRAVE_ACCENT" (the "`" key to the left of "1" and above "Tab")



***
<!-- ------------------------------------------------------------ -->

# Xaero's Minimap (Mod) - Installation

- Description: Used for simplified creation of downloaded community schematics

- ### MaLiLib (Mod, Prerequisite for Litematica)
  - [Download](https://modrinth.com/mod/xaeros-minimap) | [Source Code](https://github.com/rfresh2/XaeroPlus)
    - Place downloaded `.jar` file into Fabric mods directory at `%APPDATA%\.minecraft\mods`

# Xaero's Minimap (Mod) - Setup/Usage

- ### Hotkeys
  - View/Set Hotkeys
    - Press "ESC" > "Options..." > "Controls" > "Key Binds..." > Scroll down to "Xaero's Minimap"
      - Set "Toggle In-World Waypoints" to "Z"
      - Set "Toggle Minimap" to "Z"
  - Open Settings
    - Press "Y" to open Xaero Minimap Settings (Default Hotkey)
  - Create a waypoint
    - Press "B" to create a waypoint (Default Hotkey)
  - View Waypoints
    - Press "U" to open waypoints list (Default Hotkey)


***
<!-- ------------------------------------------------------------ -->
