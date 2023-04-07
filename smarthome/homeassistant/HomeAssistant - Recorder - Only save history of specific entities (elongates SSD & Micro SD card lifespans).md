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