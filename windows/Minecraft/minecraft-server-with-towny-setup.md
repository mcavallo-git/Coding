# Setting up Minecraft Server w/ Towny


***
<!-- ------------------------------------------------------------ -->


## DatHost (Server host)
  - Manage Server: https://dathost.net/minecraft-server-hosting
    - Server Type: `PaperMC` (Java Server Software (Towny-compatible))
      - Documentation: https://papermc.io/
  - Config updates (`server.properties`)
    ```shell
      enforce-secure-profile=false
      motd=Legendary Pyroz Server
      player-idle-timeout=0
      view-distance=32
    ```


## GeyserMC (lets Bedrock players connect to a Java server)
  - Download GeyserMC: https://geysermc.org/download
  - Installing GeyserMc: https://geysermc.org/wiki/geyser/setup/?platform=paper-spigot
  - FloodGate (lets Bedrock players connect without a Java account)
    - Download FloodGate: https://geysermc.org/download/?project=floodgate
    - Installing FloodGate: https://geysermc.org/wiki/floodgate/setup/
  - Config updates (`/plugins/Geyser-Spigot/config.yml`):
    ```yaml
      bedrock:
        clone-remote-port: true
      java:
        auth-type: floodgate
      motd:
        primary-motd: Legendary Pyroz Server
        secondary-motd: Legendary Pyroz Server
      gameplay:
        server-name: Legendary Pyroz Server
    ```


## Towny (lets players control regions)
  - Download Towny (Current Recommended Versions): https://github.com/TownyAdvanced/Towny?tab=readme-ov-file#current-recommended-versions
  - Installing Towny: https://github.com/TownyAdvanced/Towny/wiki/Installation
  - Config updates (`/plugins/Towny/settings/config.yml`):
    ```yaml
      economy:
        using_economy: 'false'
      unclaimed:
        unclaimed_zone_build: 'true'
        unclaimed_zone_destroy: 'true'
        unclaimed_zone_item_use: 'true'
        unclaimed_zone_switch: 'true'
      new_world_settings:
        pvp:
          world_pvp: 'false'
          war_allowed: 'false'
        jailing_enabled: 'false'
        plot_management:
          block_delete:  # Toggle manually via "/tw world toggle unclaimblockdelete"
            enabled: 'false'
            unclaim_delete: NONE
          mayor_plotblock_delete:
            enabled: 'false'
            mayor_plot_delete: NONE
          revert_on_unclaim:
            enabled: 'false'
          wild_revert_on_mob_explosion:
            enabled: 'false'
          wild_revert_on_block_explosion:
            enabled: 'false'
      global_town_settings:
        health_regen:
          speed: 2s
      default_perm_flags:
        town:
          default:
            pvp: 'false'
      claiming:
        town_block_ratio: '36'
        town_block_limit: '36'
        distance_rules:
          min_plot_distance_from_town_plot: '4'
          min_distance_from_town_homeblock: '4'
          min_distance_for_outpost_from_plot: '4'
      spawning:
        visualized_spawn_points_enabled: 'false'
        town_spawn:
          allow_town_spawn: 'false'
          allow_town_spawn_travel: 'false'
          allow_town_spawn_travel_nation: 'false'
          allow_town_spawn_travel_ally: 'false'
          spawning_cooldowns:
            town_spawn_cooldown_time: '604800'
            outpost_cooldown_time: '604800'
            nation_member_town_spawn_cooldown_time: '604800'
            nation_ally_town_spawn_cooldown_time: '604800'
            unaffiliated_town_spawn_cooldown_time: '604800'
        nation_spawn:
          allow_nation_spawn: 'false'
          allow_nation_spawn_travel: 'false'
          allow_nation_spawn_travel_ally: 'false'
      protection:
        switch_ids: ...,SADDLE  (append SADDLE to list)
        mob_types: ...,HappyGhast  (append HappyGhast to list)
      resident_settings:
        delete_old_residents:
          enable: 'false'
    ```
  - Config updates (`/plugins/Towny/settings/ChatConfig.yml`):
    ```yaml
      channel_formats:
        global: '{channelTag} {playername}&f:{msgcolour} {msg}'
        town: '{channelTag} {playername}&f:{msgcolour} {msg}'
        nation: '{channelTag} {playername}&f:{msgcolour} {msg}'
        alliance: '{channelTag} {playername}&f:{msgcolour} {msg}'
        default: '{channelTag} {playername}&f:{msgcolour} {msg}'
    ```


## DeathLocation (lets players see their death coordinates)
  - Download DeathLocation: https://github.com/Xitee1/DeathLocation
  - Config updates (`/plugins/DeathLocation/config.yml`):
    ```yaml
      types:
        chat-message: false
        actionbar: false
      message:
        append: true
        messageOther: ' &b(%x, %y, %z)'
    ```


***
<!-- ------------------------------------------------------------ -->
