# Setting up Minecraft Client w/ Litematica for simplified Schematic creation


***
<!-- ------------------------------------------------------------ -->

# Installation

- ### Fabric (Mod loader for Minecraft)
  - [Download](https://fabricmc.net/) | [Install Guide](https://wiki.fabricmc.net/install)
  - Mods directory: `%APPDATA%\.minecraft\mods`

- ### Fabric API (Mod, Prerequisite for Litematica)
  - [Download](http://github.com/FabricMC/fabric-api/releases/latest) | [Source Code](https://github.com/FabricMC/fabric-api)
    - Place downloaded `.jar` file into Fabric mods directory at `%APPDATA%\.minecraft\mods`

- ### MaLiLib (Mod, Prerequisite for Litematica)
  - [Download](https://modrinth.com/mod/malilib) | [Source Code](https://github.com/maruohon/malilib/)
    - Place downloaded `.jar` file into Fabric mods directory at `%APPDATA%\.minecraft\mods`

- ### Litematica (Mod)
  - [Download](https://modrinth.com/mod/litematica) | [Source Code](https://github.com/maruohon/litematica/)
    - Place downloaded `.jar` file into Fabric mods directory at `%APPDATA%\.minecraft\mods`

***
<!-- ------------------------------------------------------------ -->

# Setup

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


***
<!-- ------------------------------------------------------------ -->
