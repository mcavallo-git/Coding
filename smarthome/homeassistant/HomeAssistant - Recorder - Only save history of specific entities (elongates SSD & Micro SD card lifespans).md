## HomeAssistant - Recorder - Only save history of specific entities (elongates SSD & Micro SD card lifespans)

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
    - `events`                  <!--  2110   ⚠️   -->
      ```sql
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
    - `states`                  <!--  77266  ⚠️   -->
      ```sql
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
    - `statistics`              <!--  19207  ⚠️   -->
      ```sql
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




- ### Save specific entity history only
  - In HomeAssistant's configuration.yaml, under `recorder:`, specify an `include:` clause as detailed in the [`Recorder docs`](https://www.home-assistant.io/integrations/recorder/)


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