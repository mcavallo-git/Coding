## HomeAssistant - Recorder - Only save history of specific entities (elongates SSD & Micro SD card lifespans)

***

- ### Configure recorder to store specific entity history, only
  - In HomeAssistant's `configuration.yaml`, under `recorder:`, specify an `include:` clause as detailed in the [`Recorder docs`](https://www.home-assistant.io/integrations/recorder/)
    - Example:
      ```yaml

      recorder:

        auto_purge: true  # (default: true) Automatically purge the database every night at 04:12 local time. Purging keeps the database from growing indefinitely, which takes up disk space and can make Home Assistant slow. If you disable auto_purge it is recommended that you create an automation to call the recorder.purge periodically.

        auto_repack: true  # (default: true) Automatically repack the database every second sunday after the auto purge. Without a repack, the database may not decrease in size even after purging, which takes up disk space and can make Home Assistant slow. If you disable auto_repack it is recommended that you create an automation to call the recorder.purge periodically. This flag has no effect if auto_purge is disabled.

        commit_interval: 10  # (default: 1) How often (in seconds) the events and state changes are committed to the database - use 30 for Raspberry Pi w/ SD card

        purge_keep_days: 1  # (default: 10) Specify the number of history days to keep in recorder database after a purge.

        include:
          domains:
            - binary_sensor
            - button
            - sensor
            - switch
            - update

        exclude:
          domains:
            - automation
            - weather
          entities:
            - sensor.hacs
          entity_globs:
            - sensor.*_electric_consum*
            - sensor.*_storage

      ```


***

- ### View all entities 
  - Note: Recorder saves history for *all* entities, by default
  - On your Home Assistant instance, go to `Developer Tools` > `TEMPLATE` > Paste the following into the `Template editor`:
    ```
    {% for state in states %}
      - {{ state.entity_id -}}
    {% endfor %}
    ```

- ### Troubleshoot SQLite3 Database Directly
  - Inspection queries by-table (to run directly against the `home-assistant_v2.db` database in an attempt to determine which entities/events are stored in the database, taking up space, etc.)
***
  - ```sql
    -- Show `states` (grouped by entity)
    SELECT
      COUNT(*),
      meta.entity_id
    FROM
      states sta
    LEFT JOIN
      states_meta meta ON sta.metadata_id = meta.metadata_id
    GROUP BY
      meta.entity_id
    ORDER BY
      COUNT(*) DESC,
      meta.entity_id
    ```
***
  - ```sql
    -- Show `states` (grouped by entity & state)
    SELECT
      COUNT(*),
      meta.entity_id,
      sta.state,
      attr.shared_attrs
    FROM
      states sta
    LEFT JOIN
      states_meta meta ON sta.metadata_id = meta.metadata_id
    LEFT JOIN
      state_attributes attr ON sta.attributes_id = attr.attributes_id
    GROUP BY
      meta.entity_id,
      sta.state
    ORDER BY
      COUNT(*) DESC,
      meta.entity_id,
      sta.state
    ```
***
  - ```sql
    -- Show `events` (grouped by type)
    SELECT
      COUNT(*),
      type.event_type,
      data.shared_data
    FROM
      events ev
    LEFT JOIN
      event_types type ON ev.event_type_id = type.event_type_id
    LEFT JOIN
      event_data data ON ev.data_id = data.data_id
    GROUP BY
      type.event_type,
      data.shared_data
    ORDER BY
      COUNT(*) DESC,
      type.event_type,
      data.shared_data
    ```
***
  - ```sql
    -- Show `statistics`
    SELECT
      COUNT(*),
      meta.statistic_id,
      meta.unit_of_measurement,
      meta.source
    FROM
      statistics sta
    LEFT JOIN
      statistics_meta meta ON sta.metadata_id = meta.id
    GROUP BY
      meta.statistic_id
    ORDER BY
      COUNT(*) DESC,
      meta.statistic_id
    ```
***


<!--
# ------------------------------------------------------------
#
# Citation(s)
#
#   community.home-assistant.io  |  "Hass database growing huge - Home Assistant OS - Home Assistant Community"  |  https://community.home-assistant.io/t/hass-database-growing-huge/77125
#
#   www.home-assistant.io  |  "Recorder - Home Assistant"  |  https://www.home-assistant.io/integrations/recorder/
#
#   www.reddit.com  |  "PSA: Optimize your Home Assistant Database : homeassistant"  |  https://www.reddit.com/r/homeassistant/comments/10lmvfk/psa_optimize_your_home_assistant_database/
#
# ------------------------------------------------------------
-->